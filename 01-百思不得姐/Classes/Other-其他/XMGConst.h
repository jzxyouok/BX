//
//  XMGConst.h
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//
#import <UIKit/UIKit.h>
/**帖子的类型 */
typedef enum {
    XMGTpoicTypeAll = 1,
    XMGTpoicTypeImage = 10,
    XMGTpoicTypeWord = 29,
    XMGTpoicTypeSound = 31,
    XMGTpoicTypeMovie = 41
}XMGTpoicType;
/*--------------------------------------------------------顶部视图---------------------------------------------------------------------*/
/**顶部视图的高度(全部,视频,音频,图片,段子) */
UIKIT_EXTERN CGFloat const titleViewHeight;
/**顶部视图的Y值 */
UIKIT_EXTERN CGFloat const titleViewY;


/*---------------------------------------------------------cell-----------------------------------------------------------------------*/
/**cell中文字label的Y值 */
UIKIT_EXTERN CGFloat const cellTextLabelY;
/**cell底部工具条的高度 */
UIKIT_EXTERN CGFloat const cellBottomViewH;
/**cell中控件的间距 */
UIKIT_EXTERN CGFloat const XMGTopicMargin;


/*---------------------------------------------------------图片帖子---------------------------------------------------------------------*/
/**图片帖子中间图片的最大高度 */
UIKIT_EXTERN CGFloat const XMGTopicPictureMaxH;
/**图片帖子中间的图片超过最大高度 使用BreakH */
UIKIT_EXTERN CGFloat const XMGTopicPictureBreakH;


/*---------------------------------------------------------XMGUser---------------------------------------------------------------------*/
/**XMGUser模型中的男性 */
UIKIT_EXTERN NSString * const XMGUserSexMale;
/**XMGUser模型中的女性 */
UIKIT_EXTERN NSString * const XMGUserSexFemale;


/*----------------------------------------------------------评论------------------------------------------------------------------------*/
/**最热评论的文字高度 */
UIKIT_EXTERN CGFloat const XMGTopCmtH;
/**评论列表组头部高度 */
UIKIT_EXTERN CGFloat const XMGSectionHeaderH;
/**评论列表组头部文字大小 */
UIKIT_EXTERN CGFloat const XMGSectionHeaderFont;
/**评论文字的大小 */
UIKIT_EXTERN CGFloat const XMGCommentLabelFont;