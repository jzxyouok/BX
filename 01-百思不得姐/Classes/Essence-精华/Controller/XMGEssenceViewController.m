//
//  XMGEssenceViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGRecommendTagsViewController.h"
#import "XMGTestView.h"

@implementation XMGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    XMGTestView *testView = [[XMGTestView alloc] init];
    testView.frame = CGRectMake(100, 100, 0, 1000);
    testView.bounds = CGRectMake(0, 0, 10, 10);
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

- (void)tagClick
{
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}
@end
