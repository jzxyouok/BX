//
//  XMGCommentCell.m
//  01-百思不得姐
//
//  Created by love on 16/6/4.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGCommentCell.h"
#import "XMGCommnt.h"
#import <UIImageView+WebCache.h>
#import "XMGUser.h"
@interface  XMGCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

/**点赞 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

- (IBAction)likeCount;
- (IBAction)playVoice;

@end

@implementation XMGCommentCell
- (void)setComment:(XMGCommnt *)comment
{
    _comment = comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:_comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [UIImage imageNamed:[_comment.user.sex isEqualToString:XMGUserSexMale]?@"Profile_manIcon":@"Profile_womanIcon"];
    self.usernameLabel.text = _comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",_comment.like_count];
    if (_comment.voiceuri.length) {//如果是音频
        self.voiceBtn.hidden = NO;
        [self.voiceBtn setTitle:[NSString stringWithFormat:@"%zd''",_comment.voicetime] forState:UIControlStateNormal];
        self.contentLabel.hidden = YES;
    }else {
        self.contentLabel.hidden = NO;
        self.contentLabel.text = _comment.content;
        self.voiceBtn.hidden = YES;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)likeCount {
    
}

- (IBAction)playVoice {
    
}

@end
