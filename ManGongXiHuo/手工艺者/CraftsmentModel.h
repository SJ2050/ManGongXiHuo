//
//  CraftsmentModel.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-14.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CraftsmentModel : NSObject

@property(assign,nonatomic)int userId;//用户者id

@property(copy,nonatomic)NSString *userName;//用户名

@property(copy,nonatomic)NSString *userPwd;//用户密码

@property(strong,nonatomic)UIImage *phone;//图片

@property(strong,nonatomic)UIImage *backgtoundImg;//背景图片

@property(assign,nonatomic)float balance;//余额

@property(copy,nonatomic)NSString *address;//地址

@property(copy,nonatomic)NSString *signature;//签名

@property(copy,nonatomic)NSString *nickName;//昵称

@end
