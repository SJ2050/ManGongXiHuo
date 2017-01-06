//
//  DynamicTableViewCell.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-19.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CraftsmentModel.h"
#import "worksModel.h"

@interface DynamicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property(retain,nonatomic)CraftsmentModel *cModels;
@property(retain,nonatomic)worksModel *wModels;
@property(retain,nonatomic)NSArray *wArray;

@end
