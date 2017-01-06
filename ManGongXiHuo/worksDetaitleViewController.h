//
//  worksDetaitleViewController.h
//  SlowCarefulPriject
//
//  Created by teacher on 16-10-12.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "worksModel.h"
#import "CraftsmentModel.h"


@interface worksDetaitleViewController : UIViewController
@property (strong,nonatomic) worksModel *works;
@property (strong,nonatomic) CraftsmentModel *cModel;

@end
