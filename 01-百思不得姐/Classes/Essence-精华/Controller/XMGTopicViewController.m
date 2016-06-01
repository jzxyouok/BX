//
//  XMGTopicViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicViewController.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>

#import "XMGWordTopic.h"
#import "XMGWordTopicCell.h"
#import "XMGUser.h"
#import "XMGCommentViewController.h"
@interface XMGTopicViewController ()

//模型数组
@property (nonatomic, strong) NSMutableArray *wordTopics;

/*
 *加载的页数
 */
@property (nonatomic, assign) NSInteger page;
/*
 *maxtime
 */
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
//记录请求是否过期的请求参数体
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation XMGTopicViewController
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
static NSString * const XMGWordTopicId = @"wordTopic";
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内边距
    [self setUpView];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    //设置刷新控件
    [self setUpRefresh];
    //一进来就进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGWordTopicCell class]) bundle:nil] forCellReuseIdentifier:XMGWordTopicId];
}
- (void)setUpView
{
    CGFloat top = titleViewY + titleViewHeight;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
}
/**
 *  设置刷新控件
 */
- (void)setUpRefresh
{
    //上拉加载更多
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
/*
 *上拉加载更多
 */
- (void)loadMore
{
    [self.tableView.mj_header endRefreshing];
    //发送请求
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@(self.type),
                             @"page":@(self.page),
                             @"maxtime":self.maxtime};
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable  responseObject) {
        if (self.params != params) return;
        NSArray *list = responseObject[@"list"];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        NSArray *array = [XMGWordTopic mj_objectArrayWithKeyValuesArray:list];
        [self.wordTopics addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        ++self.page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
/**
 *  下拉刷新
 */
- (void)loadNew
{
    [self.tableView.mj_footer endRefreshing];
    //发送请求
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@(self.type),
                             @"page":@(self.page)
                             };
    self.params = params;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable  responseObject) {
        if (self.params != params) return;
        [SVProgressHUD dismiss];
        NSArray *array = responseObject[@"list"];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.wordTopics = [XMGWordTopic mj_objectArrayWithKeyValuesArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        [SVProgressHUD showErrorWithStatus:@"加载数据失败!"];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - tableView数据源-代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.tableView.mj_footer.hidden = (self.wordTopics.count == 0);
    return self.wordTopics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGWordTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGWordTopicId];
    XMGWordTopic *wordTopic = self.wordTopics[indexPath.row];
    cell.wordTopic = wordTopic;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCommentViewController *commentVc = [[XMGCommentViewController alloc]init];
    commentVc.topic = _wordTopics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}
/**
 *设置行高
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGWordTopic *topic = self.wordTopics[indexPath.row];
    return topic.cellHeight;
}
- (void)dealloc
{
    //取消所有请求
    [self.manager.operationQueue cancelAllOperations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
