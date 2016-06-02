//
//  XMGCommentHeaderFooterView.m
//  01-百思不得姐
//
//  Created by love on 16/6/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCommentHeaderFooterView.h"
@interface  XMGCommentHeaderFooterView()
/**显示文字的label */
@property (nonatomic, weak) UILabel *label;
@end

@implementation XMGCommentHeaderFooterView
+ (instancetype)headerFooterViewWith:(UITableView *)tableview
{
    XMGCommentHeaderFooterView *header = [tableview dequeueReusableHeaderFooterViewWithIdentifier:XMGCommentHeaderId];
    if (header == nil) {
        header = [[XMGCommentHeaderFooterView alloc]initWithReuseIdentifier:XMGCommentHeaderId];
    }
    return header;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = XMGGlobalBg;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(XMGTopicMargin, 0, XMGScreenWidth, XMGSectionHeaderH)];
        label.font = [UIFont systemFontOfSize:XMGSectionHeaderFont];
        label.textColor = XMGRGBColor(73, 73, 73);
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text =  _title;
}
@end
