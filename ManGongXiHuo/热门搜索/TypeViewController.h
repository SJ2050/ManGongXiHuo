//
//  TypeViewController.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-23.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchModel.h"
#import "TypeMode.h"
@interface TypeViewController : UIViewController
@property(strong,nonatomic)SearchModel *sModel;
@property (strong,nonatomic)TypeMode *typeModel;
@end
