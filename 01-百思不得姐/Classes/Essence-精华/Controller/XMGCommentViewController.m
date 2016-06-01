//
//  XMGCommentViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/31.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCommentViewController.h"
#import "XMGWordTopicCell.h"
#import "XMGWordTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "XMGCommentTableViewCell.h"
#import "XMGCommnt.h"
#import <MJExtension.h>
@interface XMGCommentViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**data */
@property (nonatomic, strong) NSMutableArray *data;
/**hot */
@property (nonatomic, strong) NSMutableArray *hot;
/**最热评论数 */
@property (nonatomic, assign) NSInteger hotCount;
/**最新评论数 */
@property (nonatomic, assign) NSInteger dataCount;
@end

@implementation XMGCommentViewController
static NSString * const Id = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:Id];
    //设置导航栏
    [self setUpNav];
    //添加监听
    [self addObserver];
    //设置表格头部视图
    [self setTableHeader];
    //设置刷新控件
    [self setUpRefresh];
    //让下拉刷新控件主动进入刷新
    [self.tableView.mj_header beginRefreshing];
}

/**设置导航栏 */
- (void)setUpNav
{
    //设置标题
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:@selector(share)];
}
/**添加监听 */
- (void)addObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
/**设置表格头部视图 */
- (void)setTableHeader
{
    UIView *header = [[UIView alloc]init];
    header.height = _topic.cellHeight+XMGTopicMargin;
    
    XMGWordTopicCell *cell = [XMGWordTopicCell cell];
    cell.wordTopic=  self.topic;
    cell.size = CGSizeMake(XMGScreenWidth, 0);
    
    cell.backgroundColor = [UIColor clearColor];
    [header addSubview:cell];
    self.tableView.tableHeaderView = header;
    self.tableView.backgroundColor = XMGGlobalBg;
}
/**设置刷新控件 */
- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
}
/**下拉加载新数据 */
- (void)loadNew
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.Id;
    params[@"hot"] = @"1";
  [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
      
  } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
      self.data = [XMGCommnt mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
      self.hot = [XMGCommnt mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
      self.dataCount = self.data.count;
      self.hotCount = self.hot.count;
      [self.tableView.mj_header endRefreshing];
      [self.tableView reloadData];
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      [self.tableView.mj_header endRefreshing];
  }];
}
/**上拉加载更多 */
- (void)loadMore
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/**右侧分享 */
- (void)share
{
    
}
/**键盘弹出及收起 */
- (void)keyboardChangeFrame:(NSNotification *)noti
{
    CGRect endFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _bottomConstraint.constant = XMGScreenHeight - endFrame.origin.y;
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
/**准备滚动表格 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - 数据源 - 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_hotCount) return 2;
    if (_dataCount) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       if (_hotCount) {//如果存在热门评论
        if (section == 0) return _hotCount;
        if (section == 1) return _dataCount;
           return 0;
        }else if (_dataCount) {//如果存在最新评论
        return self.data.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (_hotCount) {//如果存在最热评论
        if (indexPath.section == 0) cell.comment = self.hot[indexPath.row];
        if (indexPath.section == 1) cell.comment = self.data[indexPath.row];
    }else if (_dataCount) {//如果存在最新评论
        cell.comment = self.data[indexPath.row];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_hotCount) {//如果存在热门评论
        if (section == 0) return @"最热评论";
        if (section == 1) return @"最新评论";
    }else if (_dataCount) {//如果存在最新评论
        return @"最新评论";
    }
    return nil;
}
@end
