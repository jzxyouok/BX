//
//  XMGTopicVideoView.m
//  01-百思不得姐
//
//  Created by love on 16/5/27.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicVideoView.h"
#import "XMGWordTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGShowPictureViewController.h"
@interface XMGTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;

- (IBAction)play;

@end

@implementation XMGTopicVideoView
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    _videoTime.font = [UIFont systemFontOfSize:12];
    _playCount.font = [UIFont systemFontOfSize:12];
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)];
    [self.imageView addGestureRecognizer:tap];

}
+ (instancetype)videoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)setTopic:(XMGWordTopic *)topic
{
    _topic = topic;
    _playCount.text = [NSString stringWithFormat:@"%@播放",_topic.playcount];
    NSInteger minute = _topic.videotime.integerValue / 60;
    NSInteger second = _topic.videotime.integerValue % 60;
    _videoTime.text= [NSString stringWithFormat:@"%02zd分%02zd秒",minute,second];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_topic.large_image]];
}

- (IBAction)play {
}
- (void)showPicture
{
    XMGShowPictureViewController *showPicture = [[XMGShowPictureViewController alloc]init];
    //传递模型给控制器
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
@end
