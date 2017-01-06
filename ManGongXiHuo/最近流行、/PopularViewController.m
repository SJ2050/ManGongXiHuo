//
//  PopularViewController.m
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-10.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "PopularViewController.h"
#import "PopularTableViewCell.h"
#import "DBHelper.h"
#import "worksModel.h"
#import <sqlite3.h>
#import "worksDetaitleViewController.h"
#import "DetailTableViewCell.h"



#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface PopularViewController ()<popTableDelegate>
{
    NSMutableArray *dataArray;
   
}
@end

@implementation PopularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = RGB(241, 241, 231);
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"PopularTableViewCell" bundle:nil] forCellReuseIdentifier:@"acell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initData];
    
}


- (void)initData{
    dataArray = [NSMutableArray arrayWithCapacity:0];
    DBHelper *db = [DBHelper dbHelper];
    //构造sql语句
    NSString *sql = @"select * from worksInfo";
    sqlite3_stmt *stmt = [db selectDB:sql];
    
    //得到数据
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSLog(@"成功进入");
        //创建数据模型对象
        worksModel *work = [[worksModel alloc] init];
        //将数据 存到数据模型中
        const char *ch = (const char *)sqlite3_column_text(stmt, 1) ;
        NSString *strname = [NSString stringWithUTF8String:ch];
        work.worksName = strname;
        
        work.worksId = sqlite3_column_int(stmt, 0);
        work.price = sqlite3_column_double(stmt, 2);
        work.typeId =sqlite3_column_int(stmt, 3);
        work.introduce =[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
        work.holderId =sqlite3_column_int(stmt, 5);
        work.shelfTimer = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)];
        
        [dataArray addObject:work];
    }
    //刷新表格
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   //传值   上级到下级  用属性
    worksDetaitleViewController *detailCtl = [[worksDetaitleViewController alloc] init];
    detailCtl.works = [dataArray objectAtIndex:indexPath.row];
    detailCtl.hidesBottomBarWhenPushed = YES;

    //导航栏页面跳转
    [self.navigationController pushViewController:detailCtl animated:YES];


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PopularTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.workModel = [dataArray objectAtIndex:indexPath.row];
    //设置选中行样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置tag值
    cell.detailBtn.tag = indexPath.row+1;
    cell.delegate = self;
    return cell;
}

- (void)pushDetailViewCtl:(NSInteger)tag{
    worksDetaitleViewController *worksCtl = [[worksDetaitleViewController alloc] init];
    worksCtl.works = [dataArray objectAtIndex:tag-1];
    worksCtl.hidesBottomBarWhenPushed = YES;
    worksCtl.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:worksCtl animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.width/(351.0/238.0);
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
