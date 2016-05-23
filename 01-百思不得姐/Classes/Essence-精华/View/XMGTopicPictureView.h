//
//  XMGTopicPictureView.h
//  01-百思不得姐
//
//  Created by love on 16/5/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGWordTopic.h"
@interface XMGTopicPictureView : UIView
@property (nonatomic, strong) XMGWordTopic *topic;
+ (instancetype)pictureView;
@end
