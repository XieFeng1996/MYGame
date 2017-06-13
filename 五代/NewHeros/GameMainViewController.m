//
//  GameMainViewController.m
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "GameMainViewController.h"

@interface GameMainViewController ()

@end

@implementation GameMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //定义图片的位置和尺寸
    UIImageView *subView =[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 667.0f, 375.0f)];
    //设定图片名称并拖放添加图片到image项目文件夹
    [subView setImage:[UIImage imageNamed:@"timg.jpg"]];
    //在view中加入图片subview并使背景处于最底层
    [self.view insertSubview:subView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    //隐藏导航栏
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden =YES;
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
