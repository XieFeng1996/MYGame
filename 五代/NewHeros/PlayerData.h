//
//  PlayerData.h
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerData : NSObject
{
    int PlayerLife;//玩家生命
    int PlayerAttack;//玩家攻击力
    int PlayerID;//玩家ID
    int PlayerPassiveID;//玩家被动ID
}
@property(nonatomic)int PlayerLife;
@property(nonatomic)int PlayerAttack;
@property(nonatomic)int PlayerID;
@property(nonatomic)int PlayerPassiveID;
-(id)initWithLife:(int)PL andAttack:(int)PA andID:(int)PD andPassiveID:(int)PPD;
//获得玩家的各项属性
-(int)getPlayerLife;
-(int)getPlayerAttack;
-(int)getPlayerID;
-(int)getPlayerPassiveID;
@end
