//
//  XMGPublishViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/25.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPublishViewController.h"
#import "XMGVerticalButton.h"
//列数
static NSInteger const cols = 3;
@interface XMGPublishViewController ()
- (IBAction)cancel;

@end

@implementation XMGPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审贴",@"离线下载"];
    //添加标语
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slogan.y = XMGScreenHeight * 0.2;
    slogan.centerX = XMGScreenWidth * 0.5;
    [self.view addSubview:slogan];
    
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
    CGFloat buttonY = 0;
    //添加按钮
    for (NSInteger i = 0; i<6; i++) {
        //行数
        NSInteger row = i / cols;
        //列数
        NSInteger col = i % cols;
        //设置位置和大小
        buttonX = col*(buttonW+margin)+startX;
        buttonY = startY+row * buttonH;
        XMGVerticalButton *button = [[XMGVerticalButton alloc]init];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //设置标题和图片
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (IBAction)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
