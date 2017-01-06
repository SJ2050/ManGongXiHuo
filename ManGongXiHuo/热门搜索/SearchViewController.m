//
//  SearchViewController.m
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-10.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchModel.h"
#import <sqlite3.h>
#import "DBHelper.h"
#import "TypeViewController.h"

@interface SearchViewController ()
{
    UIView *views;
    NSMutableArray *dataArray;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    self.tableView.backgroundColor = RGB(241, 241, 231);
    views = [[UIView alloc] init];
    views.frame = CGRectMake(0, 20, 320, 190);
    self.tableView.tableHeaderView = views;
    [self initData];
}


- (void)createView{
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 132)];
    myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myView];
    
    UITextField *textfiled = [[UITextField alloc] initWithFrame:CGRectMake(10, 13, 300, 35)];
    textfiled.placeholder = @" 手工作品搜索";
    //得到焦点
    //[textfiled becomeFirstResponder];
    textfiled.layer.borderWidth = 0.3;
    textfiled.layer.borderColor = [UIColor grayColor].CGColor;
    
    textfiled.layer.cornerRadius = 6;
    textfiled.layer.masksToBounds = YES;
    textfiled.backgroundColor = [UIColor whiteColor];
    
    //左视图
     UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 25,25)];
    imgView.image = [UIImage imageNamed:@"ss.png"];
    textfiled.leftView = imgView;
     textfiled.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textfiled];
    
    
    UIImageView *oneImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 100, 95)];
    oneImg.image = [UIImage imageNamed:@"e2d7bd1799221dff4478844b04dba653.jpg"];
    
    UIImageView *twoImg = [[UIImageView alloc] initWithFrame:CGRectMake(110, 20, 100, 95)];
    twoImg.image = [UIImage imageNamed:@"u=3156948690,3267344864&fm=21&gp=0.jpg"];
    
    UIImageView *threeImg = [[UIImageView alloc] initWithFrame:CGRectMake(215, 20, 100, 95)];
    threeImg.image = [UIImage imageNamed:@"u=669676523,1857370482&fm=21&gp=0.jpg"];
    [myView addSubview:oneImg];
    [myView addSubview:twoImg];
    [myView addSubview:threeImg];
}

- (void)initData{
    dataArray = [NSMutableArray arrayWithCapacity:0];
    DBHelper *db = [DBHelper dbHelper];
    //构造sql语句
    NSString *sql = @"select * from typeInfo";
    sqlite3_stmt *stmt = [db selectDB:sql];
    
    //得到数据
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSLog(@"成功进入");
        //创建数据模型对象
        SearchModel *search = [[SearchModel alloc] init];
     
        //将数据 存到数据模型中
        const char *ch = (const char *)sqlite3_column_text(stmt, 1) ;
        NSString *strname = [NSString stringWithUTF8String:ch];
        search.typeName = strname;
        
        search.typeId = sqlite3_column_int(stmt, 0);
        search.typeIntrol = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
        [dataArray addObject:search];
    }
    //刷新表格
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //传值   上级到下级  用属性
    TypeViewController *typeCtl = [[TypeViewController alloc] init];
    typeCtl.sModel = [dataArray objectAtIndex:indexPath.row];
    typeCtl.hidesBottomBarWhenPushed = YES;
    
    //导航栏页面跳转
    [self.navigationController pushViewController:typeCtl animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"有%ld条数据",(unsigned long)dataArray.count);
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     重用机制
     */
    //去复用池寻找 是否有 acell 类型的单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
   
    //如果没有就创建一个 并且设置其 类型为 acell 样式为默认的
    if(!cell)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"acell"];
        //cell.tag = indexPath.row + 1;
    }
   
    cell.backgroundColor = [UIColor clearColor];
    SearchModel *search = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d、%@",search.typeId,search.typeName];
    cell.textLabel.textColor = MAINCOLOR;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    //失去焦点
//    for (UIView *viewss in self.view.subviews) {
//        if([viewss isKindOfClass:[UITextField class]])
//        {
//            UITextField *filed = (UITextField *)viewss;
//            //失去焦点
//            [filed resignFirstResponder];
//        }
//    }
//}

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
