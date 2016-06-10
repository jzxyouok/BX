//
//  XMGCommnt.h
//  01-百思不得姐
//
//  Created by love on 16/5/30.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMGUser;
@interface XMGCommnt : NSObject
/** 音频文件的时长*/
@property (nonatomic, assign) NSInteger voicetime;
/**音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 评论的文字内容*/
@property (nonatomic, copy) NSString *content;
/**点赞数 */
@property (nonatomic, assign) NSInteger like_count;
/**用户 */
@property (nonatomic, strong) XMGUser *user;
/**Id */
@property (nonatomic, copy) NSString *Id;
@end
