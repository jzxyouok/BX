//
//  XMGWordTopicCell.h
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGWordTopic;
@interface XMGWordTopicCell : UITableViewCell
//模型
@property (nonatomic, strong) XMGWordTopic *wordTopic;
/**快速返回一个实例化的对象 */
+ (instancetype)cell;
@end
