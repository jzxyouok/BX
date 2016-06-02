//
//  XMGCommentHeaderFooterView.h
//  01-百思不得姐
//
//  Created by love on 16/6/2.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGCommentHeaderFooterView : UITableViewHeaderFooterView
/**显示的文字 */
@property (nonatomic, copy) NSString *title;
+ (instancetype)headerFooterViewWith:(UITableView *)tableview;
@end
