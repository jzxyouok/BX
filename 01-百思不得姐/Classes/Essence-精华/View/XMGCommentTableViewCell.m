//
//  XMGCommentTableViewCell.m
//  01-百思不得姐
//
//  Created by love on 16/6/1.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCommentTableViewCell.h"
#import "XMGCommnt.h"
@implementation XMGCommentTableViewCell
- (void)awakeFromNib
{
    self.textLabel.font = [UIFont systemFontOfSize:XMGCommentLabelFont];
}
- (void)setComment:(XMGCommnt *)comment
{
    _comment = comment;
    self.textLabel.text = _comment.content;
}

@end
