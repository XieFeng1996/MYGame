//
//  CardInformation.h
//  NewHeros
//
//  Created by 洪天伟 on 17/4/29.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import <Foundation/Foundation.h>
//枚举卡牌类型
enum cardType{
    Melee,         //近战
    Archer,        //射手
    Assassin,      //刺客
    Assist,        //辅助
    Special        //特殊
};
//枚举攻击类型
enum damageType{
    ordinaryInjury,        //普通伤害
    fixedDamage,           //固定伤害
    realDamage,            //真实伤害
};
struct Card
{
    int cardID;               //卡牌ID
    int cardAttackPower;      //卡牌攻击力
    int cardLife;             //卡牌生命
    char *cardName;           //卡牌名字
    int cardVirtue;           //卡牌属性
    char *cardPassive;        //卡牌被动
    int cardPassiveID;        //卡牌被动ID
    char *cardInitiative;     //卡牌主动
    int cardInitiativeID;     //卡牌主动ID
    int cardDamageType;       //卡牌伤害类型
    BOOL hero;                //是否为英雄单位
};
@interface CardInformation : NSObject
//获得卡牌的被动信息
-(NSString *)creatCardInformation:(int)cardnumber;
//获得卡牌的生命值
-(int)getallCardLife:(int)cardnumber;
//获得卡牌的攻击力
-(int)getallCardAttack:(int)cardnumber;
//获得卡牌的名字
-(NSString *)getallCardName:(int)cardnumber;
//获得卡牌的编号(一共20张卡牌，从0-19，卡牌编号可以用作随机数)
-(int)getallCardID:(int)cardnumber;
//获得卡牌的被动ID
-(int)getallCardPassiveID:(int)cardnumber;
//获得卡牌主动ID
-(int)getallCardInitiativeID:(int)cardnumber;
//获得卡牌是否英雄单位(是和否)
-(BOOL)getallCardHeroUnits:(int)cardnumber;
@end
