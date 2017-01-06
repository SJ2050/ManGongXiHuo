//
//  LoginView.m
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-17.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
        [self createMainView];
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:231/255.0 alpha:1];
    }
    return self;
}
- (void)createMainView{
    
/*
   登陆按钮
 */
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 121, 220, 40)];
    [loginBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor whiteColor];
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 5;
    //按钮中字体左对齐
    loginBtn.layer.masksToBounds = YES;
    loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    loginBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    UIButton *regBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 171, 220, 40)];
    [regBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
regBtn.backgroundColor = [UIColor whiteColor];
    regBtn.layer.cornerRadius = 5;
    regBtn.layer.masksToBounds = YES;
    //按钮中字体左对齐
    regBtn.layer.masksToBounds = YES;
    regBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    regBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    /*
       lab
     */
    UILabel *topLab = [[UILabel alloc] initWithFrame:CGRectMake(45, 80, 220, 50)];
    topLab.text = @"关注有趣的手工艺者？";
    topLab.font = [UIFont boldSystemFontOfSize:20];
    topLab.textColor = [UIColor grayColor];
    topLab.alpha = 0.6;
    UILabel *downLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 320, 260, 200)];
    downLab.text = @"那一年，转山转水转佛塔，不为修来生，只为途中与你相见。";
    downLab.alpha = 0.6;
    downLab.font = [UIFont boldSystemFontOfSize:18];
    downLab.textColor = [UIColor grayColor];
    downLab.numberOfLines = 0;
    
    UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(200, 440, 260, 30)];
    rightLab.text = @"—仓央嘉措";
    rightLab.alpha = 0.6;
    rightLab.font = [UIFont boldSystemFontOfSize:18];
    rightLab.textColor = [UIColor grayColor];
    /*
     >
     */
    UIButton *moreBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(220, 123, 40, 30)];
    [moreBtn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [moreBtn1 setTitle:@">" forState:UIControlStateNormal];
    moreBtn1.backgroundColor = [UIColor whiteColor];
    moreBtn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    UIButton *moreBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(220, 173, 45, 30)];
    [moreBtn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [moreBtn2 setTitle:@">" forState:UIControlStateNormal];
    moreBtn2.backgroundColor = [UIColor whiteColor];
    moreBtn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];

   
    [self addSubview:rightLab];
    [self addSubview:downLab];
    [self addSubview:topLab];
    //[self addSubview:regBtn];
    [self addSubview:loginBtn];
    [self addSubview:moreBtn1];
    //[self addSubview:moreBtn2];
    
}

- (void)login
{
    [self.delegate login];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
