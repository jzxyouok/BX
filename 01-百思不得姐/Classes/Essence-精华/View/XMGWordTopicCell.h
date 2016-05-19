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
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
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
