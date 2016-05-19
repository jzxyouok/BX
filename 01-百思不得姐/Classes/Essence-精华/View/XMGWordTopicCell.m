//
//  XMGWordTopicCell.m
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGWordTopicCell.h"
#import "XMGWordTopic.h"
#import <UIImageView+WebCache.h>
@implementation XMGWordTopicCell
- (void)awakeFromNib
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
}
- (void)setWordTopic:(XMGWordTopic *)wordTopic
{
    _wordTopic = wordTopic;
    //头像
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:_wordTopic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //姓名
    _nameLabel.text = _wordTopic.name;
    //时间
    _createTimeLabel.text = _wordTopic.created_at;
    //顶
    [_dingButton setTitle:[NSString stringWithFormat:@"%zd",_wordTopic.ding] forState:UIControlStateNormal];
    //踩
    [_caiButton setTitle:[NSString stringWithFormat:@"%zd",_wordTopic.cai] forState:UIControlStateNormal];
    //分享
    [_shareButton setTitle:[NSString stringWithFormat:@"%zd",_wordTopic.repost] forState:UIControlStateNormal];
    //评论
    [_commentButton setTitle:[NSString stringWithFormat:@"%zd",_wordTopic.comment] forState:UIControlStateNormal];
}

- (IBAction)clickFollow:(UIButton *)sender {
}

- (IBAction)clickDing:(UIButton *)sender {
}

- (IBAction)clickCai:(UIButton *)sender {
}

- (IBAction)clickShare:(UIButton *)sender {
}

- (IBAction)clickComment:(UIButton *)sender {
}
- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    [super setFrame:frame];
}
@end
