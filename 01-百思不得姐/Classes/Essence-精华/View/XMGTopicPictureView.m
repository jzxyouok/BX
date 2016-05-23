//
//  XMGTopicPictureView.m
//  01-百思不得姐
//
//  Created by love on 16/5/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import <UIImageView+WebCache.h>
@interface XMGTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation XMGTopicPictureView
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)setTopic:(XMGWordTopic *)topic
{
    _topic = topic;
    //显示图片
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_topic.large_image]];
    //判断是否为gif图片
    NSString *extension = _topic.large_image.pathExtension;
    _gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    //判断是否需要显示点击显示全部
    if (_topic.isTooBig) {
        _seeBigButton.hidden = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else {
        _seeBigButton.hidden = YES;
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
