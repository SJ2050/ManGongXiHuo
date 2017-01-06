//
//  DBHelper.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-13.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DBHelper : NSObject
{
    sqlite3 *db;
    NSString *documentPath;
}
//执行查询
- (sqlite3_stmt *)selectDB:(NSString *)sql;
//执行非查询
- (BOOL)execDB:(NSString *)sql;
+ (id)dbHelper;
//- (BOOL)updateDB:(NSString *)sql;
@end
