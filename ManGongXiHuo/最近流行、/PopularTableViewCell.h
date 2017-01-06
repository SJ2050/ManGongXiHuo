//
//  PopularTableViewCell.h
//  ManGongXiHuo
//
//  Created by teacher on 16-10-11.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "worksModel.h"
@protocol popTableDelegate <NSObject>

- (void)pushDetailViewCtl:(NSInteger) tag;

@end

@interface PopularTableViewCell : UITableViewCell

- (IBAction)clickDetail:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;

@property(retain,nonatomic)worksModel *workModel;
@property (weak, nonatomic) IBOutlet UIView *contentViews;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UILabel *workNameLab;
- (IBAction)clickCollect:(UIButton *)sender;
@property (assign,nonatomic) id <popTableDelegate> delegate;
@end
