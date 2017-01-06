//
//  ViewController.m
//  Login
//
//  Created by teacher on 16-9-1.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "ViewController.h"
#define W  self.view.frame.size.width
#define H self.view.frame.size.height
#import "DBHelper.h"
#import <sqlite3.h>
#define DBNAME @"SlowAccumulationData"
#define DBTYPE @"db"

@interface ViewController ()<UITextFieldDelegate>
{
    UIButton *loginBtn;
    UIButton *regBtn;
    UITextField *userText;
    UITextField *pwdText;
    NSString *documentsPath;
}
@end
//1188967.jpg
@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[self scaleImage:[UIImage imageNamed:@"44.jpeg"] ToSize:CGSizeMake(W, H)]];
    [self createText];
    [self createBtn];
    [self createLab];

}



- (void)createLab{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(60, 70, 200, 30)];
    lab.text = @"Welcome to visit!";
    //字体大小
    //lab.font = [UIFont systemFontOfSize:25];
    lab.font = [UIFont fontWithName:@"Marker Felt" size:30];
    //适应lable的宽度
    lab.adjustsFontSizeToFitWidth = YES;
    lab.textColor =MAINCOLOR;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.shadowColor = [UIColor greenColor];
    lab.shadowOffset = CGSizeMake(1.0, 1.0);
    NSArray *array = [UIFont familyNames];
    NSLog(@"%@",array);
    
    [self.view addSubview:lab];
}

- (void)createText{
    //创建文本框
    userText = [[UITextField alloc] initWithFrame:CGRectMake(60, 120, 200, 30)];
    pwdText = [[UITextField alloc] initWithFrame:CGRectMake(60, 160, 200, 30)];
    //得到焦点
    [userText becomeFirstResponder];
    [pwdText becomeFirstResponder];
    //设置提示语句
    userText.placeholder = @"请输入用户名";
    pwdText.placeholder = @"请输入密码";
    pwdText.secureTextEntry = YES;
//    text.text = @"用户名：";
//    text1.text = @"密码：";
    
    //设置对齐方式
    userText.textAlignment = NSTextAlignmentLeft;
    pwdText.textAlignment = NSTextAlignmentLeft;
    //设置颜色
    userText.textColor = MAINCOLOR;
     pwdText.textColor = MAINCOLOR;
    //设置边框样式
    userText.borderStyle = UITextBorderStyleRoundedRect ;
    pwdText.borderStyle = UITextBorderStyleRoundedRect ;
    //透明度
    userText.alpha = 0.6;
    pwdText.alpha = 0.6;
    //再次编辑时清空内容
   // text.clearsOnBeginEditing = YES;
    //设置清空按钮的显示
    userText.clearButtonMode = UITextFieldViewModeAlways;
    pwdText.clearButtonMode = UITextFieldViewModeAlways;

    userText.tag = 1;
    pwdText.tag = 2;
    
    userText.delegate = self;
    pwdText.delegate = self;
    //将文本框添加到视图中
    [self.view addSubview:userText];
    [self.view addSubview:pwdText];
}

