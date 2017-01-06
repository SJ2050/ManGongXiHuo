//
//  DetailTableViewCell.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-14.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CraftsmentModel.h"
#import "worksModel.h"


@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headeImg;
- (IBAction)clickHeadImg:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *introductionLab;
@property(retain,nonatomic)CraftsmentModel *cModel;
@property(retain,nonatomic)worksModel *wModel;

@end
