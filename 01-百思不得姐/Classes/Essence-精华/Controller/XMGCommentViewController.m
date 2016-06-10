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
#import "XMGCommnt.h"
#import <MJExtension.h>
#import "XMGCommentHeaderFooterView.h"
#import "XMGCommentCell.h"
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
/**最热评论的数组 */
@property (nonatomic, strong) NSArray *top_cmt;
/**页码 */
@property (nonatomic, assign) NSInteger page;
/**manager */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation XMGCommentViewController
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
/**评论的标识 */
static NSString * const commentId = @"comment";
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell重用标识符
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:commentId];
    //基本设置
    [self setUpBasic];
    //添加监听
    [self addObserver];
    //设置表格头部视图
    [self setTableHeader];
    //设置刷新控件
    [self setUpRefresh];
    //让下拉刷新控件主动进入刷新
    [self.tableView.mj_header beginRefreshing];
}

/**基本设置 */
- (void)setUpBasic
{
    //设置标题
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:@selector(share)];
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, XMGTopicMargin, 0);
}
/**添加监听 */
- (void)addObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
/**设置表格头部视图 */
- (void)setTableHeader
{
    if (_topic.top_cmt.count) {
        //记录
        self.top_cmt = _topic.top_cmt;
        //清空
        _topic.top_cmt = nil;
        [_topic setValue:@0 forKeyPath:@"cellHeight"];
    }
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
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    //一开始隐藏
    self.tableView.mj_footer.hidden = YES;
}
/**下拉加载新数据 */
- (void)loadNew
{
    //所有任务都取消
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.Id;
    params[@"hot"] = @"1";
  [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
      
  } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
      self.data = [XMGCommnt mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
      self.hot = [XMGCommnt mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
      self.dataCount = self.data.count;
      self.hotCount = self.hot.count;
      //结束刷新
      [self.tableView.mj_header endRefreshing];
      self.page = 1;
      //刷新表格
      [self.tableView reloadData];
//      控制footer的状态
      NSInteger total = [responseObject[@"total"] integerValue];
      if (_dataCount >= total) {
          [self.tableView.mj_footer endRefreshingWithNoMoreData];
      }
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      [self.tableView.mj_header endRefreshing];
  }];
}
/**上拉加载更多 */
- (void)loadMore
{
    //取消所有
    [self.manager.operationQueue cancelAllOperations];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.Id;
    params[@"page"] = @(self.page+1);
    XMGCommnt *commnt = [self.data lastObject];
    params[@"lastcid"] = commnt.Id;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [XMGCommnt mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.data addObjectsFromArray:array];
        self.dataCount = self.data.count;
        self.page++;
        //控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (_dataCount >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            //停止刷新
            [self.tableView.mj_footer endRefreshing];
        }
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
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
        return section? _dataCount:_hotCount;
        }else if (_dataCount) {//如果存在最新评论
        return _dataCount;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.mj_footer.hidden = (self.dataCount == 0);
    XMGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentId];
    cell.comment = [self commentAtIndexPath:indexPath];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    XMGCommentHeaderFooterView *header = [XMGCommentHeaderFooterView headerFooterViewWith:tableView];
    if (_hotCount) {//如果存在最热评论
        header.title = section? @"最新评论" : @"最热评论";
    }else if (_dataCount) {//如果存在最新评论
        header.title = @"最新评论";
    }
    return header;
}
- (XMGCommnt *)commentAtIndexPath:(NSIndexPath *)indexPath
{
    if (_hotCount) {
        return indexPath.section?self.data[indexPath.row] : self.hot[indexPath.row];
    }else if (_dataCount) {
        return self.data[indexPath.row];
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return XMGSectionHeaderH;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    if (self.top_cmt) {
        _topic.top_cmt = self.top_cmt;
        [_topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end
