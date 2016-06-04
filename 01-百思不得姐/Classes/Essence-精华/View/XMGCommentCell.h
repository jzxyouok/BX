//
//  XMGCommentCell.h
//  01-百思不得姐
//
//  Created by love on 16/6/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGCommnt;
@interface XMGCommentCell : UITableViewCell
/**评论模型 */
@property (nonatomic, strong) XMGCommnt *comment;
@end
