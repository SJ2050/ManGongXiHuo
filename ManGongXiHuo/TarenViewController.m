//
//  TarenViewController.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-22.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "TarenViewController.h"

@interface TarenViewController ()
{
    UIView *topView;
    UIView *downView;
    UIImageView *bgImgView;
    UILabel *nameLab;
    UILabel *sigLab;
    UIButton *headerImg;
    UIButton *allBtn;
    UIButton *right;
}
@end

@implementation TarenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    self.view.backgroundColor = BGCOLOR;
    [self setStyle];
    
}

- (void)createTopView{
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_W/(11/6.0))];
    topView.backgroundColor = [UIColor purpleColor];
    /*
     背景图片
     */
    bgImgView = [[UIImageView alloc] initWithFrame:topView.bounds];
    bgImgView.image = [UIImage imageNamed:@"29.jpg"];
    /*
     头像
     */
    headerImg = [[UIButton alloc] initWithFrame:CGRectMake(20, (topView.frame.size.height/5)*1.5, 60, 60)];
    [headerImg setBackgroundImage:[UIImage imageNamed:@"qq13.jpg"] forState:UIControlStateNormal];
    
    headerImg.layer.borderWidth = 0.3;
    headerImg.layer.borderColor = [UIColor whiteColor].CGColor;
    //设置圆角
    headerImg.layer.cornerRadius = 4;
    //隐藏边框外的内容
    headerImg.layer.masksToBounds = YES;
    /*
     名字
     */
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(90, headerImg.frame.origin.y, SCREEN_W-110, 15)];
    //字体加粗 大小
    nameLab.font = [UIFont boldSystemFontOfSize:18];
    nameLab.textColor = [UIColor whiteColor];
    //字体靠左边对齐
    nameLab.textAlignment = NSTextAlignmentLeft;
    nameLab.text = @"张小砚台";
    /*
     签名
     */
    sigLab = [[UILabel alloc] initWithFrame:CGRectMake(90,nameLab.frame.origin.y+16+5, nameLab.frame.size.width, 39)];
    //字体加粗 大小
    sigLab.font = [UIFont systemFontOfSize:16];
    sigLab.textColor = [UIColor whiteColor];
    //字体靠左边对齐
    sigLab.textAlignment = NSTextAlignmentLeft;
    sigLab.numberOfLines = 2;
    sigLab.text = @"以梦为马，驰骋岁月。以梦为马，诗酒趁年华！";
    /*
     设置图标
     */
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn setBackgroundImage:[UIImage imageNamed:@"sz.png"] forState:UIControlStateNormal];
    //添加事件
   // [btn addTarget:self action:@selector(pushBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //视图的顶点 坐标被重写  大小可以改变
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    
    
    [topView addSubview:bgImgView];
    [topView addSubview:headerImg];
    [topView addSubview:nameLab];
    [topView addSubview:sigLab];
    [self.view addSubview:topView];
    [self createSegBtn];
}
//concern创建四个分段按钮
- (void)createSegBtn{
    
    UIButton *worksBtn = [self createBtn:@"作品" andIndex:0];
    [topView addSubview:worksBtn];
    UIButton *concernBtn = [self createBtn:@"关注" andIndex:1];
    [topView addSubview:concernBtn];
    
    UIButton *fansBtn = [self createBtn:@"粉丝" andIndex:2];
    [topView addSubview:fansBtn];
}
/*
 设置按钮封装成统一的方法
 */
- (UIButton *)createBtn:(NSString *)title andIndex:(int)index
{
    UIButton *segBtn = [[UIButton alloc] initWithFrame:CGRectMake(index*SCREEN_W/3.0, topView.frame.size.height- 25, SCREEN_W/3.0, 25)];
    [segBtn setTitle:title forState:UIControlStateNormal];
    segBtn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];//背景颜色透明度
    [segBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    segBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    //设置变宽
    segBtn.layer.borderWidth = 0.3;
    //添加事件
    [segBtn addTarget:self action:@selector(changeType:) forControlEvents:UIControlEventTouchUpInside];
    //设置tag值
    segBtn.tag = index+1;
    //字体加粗 大小
    segBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    return segBtn;
    
}

- (void)changeType:(UIButton *)btn
{
    [allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    allBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    allBtn = btn;
    
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    switch (btn.tag) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
    
}




- (void)setStyle
{
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    /*
     关注
     */
    right = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 35)];
    [right setTitle:@"关注" forState:UIControlStateNormal];
    //设置阴影
    right.layer.shadowOffset = CGSizeMake(0, 2);
    right.layer.shadowOpacity = 0.9;
    right.layer.borderWidth = 2;
    right.layer.borderColor = MAINCOLOR.CGColor;
    right.layer.cornerRadius = 8;
    right.layer.masksToBounds = YES;
    //添加事件
    [right addTarget:self action:@selector(guanzhu:) forControlEvents:UIControlEventTouchUpInside];
    right.tag = 1;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    //视图的顶点 坐标被重写  大小可以改变
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [leftBtn addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
}
- (void)guanzhu:(UIButton *)btn{
    if (btn.tag == 1) {
        right.tag = 2;
         [right setTitle:@"取消关注" forState:UIControlStateNormal];
    }else if(btn.tag == 2){
        right.tag = 1;
         [right setTitle:@"关注" forState:UIControlStateNormal];
    }
}

- (void)onBack
{
    //返回
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
