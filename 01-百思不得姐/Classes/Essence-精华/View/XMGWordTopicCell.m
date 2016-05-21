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
@interface XMGWordTopicCell ()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  新浪加v
 */
@property (weak, nonatomic) IBOutlet UIImageView *sinavImageView;

/**
 *  姓名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  创建时间
 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**
 *  顶
 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**
 *  踩
 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/**
 *  分享/转发
 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/**
 *添加好友
 */
- (IBAction)clickFollow:(UIButton *)sender;

/**
 *顶一下
 */
- (IBAction)clickDing:(UIButton *)sender;

/**
 *踩一下
 */
- (IBAction)clickCai:(UIButton *)sender;

/**
 *分享
 */
- (IBAction)clickShare:(UIButton *)sender;

/**
 *评论
 */
- (IBAction)clickComment:(UIButton *)sender;

@end

@implementation XMGWordTopicCell
- (void)awakeFromNib
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = imageView;
}
/*
 今年
  -今天
   -1分钟内
    刚刚
   -1小时内
    XX分钟内
   -其他
    XX小时内
  -昨天
    昨天 18:56:04
  -其他
   06-05 17:03:03
 非今年
  2014-01-01 12:05:40
 */
- (void)setWordTopic:(XMGWordTopic *)wordTopic
{
    _wordTopic = wordTopic;
    //新浪加v
    _sinavImageView.hidden = !_wordTopic.isSina_v;
    //头像
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:_wordTopic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //姓名
    _nameLabel.text = _wordTopic.name;
    //时间
    [self.createTimeLabel setText:_wordTopic.created_at];
    //顶
    [self setTitleWithButton:_dingButton count:_wordTopic.ding placeTitle:@"顶"];
    //踩
    [self setTitleWithButton:_caiButton count:_wordTopic.cai placeTitle:@"踩"];
    //分享
    [self setTitleWithButton:_shareButton count:_wordTopic.repost placeTitle:@"分享"];
    //评论
    [self setTitleWithButton:_commentButton count:_wordTopic.comment placeTitle:@"评论"];
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
#pragma mark - 对按钮文字做处理的方法
- (void)setTitleWithButton:(UIButton *)button count:(NSInteger)count placeTitle:(NSString *)placeTitle
{
    if (count>=10000) {
        placeTitle = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count>0) {
        placeTitle = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeTitle forState:UIControlStateNormal];
}
@end
