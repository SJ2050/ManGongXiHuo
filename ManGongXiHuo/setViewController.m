//
//  setViewController.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-22.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "setViewController.h"

@interface setViewController ()
{
    UIView *views;
}
@end

@implementation setViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createBtn];
    [self createPic];
     self.navigationItem.title = @"设置";
    
    
}

- (void)createBtn{
    UIButton *left = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [left setTitle:@"取消" forState:UIControlStateNormal];
    //设置阴影
    left.layer.shadowOffset = CGSizeMake(0, 2);
    left.layer.shadowOpacity = 0.9;
    left.layer.borderWidth = 2;
    left.layer.borderColor = MAINCOLOR.CGColor;
    left.layer.cornerRadius = 8;
    left.layer.masksToBounds = YES;
    //添加事件
     [left addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:left];
    //视图的顶点 坐标被重写  大小可以改变
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    /*
      完成
     */
    UIButton *right = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [right setTitle:@"完成" forState:UIControlStateNormal];
    //设置阴影
    right.layer.shadowOffset = CGSizeMake(0, 2);
    right.layer.shadowOpacity = 0.9;
    right.layer.borderWidth = 2;
    right.layer.borderColor = MAINCOLOR.CGColor;
    right.layer.cornerRadius = 8;
    right.layer.masksToBounds = YES;
    //添加事件
    [right addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:right];
    //视图的顶点 坐标被重写  大小可以改变
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
}

- (void)createPic{
    
    views = [[UIView alloc] init];
    views.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    views.backgroundColor = BGCOLOR;
    [self.view addSubview:views];
    /*
     联系地址
     */
    CGFloat heights = 90;
    CGFloat gao = 50;
    UIButton *addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, heights, 260, gao)];
    [addressBtn setBackgroundImage:[UIImage imageNamed:@"address.png"] forState:UIControlStateNormal];
    [views addSubview:addressBtn];
    /*
       自动更新
     */
    UIButton *zidongBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, heights+gao+20, 260, 50)];
    [zidongBtn setBackgroundImage:[UIImage imageNamed:@"zigonggengxin.png"] forState:UIControlStateNormal];
    [views addSubview:zidongBtn];
    /*
       更新通知
     */
    UIButton *tongzhiBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, heights+(gao*2)+25, 260, 50)];
    [tongzhiBtn setBackgroundImage:[UIImage imageNamed:@"dengxintongzhi.png"] forState:UIControlStateNormal];
    [views addSubview:tongzhiBtn];
    /*
      绑定微博号
     */
    UIButton *  weiboBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, heights+(gao*3)+30, 260, 50)];
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"bangdingweibo.png"] forState:UIControlStateNormal];
    [views addSubview:weiboBtn];
    /*
     
     给我们一个好评*/
    UIButton *goodBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, heights+(gao*4)+50, 260, 50)];
    [goodBtn setBackgroundImage:[UIImage imageNamed:@"haoping.png"] forState:UIControlStateNormal];
    [views addSubview:goodBtn];
    /*
       意见反馈
     */
    UIButton *yijianBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, heights+(gao*5)+55, 260, 50)];
    [yijianBtn setBackgroundImage:[UIImage imageNamed:@"yijian.png"] forState:UIControlStateNormal];
    [views addSubview:yijianBtn];
    /*
    清除缓存
     */
    UIButton *huancunBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, heights+(gao*6)+70, 260, 50)];
    [huancunBtn setBackgroundImage:[UIImage imageNamed:@"huancun.png"] forState:UIControlStateNormal];
    [views addSubview:huancunBtn];
}
- (void)onBack
{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
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
