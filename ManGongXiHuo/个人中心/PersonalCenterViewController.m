
//
//  PersonalCenterViewController.m
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-10.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "ViewController.h"
#import "LoginView.h"
#import "setViewController.h"
#import "TarenViewController.h"
#import "setViewController.h"
#import "DBHelper.h"
#import <sqlite3.h>
#import "worksModel.h"


@interface PersonalCenterViewController ()<LoginDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *topView;
    UIView *downView;
    
    UIImageView *bgImgView;
    UILabel *nameLab;
    UILabel *sigLab;
    UIButton *headerImg;
    UIButton *allBtn;
    
    NSMutableArray *dataArray;
    NSMutableArray *worksArray;
    
    UITableView *myTable;
    LoginView *loginView;
    UIImageView *imgView;
   
    UIView *shopView;
    UIView *zuopinView;
}
@end

@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    [self createDownView];
    //[self initGuanzhu];
   // self.tableView.dataSource = self;
    
}


- (void)login{
    ViewController *viewCtl = [[ViewController alloc] init];
   //模态跳转
    [self presentViewController:viewCtl animated:YES completion:nil];
}

- (void)isLogin
{
    //只有 试图控制器 才能控制界面跳转
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *islogin = [defaults objectForKey:@"islogin"];
    if([islogin isEqualToString:@"YES"])
    {
        //如果已经登录
        //1、移除 登陆视图
        [loginView removeFromSuperview];
        //2、将内容视图添加到 主视图中(创建与否)
        if(!topView)
        {
            [self createTopView];
            [self createDownView];
        }
        
        [self.view addSubview:topView];
        [self.view addSubview:downView];
        
    }
    else
    {
        //如果未登录
        //1、移除内容视图
        [topView removeFromSuperview];
        [downView removeFromSuperview];
        //2、登陆视图添加到 主视图中
        [self createLoginView];
        [self.view addSubview:loginView];
    }
    
    
}

- (void)createTopView{
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_W/(11/6.0))];
    topView.backgroundColor = [UIColor purpleColor];
    /*
       背景图片
     */
    bgImgView = [[UIImageView alloc] initWithFrame:topView.bounds];
    bgImgView.image = [UIImage imageNamed:@"cc3.jpeg"];
    /*
       头像
     */
    headerImg = [[UIButton alloc] initWithFrame:CGRectMake(20, (topView.frame.size.height/5)*1.5, 60, 60)];
    [headerImg setBackgroundImage:[UIImage imageNamed:@"youxiang.jpg"] forState:UIControlStateNormal];
    
    headerImg.layer.borderWidth = 0.3;
    headerImg.layer.borderColor = [UIColor whiteColor].CGColor;
    //设置圆角
    headerImg.layer.cornerRadius = 4;
    //隐藏边框外的内容
    headerImg.layer.masksToBounds = YES;
    
    //事件
    [headerImg addTarget:self action:@selector(tiaozhuan) forControlEvents:UIControlEventTouchUpInside];
    /*
       名字
     */
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(90, headerImg.frame.origin.y, SCREEN_W-110, 15)];
    //字体加粗 大小
    nameLab.font = [UIFont boldSystemFontOfSize:18];
    nameLab.textColor = [UIColor whiteColor];
    //字体靠左边对齐
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.text = @"张小砚台";
    /*
       签名
     */
    sigLab = [[UILabel alloc] initWithFrame:CGRectMake(90,nameLab.frame.origin.y+16+5, nameLab.frame.size.width, 39)];
    //字体加粗 大小
    sigLab.font = [UIFont systemFontOfSize:16];
    sigLab.textColor = [UIColor whiteColor];
    //字体靠左边对齐
    sigLab.textAlignment = NSTextAlignmentLeft;
    sigLab.numberOfLines = 2;
    sigLab.text = @"以梦为马，驰骋岁月。以梦为马，诗酒趁年华！";
    /*
       设置图标
     */
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setBackgroundImage:[UIImage imageNamed:@"sz.png"] forState:UIControlStateNormal];
    //添加事件
    [btn addTarget:self action:@selector(pushBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //视图的顶点 坐标被重写  大小可以改变
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
    
    [topView addSubview:bgImgView];
    [topView addSubview:headerImg];
    [topView addSubview:nameLab];
    [topView addSubview:sigLab];
    [self.view addSubview:topView];
    [self createSegBtn];
}
////////////////////////////////////////////////
- (void)tiaozhuan{
    TarenViewController *tarenCtl = [[TarenViewController alloc] init];
    //导航栏页面跳转
    [self.navigationController pushViewController:tarenCtl animated:YES];
}
/////////////////////////

//concern创建四个分段按钮
- (void)createSegBtn{
    
    UIButton *worksBtn = [self createBtn:@"作品" andIndex:0];
    [topView addSubview:worksBtn];
    
    UIButton *shopBtn = [self createBtn:@"购物车" andIndex:1];
    [topView addSubview:shopBtn];
    
    UIButton *concernBtn = [self createBtn:@"关注" andIndex:2];
    [topView addSubview:concernBtn];
    
    UIButton *fansBtn = [self createBtn:@"粉丝" andIndex:3];
    [topView addSubview:fansBtn];
}
/*
   设置按钮封装成统一的方法
 */
- (UIButton *)createBtn:(NSString *)title andIndex:(int)index
{
    UIButton *segBtn = [[UIButton alloc] initWithFrame:CGRectMake(index*SCREEN_W/4.0, topView.frame.size.height- 25, SCREEN_W/4.0, 25)];
    [segBtn setTitle:title forState:UIControlStateNormal];
    segBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];//背景颜色透明度
    [segBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    segBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    //设置变宽
    segBtn.layer.borderWidth = 0.3;
    //添加事件
    [segBtn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    //设置tag值
    segBtn.tag = index+1;
    //字体加粗 大小
    segBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    return segBtn;
    
}

- (void)changeType:(UIButton *)btn
{
    [allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    allBtn = btn;
    
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    switch (btn.tag) {
        case 1:
            [shopView removeFromSuperview];
            [myTable removeFromSuperview];
            [imgView removeFromSuperview];
            [self zuopin];
            break;
        case 2:
             [myTable removeFromSuperview];
             [imgView removeFromSuperview];
            [zuopinView removeFromSuperview];
            [self shopCart];
            break;
        case 3:
            [shopView removeFromSuperview];
            [zuopinView removeFromSuperview];
            [self guanzhus];
           
            break;
        case 4:
            [shopView removeFromSuperview];
            [zuopinView removeFromSuperview];
            [myTable removeFromSuperview];

            [self fans];
            break;
        default:
            break;
    }
    
}
/*
  关注
 */
- (void)guanzhus{
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, downView.frame.size.height)];
    [self initGuanzhu];
    [downView addSubview:myTable];
    myTable.delegate = self;
    myTable.dataSource = self;
}
/*
 粉丝
 */
- (void)fans{
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, downView.frame.size.height-110)];
    imgView.image = [UIImage imageNamed:@"chi.jpg"];
    [downView addSubview:imgView];
}
/*
 购物车
 */
