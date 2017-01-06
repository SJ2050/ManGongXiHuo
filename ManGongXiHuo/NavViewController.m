//
//  NavViewController.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-11.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "NavViewController.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏 标题颜色 1、富文本  2、titleView
    self.navigationBar.barTintColor = [UIColor colorWithRed:40/255.0 green:101/255.0 blue:61/255.0 alpha:1];
    // 1、富文本
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
