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
/**点赞 */
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

- (IBAction)likeCount;
@end

@implementation XMGCommentCell
- (void)setComment:(XMGCommnt *)comment
{
    _comment = comment;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:_comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexView.image = [UIImage imageNamed:[_comment.user.sex isEqualToString:XMGUserSexMale]?@"Profile_manIcon":@"Profile_womanIcon"];
    self.contentLabel.text = _comment.content;
    self.usernameLabel.text = _comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",_comment.like_count];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)likeCount {
    
}

@end