- (void)shopCart{
    shopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, downView.frame.size.height)];
    [downView addSubview:shopView];
     UITextField *myField = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 220, 30)];
    myField.layer.borderWidth = 1;
    myField.layer.borderColor = [UIColor grayColor].CGColor;
    myField.layer.cornerRadius = 5;
    myField.layer.masksToBounds = YES;
    myField.text = @"  账户余额:";
    myField.textColor = [UIColor grayColor];
    myField.alpha = 0.5;
    myField.backgroundColor = [UIColor whiteColor];
    /*
     money
     */
    UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 50, 20)];
    moneyLab.text = @"118";
    moneyLab.textColor = [UIColor grayColor];
    moneyLab.alpha = 0.7;
    /*
     充值
     */
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(170, 0, 50, 30)];
    [btn setTitle:@"充值" forState:UIControlStateNormal];
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    UIImageView *imgCart = [[UIImageView alloc] initWithFrame:CGRectMake(30, 100, 260, 170)];
    imgCart.image = [UIImage imageNamed:@"cc5.jpg"];
    /*
     名字
     */
    UILabel *nameLabs = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 260, 25)];
    nameLabs.text = @"  张艺兴";
    nameLabs.textColor = MAINCOLOR;
    nameLabs.font = [UIFont boldSystemFontOfSize:18];
    nameLabs.backgroundColor = [UIColor whiteColor];
    /*
     题目
     */
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, 260, 30)];
    title.text = @"  张艺兴 - 一个人                   >";
    title.textColor = MAINCOLOR;
    title.font = [UIFont boldSystemFontOfSize:18];
    title.backgroundColor = [UIColor whiteColor];
    
    
    [shopView addSubview:title];
    [shopView addSubview:nameLabs];
    [shopView addSubview:imgCart];
    [myField addSubview:btn];
    [myField addSubview:moneyLab];
     [shopView addSubview:myField];
   
}

/*
 zuop
 */
