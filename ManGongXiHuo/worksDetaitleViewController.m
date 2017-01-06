//
//  worksDetaitleViewController.m
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-12.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "worksDetaitleViewController.h"
#import "DetailTableViewCell.h"
#import "CraftsmentModel.h"
#import "DBHelper.h"
#import <sqlite3.h>

@interface worksDetaitleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *workDetailTable;
    UIView *tabBarView;
    NSMutableArray *dataArray;
    //收藏
    UIButton *collectBtn;
    
}

@end

@implementation worksDetaitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"[%@]",_works.worksName);
    [self setStyle];
     [self createTabBarView];
     [self createTableView];
    
       //[self initData];
}
- (void)initData
{
    //1、根据商品ID 查询 商品拥有者信息
    //2、查询该商品对的品论信息
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
- (void)createTableView
{
    workDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W,SCREEN_H-104)];
    workDetailTable.backgroundColor = BGCOLOR;
    workDetailTable.delegate = self;
    workDetailTable.dataSource = self;
    
    [workDetailTable registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"acell"];
    
    [self.view addSubview:workDetailTable];
}
- (void)createTabBarView
{
    
    tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_H-40, SCREEN_W, 40)];
    tabBarView.backgroundColor = [UIColor blackColor];
    
    
    /*
     购物车
     */
    UIButton *shopBtn = [self createBtn:[UIImage imageNamed:@"gouwuche1.png"] andIndex:0];
    [tabBarView addSubview:shopBtn];
    /*
     收藏
     */
    collectBtn = [self createBtn:[UIImage imageNamed:@"taoxin.png"] andIndex:1];
    collectBtn.tag = 1;
    [collectBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:collectBtn];
    
    /*
     评论
     */
    UIButton *commentBtn = [self createBtn:[UIImage imageNamed:@"pinlun.png"] andIndex:2];
    [tabBarView addSubview:commentBtn];
    /*
     分享
     */
    UIButton *shareBtn = [self createBtn:[UIImage imageNamed:@"fenxiang.png"] andIndex:3];
    [tabBarView addSubview:shareBtn];
    
    [self.view addSubview:tabBarView];
}

- (void)changeBtn:(UIButton *)btn{
    if (btn.tag == 1) {
        collectBtn.tag = 2;
        [collectBtn setBackgroundImage:[UIImage imageNamed:@"taoxin1.png"] forState:UIControlStateNormal];
    }else if(btn.tag == 2){
        collectBtn.tag = 1;
        [collectBtn setBackgroundImage:[UIImage imageNamed:@"taoxin.png"] forState:UIControlStateNormal];
    }
}

/*
 设置按钮封装成统一的方法
 */
- (UIButton *)createBtn:(UIImage *)images andIndex:(int)index
{
    UIButton *segBtn = [[UIButton alloc] initWithFrame:CGRectMake(index*tabBarView.frame.size.width/4.0+30, 10, 20, 20)];
    [segBtn setBackgroundImage:images forState:UIControlStateNormal];
    return segBtn;
    
}
- (void)setStyle
{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [leftBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row == 0)
//    {
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell" forIndexPath:indexPath];
        cell.wModel = _works;
   
    //设置表格样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //CraftsmentModel *craft = [dataArray objectAtIndex:indexPath.row];
    NSLog(@"有%d条数据",dataArray.count);
    //NSLog(@"%@",craft);
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",craft.nickName];
//    
    cell.cModel = _cModel;
        return cell;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
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
