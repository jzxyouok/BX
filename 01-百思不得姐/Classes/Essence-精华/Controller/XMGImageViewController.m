//
//  XMGImageViewController.m
//  01-百思不得姐
//
//  Created by love on 16/5/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGImageViewController.h"

@interface XMGImageViewController ()

@end

@implementation XMGImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