- (void)zuopin{
    CGFloat w = 90;
    CGFloat h = 70;
    CGFloat s = 15;
    zuopinView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, downView.frame.size.height)];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 10, 200, 30)];
    [btn setBackgroundImage:[UIImage imageNamed:@"shangchuan.png"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(s, 60, w, h)];
    imgView1.image = [UIImage imageNamed:@"cc1.jpg"];
    imgView1.layer.borderWidth = 1;
    imgView1.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(s+w+10, 60, w, h)];
    imgView2.image = [UIImage imageNamed:@"cc2.jpg"];
    imgView2.layer.borderWidth = 1;
    imgView2.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(s+w+10+w+10, 60, w, h)];
    imgView3.image = [UIImage imageNamed:@"cc3.jpeg"];
    imgView3.layer.borderWidth = 1;
    imgView3.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(s, 140, w, h)];
    imgView4.image = [UIImage imageNamed:@"cc4.jpg"];
    imgView4.layer.borderWidth = 1;
    imgView4.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView5 = [[UIImageView alloc] initWithFrame:CGRectMake(s+w+10, 140, w, h)];
    imgView5.image = [UIImage imageNamed:@"cc5.jpg"];
    imgView5.layer.borderWidth = 1;
    imgView5.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView6 = [[UIImageView alloc] initWithFrame:CGRectMake(s+w+10+w+10, 140, w, h)];
    imgView6.image = [UIImage imageNamed:@"cc6.jpg"];
    imgView6.layer.borderWidth = 1;
    imgView6.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView7 = [[UIImageView alloc] initWithFrame:CGRectMake(s, 220, w, h)];
    imgView7.image = [UIImage imageNamed:@"cc7.jpg"];
    imgView7.layer.borderWidth = 1;
    imgView7.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView8 = [[UIImageView alloc] initWithFrame:CGRectMake(s+w+10, 220, w, h)];
    imgView8.image = [UIImage imageNamed:@"cc8.jpg"];
    imgView8.layer.borderWidth = 1;
    imgView8.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UIImageView *imgView9 = [[UIImageView alloc] initWithFrame:CGRectMake(s+w+10+w+10, 220, w, h)];
    imgView9.image = [UIImage imageNamed:@"cc9.jpg"];
    imgView9.layer.borderWidth = 1;
    imgView9.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [zuopinView addSubview:imgView1];
    [zuopinView addSubview:imgView2];
    [zuopinView addSubview:imgView3];
    [zuopinView addSubview:imgView4];
    [zuopinView addSubview:imgView5];
    [zuopinView addSubview:imgView6];
    [zuopinView addSubview:imgView7];
    [zuopinView addSubview:imgView8];
    [zuopinView addSubview:imgView9];
    [zuopinView addSubview:btn];
    [downView addSubview:zuopinView];
}


- (void)createLoginView{
    loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    loginView.delegate = self;
}
/*下 ---------------------------------------------------*/
- (void)createDownView{
    downView = [[UIView alloc] initWithFrame:CGRectMake(0,topView.frame.size.height+64, SCREEN_W, SCREEN_H-topView.frame.size.height)];
    downView.backgroundColor = BGCOLOR;
   
 
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self isLogin];
}

- (void)pushBtn{
    
    setViewController *setCtl = [[setViewController alloc] init];
    //导航栏页面跳转
    [self.navigationController pushViewController:setCtl animated:YES];
}
/*
   关注   数据库
 */
- (void)initGuanzhu{
    //单列模式
    DBHelper *dbhelper = [DBHelper dbHelper];
    dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    //构建查询用户的sql语句
    NSString *sql = @"select * from userInformation";
    sqlite3_stmt *stmt = [dbhelper selectDB:sql];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSLog(@"有数据");
        
        CraftsmentModel *cModel = [[CraftsmentModel alloc] init];
        cModel.userId = sqlite3_column_int(stmt, 0);
        cModel.userName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
        cModel.userPwd = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 2)];
        cModel.balance =sqlite3_column_double(stmt, 5);
        cModel.address = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 6)];
        cModel.signature = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 7)];
        cModel.nickName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 8)];
        
        //添加到数组中
        [dataArray addObject:cModel];
    }
    //[self.tableView reloadData];
   
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
    //如果没有就创建一个 并且设置其 类型为 acell 样式为默认的
    if(!cell)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"acell"];
        //cell.tag = indexPath.row + 1;
    }
    /*
     关注
     */
    CraftsmentModel *cModel = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"         %@",cModel.nickName];

    cell.textLabel.textColor = MAINCOLOR;
    UIImageView *imgViews = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    imgViews.layer.borderWidth = 0.3;
    imgViews.layer.borderColor = [UIColor whiteColor].CGColor;
    imgViews.layer.cornerRadius = 4;
    imgViews.layer.masksToBounds = YES;
    imgViews.image = [UIImage imageNamed:@"bg1.jpg"];
    [cell.contentView addSubview:imgViews];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];
    cell.textLabel.adjustsFontSizeToFitWidth = NO;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
