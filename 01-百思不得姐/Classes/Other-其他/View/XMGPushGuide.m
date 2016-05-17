//
//  XMGPushGuide.m
//  01-百思不得姐
//
//  Created by love on 16/5/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPushGuide.h"

@implementation XMGPushGuide
+ (instancetype)pushGuide
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (IBAction)hide:(UIButton *)sender {
    [self removeFromSuperview];
}

//是否需要显示
+ (void)show
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:versionId];
    NSString *previousVersion = [[NSUserDefaults standardUserDefaults]objectForKey:versionId];
    if (![currentVersion isEqualToString:previousVersion]) {
        XMGPushGuide *guide = [self pushGuide];
        guide.frame = [UIScreen mainScreen].bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:guide];
        //保存当前版本
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:versionId];
    }
}
@end
