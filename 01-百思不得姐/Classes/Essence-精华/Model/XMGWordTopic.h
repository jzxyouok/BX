//
//  XMGWordTopic.h
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGWordTopic : NSObject
/*
 *用户名
 */
@property (nonatomic, copy) NSString *name;
/*
 *帖子内容
 */
@property (nonatomic, copy) NSString *text;
/*
 *图片
 */
@property (nonatomic, copy) NSString *profile_image;
@end
