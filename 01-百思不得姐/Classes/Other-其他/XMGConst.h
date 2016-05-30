//
//  XMGConst.h
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//
#import <UIKit/UIKit.h>
/**
 *帖子的类型
 */
typedef enum {
    XMGTpoicTypeAll = 1,
    XMGTpoicTypeImage = 10,
    XMGTpoicTypeWord = 29,
    XMGTpoicTypeSound = 31,
    XMGTpoicTypeMovie = 41
}XMGTpoicType;
UIKIT_EXTERN CGFloat const titleViewHeight;
UIKIT_EXTERN CGFloat const titleViewY;
UIKIT_EXTERN CGFloat const cellTextLabelY;
UIKIT_EXTERN CGFloat const cellBottomViewH;
UIKIT_EXTERN CGFloat const XMGTopicMargin;
UIKIT_EXTERN CGFloat const XMGTopicPictureMaxH;
UIKIT_EXTERN CGFloat const XMGTopicPictureBreakH;
UIKIT_EXTERN NSString * const XMGUserSexMale;
UIKIT_EXTERN NSString * const XMGUserSexFemale;