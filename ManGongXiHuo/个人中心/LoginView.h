//
//  LoginView.h
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-17.
//  Copyright (c) 2016年 teacher. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CraftsmentModel.h"
@protocol LoginDelegate <NSObject>

- (void)login;
- (void)reg;

@end
@interface LoginView : UIView
@property(assign,nonatomic,readwrite) id <LoginDelegate> delegate;
@end
