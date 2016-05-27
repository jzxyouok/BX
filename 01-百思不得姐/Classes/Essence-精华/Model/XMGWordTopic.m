//
//  XMGWordTopic.m
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGWordTopic.h"
#import "NSDate+XMGExtension.h"
@interface  XMGWordTopic()
//记录文字label的高度
@property (nonatomic, assign) CGFloat labelH;

@end

@implementation XMGWordTopic
{
    //私有成员变量
    CGFloat _cellHeight;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2"
             };
}
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //发帖时间
    NSDate *create = [fmt dateFromString:_created_at];
    if ([create isThisYear]) {
        if ([create isToday]) {
            //是今天
            NSDateComponents *cmps = [[NSDate date] deltaFromDate:create];
            if (cmps.hour >=1) {
                //今天其他
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute>=1) {
                //今天1小时内
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else {
                //今天1分钟内
                return [NSString stringWithFormat:@"刚刚"];
            }
        }else if ([create isYesterday]) {
            //是昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [NSString stringWithFormat:@"%@",[fmt stringFromDate:create]];
        }else {
            //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [NSString stringWithFormat:@"%@",[fmt stringFromDate:create]];
        }
    }else {
        //不是今年
        return [NSString stringWithFormat:@"%@",_created_at];
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width-4*XMGTopicMargin, MAXFLOAT);
        self.labelH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
       //文字
            _cellHeight = cellTextLabelY+cellBottomViewH+self.labelH+XMGTopicMargin;
        //如果是图片帖子
        if (self.type == XMGTpoicTypeImage) {
            CGFloat imageW = maxSize.width;
            CGFloat imageH = imageW * self.height / self.width;
            //判断中间内容的高度是否超过最大的高度,使用BreakH
            if (imageH >= XMGTopicPictureMaxH) {
                imageH = XMGTopicPictureBreakH;
                self.tooBig = YES;
            }
            _cellHeight = cellTextLabelY+cellBottomViewH+self.labelH+2*XMGTopicMargin+imageH;
            //图片帖子中间的尺寸
            _pictureFrame = CGRectMake(XMGTopicMargin, cellTextLabelY+self.labelH+XMGTopicMargin, imageW, imageH);
        }else if (self.type == XMGTpoicTypeSound) {
            //如果是声音帖子
            CGFloat imageW = maxSize.width;
            CGFloat imageH = imageW * self.height / self.width;
            _cellHeight = cellTextLabelY+cellBottomViewH+self.labelH+2*XMGTopicMargin+imageH;
            //声音帖子中间的尺寸
            _voiceFrame = CGRectMake(XMGTopicMargin, cellTextLabelY+self.labelH+XMGTopicMargin, imageW, imageH);
        }
        //补偿
        _cellHeight +=XMGTopicMargin;
    }
    return _cellHeight;
}
@end
