//
//  XMGCommentViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/31.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCommentViewController.h"

@interface XMGCommentViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation XMGCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setUpNav];
    //添加监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
   }

/**设置导航栏 */
- (void)setUpNav
{
    //设置标题
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:@selector(share)];
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
@end
