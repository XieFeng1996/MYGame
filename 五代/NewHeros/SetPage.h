//
//  SetPage.h
//  NewHeros
//
//  Created by 洪天伟 on 17/5/25.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetPage : UIViewController
//加载背景图片
-(void)loadBackground;
//设置文本
-(void)setText;
//文字输出
-(void)TextOutput:(int)TN;
@property (weak, nonatomic) IBOutlet UILabel *Rule;
//上一页
- (IBAction)Previous:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PButton;

//下一页
- (IBAction)Next:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *NButton;


@end
