//
//  XMGCommentTableViewCell.h
//  01-百思不得姐
//
//  Created by love on 16/6/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMGCommnt;
@interface XMGCommentTableViewCell : UITableViewCell
/**模型 */
@property (nonatomic, strong) XMGCommnt *comment;
@end
