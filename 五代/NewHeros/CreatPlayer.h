//
//  CreatPlayer.h
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "PlayerData.h"

@interface CreatPlayer : PlayerData
{
    PlayerData *PData[5];
    bool playerRandomnumber;//玩家被动是否触发
    bool pyrrhaRandomnumber;//pyrrha被动是否触发（仅供AI使用）
}
-(void)creatPlayer;
-(int)getPlayerLife;
-(int)getPlayerAttack:(int)attack;
-(int)getPlayerID:(int)pid;
-(int)getPlayerPassiveID:(int)passiveid;
-(BOOL)getplayerRandomnumber;
-(BOOL)getAIPyrrhaRandmnumber;
@end
