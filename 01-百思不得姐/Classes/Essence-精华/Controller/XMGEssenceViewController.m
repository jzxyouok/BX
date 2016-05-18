//
//  XMGEssenceViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGRecommendTagsViewController.h"
@interface XMGEssenceViewController ()
@property (nonatomic, weak) UIView *titleIndicator;
@property (nonatomic, weak) UIButton *currentButton;
@property (nonatomic, weak) UIView *titleView;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    [self setUpTitleView];
    [self setUpContentView];
}
- (void)setUpNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}
- (void)setUpTitleView
{
    //整个titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 30)];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    self.titleView  = titleView;
    
    //titleIndicator
    UIView *titleIndicator = [[UIView alloc]init];
    titleIndicator.height = 2;
    titleIndicator.y = titleView.height - titleIndicator.height;
    titleIndicator.backgroundColor = [UIColor redColor];
    self.titleIndicator = titleIndicator;
    [titleView addSubview:titleIndicator];
    
    //titleButton
    NSArray *titles = @[@"全部",@"视频",@"音频",@"图片",@"段子"];
    NSInteger titleCount = titles.count;
    CGFloat Width = titleView.width / titleCount;
    CGFloat Height = titleView.height;
    for (NSInteger i = 0; i < titleCount; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(Width * i, 0, Width, Height);
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认选中第一个
        if (i == 0) {
            titleButton.enabled = NO;
            [titleButton.titleLabel sizeToFit];
            titleIndicator.width = titleButton.titleLabel.width;
            titleIndicator.centerX = titleButton.centerX;
            self.currentButton = titleButton;
        }
        [titleView addSubview:titleButton];
    }
    
}
- (void)setUpContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    contentView.contentSize = CGSizeMake(0, 800);
    UIButton *topBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    topBtn.backgroundColor = [UIColor redColor];
    
    UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 700, 100, 100)];
    bottomBtn.backgroundColor = [UIColor greenColor];
    [contentView addSubview:topBtn];
    [contentView addSubview:bottomBtn];
    
    [self.view insertSubview:contentView atIndex:0];
}
- (void)tagClick
{
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)didSelectButton:(UIButton *)button
{
    //控制顶部按钮的状态
    button.enabled = NO;
    self.currentButton.enabled = YES;
    self.currentButton = button;
    self.titleIndicator.width = button.titleLabel.width;
    [UIView animateWithDuration:0.5 animations:^{
        self.titleIndicator.centerX = button.centerX;
    }];
}
@end
