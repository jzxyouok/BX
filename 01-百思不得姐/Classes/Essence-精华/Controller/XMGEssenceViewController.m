//
//  XMGEssenceViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGRecommendTagsViewController.h"
#import "XMGAllViewController.h"
#import "XMGMovieViewController.h"
#import "XMGSoundViewController.h"
#import "XMGImageViewController.h"
#import "XMGWordViewController.h"
static CGFloat const animationTime = 0.5;
@interface XMGEssenceViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIView *titleIndicator;
@property (nonatomic, weak) UIButton *currentButton;
@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpNav];
    [self setUpChildVces];
    [self setUpTitleView];
    [self setUpContentView];
}
/**
 *  设置导航栏
 */
- (void)setUpNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;
}

/**
 *  设置顶部
 */
- (void)setUpTitleView
{
    //整个titleView
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, 30)];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:animationTime];
    [self.view addSubview:titleView];
    self.titleView  = titleView;
    
    //titleIndicator
    UIView *titleIndicator = [[UIView alloc]init];
    titleIndicator.height = 2;
    titleIndicator.y = titleView.height - titleIndicator.height;
    titleIndicator.backgroundColor = [UIColor redColor];
    titleIndicator.tag = -1;
    self.titleIndicator = titleIndicator;
    
    //titleButton
    NSArray *titles = @[@"全部",@"视频",@"音频",@"图片",@"段子"];
    NSInteger titleCount = titles.count;
    CGFloat Width = titleView.width / titleCount;
    CGFloat Height = titleView.height;
    for (NSInteger i = 0; i < titleCount; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
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
    [titleView addSubview:titleIndicator];
}

/**
 *  设置中间
 */
- (void)setUpContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    contentView.pagingEnabled = YES;
    contentView.bounces = YES;
    contentView.delegate = self;
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count , 0);
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    [self scrollViewDidEndScrollingAnimation:self.contentView];
}

/**
 *  添加子控制器
 */
- (void)setUpChildVces
{
    XMGAllViewController *all = [[XMGAllViewController alloc]init];
    [self addChildViewController:all];
    
    XMGMovieViewController *movie = [[XMGMovieViewController alloc]init];
    [self addChildViewController:movie];
    
    XMGSoundViewController *sound = [[XMGSoundViewController alloc]init];
    [self addChildViewController:sound];
    
    XMGImageViewController *image = [[XMGImageViewController alloc]init];
    [self addChildViewController:image];
    
    XMGWordViewController *word = [[XMGWordViewController alloc]init];
    [self addChildViewController:word];
}

/**
 *  点击了推荐标签
 */
- (void)tagClick
{
    XMGRecommendTagsViewController *tags = [[XMGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

/**
 *点击顶部按钮
 */
- (void)didSelectButton:(UIButton *)button
{
    //控制顶部按钮的状态
    button.enabled = NO;
    self.currentButton.enabled = YES;
    self.currentButton = button;
    [UIView animateWithDuration:animationTime animations:^{
        self.titleIndicator.width = button.titleLabel.width;
        self.titleIndicator.centerX = button.centerX;
    }];

       //滚动结果后再显示
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
/**
 *通过contentoffset偏移
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.contentView.width;
    //添加tableView到scrollView上
    UIViewController *Vc = self.childViewControllers[index];
    Vc.view.x = scrollView.contentOffset.x;
    Vc.view.y = 0;
    Vc.view.height = self.view.height;
    [self.contentView addSubview:Vc.view];
}
/**
 *用户拖动偏移
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self didSelectButton:self.titleView.subviews[index]];
}
@end
