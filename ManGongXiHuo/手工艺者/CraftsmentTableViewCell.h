//
//  CraftsmentTableViewCell.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-14.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CraftsmentModel.h"
#import "worksModel.h"

@interface CraftsmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellHeight;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellWidth;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property(retain,nonatomic)CraftsmentModel *cModels;

@property(retain,nonatomic)NSArray *works;
@property (weak, nonatomic) IBOutlet UIScrollView *SCRView;


@end
