//
//  CardSelectViewController.h
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardSelectViewController : UIViewController
- (IBAction)Melee:(id)sender;
- (IBAction)Assassin:(id)sender;
- (IBAction)Archar:(id)sender;
- (IBAction)Assist:(id)sender;
- (IBAction)Special:(id)sender;
- (IBAction)UnKnown:(id)sender;
- (IBAction)Next:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *CardImage;
@property (weak, nonatomic) IBOutlet UILabel *CardEffect;//卡牌作用
@property (weak, nonatomic) IBOutlet UILabel *CardInitiative;//主动
@property (weak, nonatomic) IBOutlet UILabel *CardPassive;

//设置文本
-(void)setCardText;
//设置背景图片
-(void)setCardBackgound;
//人物
//Assassin
-(void)Eryishi;
-(void)Hei;
-(void)Tongren;
-(void)Yasina;
-(void)Feicunjianxin;
-(void)Neipudun;
-(void)Hunpoyaomeng;
//Melee
-(void)Zun;
-(void)Safeiluosi;
-(void)FFFxiaobing;
-(void)Nilu;
//Archar
-(void)Heiyansheshou;
-(void)Qianjianzhi;
-(void)FFFpaoche;
-(void)Chaotianshinai;
//Assist
-(void)You;
-(void)Yadianna;
//Special
-(void)Jiangshi;
-(void)Dalong;
-(void)Xiaolong;
@end
