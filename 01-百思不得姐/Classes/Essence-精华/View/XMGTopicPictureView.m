//
//  XMGTopicPictureView.m
//  01-百思不得姐
//
//  Created by love on 16/5/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "XMGProgressView.h"
#import "XMGShowPictureViewController.h"
@interface XMGTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;

@end

@implementation XMGTopicPictureView
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)setTopic:(XMGWordTopic *)topic
{
    _topic = topic;
    //立马显示模型中的图片下载进度
    [self.progressView setProgress:_topic.pictureProgress animated:NO];
    //显示图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        _topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:_topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        if (_topic.isTooBig == NO) return;
        //如果是大图   开启图形上下文
        UIGraphicsBeginImageContextWithOptions(_topic.pictureFrame.size, YES, 0);
        CGFloat width = _topic.pictureFrame.size.width;
        CGFloat height = width * _topic.height / _topic.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        //获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭图形上下文
        UIGraphicsEndImageContext();
    }];
    //判断是否为gif图片
    NSString *extension = _topic.large_image.pathExtension;
    _gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //判断是否需要显示点击显示全部
    if (_topic.isTooBig) {
        _seeBigButton.hidden = NO;
    }else {
        _seeBigButton.hidden = YES;
    }
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)];
    [self.imageView addGestureRecognizer:tap];
}
- (void)showPicture
{
    XMGShowPictureViewController *showPicture = [[XMGShowPictureViewController alloc]init];
    //传递模型给控制器
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
@end
