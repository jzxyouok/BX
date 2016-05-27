//
//  XMGTopicVoiceView.h
//  01-百思不得姐
//
//  Created by love on 16/5/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGWordTopic;
@interface XMGTopicVoiceView : UIView
+ (instancetype)voiceView;
//模型
@property (nonatomic, strong) XMGWordTopic *topic;
@end
