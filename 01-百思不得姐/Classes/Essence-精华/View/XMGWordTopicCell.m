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
#import "XMGTopicPictureView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicVideoView.h"
#import "XMGCommnt.h"
#import "XMGUser.h"
@interface XMGWordTopicCell ()
/**头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**新浪加v */
@property (weak, nonatomic) IBOutlet UIImageView *sinavImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

/**姓名 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**创建时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/**顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/**分享/转发 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/**评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/**图片帖子 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/**声音帖子 */
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;
/**视频帖子 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;
/**点击更多 */
- (IBAction)more;
/**顶一下 */
- (IBAction)clickDing:(UIButton *)sender;
/**踩一下 */
- (IBAction)clickCai:(UIButton *)sender;
/**分享 */
- (IBAction)clickShare:(UIButton *)sender;
/**评论 */
- (IBAction)clickComment:(UIButton *)sender;
/**最热评论父控件 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/**最热评论文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

@end

@implementation XMGWordTopicCell
+ (instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (XMGTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (XMGTopicVideoView *)videoView
{
    if (_videoView == nil) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}
/**点击了更多 */
- (IBAction)more {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //收藏
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        XMGLog(@"收藏成功!");
    }]];
    //转发
    [alert addAction:[UIAlertAction actionWithTitle:@"转发" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        XMGLog(@"转发成功!");
    }]];
    //取消
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        XMGLog(@"取消成功!");
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
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
    //帖子文字内容
    _labelTitle.text = _wordTopic.text;
    //判断帖子的类型
    if (_wordTopic.type == XMGTpoicTypeImage) {//图片帖子
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        //传递模型显示图片
        self.pictureView.topic = _wordTopic;
        //pictureView的frame
        self.pictureView.frame = _wordTopic.pictureFrame;
    }else if (_wordTopic.type == XMGTpoicTypeSound) {//声音帖子
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.topic = _wordTopic;
        //取出模型中计算好的voiceFrame属性
        self.voiceView.frame = _wordTopic.voiceFrame;
    }else if (_wordTopic.type == XMGTpoicTypeMovie) {//视频帖子
        self.videoView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.topic = _wordTopic;
        self.videoView.frame = _wordTopic.videoFrame;
    }else {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    //判断是否需要显示最热评论
    if (_wordTopic.top_cmt.count) {
        self.topCmtView.hidden = NO;
        XMGCommnt *cmt = _wordTopic.top_cmt[0];
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
    }else {
        self.topCmtView.hidden = YES;
    }
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
    frame.origin.x = XMGTopicMargin;
    frame.origin.y += XMGTopicMargin;
    frame.size.width -= 2 * XMGTopicMargin;
    frame.size.height = self.wordTopic.cellHeight - XMGTopicMargin;
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
