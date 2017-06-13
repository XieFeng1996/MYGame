//
//  PlayerData.m
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "PlayerData.h"

@implementation PlayerData
@synthesize PlayerAttack,PlayerID,PlayerLife,PlayerPassiveID;
-(id)initWithLife:(int)PL andAttack:(int)PA andID:(int)PD andPassiveID:(int)PPD
{
    self =[super init];
    if (nil !=self) {
        PlayerLife =PL;
        PlayerAttack =PA;
        PlayerID =PD;
        PlayerPassiveID =PPD;
    }
    return self;
}
-(int)getPlayerLife
{
    return PlayerLife;
}
-(int)getPlayerAttack
{
    return PlayerAttack;
}
-(int)getPlayerID
{
    return PlayerID;
}
-(int)getPlayerPassiveID
{
    return PlayerPassiveID;
}
@end
