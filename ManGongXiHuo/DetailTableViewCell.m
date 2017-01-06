//
//  DetailTableViewCell.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-14.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "worksModel.h"
#import "TarenViewController.h"


@implementation DetailTableViewCell

- (void)awakeFromNib {
    _headeImg.layer.cornerRadius = 4;
    _headeImg.layer.masksToBounds = YES;
   // UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dh.png"]];
   // [_introductionLab setBackgroundColor:color];
    _introductionLab.layer.cornerRadius = 5;
    _introductionLab.layer.masksToBounds = YES;
}
/*
  最近流行
 */
- (void)setWModel:(worksModel *)wModel{
    _wModel = wModel;
    _introductionLab.text = wModel.introduce;
    
}
/*
 手工艺者
 */
- (void)setCModel:(CraftsmentModel *)cModel{
    _cModel = cModel;
    _nameLab.text = cModel.nickName;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
