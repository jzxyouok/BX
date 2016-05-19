//
//  NSDate+XMGExtension.h
//  01-百思不得姐
//
//  Created by love on 16/5/20.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XMGExtension)
/**
 *快速返回某个时间date和现在时间now之间的差值年月日时分秒
 */
- (NSDateComponents *)deltaFromDate:(NSDate *)date;

/**
 *查看某个时间是否是今年
 */
- (BOOL)isThisYear;

/**
 *查看某个时间是否是今天
 */
- (BOOL)isToday;

/**
 *查看某个时间是否是昨天
 */
- (BOOL)isYesterday;
@end
