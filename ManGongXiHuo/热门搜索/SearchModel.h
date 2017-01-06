//
//  SearchModel.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-17.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property(assign,nonatomic)int typeId;//商品类型id
@property(copy,nonatomic)NSString *typeName;//商品名称
@property(copy,nonatomic)NSString *typeIntrol;//介绍

@end
