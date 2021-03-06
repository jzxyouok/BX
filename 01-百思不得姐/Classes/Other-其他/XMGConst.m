//
//  XMGConst.m
//  01-百思不得姐
//
//  Created by love on 16/5/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
/*--------------------------------------------------------顶部视图---------------------------------------------------------------------*/
/**顶部视图的高度(全部,视频,音频,图片,段子) */
CGFloat const titleViewHeight = 30;
/**顶部视图的Y值 */
CGFloat const titleViewY = 64;


/*---------------------------------------------------------cell-----------------------------------------------------------------------*/
/**cell中文字label的Y值 */
CGFloat const cellTextLabelY = 55;
/**cell底部工具条的高度 */
CGFloat const cellBottomViewH = 44;
/**cell中控件的间距 */
CGFloat const XMGTopicMargin = 10;
/**cell的重用标识符 */
NSString * const Id = @"cell";


/*---------------------------------------------------------图片帖子---------------------------------------------------------------------*/
/**图片帖子中间图片的最大高度 */
CGFloat const XMGTopicPictureMaxH = 1000;
/**图片帖子中间的图片超过最大高度 使用BreakH */
CGFloat const XMGTopicPictureBreakH = 250;


/*---------------------------------------------------------XMGUser---------------------------------------------------------------------*/
/**XMGUser模型中的男性 */
NSString * const XMGUserSexMale = @"m";
/**XMGUser模型中的女性 */
NSString * const XMGUserSexFemale = @"f";


/*----------------------------------------------------------评论------------------------------------------------------------------------*/
/**最热评论的文字高度 */
CGFloat const XMGTopCmtH = 17;
/**评论列表组头部高度 */
CGFloat const XMGSectionHeaderH = 44;
/**评论列表组头部文字大小 */
CGFloat const XMGSectionHeaderFont = 15;
/**评论文字的大小 */
CGFloat const XMGCommentLabelFont = 14;
/**header的重用标识符 */
NSString * const XMGCommentHeaderId = @"header";



