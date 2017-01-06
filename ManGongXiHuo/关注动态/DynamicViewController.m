
//
//  DynamicViewController.m
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-10.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "DynamicViewController.h"
#import "DynamicTableViewCell.h"
#import "ViewController.h"
#import "LoginView.h"
#import "DBHelper.h"
#import "CraftsmentModel.h"
#import "worksModel.h"
#import "worksDetaitleViewController.h"


@interface DynamicViewController ()<LoginDelegate>
{
    NSMutableArray *dataArray;
    NSMutableArray *worksArray;
    LoginView *loginView;
    UIView *bgView;
}
@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"DynamicTableViewCell" bundle:nil] forCellReuseIdentifier:@"acell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initData];
}

- (void)initData{
    //单列模式
    DBHelper *dbhelper = [DBHelper dbHelper];
    worksArray = [[NSMutableArray alloc] initWithCapacity:0];
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
    //查询用户下的所有作品
    for (int i = 0; i<dataArray.count; i++) {
        NSMutableArray *userArray = [NSMutableArray arrayWithCapacity:0];
        //构建sql
        CraftsmentModel *cModel = dataArray[i];
        int userid = cModel.userId;
        NSString *sql3 = [NSString stringWithFormat:@"select * from worksInfo where id = %d",userid];
        sqlite3_stmt *stmt2 = [dbhelper selectDB:sql3];
        while (sqlite3_step(stmt2) == SQLITE_ROW) {
            
            //创建数据模型对象
            worksModel *work = [[worksModel alloc] init];
            //将数据 存到数据模型中
            const char *ch = (const char *)sqlite3_column_text(stmt2, 1) ;
            NSString *strname = [NSString stringWithUTF8String:ch];
            work.worksName = strname;
            
            work.worksId = sqlite3_column_int(stmt2, 0);
            work.price = sqlite3_column_double(stmt2, 2);
            work.typeId =sqlite3_column_int(stmt2, 3);
            work.introduce =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt2, 4)];
            work.holderId =sqlite3_column_int(stmt2, 5);
            work.shelfTimer = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt2, 6)];
            
            [userArray addObject:work];
            
        }
        [worksArray addObject:userArray];
       
    }
    
    
    
    //刷新表格
    [self.tableView reloadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)viewWillAppear:(BOOL)animated{
//    [self isLogin];
//}

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
        if(!bgView)
        {
            [self createLoginView];
            
        }
        
        [self.view addSubview:bgView];
     
        
    }
    else
    {
        //如果未登录
        //1、移除内容视图
        [bgView removeFromSuperview];
        
        //2、登陆视图添加到 主视图中
        [self createLoginView];
        [self.view addSubview:loginView];
    }
    
    
}

- (void)login{
    ViewController *viewCtl = [[ViewController alloc] init];
    //模态跳转
    [self presentViewController:viewCtl animated:YES completion:nil];
}

- (void)createLoginView{
    loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    loginView.delegate = self;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell" forIndexPath:indexPath];
    cell.backgroundColor = BGCOLOR;
    cell.cModels = [dataArray objectAtIndex:indexPath.row];
    cell.wArray = [worksArray objectAtIndex:indexPath.row];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    worksDetaitleViewController *worksCtl = [[worksDetaitleViewController alloc] init];
    worksModel *wModel = [[worksModel alloc] init];
    
    worksCtl.cModel = [dataArray objectAtIndex:indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
