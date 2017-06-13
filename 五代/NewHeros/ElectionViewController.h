//
//  ElectionViewController.h
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GameStartViewController.h"
//选人界面
struct playerData{
    int playerID;//玩家ID
    char *playerName;//玩家名字
    int playerAttack;//玩家攻击力
    int playerLife;//玩家生命
    char *playerPassive;//玩家被动描述
    int playerPassiveID;//玩家被动ID
};
@interface ElectionViewController : UIViewController
//改变显示字体颜色
- (IBAction)NextPlayer:(id)sender;
//角色名字
@property (weak, nonatomic) IBOutlet UILabel *playerName;
//角色攻击力
@property (weak, nonatomic) IBOutlet UILabel *playerAttack;
//角色生命值
@property (weak, nonatomic) IBOutlet UILabel *playerLife;
//角色ID
@property (weak, nonatomic) IBOutlet UILabel *playerID;
//角色介绍
@property (weak, nonatomic) IBOutlet UILabel *playerLntroduction;
//角色被动
@property (weak, nonatomic) IBOutlet UILabel *playerPassive;
//角色图片
@property (weak, nonatomic) IBOutlet UIImageView *playerImage;
//角色
-(void)Ruby;
-(void)Weiss;
-(void)Blake;
-(void)Yang;
-(void)Pyrrha;
//设置文本
-(void)setText;
@end
