//
//  XMGWordTopic.m
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGWordTopic.h"
#import "NSDate+XMGExtension.h"
@implementation XMGWordTopic
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //发帖时间
    NSDate *create = [fmt dateFromString:_created_at];
    if ([create isThisYear]) {
        if ([create isToday]) {
            //是今天
            NSDateComponents *cmps = [[NSDate date] deltaFromDate:create];
            if (cmps.hour >=1) {
                //今天其他
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute>=1) {
                //今天1小时内
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else {
                //今天1分钟内
                return [NSString stringWithFormat:@"刚刚"];
            }
        }else if ([create isYesterday]) {
            //是昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [NSString stringWithFormat:@"%@",[fmt stringFromDate:create]];
        }else {
            //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [NSString stringWithFormat:@"%@",[fmt stringFromDate:create]];
        }
    }else {
        //不是今年
        return [NSString stringWithFormat:@"%@",_created_at];
    }
}
@end
