//
//  XMGShowPictureViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/24.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGShowPictureViewController.h"
#import <UIImageView+WebCache.h>
#import "XMGWordTopic.h"
#import <SVProgressHUD.h>
#import "XMGProgressView.h"
@interface XMGShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;
- (IBAction)back;
- (IBAction)savePicture;
- (IBAction)share;

@end

@implementation XMGShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //最终显示的宽度:屏幕宽  高度:屏幕宽 * 高度 / 宽度
    //屏幕的宽度
    CGFloat imageW = XMGScreenWidth;
    CGFloat imageH = imageW * self.topic.height / self.topic.width;
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [imageView addGestureRecognizer:tap];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    if (imageH >=XMGScreenHeight) {
        //滚动显示
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
    }else {
        //居中显示
        imageView.size = CGSizeMake(imageW, imageH);
        imageView.centerX = XMGScreenWidth * 0.5;
        imageView.centerY = XMGScreenHeight * 0.5;
    }
    //立马显示模型中的下载进度
    [self.progressView setProgress:_topic.pictureProgress animated:NO];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        _topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:_topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture {
    //图片没有下载完成时,提醒用户
    if (!self.imageView.image) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完成!"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)share {
}
//图片保存
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}

@end
