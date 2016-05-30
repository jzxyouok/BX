//
//  XMGWordTopic.h
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGWordTopic : NSObject
/**用户名 */
@property (nonatomic, copy) NSString *name;
/**帖子内容 */
@property (nonatomic, copy) NSString *text;
/**图片 */
@property (nonatomic, copy) NSString *profile_image;
/**新浪加V */
@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;
/**发帖时间 */
@property (nonatomic, copy) NSString *created_at;
/**顶的人数 */
@property (nonatomic, assign) NSInteger ding;
/**踩的人数 */
@property (nonatomic, assign) NSInteger cai;
/**转发的人数 */
@property (nonatomic, assign) NSInteger repost;
/**评论的人数 */
@property (nonatomic, assign) NSInteger comment;
/**音频的时长 */
@property (nonatomic, copy) NSString *voicetime;
/**音频的播放地址 */
@property (nonatomic, copy) NSString *voiceuri;
/**音频播放次数 */
@property (nonatomic, copy) NSString *playcount;
/**视频的时长 */
@property (nonatomic, copy) NSString *videotime;
/**视频的url */
@property (nonatomic, copy) NSString *videouri;
/**最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;

/*--------------------------------------------------辅助属性---------------------------------------------------*/
/**行高 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/**图片帖子中间的frame */
@property (nonatomic, assign, readonly) CGRect pictureFrame;
/**声音帖子中间的frame */
@property (nonatomic, assign, readonly) CGRect voiceFrame;
/**视频帖子中间的frame */
@property (nonatomic, assign, readonly) CGRect videoFrame;
/**图片宽度 */
@property (nonatomic, assign) CGFloat width;
/**图片高度 */
@property (nonatomic, assign) CGFloat height;
/**图片URL image0 */
@property (nonatomic, copy) NSString *small_image;
/**图片URL image1 */
@property (nonatomic, copy) NSString *large_image;
/**图片URL image1 */
@property (nonatomic, copy) NSString *middle_image;
/**帖子的类型 */
@property (nonatomic, assign) XMGTpoicType type;
/**图片是否太大 */
@property (nonatomic, assign,getter=isTooBig) BOOL tooBig;
/**图片下载的进度 */
@property (nonatomic, assign) CGFloat pictureProgress;
@end
