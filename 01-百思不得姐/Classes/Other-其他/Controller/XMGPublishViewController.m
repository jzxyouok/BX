//
//  XMGPublishViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPublishViewController.h"
#import "XMGVerticalButton.h"
#import <POP.h>
//列数
static NSInteger const cols = 3;
static CGFloat const XMGAnimationDelay = 0.1;
static CGFloat const XMGSpringFactor = 10;
@interface XMGPublishViewController ()
- (IBAction)cancel;
@end

@implementation XMGPublishViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //动画完成前,禁止用户操作
    self.view.userInteractionEnabled = NO;
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审贴",@"离线下载"];

    //计算间距
    CGFloat buttonW = 70;
    CGFloat buttonH = buttonW + 30;
    //按钮X开始位置
    CGFloat startX = 15;
    //按钮Y开始位置
    CGFloat startY = (XMGScreenHeight- 2 * buttonH)* 0.5;
    //按钮间距
    CGFloat margin = (XMGScreenWidth - 2*startX - cols * buttonW) / (cols-1);
    CGFloat buttonX = 0;
    CGFloat buttonEndY = 0;
    //添加按钮
    for (NSInteger i = 0; i<images.count; i++) {
        XMGVerticalButton *button = [[XMGVerticalButton alloc]init];
        [self.view addSubview:button];
        //设置标题和图片
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //行数
        NSInteger row = i / cols;
        //列数
        NSInteger col = i % cols;
        //设置位置和大小
        buttonX = col*(buttonW+margin)+startX;
        buttonEndY = startY+row * buttonH;
        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        spring.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, startY-XMGScreenHeight, buttonW, buttonH)];
        spring.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        spring.springSpeed = XMGSpringFactor;
        spring.springBounciness = XMGSpringFactor;
        spring.beginTime = CACurrentMediaTime()+XMGAnimationDelay * i;
        [button pop_addAnimation:spring forKey:nil];
    }
    
    //添加口号
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:slogan];
    slogan.center = CGPointMake(XMGScreenWidth * 0.5, -XMGScreenHeight);
    
    //计算位置
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(XMGScreenWidth * 0.5,  -XMGScreenHeight)];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(XMGScreenWidth * 0.5, XMGScreenHeight * 0.2)];
    spring.springBounciness = XMGSpringFactor;
    spring.springSpeed = XMGSpringFactor;
    spring.beginTime = CACurrentMediaTime() + images.count * XMGAnimationDelay;
    [spring setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    [slogan pop_addAnimation:spring forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
