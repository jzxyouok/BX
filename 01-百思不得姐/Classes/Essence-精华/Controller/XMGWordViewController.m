//
//  XMGWordViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGWordViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

#import "XMGWordTopic.h"

@interface XMGWordViewController ()
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
@end

@implementation XMGWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置刷新控件
    [self setUpRefresh];
    //一进来就进入刷新状态
    [self.tableView.mj_header beginRefreshing];
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
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
/*
 *上拉加载更多
 */
- (void)loadMore
{
    //发送请求
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@"29",
                             @"page":@(++self.page),
                             @"maxtime":self.maxtime};
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable  responseObject) {
        NSArray *list = responseObject[@"list"];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        NSArray *array = [XMGWordTopic mj_objectArrayWithKeyValuesArray:list];
        [self.wordTopics addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}
/**
 *  下拉刷新
 */
- (void)loadNew
{
    self.page = 0;
    //发送请求
    NSDictionary *params = @{@"a":@"list",
                             @"c":@"data",
                             @"type":@"29",
                             @"page":@(self.page)
                             };
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable  responseObject) {
        NSArray *array = responseObject[@"list"];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.wordTopics = [XMGWordTopic mj_objectArrayWithKeyValuesArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.wordTopics.count;
}
static NSString * const Id = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    XMGWordTopic *wordTopic = self.wordTopics[indexPath.row];
    cell.textLabel.text = wordTopic.name;
    cell.detailTextLabel.text = wordTopic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:wordTopic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
