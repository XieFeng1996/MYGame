//
//  CardInformation.m
//  NewHeros
//
//  Created by 洪天伟 on 17/4/29.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "CardInformation.h"

@implementation CardInformation
struct Card cardData[50] ={
    {0,6,6,"二仪式",Assassin,"二仪式直接斩杀生命值低于或等于3的单位",1001,"猫返：攻击有概率回复自己一点生命",2001,ordinaryInjury,true},
    {1,7,5,"黑",Assassin,"黑攻击后处于隐身状态",1002,"攻击一个目标，有概率使敌方进入麻痹状态",2002,ordinaryInjury,true},
    {2,5,6,"绯村剑心",Assassin,"剑心的攻击力随着生命值的减少而增加，每减少1点生命值增加2点攻击力,生命值低于或等于3时被动失效",1003,"剑心对任意单位进行一次普通伤害，当生命值低于或等于3时对目标发动一场九头龙闪，造成8点真实伤害",2003,realDamage,true},
    {3,6,7,"涅普顿",Assassin,"主人公补正：对涅普顿对伤害减少1",1004,"女神连斩：向目标发动三次攻击，每次造成2点伤害（最低1点）",2004,ordinaryInjury,true},
    {4,8,4,"桐谷和人",Assassin,"笨蛋情侣：当亚丝娜在场上时，攻击力＋1",1005,"对任意单位释放星爆气流斩，造成6点固定伤害",2005,fixedDamage,true},
    {5,7,5,"魂魄妖梦",Assassin,"妖梦的攻击力会造成混合伤害，对敌人造成固定伤害2+敌人攻击力的一半",1006,"对敌方任意单位发的［未来永劫斩］，被击中者有概率造成眩晕，持续一回合",2006,ordinaryInjury,true},
    {6,7,6,"亚丝娜",Assassin,"笨蛋情侣：当桐人在场上时，攻击＋1",1007,"亚丝娜发动［圣母圣咏］，对目标进行十一连刺，造成6点真实伤害",2007,realDamage,true},
    
    {7,2,5,"FFF团小兵",Melee,"当场上存在3个FFF团小兵时，小兵攻击力＋1",1031,"向敌方近战单位发动一次攻击",2031,ordinaryInjury,false},
    {8,5,9,"尼禄",Melee,"皇帝的特权：所有对尼禄的伤害－1",1032,"黄金剧场：尼禄的攻击无视隐身等状态并有概率造成眩晕",2032,ordinaryInjury,true},
    {9,3,10,"萨菲罗斯",Melee,"伤害分流：每受到2点伤害就会将下一次受到的伤害＊3平均分流给对面所有单位",1033,"萨菲罗斯挥舞正宗，对敌人造成自己最大生命值＊0.05的流血伤害，持续2回合",2033,ordinaryInjury,true},
    {10,4,10,"周防尊",Melee,"伤害分担：敌人对队友的伤害－1，队员受到伤害的30%分担给尊",1034,"向敌人扔出达摩克斯之剑，造成1点真实伤害并有概率眩晕",2034,realDamage,true},
    
    {11,8,6,"黑岩射手",Archer,"攻击自带暴击，暴击伤害为150%",1061,"攻击后有概率进入蓝羽化，受到的伤害－1，持续一回合",2061,ordinaryInjury,true},
    {12,9,4,"朝田诗乃",Archer,"诗乃必须死：诗乃受到的伤害＋1且不受辅助伤害减免，诗乃的最终伤害＋2",1062,"狙击镜：诗乃的攻击有概率造成眩晕",2063,ordinaryInjury,true},
    {13,8,4,"浅间智",Archer,"第三次攻击时，攻击造成2点AOE伤害并有概率眩晕",1063,"攻击附带减速效果，当减速buff达到3层时，该单位将冻结",2063,ordinaryInjury,true},
    {14,3,4,"FFF团炮车",Archer,"当场上存在3个FFF团小兵时，小兵攻击力＋1",1064,"向敌方任意单位攻击一次",2064,ordinaryInjury,false},
    
    {15,2,6,"雅典娜",Assist,"队友死亡时，雅典娜会复活队员，该被动只生效一次",1091,"雅典娜回复单一队友3点生命值",2091,ordinaryInjury,true},
    {16,2,6,"优克莉伍徳",Assist,"死灵法师：每隔一个回合，优都会召唤一个僵尸进入战场",1092,"优挥舞镰刀攻击对方单位，如果该回合内有友方单位阵亡，优将会复活其中一个单位",2092,ordinaryInjury,true},
    
