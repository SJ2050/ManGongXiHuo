//
//  TarBarViewController.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-11.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "TarBarViewController.h"
#import "PersonalCenterViewController.h"
#import "DynamicViewController.h"
#import "SearchViewController.h"
#import "CraftsmenViewController.h"
#import "PopularViewController.h"
#import "NavViewController.h"


@interface TarBarViewController ()

@end

@implementation TarBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)createView{
    PopularViewController *popCtl = [[PopularViewController alloc] init];
    popCtl.title = @"慢工细活";

    popCtl.tabBarItem.title = @"最近流行";
    popCtl.tabBarItem.image = [[UIImage imageNamed:@"lx.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    popCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"lx_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NavViewController *navPop = [[NavViewController alloc] initWithRootViewController:popCtl];
    
    
    
    CraftsmenViewController  *craCtl = [[CraftsmenViewController alloc] init];
    craCtl.title = @"慢工细活";
    craCtl.tabBarItem.title = @"手工艺者";
    
    craCtl.tabBarItem.image = [[UIImage imageNamed:@"sgy.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    craCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"sgy_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NavViewController *navCra = [[NavViewController alloc] initWithRootViewController:craCtl];
    
    SearchViewController *searchCtl = [[SearchViewController alloc] init];
    searchCtl.tabBarItem.image = [[UIImage imageNamed:@"ss.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"ss_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchCtl.title = @"慢工细活";
    searchCtl.tabBarItem.title = @"热门搜索";
    searchCtl.tableView.backgroundColor = BGCOLOR;
    NavViewController *navSearch = [[NavViewController alloc] initWithRootViewController:searchCtl];
    
    
    DynamicViewController *dynCtl = [[DynamicViewController alloc] init];
    dynCtl.tabBarItem.image = [[UIImage imageNamed:@"gz.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dynCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"gz_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    dynCtl.title = @"慢工细活";
    dynCtl.tabBarItem.title = @"关注动态";
    dynCtl.tableView.backgroundColor = BGCOLOR;
    NavViewController *navDyn = [[NavViewController alloc] initWithRootViewController:dynCtl];
    
    
    PersonalCenterViewController *perCtl = [[PersonalCenterViewController alloc] init];
    perCtl.tabBarItem.image = [[UIImage imageNamed:@"user.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    perCtl.tabBarItem.selectedImage = [[UIImage imageNamed:@"user_1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    perCtl.title = @"慢工细活";
    perCtl.tabBarItem.title = @"个人中心";
    perCtl.view.backgroundColor = [UIColor whiteColor];
    NavViewController *navPer = [[NavViewController alloc] initWithRootViewController:perCtl];
    
    self.viewControllers = @[navPop,navCra,navSearch,navDyn,navPer];
    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor whiteColor];
    
    //[self setSelectedIndex:3];
    
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
