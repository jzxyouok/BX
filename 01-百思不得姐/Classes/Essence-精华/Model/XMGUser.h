//
//  XMGUser.h
//  01-百思不得姐
//
//  Created by love on 16/5/28.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGUser : NSObject
/*
 *用户名
 */
@property (nonatomic, copy) NSString *username;

/*
 *头像
 */
@property (nonatomic, copy) NSString *profile_image;

/*
 *性别
 */
@property (nonatomic, copy) NSString *sex;
@end