    {17,10,12,"欧西里斯天空龙",Special,"龙的存在时最高傲的，当欧西里斯天空龙存在时，初特殊类单位其余不能存在",3011,"欧西里斯天空龙对敌方全体造成4点真实伤害",4011,realDamage,false},
    {18,2,2,"僵尸",Special,"僵尸也有被动吗？",3012,"攻击敌方近战单位，攻击后死亡",4012,ordinaryInjury,false},
    {19,8,10,"青眼白龙",Special,"当欧西里斯天空龙存在时，青眼白龙可以无消耗召唤",3013,"攻击敌方任意单位，对英雄单位伤害增加1",false}
};
-(NSString *)creatCardInformation:(int)cardnumber
{
    NSString *cardInformation;
    switch (cardnumber) {
        case 0:
            //二仪式
            cardInformation =[NSString stringWithCString:cardData[0].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 1:
            //黑
            cardInformation =[NSString stringWithCString:cardData[1].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 2:
            //剑心
            cardInformation =[NSString stringWithCString:cardData[2].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 3:
            //涅普顿
            cardInformation =[NSString stringWithCString:cardData[3].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 4:
            //桐人
            cardInformation =[NSString stringWithCString:cardData[4].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 5:
            //妖梦
            cardInformation =[NSString stringWithCString:cardData[5].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 6:
            //亚丝娜
            cardInformation =[NSString stringWithCString:cardData[6].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 7:
            //小兵
            cardInformation =[NSString stringWithCString:cardData[7].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 8:
            //尼禄
            cardInformation =[NSString stringWithCString:cardData[8].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 9:
            //萨菲罗斯
            cardInformation =[NSString stringWithCString:cardData[9].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 10:
            //尊
            cardInformation =[NSString stringWithCString:cardData[10].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 11:
            //黑岩
            cardInformation =[NSString stringWithCString:cardData[11].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 12:
            //诗乃
            cardInformation =[NSString stringWithCString:cardData[12].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 13:
            //浅间智
            cardInformation =[NSString stringWithCString:cardData[13].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 14:
            //炮车
            cardInformation =[NSString stringWithCString:cardData[14].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 15:
            //雅典娜
            cardInformation =[NSString stringWithCString:cardData[15].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 16:
            //优
            cardInformation =[NSString stringWithCString:cardData[16].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 17:
            //大龙
            cardInformation =[NSString stringWithCString:cardData[17].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 18:
            //僵尸
            cardInformation =[NSString stringWithCString:cardData[18].cardPassive encoding:NSUTF8StringEncoding];
            break;
        case 19:
            //小龙
            cardInformation =[NSString stringWithCString:cardData[19].cardPassive encoding:NSUTF8StringEncoding];
            break;
        default:
            break;
    }
    return cardInformation;
}
//获得卡牌的生命值
-(int)getallCardLife:(int)cardnumber
{
    int cardInformation;
    switch (cardnumber) {
        case 0:
            //二仪式
            cardInformation =cardData[0].cardLife;
            break;
        case 1:
            //黑
            cardInformation =cardData[1].cardLife;
            break;
        case 2:
            //剑心
            cardInformation =cardData[2].cardLife;
            break;
        case 3:
            //涅普顿
            cardInformation =cardData[3].cardLife;
            break;
        case 4:
            //桐人
            cardInformation =cardData[4].cardLife;
            break;
        case 5:
            //妖梦
            cardInformation =cardData[5].cardLife;
            break;
        case 6:
            //亚丝娜
            cardInformation =cardData[6].cardLife;
            break;
        case 7:
            //小兵
            cardInformation =cardData[7].cardLife;
            break;
        case 8:
            //尼禄
            cardInformation =cardData[8].cardLife;
            break;
        case 9:
            //萨菲罗斯
            cardInformation =cardData[9].cardLife;
            break;
        case 10:
            //尊
            cardInformation =cardData[10].cardLife;
            break;
        case 11:
            //黑岩
            cardInformation =cardData[11].cardLife;
            break;
        case 12:
            //诗乃
            cardInformation =cardData[12].cardLife;
            break;
        case 13:
            //浅间智
            cardInformation =cardData[13].cardLife;
            break;
        case 14:
            //炮车
            cardInformation =cardData[14].cardLife;
            break;
        case 15:
            //雅典娜
            cardInformation =cardData[15].cardLife;
            break;
        case 16:
            //优
            cardInformation =cardData[16].cardLife;
            break;
        case 17:
            //大龙
            cardInformation =cardData[17].cardLife;
            break;
        case 18:
            //僵尸
            cardInformation =cardData[18].cardLife;
            break;
        case 19:
            //小龙
            cardInformation =cardData[19].cardLife;
            break;
        default:
            break;
    }
    return cardInformation;
}
//获得卡牌的攻击力
-(int)getallCardAttack:(int)cardnumber
{
    int cardInformation;
    switch (cardnumber) {
        case 0:
            //二仪式
            cardInformation =cardData[0].cardAttackPower;
            break;
        case 1:
            //黑
            cardInformation =cardData[1].cardAttackPower;
            break;
        case 2:
            //剑心
            cardInformation =cardData[2].cardAttackPower;
            break;
        case 3:
            //涅普顿
            cardInformation =cardData[3].cardAttackPower;
            break;
        case 4:
            //桐人
            cardInformation =cardData[4].cardAttackPower;
            break;
        case 5:
            //妖梦
            cardInformation =cardData[5].cardAttackPower;
            break;
        case 6:
            //亚丝娜
            cardInformation =cardData[6].cardAttackPower;
            break;
        case 7:
            //小兵
            cardInformation =cardData[7].cardAttackPower;
            break;
        case 8:
            //尼禄
            cardInformation =cardData[8].cardAttackPower;
            break;
        case 9:
            //萨菲罗斯
            cardInformation =cardData[9].cardAttackPower;
            break;
        case 10:
            //尊
            cardInformation =cardData[10].cardAttackPower;
            break;
        case 11:
            //黑岩
            cardInformation =cardData[11].cardAttackPower;
            break;
        case 12:
            //诗乃
            cardInformation =cardData[12].cardAttackPower;
            break;
        case 13:
            //浅间智
            cardInformation =cardData[13].cardAttackPower;
            break;
        case 14:
            //炮车
            cardInformation =cardData[14].cardAttackPower;
            break;
        case 15:
            //雅典娜
            cardInformation =cardData[15].cardAttackPower;
            break;
        case 16:
            //优
            cardInformation =cardData[16].cardAttackPower;
            break;
        case 17:
            //大龙
            cardInformation =cardData[17].cardAttackPower;
            break;
        case 18:
            //僵尸
            cardInformation =cardData[18].cardAttackPower;
            break;
        case 19:
            //小龙
            cardInformation =cardData[19].cardAttackPower;
            break;
        default:
            break;
    }
    return cardInformation;
}
//获得卡牌的名字
-(NSString *)getallCardName:(int)cardnumber
{
    NSString *cardInformation;
    switch (cardnumber) {
        case 0:
            //二仪式
            cardInformation =[NSString stringWithCString:cardData[0].cardName encoding:NSUTF8StringEncoding];
            break;
        case 1:
            //黑
            cardInformation =[NSString stringWithCString:cardData[1].cardName encoding:NSUTF8StringEncoding];
            break;
        case 2:
            //剑心
            cardInformation =[NSString stringWithCString:cardData[2].cardName encoding:NSUTF8StringEncoding];
            break;
        case 3:
            //涅普顿
            cardInformation =[NSString stringWithCString:cardData[3].cardName encoding:NSUTF8StringEncoding];
            break;
        case 4:
            //桐人
            cardInformation =[NSString stringWithCString:cardData[4].cardName encoding:NSUTF8StringEncoding];
            break;
        case 5:
            //妖梦
            cardInformation =[NSString stringWithCString:cardData[5].cardName encoding:NSUTF8StringEncoding];
            break;
        case 6:
            //亚丝娜
            cardInformation =[NSString stringWithCString:cardData[6].cardName encoding:NSUTF8StringEncoding];
            break;
        case 7:
            //小兵
            cardInformation =[NSString stringWithCString:cardData[7].cardName encoding:NSUTF8StringEncoding];
            break;
        case 8:
            //尼禄
            cardInformation =[NSString stringWithCString:cardData[8].cardName encoding:NSUTF8StringEncoding];
            break;
        case 9:
            //萨菲罗斯
            cardInformation =[NSString stringWithCString:cardData[9].cardName encoding:NSUTF8StringEncoding];
            break;
        case 10:
            //尊
            cardInformation =[NSString stringWithCString:cardData[10].cardName encoding:NSUTF8StringEncoding];
            break;
        case 11:
            //黑岩
            cardInformation =[NSString stringWithCString:cardData[11].cardName encoding:NSUTF8StringEncoding];
            break;
        case 12:
            //诗乃
            cardInformation =[NSString stringWithCString:cardData[12].cardName encoding:NSUTF8StringEncoding];
            break;
        case 13:
            //浅间智
            cardInformation =[NSString stringWithCString:cardData[13].cardName encoding:NSUTF8StringEncoding];
            break;
        case 14:
            //炮车
            cardInformation =[NSString stringWithCString:cardData[14].cardName encoding:NSUTF8StringEncoding];
            break;
        case 15:
            //雅典娜
            cardInformation =[NSString stringWithCString:cardData[15].cardName encoding:NSUTF8StringEncoding];
            break;
        case 16:
            //优
            cardInformation =[NSString stringWithCString:cardData[16].cardName encoding:NSUTF8StringEncoding];
            break;
        case 17:
            //大龙
            cardInformation =[NSString stringWithCString:cardData[17].cardName encoding:NSUTF8StringEncoding];
            break;
        case 18:
            //僵尸
            cardInformation =[NSString stringWithCString:cardData[18].cardName encoding:NSUTF8StringEncoding];
            break;
        case 19:
            //小龙
            cardInformation =[NSString stringWithCString:cardData[19].cardName encoding:NSUTF8StringEncoding];
            break;
        default:
            break;
    }
    return cardInformation;

}
//获得卡牌的编号(一共20张卡牌，从0-19，卡牌编号可以用作随机数)
-(int)getallCardID:(int)cardnumber
{
    int cardInformation;
    switch (cardnumber) {
        case 0:
            //二仪式
            cardInformation =cardData[0].cardID;
            break;
        case 1:
            //黑
            cardInformation =cardData[1].cardID;
            break;
        case 2:
            //剑心
            cardInformation =cardData[2].cardID;
            break;
        case 3:
            //涅普顿
            cardInformation =cardData[3].cardID;
            break;
        case 4:
            //桐人
            cardInformation =cardData[4].cardID;
            break;
        case 5:
            //妖梦
            cardInformation =cardData[5].cardID;
            break;
        case 6:
            //亚丝娜
            cardInformation =cardData[6].cardID;
            break;
        case 7:
            //小兵
            cardInformation =cardData[7].cardID;
            break;
        case 8:
            //尼禄
            cardInformation =cardData[8].cardID;
            break;
        case 9:
            //萨菲罗斯
            cardInformation =cardData[9].cardID;
            break;
        case 10:
            //尊
            cardInformation =cardData[10].cardID;
            break;
        case 11:
            //黑岩
            cardInformation =cardData[11].cardID;
            break;
        case 12:
            //诗乃
            cardInformation =cardData[12].cardID;
            break;
        case 13:
            //浅间智
            cardInformation =cardData[13].cardID;
            break;
        case 14:
            //炮车
            cardInformation =cardData[14].cardID;
            break;
        case 15:
            //雅典娜
            cardInformation =cardData[15].cardID;
            break;
        case 16:
            //优
            cardInformation =cardData[16].cardID;
            break;
        case 17:
            //大龙
            cardInformation =cardData[17].cardID;
            break;
        case 18:
            //僵尸
            cardInformation =cardData[18].cardID;
            break;
        case 19:
            //小龙
            cardInformation =cardData[19].cardID;
            break;
        default:
            break;
    }
    return cardInformation;
}
//获得卡牌的被动ID(消息处理中心通过被动ID和主动ID来判断伤害)
-(int)getallCardPassiveID:(int)cardnumber
{
    int cardInformation;
    switch (cardnumber) {
        case 0:
            //二仪式
            cardInformation =cardData[0].cardPassiveID;
            break;
        case 1:
            //黑
            cardInformation =cardData[1].cardPassiveID;
            break;
        case 2:
            //剑心
            cardInformation =cardData[2].cardPassiveID;
            break;
        case 3:
            //涅普顿
            cardInformation =cardData[3].cardPassiveID;
            break;
        case 4:
            //桐人
            cardInformation =cardData[4].cardPassiveID;
            break;
        case 5:
            //妖梦
            cardInformation =cardData[5].cardPassiveID;
            break;
        case 6:
            //亚丝娜
            cardInformation =cardData[6].cardPassiveID;
            break;
        case 7:
            //小兵
            cardInformation =cardData[7].cardPassiveID;
            break;
        case 8:
            //尼禄
            cardInformation =cardData[8].cardPassiveID;
            break;
        case 9:
            //萨菲罗斯
            cardInformation =cardData[9].cardPassiveID;
            break;
        case 10:
            //尊
            cardInformation =cardData[10].cardPassiveID;
            break;
        case 11:
            //黑岩
            cardInformation =cardData[11].cardPassiveID;
            break;
        case 12:
            //诗乃
            cardInformation =cardData[12].cardPassiveID;
            break;
        case 13:
            //浅间智
            cardInformation =cardData[13].cardPassiveID;
            break;
        case 14:
            //炮车
            cardInformation =cardData[14].cardPassiveID;
            break;
        case 15:
            //雅典娜
            cardInformation =cardData[15].cardPassiveID;
            break;
        case 16:
            //优
            cardInformation =cardData[16].cardPassiveID;
            break;
        case 17:
            //大龙
            cardInformation =cardData[17].cardPassiveID;
            break;
        case 18:
            //僵尸
            cardInformation =cardData[18].cardPassiveID;
            break;
        case 19:
            //小龙
            cardInformation =cardData[19].cardPassiveID;
            break;
        default:
            break;
    }
    return cardInformation;
}
//获得卡牌主动ID
-(int)getallCardInitiativeID:(int)cardnumber
{
    int cardInformation;
    switch (cardnumber) {
        case 0:
            //二仪式
            cardInformation =cardData[0].cardInitiativeID;
            break;
        case 1:
            //黑
            cardInformation =cardData[1].cardInitiativeID;
            break;
        case 2:
            //剑心
            cardInformation =cardData[2].cardInitiativeID;
            break;
        case 3:
            //涅普顿
            cardInformation =cardData[3].cardInitiativeID;
            break;
        case 4:
            //桐人
            cardInformation =cardData[4].cardInitiativeID;
            break;
        case 5:
            //妖梦
            cardInformation =cardData[5].cardInitiativeID;
            break;
        case 6:
            //亚丝娜
            cardInformation =cardData[6].cardInitiativeID;
            break;
        case 7:
            //小兵
            cardInformation =cardData[7].cardInitiativeID;
            break;
        case 8:
            //尼禄
            cardInformation =cardData[8].cardInitiativeID;
            break;
        case 9:
            //萨菲罗斯
            cardInformation =cardData[9].cardInitiativeID;
            break;
        case 10:
            //尊
            cardInformation =cardData[10].cardInitiativeID;
            break;
        case 11:
            //黑岩
            cardInformation =cardData[11].cardInitiativeID;
            break;
        case 12:
            //诗乃
            cardInformation =cardData[12].cardInitiativeID;
            break;
        case 13:
            //浅间智
            cardInformation =cardData[13].cardInitiativeID;
            break;
        case 14:
            //炮车
            cardInformation =cardData[14].cardInitiativeID;
            break;
        case 15:
            //雅典娜
            cardInformation =cardData[15].cardInitiativeID;
            break;
        case 16:
            //优
            cardInformation =cardData[16].cardInitiativeID;
            break;
        case 17:
            //大龙
            cardInformation =cardData[17].cardInitiativeID;
            break;
        case 18:
            //僵尸
            cardInformation =cardData[18].cardInitiativeID;
            break;
        case 19:
            //小龙
            cardInformation =cardData[19].cardInitiativeID;
            break;
        default:
            break;
    }
    return cardInformation;
}
//获得卡牌是否英雄单位(是和否)
-(BOOL)getallCardHeroUnits:(int)cardnumber
{
    BOOL cardInformation;
    switch (cardnumber) {
        case 1:
            //1表示该单位为英雄单位
            cardInformation =true;
            break;
        case 2:
            cardInformation =false;
            break;
        default:
            break;
    }
    return cardInformation;
}
@end
