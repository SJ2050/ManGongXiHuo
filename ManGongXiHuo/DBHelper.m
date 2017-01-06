//
//  DBHelper.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-13.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "DBHelper.h"
#define DBNAME @"SlowAccumulationData"
#define DBTYPE @"db"
@implementation DBHelper
static DBHelper *helper;
+ (id)dbHelper{
    if (!helper) {
        helper = [[DBHelper alloc] init];
    }
    return helper;
}
- (BOOL)moveDBHelper{
   //得到数据库在资源包中的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:DBNAME ofType:DBTYPE];
   
    
    
    //构建沙盒路径
    documentPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES) firstObject] stringByAppendingFormat:@"/%@",DBNAME];
    NSLog(@"%@",documentPath);
    //判断沙盒路径是否存在
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if (![fm fileExistsAtPath:documentPath]) {
        if ([fm copyItemAtPath:path toPath:documentPath error:nil]) {
            NSLog(@"复制成功");
            return YES;
        }
        else{
            NSLog(@"复制失败");
            return NO;
        }
    }
    else{
        NSLog(@"文件已存在");
    }
    return YES;
}

//打开数据库
- (BOOL)openDB{
   int isok = sqlite3_open([documentPath UTF8String], &db);
    if (isok == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        return YES;
    }
    
    NSLog(@"数据库打开失败");
    return NO;
}

//关闭数据库
- (BOOL)closeDBHelper{
    
    sqlite3_free(nil);
    sqlite3_close(db);
    
    return YES;
}
//执行查询
- (sqlite3_stmt *)selectDB:(NSString *)sql{
 
    //1打开数据库
    //前提 确保数据库存在 并且可读可写
    //定义数据库句柄
    sqlite3_stmt *stmt;
    if ([self moveDBHelper]) {
        if ([self openDB]) {
            //2操作数据库
        int number = sqlite3_prepare(db, [sql UTF8String], -1, &stmt, NULL);
            if (number == SQLITE_OK) {
                [self closeDBHelper];
                return stmt;
            }
        }
    }
    //3关闭数据库
    [self closeDBHelper];
    return nil;
}
//执行非查询
- (BOOL)execDB:(NSString *)sql{
  
    if ([self moveDBHelper]) {
        if ([self openDB]) {
            //2操作数据库
            int number = sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL) ;
              if (number == SQLITE_OK) {
                [self closeDBHelper];
                return YES;
            }
        }
    }
    return NO;
}

//- (BOOL)updateDB:(NSString *)sql{
//    
//    if ([self moveDBHelper]) {
//        if ([self openDB]) {
//            //执行非查询语句
//            NSInteger number = sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);
//            if (number == SQLITE_OK) {
//                
//                [self closeDBHelper];
//                return YES;
//                
//            }
//        }
//    }
//    //关闭数据库
//    [self closeDBHelper];
//    return NO;
//}
@end
