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
@interface XMGCommentViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XMGCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setUpNav];
    //添加监听
    [self addObserver];
    //设置表格头部视图
    [self setTableHeader];
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
    XMGWordTopicCell *cell = [XMGWordTopicCell cell];
    cell.wordTopic=  self.topic;
    cell.size = CGSizeMake(XMGScreenWidth, 0);
    header.height = _topic.cellHeight+XMGTopicMargin;
    [header addSubview:cell];
    self.tableView.tableHeaderView = header;
    self.tableView.backgroundColor = XMGGlobalBg;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd",indexPath.section,indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"评论";
}
@end
