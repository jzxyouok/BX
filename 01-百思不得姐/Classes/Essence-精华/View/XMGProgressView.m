//
//  XMGProgressView.m
//  01-百思不得姐
//
//  Created by love on 16/5/24.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGProgressView.h"

@implementation XMGProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 5;
    self.progressLabel.textColor = [UIColor whiteColor];
}
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
}
@end
