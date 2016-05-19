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
@end
