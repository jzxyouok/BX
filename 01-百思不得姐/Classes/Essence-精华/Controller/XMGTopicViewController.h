//
//  XMGTopicViewController.h
//  01-百思不得姐
//
//  Created by love on 16/5/21.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    XMGTpoicTypeAll = 1,
    XMGTpoicTypeImage = 10,
    XMGTpoicTypeWord = 29,
    XMGTpoicTypeSound = 31,
    XMGTpoicTypeMovie = 41
}XMGTpoicType;
@interface XMGTopicViewController : UITableViewController
@property (nonatomic, assign) XMGTpoicType type;
@end
