//
//  CraftsmentTableViewCell.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-14.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "CraftsmentTableViewCell.h"
#define W self.frame.size.width
#define H self.frame.size.height
@implementation CraftsmentTableViewCell

- (void)awakeFromNib {
    _headerImg.layer.cornerRadius = 4;
    _headerImg.layer.masksToBounds = YES;
}

- (void)setCModels:(CraftsmentModel *)cModels{

    _cModels = cModels;
    _nameLab.text = _cModels.nickName;
}

- (void)setWorks:(NSArray *)works{
    CGFloat width = (W - 40)/3.0;
    _works = works;
    _cellHeight.constant = 90;
    if (_works.count <=3) {
        _cellWidth.constant = self.frame.size.width - 20;
    }else{
        
        _cellWidth.constant = (width ) *_works.count ;
    }
    for (int i = 0; i<_works.count; i++) {
        //worksModel *workmodel = _works[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(width+10), 0, width, 90)];
        imgView.image = [UIImage imageNamed:@"20140805145x1312.jpg"];
        [_SCRView addSubview:imgView];
        _SCRView.userInteractionEnabled = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
