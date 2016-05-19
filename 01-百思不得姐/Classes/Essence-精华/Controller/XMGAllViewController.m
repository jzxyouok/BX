//
//  XMGAllViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGAllViewController.h"

@interface XMGAllViewController ()

@end

@implementation XMGAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置内边距
    [self setUpView];
   }
- (void)setUpView
{
    CGFloat top = titleViewY + titleViewHeight;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
static NSString * const Id = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    [cell.textLabel setText:[NSString stringWithFormat:@"%@-----%zd",NSStringFromClass([self class]),indexPath.row]];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

@end
