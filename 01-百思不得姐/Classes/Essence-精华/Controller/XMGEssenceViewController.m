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
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    [self setUpTitleView];
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
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton addTarget:self action:@selector(didSelectButton:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
    }
    
    //titleIndicator
    UIView *titleIndicator = [[UIView alloc]init];
    titleIndicator.height = 2;
    titleIndicator.y = titleView.height - titleIndicator.height;
    titleIndicator.backgroundColor = [UIColor redColor];
    self.titleIndicator = titleIndicator;
    [titleView addSubview:titleIndicator];
}
- (void)tagClick
{
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

- (void)didSelectButton:(UIButton *)button
{
    self.titleIndicator.width = button.titleLabel.width;
    [UIView animateWithDuration:0.5 animations:^{
        self.titleIndicator.centerX = button.centerX;
    }];
}
@end
