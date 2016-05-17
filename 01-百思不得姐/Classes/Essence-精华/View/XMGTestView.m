//
//  XMGTestView.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/23.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGTestView.h"

@implementation XMGTestView

+ (instancetype)testView
{
    return [[self alloc] init];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(100, 100);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    bounds.size = CGSizeMake(100, 100);
    [super setBounds:bounds];
}

@end
