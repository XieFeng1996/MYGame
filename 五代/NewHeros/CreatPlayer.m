//
//  CreatPlayer.m
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "CreatPlayer.h"

@implementation CreatPlayer
-(void)creatPlayer
{//顺序依次是RWBYP
    PData[0]=[[PlayerData alloc]initWithLife:30 andAttack:5 andID:0 andPassiveID:100];
    PData[1]=[[PlayerData alloc]initWithLife:30 andAttack:5 andID:1 andPassiveID:101];
    PData[2]=[[PlayerData alloc]initWithLife:30 andAttack:5 andID:2 andPassiveID:102];
    PData[3]=[[PlayerData alloc]initWithLife:30 andAttack:5 andID:3 andPassiveID:103];
    PData[4]=[[PlayerData alloc]initWithLife:30 andAttack:6 andID:4 andPassiveID:104];
}
-(int)getPlayerLife
{
    return PData[0]->PlayerLife;
}
-(int)getPlayerAttack:(int)attack
{
    switch (attack) {
        case 0:
        case 1:
        case 2:
        case 3:
            return PData[0]->PlayerAttack;
            break;
        case 4:
            return PData[4]->PlayerAttack;
        default:
            break;
    }
    return 0;
}
-(int)getPlayerID:(int)pid
{
    switch (pid) {
        case 0:
            return PData[0]->PlayerID;
            break;
        case 1:
            return PData[1]->PlayerID;
            break;
        case 2:
            return PData[2]->PlayerID;
            break;
        case 3:
            return PData[3]->PlayerID;
            break;
        case 4:
            return PData[4]->PlayerID;
            break;
        default:
            break;
    }
    return 0;
}
-(int)getPlayerPassiveID:(int)passiveid
{
    switch (passiveid) {
        case 0:
            return PData[0]->PlayerPassiveID;
            break;
        case 1:
            return PData[1]->PlayerPassiveID;
            break;
        case 2:
            return PData[2]->PlayerPassiveID;
            break;
        case 3:
            return PData[3]->PlayerPassiveID;
            break;
        case 4:
            return PData[4]->PlayerPassiveID;
            break;
        default:
            break;
    }
    return 0;
}
-(BOOL)getplayerRandomnumber
{
    int temp = arc4random()%10;//0-9 被动触发概率10%
    switch (temp) {
        case 0:
        case 1:
        case 2:
        case 3:
            return playerRandomnumber =false;
            break;
        case 4:
            return playerRandomnumber =true;
            break;
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            return playerRandomnumber =false;
            break;
        default:
            break;
    }
    return 0;
}
-(BOOL)getAIPyrrhaRandmnumber
{
    int temp =arc4random()%10; //触发几率70%
    switch (temp) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            return pyrrhaRandomnumber =true; //触发被动
            break;
        case 7:
        case 8:
        case 9:
            return pyrrhaRandomnumber = false;//不触发被动
            break;
        default:
            break;
    }
    return 0;
}
@end
