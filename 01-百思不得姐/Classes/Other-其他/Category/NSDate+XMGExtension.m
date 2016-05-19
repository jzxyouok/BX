//
//  NSDate+XMGExtension.m
//  01-百思不得姐
//
//  Created by love on 16/5/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSDate+XMGExtension.h"

@implementation NSDate (XMGExtension)
- (NSDateComponents *)deltaFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:date toDate:self options:0];
}
- (BOOL)isThisYear
{
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //当前时间的年
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:now];
    //需要查询的时间的年
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return (nowYear == selfYear);
}

- (BOOL)isToday
{
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //当前时间年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    //需要查询的时间的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
     return (nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day);
}

- (BOOL)isYesterday
{
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //当前时间年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    //需要查询的时间的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return (nowCmps.year == selfCmps.year && nowCmps.month == selfCmps.month && nowCmps.day == selfCmps.day+1);
}
@end
