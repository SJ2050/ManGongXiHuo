//
//  DynamicTableViewCell.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-19.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "DynamicTableViewCell.h"

@implementation DynamicTableViewCell

- (void)awakeFromNib {
    _headerImg.layer.borderWidth = 1;
    _headerImg.layer.borderColor = [UIColor whiteColor].CGColor;
    _headerImg.layer.cornerRadius = 4;
    _headerImg.layer.masksToBounds = YES;
    
    //设置阴影
    _bgView.layer.shadowOffset = CGSizeMake(0, 2);
    _bgView.layer.shadowOpacity = 0.9;
}
//- (void)setWModels:(worksModel *)wModels{
//    _wModels = wModels;
//    _titleLab.text = wModels.worksName;
//    
//    _timeLab.text = wModels.shelfTimer;
//}


- (void)setCModels:(CraftsmentModel *)cModels{
    _cModels = cModels;
    _nameLab.text = cModels.nickName;
    
}

- (void)setWArray:(NSArray *)wArray{
    _wArray = wArray;
//    worksModel *wmodel = [[worksModel alloc] init];
//    _titleLab.text = wmodel.worksName;
   
   // _timeLab.text = wArray
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
