//
//  TypeViewController.m
//  ManGongXiHuo
//
//  Created by teacher on 16-10-23.
//  Copyright (c) 2016年 teacher. All rights reserved.
//

#import "TypeViewController.h"

@interface TypeViewController ()<UIScrollViewDelegate>
{
    UIView *views;
    UIScrollView *myScroll;
    NSMutableArray *arrayImage;
      NSTimer *timers;
    UIPageControl *pageCtl;
}
@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
   
    [self createScrollView];
    [self initImage];
}


- (void)createView{
    views = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H)];
    views.backgroundColor =BGCOLOR;
  /*
    搜索框
   */
    UITextField *myField = [[UITextField alloc] initWithFrame:CGRectMake(20, 15, 280, 35)];
    myField.layer.borderWidth = 0.3;
    myField.placeholder = @"搜索";
    myField.layer.borderColor = [UIColor grayColor].CGColor;
    myField.layer.cornerRadius = 7;
    myField.layer.masksToBounds = YES;
    myField.backgroundColor = [UIColor whiteColor];
    
    /*
     简介
     */
    UILabel *myLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 280, 250)];
    
    myLab.backgroundColor = [UIColor grayColor];
    [views addSubview:myLab];
    self.navigationItem.title = @"金属";
    [views addSubview:myField];
    
    [self.view addSubview:views];
}
- (void)createScrollView{
    myScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_W, 150)];
    myScroll.delegate = self;
    myScroll.contentSize = CGSizeMake(8*SCREEN_W, 150);
    //设置整页滚动
    myScroll.pagingEnabled = YES;
    //是否允许回弹
    myScroll.bounces = NO;
    //是否显示滚动条 横向
    myScroll.showsHorizontalScrollIndicator = NO;
    //纵向
    myScroll.showsVerticalScrollIndicator = NO;
    //设置内容的偏移量
    myScroll.contentOffset = CGPointMake(SCREEN_W, 0);
    myScroll.tag = 11;
    [views addSubview:myScroll];
}

- (void)initImage{
    arrayImage = [NSMutableArray arrayWithCapacity:0];
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake(0*SCREEN_W, 0, SCREEN_W, 150)];
    img1.image = [UIImage imageNamed:@"original-6.jpg"];
    [myScroll addSubview:img1];
    for (int i = 0; i<6; i++) {
        UIImage *images = [UIImage imageNamed:[NSString stringWithFormat:@"original-%d.jpg",i+1]];
        [arrayImage addObject:images];
        // NSLog(@"%@",arrayImage);
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_W+SCREEN_W, 0, SCREEN_W, 150)];
        img.image = arrayImage[i];
        
        [myScroll addSubview:img];
    }
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:CGRectMake(arrayImage.count*SCREEN_W+SCREEN_W, 0, SCREEN_W, 150)];
    img2.image = [UIImage imageNamed:@"original-1.jpg"];
    [myScroll addSubview:img2];
    
    timers = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(gun) userInfo:nil repeats:YES];
    
    pageCtl = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 190, 120, 30)];
    
    pageCtl.numberOfPages = arrayImage.count;
    //    未选中
    pageCtl.pageIndicatorTintColor = [UIColor grayColor];
    //选中
    pageCtl.currentPageIndicatorTintColor = MAINCOLOR;
    pageCtl.currentPage = 0;
    [pageCtl addTarget:self action:@selector(changeContent) forControlEvents:UIControlEventValueChanged];
    
    [views addSubview:pageCtl];
}


- (void)gun{
    int index = myScroll.contentOffset.x/SCREEN_W;
    
    NSLog(@"%d",index);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        myScroll.contentOffset = CGPointMake((index+1)*SCREEN_W, 0);
        
    } completion:^(BOOL finished) {
        //动画执行完成后执行的代码
        if(index==arrayImage.count)
        {
            myScroll.contentOffset = CGPointMake(1*SCREEN_W, 0);
            
        }
        int index1 = myScroll.contentOffset.x/SCREEN_W;
        pageCtl.currentPage = index1-1;
    }];
}

- (void)changeContent{
    
    [UIView animateWithDuration:0.5 animations:^{
        myScroll.contentOffset = CGPointMake((pageCtl.currentPage+1)*SCREEN_W, 0) ;
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag ==11) {
        int index = scrollView.contentOffset.x/SCREEN_W;
        if(index==0)
        {
            scrollView.contentOffset = CGPointMake(arrayImage.count*SCREEN_W, 0);
        }
        else if(index==arrayImage.count+1)
        {
            scrollView.contentOffset = CGPointMake(SCREEN_W, 0);
        }
        int index1 = scrollView.contentOffset.x/SCREEN_W;
        
        pageCtl.currentPage = index1-1;
    }
    
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
