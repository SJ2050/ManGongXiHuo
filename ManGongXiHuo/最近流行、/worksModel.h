//
//  worksModel.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-13.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface worksModel : NSObject
@property(assign,readwrite,nonatomic)int worksId;//作品id

@property(copy,readwrite,nonatomic)NSString *worksName;//作品名称

@property(assign,readwrite,nonatomic)float price;//作品价格

@property(assign,readwrite,nonatomic)int typeId;//作品类型id

@property(copy,readwrite,nonatomic)NSString *introduce;//作品简介

@property(assign,readwrite,nonatomic)int holderId;//作品拥有者id

@property(copy,readwrite,nonatomic)NSString *shelfTimer;//作品发布时间
@property(strong,nonatomic)UIImage *image;
@end
