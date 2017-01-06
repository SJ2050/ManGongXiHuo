//
//  PopularTableViewCell.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-11.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "PopularTableViewCell.h"

@implementation PopularTableViewCell

- (void)awakeFromNib {
    //设置边宽
    _contentViews.layer.borderWidth = 0.3;
    _contentViews.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    _contentViews.layer.shadowColor = [UIColor grayColor].CGColor;
    //设置圆角
    _contentViews.layer.cornerRadius = 5.0;
    //设置阴影
    _contentViews.layer.shadowOffset = CGSizeMake(0, 2);
    _contentViews.layer.shadowOpacity = 0.9;
    _collectBtn.tag = 1;
}
- (void)setWorkModel:(worksModel *)workModel{
    _workModel = workModel;
    _workNameLab.text = _workModel.worksName;
}

- (IBAction)clickDetail:(UIButton *)sender{
    [self.delegate pushDetailViewCtl:sender.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}


- (IBAction)clickCollect:(UIButton *)sender {
    
    if (sender.tag == 1) {
        _collectBtn.tag = 2;
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"taoxin1.png"] forState:UIControlStateNormal];
    }else if(sender.tag == 2){
        _collectBtn.tag = 1;
       [_collectBtn setBackgroundImage:[UIImage imageNamed:@"taoxin.png"] forState:UIControlStateNormal];
    }
    
}
@end
