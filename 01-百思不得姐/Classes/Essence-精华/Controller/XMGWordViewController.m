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
@property (nonatomic, strong) NSArray *wordTopics;
@end

@implementation XMGWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置刷新控件
    [self setUpRefresh];
    //发送请求
    NSDictionary *params = @{@"a":@"list",
                            @"c":@"data",
                             @"type":@"29"};
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable  responseObject) {
        NSArray *array = responseObject[@"list"];
        //字典转模型
        self.wordTopics = [XMGWordTopic mj_objectArrayWithKeyValuesArray:array];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/**
 *  设置刷新控件
 */
- (void)setUpRefresh
{
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
}
/*
 *上拉加载更多
 */
- (void)loadMore
{
    
}
/**
 *  下拉刷新
 */
- (void)loadNew
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
@end