- (void)createBtn{
    loginBtn= [[UIButton alloc] initWithFrame:CGRectMake(70, 200, 80, 30)];
    //设置背景颜色
    //btn.backgroundColor = [UIColor purpleColor];
    //btn.alpha = 0.2;
    [loginBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    //设置颜色
    
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    
    [loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.titleLabel.font =[UIFont fontWithName:@"Noteworthy" size:15];
    //设置边框
    loginBtn.layer.borderColor = MAINCOLOR.CGColor;
    loginBtn.layer.borderWidth =  1;
    loginBtn.layer.cornerRadius = 10;
    //隐藏边框外的内容
    loginBtn.layer.masksToBounds = YES;
    
    
    
    regBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 200, 80, 30)];
    //设置背景颜色
    //btn.backgroundColor = [UIColor purpleColor];
    //btn.alpha = 0.2;
    [regBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    
    //设置颜色
    
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    [regBtn addTarget:self action:@selector(reg) forControlEvents:UIControlEventTouchUpInside];
    regBtn.titleLabel.font =[UIFont fontWithName:@"Noteworthy" size:15];
    //设置边框
    regBtn.layer.borderColor = MAINCOLOR.CGColor;
    regBtn.layer.borderWidth =  1;
    regBtn.layer.cornerRadius = 10;
    //隐藏边框外的内容
    regBtn.layer.masksToBounds = YES;
    //左视图
   // UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 0, 30, 30)];
    //imgView.image = [UIImage imageNamed:@"b.jpg"];
    //userText.leftView = imgView;
    userText.leftViewMode = UITextFieldViewModeAlways;
    
    //左视图
    //UIImageView *imgView1 = [[UIImageView alloc] /initWithFrame:CGRectMake(1, 0, 30, 30)];
   // imgView1.image = [UIImage imageNamed:@"a.jpg"];
   // pwdText.leftView = imgView1;
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    
    /*
       退出按钮
     */
    
    
    [self.view addSubview:loginBtn];
     [self.view addSubview:regBtn];
}



- (void)login
{
    //用户名
    if (userText.text.length <5 || userText.text.length>16) {
        NSLog(@"用户不合法");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不合法长度必须在5-16之间" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        userText.text = @"";
        [userText becomeFirstResponder];
        return;
    }
    
    //密码
    if (pwdText.text.length <6 || pwdText.text.length>16) {
        NSLog(@"用户不合法");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不合法长度必须在6-16之间" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        pwdText.text = @"";
        [pwdText becomeFirstResponder];
        return;
    }
    
    NSArray *userArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:DBNAME ofType:DBTYPE]];
    //得到数据库在资源包中的路径
   // NSString *path = [[NSBundle mainBundle] pathForResource:DBNAME ofType:DBTYPE];
    
    NSDictionary *dic = @{@"name":userText.text,@"pwd":pwdText.text};
    
    NSUInteger index = [userArray indexOfObject:dic];
    if ((int)index>0 || index == 2147483647) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];

     }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    
    }
    
    NSLog(@"%@ %d",userArray,index);
    
    NSLog(@"登陆。。。。。。。。。。。。。。。。");
    
    DBHelper *helper = [[DBHelper alloc] init];
    sqlite3_stmt *stmts = [helper selectDB:[NSString stringWithFormat:@"select *from userInformation where userName = '%@' and userPwd = '%@'",userText.text,pwdText.text]];
    while (sqlite3_step(stmts) == SQLITE_ROW) {
       // NSLog(@"登陆成功");
        //根据下标取值
        NSString *userName = [NSString stringWithFormat:@"%s",sqlite3_column_text(stmts, 1)];
        int userid = sqlite3_column_int(stmts, 0);
        NSLog(@"%@  %d",userName,userid);
       
        //登陆成功
        //修改登陆状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"YES" forKey:@"islogin"];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}


- (void)reg{
    //用户名
    if (userText.text.length <5 || userText.text.length>16) {
        NSLog(@"用户不合法");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不合法长度必须在5-16之间" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        userText.text = @"";
        [userText becomeFirstResponder];
        return;
    }
    
    //密码
    if (pwdText.text.length <6 || pwdText.text.length>16) {
        NSLog(@"用户不合法");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码不合法长度必须在6-16之间" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        pwdText.text = @"";
        [pwdText becomeFirstResponder];
        return;
    }
      // NSString *userArray1 = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"plist"];
     //NSLog(@"%@",userArray1);
   // NSString *path = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"plist"];
   // NSLog(@"%@",path);
   // NSString *documetPathList = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/user.plist"];
    //判断是否存在
    //NSFileManager *manager = [NSFileManager defaultManager];
   // if (![manager fileExistsAtPath:documetPathList]) {
  //      [manager copyItemAtPath:path toPath:documetPathList error:nil];
  //  }
 //   else{
  //      NSLog(@"存在");
        
  //  }
  //  NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:documetPathList];
  //  NSLog(@"%@",documetPathList);
   // NSLog(@"%@",array);
    
    
   // NSDictionary *dic = @{@"userName":@"andmin3",@"userPwd":@"andmin2"};
  // NSDictionary *dic = @{@"name":userText.text,@"pwd":pwdText.text};
    //[array addObject:dic];
   //
   // [array writeToFile:documetPathList atomically:NO];
    
    NSLog(@"注册........................................");
    
    DBHelper *help = [[DBHelper alloc] init];
    sqlite3_stmt *stmts = [help selectDB:[NSString stringWithFormat:@"select *from userInformation where userName = '%@' and userPwd = '%@'",userText.text,pwdText.text]];
    while (sqlite3_step(stmts) == SQLITE_ROW) {
        NSLog(@"该用户已存在，请登录");
        
        return;
    }
    if ([help execDB:[NSString stringWithFormat:@"insert into userInformation(userName,userPwd,photo,backgroundImage,balance,address,signature,nickName) values('%@','%@','image','image',0.0,'重庆','天天好心情','张艺兴')",userText.text,pwdText.text]]) {
        NSLog(@"注册成功");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
       NSLog(@"注册失败");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"%@",[NSValue valueWithRange:range]);
//    NSLog(@"%@",string);
    if (range.location>16) {
        return NO;
    }
    return YES;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self login];
    [textField resignFirstResponder];
    return YES;
}
//是否清空
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   //失去焦点
    for (UIView *views in self.view.subviews) {
        if([views isKindOfClass:[UITextField class]])
        {
            UITextField *filed = (UITextField *)views;
            //失去焦点
            [filed resignFirstResponder];
        }
    }
}

- (UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    
    UIImage *i;
    // 创建一个bitmap的context,并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    // 绘制改变大小的图片
    [img drawInRect:imageRect];
    // 从当前context中创建一个改变大小后的图片
    i=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return i;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
