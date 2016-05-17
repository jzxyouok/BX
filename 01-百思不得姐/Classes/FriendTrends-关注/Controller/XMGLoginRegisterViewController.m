//
//  XMGLoginRegisterViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/26.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGLoginRegisterViewController.h"

@interface XMGLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIButton *registerOrLoginButton;

@end

@implementation XMGLoginRegisterViewController
/**
 *点击注册登录按钮
 */
- (IBAction)registerOrLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.loginLeadingConstraint.constant == 0) {
        self.loginLeadingConstraint.constant = -self.view.width;
        [self.registerOrLoginButton setSelected:YES];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else {
        self.loginLeadingConstraint.constant = 0;
        [self.registerOrLoginButton setSelected:NO];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
