//
//  MessageProcessingCenter.m
//  NewHeros
//
//  Created by 洪天伟 on 17/5/4.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "MessageProcessingCenter.h"

@implementation MessageProcessingCenter
int playernumber;
int playerAttack;
int playerLife;
int playerPassiveID;
int playerID;

int AiNumber;
int AiAttack;
int AiLife;
int AiPassiveID;

//玩家人物攻击
bool PlayerPersonAttack;
//AI人物被点击
bool AIPersonIsClicked;
//AI卡牌被点击
bool AICardIsClicked;

//位置信息
int SpecifiedLocation;
//卡牌信息
int CardInformation;
//卡牌详细消息
int CardDetailsAttack[7];
int CardDetailsLife[7];
int CardDetailsPassiveID[7];
int CardDetailsInitiativeID[7];
int CardDetailsHeros[7];

//AI卡牌详细消息
int AICardAttackDetails[7];
int AICardLifeDetails[7];
int AICardPassiveIDDetailes[7];
int AICardInitiativeID[7];
int AICardHerosDetailes[7];
//AI位置信息
int AISpecifiedLocation;
//AI卡牌信息
int AICurrentCards;
//AI人物卡牌
int AIPersonInformation;
//玩家卡牌被AI人物击杀
bool PlayerCardIsKilledByAIPerson;


//AI卡牌被玩家人物击杀
bool AICardIsKilledByPlayerPerson;



//AI的被动信息是否被触发
bool AIPersonTriggerPassive;
//玩家人物的被动是否被触发
bool PlayerPersonTriggerPassive;
//卡牌被动被触发
bool CardPassiveIsTrigger;



//玩家卡牌的浅间智攻击次数
int AsamaChiriAttackTimes;
//AI卡牌的浅间智攻击次数
int AIAsamaChiriTimes;
//AI卡牌被攻击次数(用于给不同的卡牌增加减速buff)
int AICardBeAttackTimes[7];
//玩家卡牌被攻击次数
int PlayerBeAttackTimes[7];

//更改的数据
int ConstantlyChangingAttack;
int ConstantlyChangingLife;
int ConstantlyChangingPassiveID;
int ConstantlyChangingInitiativeID;
int ConstantlyChangingHero;//是否为英雄单位(0和1分别表示是否为英雄单位)

//近战英雄单位是否存在
bool WhetherTheMeleeUnitExists;
int  PMeleeNumber;
int  PMeleeReduction =-1;//玩家近战存在伤害减免
//辅助英雄单位是否存在
bool WhetherTheAuxuliaryUnitExists;
int  PAuxuliaryNumber;
int  PAuxuliaryReduction =-1;//玩家辅助存在伤害减免
int  PAuxuliaryDeepened =1;//玩家辅助伤害加深
//射手英雄单位是否存在
bool WhetherTheShooterIsPresent;
int  PShooterNumber;
int  PShooterDeepened =1;//玩家射手存在伤害加深

//AI辅助英雄单位是否存在
bool AIIsPresent;
int  AAuxuliaryNumber;
int  AIAuxuliaryReduction=-1;//AI辅助存在伤害减免
int  AIAuxuliaryDeepened =1;//AI辅助伤害加深
//AI近战英雄单位是否存在
bool AIIsTheMeleePresent;
int  AMeleeNumber;
int  AIMeleeReduction =-1;//AI近战存在伤害减免
//AI射手单位是否存在
bool AIStrikerExists;
int AShooterNumber;
int AIShooterDeepened =1;//AI射手存在伤害加深

//周防尊是否存在
bool ResepectIs;
//周防尊尊存在减伤
int ResepectPassiveReduction =-1;
//周防尊是否被使用
bool WhetherOrNotToUseIt;
//小兵数量(玩家)
int PNumberOfSolders;
bool PSoldersPassive;
//小兵数量(AI)
int ANumberOfSolders;
bool ASoldersPassive;

//你能造成的伤害（包括AI和自己）
int YouCauseHarm;
//你受到的伤害(包括Ai和自己)
int YouGetHurt;
//桐人存在
bool KazongIs;
//亚丝娜存在
bool YasinaIs;
//僵尸（特殊类）死亡标记
bool ZombieDieMark;
//音效判断(攻击)
int SoundJudgment;
//音效判断(死亡)
int SoundDeath;
//单位死亡
int UnitDeath;
//攻击者对被攻击者的伤害（最终伤害）(造成的伤害)
int UltimateInjury;
//AI大龙上场
bool AIOshilisSkyInNews;
/*
   状态消息
 */
bool DizzyNews;//眩晕
bool ParalysisNews;//麻痹
bool BlueFeather;//蓝羽化
bool SlowDown;//减速
bool FreezeNews;//冻结

/*
  记录消息
 */
int RecordPlayerCard;//玩家卡牌数
int RecordAICard;//AI卡牌数
/*
 记录玩家场上有多少张卡牌
 记录Ai场上有多少张卡牌
 */
-(int)RecordPlayerCardsNumber:(int)number{
    RecordPlayerCard =number;
    return RecordPlayerCard;
}//玩家卡牌
-(int)RecordAICardsNumber:(int)number{
    RecordAICard =number;
    return RecordAICard;
}//AI卡牌
//数据初始化工作
-(void)DataInitializationWork{
    for (int i=0; i<7; i++) {
        //玩家数据初始化
        CardDetailsAttack[i]=0;
        CardDetailsHeros[i]=-1;
        CardDetailsInitiativeID[i]=-1;
        CardDetailsLife[i]=0;
        CardDetailsPassiveID[i]=-1;
        
        //AI数据初始化
        CardDetailsAttack[i]=0;
        CardDetailsHeros[i]=-1;
        CardDetailsInitiativeID[i]=-1;
        CardDetailsLife[i]=0;
        CardDetailsPassiveID[i]=-1;
    }
}
//回馈眩晕消息
-(BOOL)FeedbackDizzyNews{
    return DizzyNews;
}
//回馈麻痹消息
-(BOOL)FeedbackParalysisNews{
    return ParalysisNews;
}
//回馈蓝羽化消息
-(BOOL)FeedbackBlueFeatherNews{
    return BlueFeather;
}
//回馈减速消息
-(BOOL)FeedbackSlowdownNews{
    return SlowDown;
}
//回馈冻结消息
-(BOOL)FeedbackFreezeNews{
    return FreezeNews;
}
//返回玩家卡牌被AI人物击杀消息
-(BOOL)PlayerCardIsKilledByAIPerson{
    return PlayerCardIsKilledByAIPerson;
}
//返回AI卡牌被玩家人物击杀消息
-(BOOL)AICardIsKilledByPlayerPerson{
    return AICardIsKilledByPlayerPerson;
}
-(int)random
{
    return arc4random()%20;
}
//获得AI的随机数
-(int)AICardRandom
{
    return arc4random()%20;
}
-(int)randomofassassign
{
    //刺客有7个
    return arc4random()%7;
}
-(int)randomofarcherandassist
{
    //射手有4个,辅助有2个
    return arc4random()%6;
}
-(int)randomofmelee
{
    //近战有4个
    return arc4random()%4;
}
//传递人物方法
-(int)initWithChangePlayer:(int)play
{
    playernumber =play;
    return playernumber;
}
-(void)setPlayer
{
    playerID =playernumber;
    playerAttack =5;
    playerLife =30;
    playerPassiveID =playernumber;
    if (playernumber ==4) {
        playerAttack =6;
    }
}
-(int)getplayerID
{
    return playerID;
}
-(int)getplayerLife
{
    return playerLife;
}
-(int)getplayerAttack
{
    return playerAttack;
}
-(int)getPassiveID
{
    return playerPassiveID;
}
//传递AI人物
-(int)initWithChangeAI:(int)play
{
    AiNumber =play;
    return AiNumber;
}
-(void)setAI
{
    AiAttack =5;
    AiLife =30;
    AiPassiveID =AiNumber;
    if (AiNumber ==4) {
        AiAttack =6;
    }
}
-(int)getAiAttack
{
    return AiAttack;
}
-(int)getAiLife
{
    return AiLife;
}
-(int)getAiPassiveID
{
    return AiPassiveID;
}
//传递手牌移动到指定位置的信息
-(int)moveToTheSpecifiedLocation:(int)play
{
    SpecifiedLocation =play;
    return SpecifiedLocation;
}
//设置卡牌信息
-(void)setCardInformation:(int)somenumber
{
    switch (somenumber) {
        case 0://214
            ConstantlyChangingAttack =6;
            ConstantlyChangingLife =6;
            ConstantlyChangingPassiveID =0;//被动ID
            ConstantlyChangingInitiativeID =0;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 1://黑
            ConstantlyChangingAttack =7;
            ConstantlyChangingLife =5;
            ConstantlyChangingPassiveID =1;//被动ID
            ConstantlyChangingInitiativeID =1;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 2://剑心
            ConstantlyChangingAttack =5;
            ConstantlyChangingLife =6;
            ConstantlyChangingPassiveID =2;//被动ID
            ConstantlyChangingInitiativeID =2;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 3://涅普顿
            ConstantlyChangingAttack =6;
            ConstantlyChangingLife =7;
            ConstantlyChangingPassiveID =3;//被动ID
            ConstantlyChangingInitiativeID =3;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 4://桐人
            ConstantlyChangingAttack =8;
            ConstantlyChangingLife =4;
            ConstantlyChangingPassiveID =4;//被动ID
            ConstantlyChangingInitiativeID =4;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 5://妖梦
            ConstantlyChangingAttack =7;
            ConstantlyChangingLife =5;
            ConstantlyChangingPassiveID =5;//被动ID
            ConstantlyChangingInitiativeID =5;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 6://亚丝娜
            ConstantlyChangingAttack =7;
            ConstantlyChangingLife =6;
            ConstantlyChangingPassiveID =6;//被动ID
            ConstantlyChangingInitiativeID =6;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 7://FFF团小兵
            ConstantlyChangingAttack =2;
            ConstantlyChangingLife =5;
            ConstantlyChangingPassiveID =7;//被动ID
            ConstantlyChangingInitiativeID =7;//主动ID
            ConstantlyChangingHero =0;
            break;
        case 8://尼禄
            ConstantlyChangingAttack =5;
            ConstantlyChangingLife =9;
            ConstantlyChangingPassiveID =8;//被动ID
            ConstantlyChangingInitiativeID =8;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 9://萨菲罗斯
            ConstantlyChangingAttack =3;
            ConstantlyChangingLife =10;
            ConstantlyChangingPassiveID =9;//被动ID
            ConstantlyChangingInitiativeID =9;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 10://周防尊
            ConstantlyChangingAttack =4;
            ConstantlyChangingLife =10;
            ConstantlyChangingPassiveID =10;//被动ID
            ConstantlyChangingInitiativeID =10;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 11://黑岩射手
            ConstantlyChangingAttack =8;
            ConstantlyChangingLife =6;
            ConstantlyChangingPassiveID =11;//被动ID
            ConstantlyChangingInitiativeID =11;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 12://朝田诗乃
            ConstantlyChangingAttack =9;
            ConstantlyChangingLife =4;
            ConstantlyChangingPassiveID =12;//被动ID
            ConstantlyChangingInitiativeID =12;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 13://浅间智
            ConstantlyChangingAttack =8;
            ConstantlyChangingLife =4;
            ConstantlyChangingPassiveID =13;//被动ID
            ConstantlyChangingInitiativeID =13;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 14://FFF团炮车
            ConstantlyChangingAttack =3;
            ConstantlyChangingLife =4;
            ConstantlyChangingPassiveID =14;//被动ID
            ConstantlyChangingInitiativeID =14;//主动ID
            ConstantlyChangingHero =0;
            break;
        case 15://雅典娜
            ConstantlyChangingAttack =2;
            ConstantlyChangingLife =6;
            ConstantlyChangingPassiveID =15;//被动ID
            ConstantlyChangingInitiativeID =15;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 16://优克莉伍徳
            ConstantlyChangingAttack =2;
            ConstantlyChangingLife =6;
            ConstantlyChangingPassiveID =16;//被动ID
            ConstantlyChangingInitiativeID =16;//主动ID
            ConstantlyChangingHero =1;
            break;
        case 17://欧西里斯天空龙
            ConstantlyChangingAttack =10;
            ConstantlyChangingLife =12;
            ConstantlyChangingPassiveID =17;//被动ID
            ConstantlyChangingInitiativeID =17;//主动ID
            ConstantlyChangingHero =0;
            break;
        case 18://僵尸
            ConstantlyChangingAttack =2;
            ConstantlyChangingLife =2;
            ConstantlyChangingPassiveID =18;//被动ID
            ConstantlyChangingInitiativeID =18;//主动ID
            ConstantlyChangingHero =0;
            break;
        case 19:
            ConstantlyChangingAttack =8;
            ConstantlyChangingLife =10;
            ConstantlyChangingPassiveID =19;//被动ID
            ConstantlyChangingInitiativeID =19;//主动ID
            ConstantlyChangingHero =0;
            break;
        default:
            break;
    }
}
//传递当前选择的手牌
-(int)passTheCurrentlySelected:(int)PTCS
{
    CardInformation =PTCS;
    return CardInformation;
}
//在指定位置上加载指定卡牌信息
-(void)LoadTheSpecifiedCardAtTheSpecifiedLoaction
{
    NSLog(@"card:%d",CardInformation);
    NSLog(@"调用了创建值赋值");
    //判断是否有辅助 射手 近战的存在<判定成功>
    if (CardInformation>=7&&CardInformation<=10) {
        WhetherTheMeleeUnitExists =true;
    }else if(CardInformation>10&&CardInformation<=14)
    {
        WhetherTheShooterIsPresent =true;
    }else if(CardInformation>14&&CardInformation<=16){
        WhetherTheAuxuliaryUnitExists =true;
    }
    NSLog(@"location:%d",SpecifiedLocation);
    switch (SpecifiedLocation) { //位置有7个，从1-7
        case 1:
            //传递进来的卡牌(用于中转消息)
            [self setCardInformation:CardInformation];
            //设置放在位置1上的卡牌信息
            CardDetailsAttack[0]=ConstantlyChangingAttack;
            CardDetailsLife[0]=ConstantlyChangingLife;
            CardDetailsPassiveID[0]=ConstantlyChangingPassiveID;
            CardDetailsInitiativeID[0]=ConstantlyChangingInitiativeID;
            CardDetailsHeros[0]=ConstantlyChangingHero;
            NSLog(@"卡牌1的生命值：%d",CardDetailsLife[0]);
            break;
        case 2:
            //传递进来的卡牌(用于中转消息)
            [self setCardInformation:CardInformation];
            //设置放在位置2上的卡牌信息
            CardDetailsAttack[1]=ConstantlyChangingAttack;
            CardDetailsLife[1]=ConstantlyChangingLife;
            CardDetailsPassiveID[1]=ConstantlyChangingPassiveID;
            CardDetailsInitiativeID[1]=ConstantlyChangingInitiativeID;
            CardDetailsHeros[1]=ConstantlyChangingHero;
            NSLog(@"卡牌2的生命值：%d",CardDetailsLife[1]);
            break;
        case 3:
            //传递进来的卡牌(用于中转消息)
            [self setCardInformation:CardInformation];
            //设置放在位置3上的卡牌信息
            CardDetailsAttack[2]=ConstantlyChangingAttack;
            CardDetailsLife[2]=ConstantlyChangingLife;
            CardDetailsPassiveID[2]=ConstantlyChangingPassiveID;
            CardDetailsInitiativeID[2]=ConstantlyChangingInitiativeID;
            CardDetailsHeros[2]=ConstantlyChangingHero;
            NSLog(@"卡牌3的生命值：%d",CardDetailsLife[2]);
            break;
        case 4:
            //传递进来的卡牌(用于中转消息)
            [self setCardInformation:CardInformation];
            //设置放在位置4上的卡牌信息
            CardDetailsAttack[3]=ConstantlyChangingAttack;
            CardDetailsLife[3]=ConstantlyChangingLife;
            CardDetailsPassiveID[3]=ConstantlyChangingPassiveID;
            CardDetailsInitiativeID[3]=ConstantlyChangingInitiativeID;
            CardDetailsHeros[3]=ConstantlyChangingHero;
            NSLog(@"卡牌4的生命值：%d",CardDetailsLife[3]);
            break;
        case 5:
            //传递进来的卡牌(用于中转消息)
            [self setCardInformation:CardInformation];
            //设置放在位置5上的卡牌信息
            CardDetailsAttack[4]=ConstantlyChangingAttack;
            CardDetailsLife[4]=ConstantlyChangingLife;
            CardDetailsPassiveID[4]=ConstantlyChangingPassiveID;
            CardDetailsInitiativeID[4]=ConstantlyChangingInitiativeID;
            CardDetailsHeros[4]=ConstantlyChangingHero;
            NSLog(@"卡牌5的生命值：%d",CardDetailsLife[4]);
            break;
        case 6:
            //传递进来的卡牌(用于中转消息)
            [self setCardInformation:CardInformation];
            //设置放在位置6上的卡牌信息
            CardDetailsAttack[5]=ConstantlyChangingAttack;
            CardDetailsLife[5]=ConstantlyChangingLife;
            CardDetailsPassiveID[5]=ConstantlyChangingPassiveID;
            CardDetailsInitiativeID[5]=ConstantlyChangingInitiativeID;
            CardDetailsHeros[5]=ConstantlyChangingHero;
            NSLog(@"卡牌6的生命值：%d",CardDetailsLife[5]);
            break;
        case 7:
            //传递进来的卡牌(用于中转消息)
            [self setCardInformation:CardInformation];
            //设置放在位置7上的卡牌信息
            CardDetailsAttack[6]=ConstantlyChangingAttack;
            CardDetailsLife[6]=ConstantlyChangingLife;
            CardDetailsPassiveID[6]=ConstantlyChangingPassiveID;
            CardDetailsInitiativeID[6]=ConstantlyChangingInitiativeID;
            CardDetailsHeros[6]=ConstantlyChangingHero;
            NSLog(@"卡牌7的生命值：%d",CardDetailsLife[6]);
            break;
        default:
            break;
    }
}
//返回卡牌攻击力信息
-(int)ReturnCardAttackMessage:(int)a
{
    return CardDetailsAttack[a];
}
//返回卡牌生命值信息
-(int)ReturnCardLifeMessage:(int)l
{
    return CardDetailsLife[l];
}
//返回卡牌主动ID信息
-(int)ReturnCardInitiativeIDMessage:(int)i
{
    return CardDetailsInitiativeID[i];
}
//返回卡牌被动ID信息
-(int)ReturnCardPassiveIDMessage:(int)p
{
    return CardDetailsPassiveID[p];
}
//返回卡牌是否为英雄信息
-(int)ReturnCardHeroMessage:(int)h
{
    return CardDetailsHeros[h];
}
//发送当前的卡牌位置
-(int)sendTheCurrentCardPosition:(int)CardPosition
{
    int TempSound =[self ReturnCardPassiveIDMessage:CardPosition-1];//判断是那张牌
    switch (CardPosition) {
        case 1:
            SpecifiedLocation =1;
            NSLog(@"点击了按钮1");
            NSLog(@"该位置所对应的卡牌被动编号是：%d",TempSound);
            NSLog(@"调用CardDetailsLife[1]");
            NSLog(@"调用人物音效");
            //输出当前卡牌的各项信息<测试成功>
            NSLog(@"Attack:%d",[self ReturnCardAttackMessage:0]);
            break;
        case 2:
            SpecifiedLocation =2;
            NSLog(@"点击了按钮2");
            NSLog(@"调用CardDetailsLife[2]");
            break;
        case 3:
            SpecifiedLocation=3;
            NSLog(@"点击了按钮3");
            NSLog(@"调用CardDetailsLife[3]");
            break;
        case 4:
            SpecifiedLocation =4;
            NSLog(@"点击了按钮4");
            NSLog(@"调用CardDetailsLife[4]");
            break;
        case 5:
            SpecifiedLocation =5;
            NSLog(@"点击了按钮5");
            NSLog(@"调用CardDetailsLife[5]");
            break;
        case 6:
            SpecifiedLocation =6;
            NSLog(@"点击了按钮6");
            NSLog(@"调用CardDetailsLife[6]");
            break;
        case 7:
            SpecifiedLocation =7;
            NSLog(@"点击了按钮7");
            NSLog(@"调用CardDetailsLife[7]");
            break;
        default:
            break;
    }
    return 0;
}
//发送当前被攻击者的位置
-(int)sendTheCUrrentlyAttackedCardPosition:(int)attackPosition
{
    //attackposition:被攻击的位置
    NSLog(@"攻击者的位置：%d",SpecifiedLocation);
    NSLog(@"被攻击者的位置：%d",attackPosition);
    switch (attackPosition) {
        case 1:
            //测试调用<17.5.16－21>(这里要做数据计算)<数据测试没问题>
            [self DealWithLifeMessages:SpecifiedLocation andAI:attackPosition];
            break;
        case 2:
            [self DealWithLifeMessages:SpecifiedLocation andAI:attackPosition];
            break;
        case 3:
            [self DealWithLifeMessages:SpecifiedLocation andAI:attackPosition];
            break;
        case 4:
           [self DealWithLifeMessages:SpecifiedLocation andAI:attackPosition];
            break;
        case 5:
            [self DealWithLifeMessages:SpecifiedLocation andAI:attackPosition];
            break;
        case 6:
           [self DealWithLifeMessages:SpecifiedLocation andAI:attackPosition];
            break;
        case 7:
           [self DealWithLifeMessages:SpecifiedLocation andAI:attackPosition];
            break;
        case 8:
            //卡牌攻击AI人物位置(测试17.5.23)
            [self CalculateTheDamageToAIPerson:SpecifiedLocation andAIPerson:attackPosition];
            break;
        default:
            break;
    }
    return 0;
}
//发送AI卡牌位置
-(int)sendTheAICardPosition:(int)AIPosition
{
    AISpecifiedLocation =AIPosition;
    return AISpecifiedLocation;
}
//发送AI当前卡牌
-(int)sendAICurrentCard:(int)AICurrentCard
{
    AICurrentCards =AICurrentCard;
    return AICurrentCards;
}
//AI在指定位置上加载指定卡牌信息
-(void)AIAtLoadSpecifiedCardInformation
{
    NSLog(@"AIcard:%d",AISpecifiedLocation);
    NSLog(@"AICurrentCard:%d",AICurrentCards);
    switch (AISpecifiedLocation) {//位置从1到7
        case 1://位置1
            [self setCardInformation:AICurrentCards];
            AICardAttackDetails[0]=ConstantlyChangingAttack;
            AICardLifeDetails[0]=ConstantlyChangingLife;
            AICardPassiveIDDetailes[0]=ConstantlyChangingPassiveID;
            AICardInitiativeID[0]=ConstantlyChangingInitiativeID;
            AICardHerosDetailes[0]=ConstantlyChangingHero;
            NSLog(@"AIAttack1:%d",AICardAttackDetails[0]);
            NSLog(@"AILife1:%d",AICardLifeDetails[0]);
            NSLog(@"AI1PID:%d",AICardPassiveIDDetailes[0]);
            NSLog(@"AI1ID:%d",AICardInitiativeID[0]);
            NSLog(@"AI1HD:%d",AICardHerosDetailes[0]);
            NSLog(@"==================分割线1==============");
            break;
        case 2://位置2
            [self setCardInformation:AICurrentCards];
            AICardAttackDetails[1]=ConstantlyChangingAttack;
            AICardLifeDetails[1]=ConstantlyChangingLife;
            AICardPassiveIDDetailes[1]=ConstantlyChangingPassiveID;
            AICardInitiativeID[1]=ConstantlyChangingInitiativeID;
            AICardHerosDetailes[1]=ConstantlyChangingHero;
            NSLog(@"AIAttack2:%d",AICardAttackDetails[1]);
            NSLog(@"AILife2:%d",AICardLifeDetails[1]);
            NSLog(@"AI2PID:%d",AICardPassiveIDDetailes[1]);
            NSLog(@"AI2ID:%d",AICardInitiativeID[1]);
            NSLog(@"AI2HD:%d",AICardHerosDetailes[1]);
            NSLog(@"==================分割线2==============");
            break;
        case 3://位置3
            [self setCardInformation:AICurrentCards];
            AICardAttackDetails[2]=ConstantlyChangingAttack;
            AICardLifeDetails[2]=ConstantlyChangingLife;
            AICardPassiveIDDetailes[2]=ConstantlyChangingPassiveID;
            AICardInitiativeID[2]=ConstantlyChangingInitiativeID;
            AICardHerosDetailes[2]=ConstantlyChangingHero;
            NSLog(@"AIAttack3:%d",AICardAttackDetails[2]);
            NSLog(@"AILife3:%d",AICardLifeDetails[2]);
            NSLog(@"AI3PID:%d",AICardPassiveIDDetailes[2]);
            NSLog(@"AI3ID:%d",AICardInitiativeID[2]);
            NSLog(@"AI3HD:%d",AICardHerosDetailes[2]);
            NSLog(@"==================分割线3==============");
            break;
        case 4://位置4
            [self setCardInformation:AICurrentCards];
            AICardAttackDetails[3]=ConstantlyChangingAttack;
            AICardLifeDetails[3]=ConstantlyChangingLife;
            AICardPassiveIDDetailes[3]=ConstantlyChangingPassiveID;
            AICardInitiativeID[3]=ConstantlyChangingInitiativeID;
            AICardHerosDetailes[3]=ConstantlyChangingHero;
            NSLog(@"AIAttack4:%d",AICardAttackDetails[3]);
            NSLog(@"AILife4:%d",AICardLifeDetails[3]);
            NSLog(@"AI4PID:%d",AICardPassiveIDDetailes[3]);
            NSLog(@"AI4ID:%d",AICardInitiativeID[3]);
            NSLog(@"AI4HD:%d",AICardHerosDetailes[3]);
            NSLog(@"==================分割线4==============");
            break;
        case 5://位置5
            [self setCardInformation:AICurrentCards];
            AICardAttackDetails[4]=ConstantlyChangingAttack;
            AICardLifeDetails[4]=ConstantlyChangingLife;
            AICardPassiveIDDetailes[4]=ConstantlyChangingPassiveID;
            AICardInitiativeID[4]=ConstantlyChangingInitiativeID;
            AICardHerosDetailes[4]=ConstantlyChangingHero;
            NSLog(@"AIAttack5:%d",AICardAttackDetails[4]);
            NSLog(@"AILife5:%d",AICardLifeDetails[4]);
            NSLog(@"AI5PID:%d",AICardPassiveIDDetailes[4]);
            NSLog(@"AI5ID:%d",AICardInitiativeID[4]);
            NSLog(@"AI5HD:%d",AICardHerosDetailes[4]);
            NSLog(@"==================分割线5==============");
            break;
        case 6://位置6
            [self setCardInformation:AICurrentCards];
            AICardAttackDetails[5]=ConstantlyChangingAttack;
            AICardLifeDetails[5]=ConstantlyChangingLife;
            AICardPassiveIDDetailes[5]=ConstantlyChangingPassiveID;
            AICardInitiativeID[5]=ConstantlyChangingInitiativeID;
            AICardHerosDetailes[5]=ConstantlyChangingHero;
            NSLog(@"AIAttack6:%d",AICardAttackDetails[5]);
            NSLog(@"AILife6:%d",AICardLifeDetails[5]);
            NSLog(@"AI6PID:%d",AICardPassiveIDDetailes[5]);
            NSLog(@"AI6ID:%d",AICardInitiativeID[5]);
            NSLog(@"AI6HD:%d",AICardHerosDetailes[5]);
            NSLog(@"==================分割线6==============");
            break;
        case 7://位置7
            [self setCardInformation:AICurrentCards];
            AICardAttackDetails[6]=ConstantlyChangingAttack;
            AICardLifeDetails[6]=ConstantlyChangingLife;
            AICardPassiveIDDetailes[6]=ConstantlyChangingPassiveID;
            AICardInitiativeID[6]=ConstantlyChangingInitiativeID;
            AICardHerosDetailes[6]=ConstantlyChangingHero;
            NSLog(@"AIAttack7:%d",AICardAttackDetails[6]);
            NSLog(@"AILife7:%d",AICardLifeDetails[6]);
            NSLog(@"AI7PID:%d",AICardPassiveIDDetailes[6]);
            NSLog(@"AI7ID:%d",AICardInitiativeID[6]);
            NSLog(@"AI7HD:%d",AICardHerosDetailes[6]);
            NSLog(@"==================分割线7==============");
            break;
        default:
            break;
    }
}
//返回AI卡牌攻击力信息
-(int)receiveAICardAttackMessage:(int)AIa
{
    return AICardAttackDetails[AIa];
}
//返回AI卡牌生命值信息
-(int)receiveAICardLifeMessage:(int)AIl
{
    return AICardLifeDetails[AIl];
}
//返回AI卡牌主动ID信息
-(int)receiveAICardInitiativeIDMessage:(int)AIi
{
    return AICardInitiativeID[AIi];
}
//返回AI卡牌被动ID信息
-(int)receiveAICardPassiveIDMessage:(int)AIp
{
    return AICardPassiveIDDetailes[AIp];
}
//返回AI卡牌是否为英雄信息
-(int)receiveAICardHeroMessage:(int)AIh
{
    return AICardHerosDetailes[AIh];
}
//数据处理(处理玩家卡牌攻击AI卡牌的动作)
-(void)DealWithLifeMessages:(int)playerAttackMessage andAI:(int)AIAttackMessage
{
    NSLog(@"调用了数据处理中心");
    //初始状态更新AI的生命值等状态
    [self UpdataData];
    //测试查看当前的AI状态
    for (int i=0; i<7; i++) {
        NSLog(@"AICardLifeDetails[%d]:%d",i,AICardLifeDetails[i]);
    }
    //获得攻击者数组和被攻击者数组
    NSLog(@"攻击者位置:%d",playerAttackMessage);
    NSLog(@"被攻击者位置：%d",AIAttackMessage);
    int GetAnArrayOfAttackers =playerAttackMessage-1;
    int GetTheArrayOfAttackers =AIAttackMessage-1;
    //获得攻击者对应的卡牌
    int TheAttackerCorresPonds=CardDetailsPassiveID[GetAnArrayOfAttackers];
    NSLog(@"攻击者的被动编号:%d",TheAttackerCorresPonds);
    //获得被攻击者对应的卡牌
    int TheAICardCorresPonding =AICardPassiveIDDetailes[GetTheArrayOfAttackers];
    NSLog(@"被攻击者的被动编号:%d",TheAICardCorresPonding);
    //妖梦的伤害
    int DemonInjury;
    //前置，使用前初始化，防止出错
    YouCauseHarm =0;
    YouGetHurt =0;
    WhetherOrNotToUseIt =false;
    ZombieDieMark =false;
    //初始化数据
    CardPassiveIsTrigger =false;
    //发送攻击者消息给处理器，获得攻击者基础攻击能造成多少伤害
    //发送数组位置和攻击者
    [self UnitExistsForCalculation:GetAnArrayOfAttackers andAttack:TheAttackerCorresPonds];
    NSLog(@"当前卡牌能造成的伤害:%d",YouCauseHarm);
    //发送被攻击者消息给处理器，获得被攻击者被攻击时造成多少生命损失
    [self AIUnitExistsForCalculation:TheAICardCorresPonding];
    NSLog(@"当前AI卡牌受到的伤害:%d",YouGetHurt);
    //获得所有单位存在信息，即是否有近战英雄单位／射手单位／辅助单位存在
    [self UnitExistCalculation];
    //判断敌人场上周防尊是否存在(或许用while会比较好)
    for (int i=0; i<7; i++) {
        if (AICardPassiveIDDetailes[i]==10) {
            if (AICardLifeDetails[i]>0) {//生命值必须大于10才可以
                ResepectIs =true;
                NSLog(@"尊存在!");
            }
        }
    }
    //特殊情况
    //还是一个一个的计算好了，代码重复点，出错的概率低点
    //先判断攻击目标，再判断敌方存在减益
    if(CardDetailsPassiveID[GetAnArrayOfAttackers]==0){//攻击者是214
        //判断被动是否生效
        if (CardPassiveIsTrigger) {//被动生效
            //214生命＋1
            CardDetailsLife[GetAnArrayOfAttackers]++;
            NSLog(@"触发了214的主动回血");
            //判断
            if (CardDetailsLife[GetAnArrayOfAttackers]>6) {
                CardDetailsLife[GetAnArrayOfAttackers]=6;
            }
        }else{
            CardDetailsLife[GetAnArrayOfAttackers]=CardDetailsLife[GetAnArrayOfAttackers];
            NSLog(@"没触发214的主动回血");
        }
        NSLog(@"调用了214的攻击动作");
        if (AICardLifeDetails[GetTheArrayOfAttackers]>3) {//优先判断被攻击者的生命
            //判断攻击目标
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
                if (ResepectIs) {//判断敌方尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }//攻击目标是敌方刺客
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
                if (ResepectIs) {//尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
            }//攻击目标是敌方近战
            if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
                if(ResepectIs){//尊是否存在
                    if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                        UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    if (AIIsPresent) {//辅助是否存在
                        //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    //没有辅助但有尊
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //尊和辅助都不存在
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方射手
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
                if (AIIsTheMeleePresent) {//近战是否存在
                    if (ResepectIs) {//尊存在
                        //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                        UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                     UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                 UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
                if (ResepectIs) {//尊存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方特殊
     }//优先判断被攻击者的生命
     else if(AICardLifeDetails[GetTheArrayOfAttackers]<=3){//
              UltimateInjury =100;//直接设置最终伤害为100
        }
    }//214
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==1) {//攻击者是黑
        NSLog(@"调用了黑的攻击动作");
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"黑的主动生效");
            DizzyNews =true;
        }else{
            NSLog(@"没有触发主动");
        }
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//黑
    if(CardDetailsPassiveID[GetAnArrayOfAttackers]==2){//攻击者是剑心
        NSLog(@"调用了剑心的攻击动作");
        if(CardDetailsLife[GetAnArrayOfAttackers]<=3){//先判断剑心的生命值
            UltimateInjury =8;//真实伤害
        }else{
            //判断攻击目标
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
                if (ResepectIs) {//判断敌方尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }//攻击目标是敌方刺客
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
                if (ResepectIs) {//尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
            }//攻击目标是敌方近战
            if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
                if(ResepectIs){//尊是否存在
                    if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                        UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    if (AIIsPresent) {//辅助是否存在
                        //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    //没有辅助但有尊
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //尊和辅助都不存在
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方射手
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
                if (AIIsTheMeleePresent) {//近战是否存在
                    if (ResepectIs) {//尊存在
                        //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                        UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
                if (ResepectIs) {//尊存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方特殊
        }
}//剑心
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==3) {//攻击者是NEP
        NSLog(@"调用了NEP的攻击动作");
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//NEP
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==4) {//桐人
        /*
          固定伤害：只吃卡牌自身的被动，尊减伤无效
         */
        NSLog(@"调用了桐人的攻击动作");
        int EscapesValues =YouCauseHarm;
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==3) {
            //攻击的是NEP
            UltimateInjury =EscapesValues+YouGetHurt;
        }else if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==8) {
            //攻击的是尼禄
            UltimateInjury =EscapesValues+YouGetHurt;
        }else if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=11&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){
            //攻击的射手(射手加伤)
            UltimateInjury =EscapesValues+YouGetHurt+AIShooterDeepened;
        }else if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]==15||AICardPassiveIDDetailes[GetTheArrayOfAttackers]==16){
            //攻击的是辅助（辅助有加伤）
            UltimateInjury =EscapesValues+AIAuxuliaryDeepened;
        }else{
            UltimateInjury =EscapesValues;
        }
}//桐人
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==5) {//妖梦
        NSLog(@"调用了妖梦的攻击动作");
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"妖梦的主动生效，造成对敌人造成眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"妖梦主动没生效");
        }
        DemonInjury =YouCauseHarm+AICardAttackDetails[GetTheArrayOfAttackers]/2;//妖梦被动（固定伤害2+敌方攻击力的一半）<吃伤害减免>
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+DemonInjury;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+DemonInjury+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+DemonInjury+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =DemonInjury+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =DemonInjury+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =DemonInjury+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =DemonInjury+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =DemonInjury+YouGetHurt;
        }//攻击目标是敌方特殊
    }//妖梦
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==6) {//攻击者是亚丝娜
        NSLog(@"调用了亚丝娜的攻击动作");
        /*
         真实伤害：只有尼禄才有伤害减免
         */
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==8) {
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }
        UltimateInjury =YouCauseHarm;//真实伤害
    }//亚丝娜
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==7) {//FFF团小兵
        NSLog(@"调用了小兵的攻击动作");
        BOOL MeleeHeroUnit =false;
        //先判断敌方场上是否有近战英雄单位
        for (int i=0; i<7; i++) {
            if (AICardPassiveIDDetailes[i]<=10&&AICardPassiveIDDetailes[i]>=8) {
                NSLog(@"返回一个消息，提示玩家需要先攻击敌方近战英雄单位");
                MeleeHeroUnit =true;
            }
        }
        if (MeleeHeroUnit ==true) {
            //只能攻击敌方近战单位（近战减伤百分百存在）
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction;
        }else {
            //攻击目标是刺客
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
            //攻击目标是射手
            if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=11&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){
                if (AIIsPresent) {//辅助存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryReduction+AIShooterDeepened;
                }
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIShooterDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIShooterDeepened;
            }
            //攻击目标是辅助
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            //攻击目标是特殊
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
        }//对应else
    }//小兵
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==8) {//尼禄
       NSLog(@"调用了尼禄的攻击动作");
        BOOL MeleeHeroUnit =false;
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"尼禄的被动生效，造成眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"尼禄的被动没有生效");
        }
        //先判断敌方场上是否有近战英雄单位
        for (int i=0; i<7; i++) {
            if (AICardPassiveIDDetailes[i]<=10&&AICardPassiveIDDetailes[i]>=8) {
                NSLog(@"返回一个消息，提示玩家需要先攻击敌方近战英雄单位");
                MeleeHeroUnit =true;
            }
        }
        if (MeleeHeroUnit ==true) {
            //只能攻击敌方近战单位（近战减伤百分百存在）
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction;
        }else {
            //攻击目标是刺客
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
            //攻击目标是射手
            if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=11&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){
                if (AIIsPresent) {//辅助存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryReduction+AIShooterDeepened;
                }
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIShooterDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIShooterDeepened;
            }
            //攻击目标是辅助
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            //攻击目标是特殊
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
        }//对应else
    }//尼禄
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==9) {//萨菲罗斯
        NSLog(@"调用了萨菲罗斯的攻击动作");
        BOOL MeleeHeroUnit =false;
        //先判断敌方场上是否有近战英雄单位
        for (int i=0; i<7; i++) {
            if (AICardPassiveIDDetailes[i]<=10&&AICardPassiveIDDetailes[i]>=8) {
                NSLog(@"返回一个消息，提示玩家需要先攻击敌方近战英雄单位");
                MeleeHeroUnit =true;
            }
        }
        if (MeleeHeroUnit ==true) {
            //只能攻击敌方近战单位（近战减伤百分百存在）
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction;
        }else {
            //攻击目标是刺客
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
            //攻击目标是射手
            if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=11&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){
                if (AIIsPresent) {//辅助存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryReduction+AIShooterDeepened;
                }
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIShooterDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIShooterDeepened;
            }
            //攻击目标是辅助
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            //攻击目标是特殊
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
        }//对应else
    }//罗斯
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==10) {//攻击者是尊
        NSLog(@"调用了尊的攻击动作");
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"尊的主动生效，造成眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"尊的主动没有生效");
        }
        UltimateInjury =YouCauseHarm;//真实伤害
    }//尊
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==11) {//黑岩
        NSLog(@"调用了黑岩的攻击动作");
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//黑岩
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==12) {//诗乃
        NSLog(@"调用了诗乃的攻击动作");
        //使用前初始化(防止其它单位触发了眩晕)
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"诗乃的攻击造成了眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"没有触发诗乃的主动");
        }
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//诗乃
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==13) {//雾影
        NSLog(@"调用了雾影的攻击动作");
        /*
         第三次攻击造成2点AOE伤害＋被攻击者百分百眩晕
         攻击会叠加减速buff，三层就冻结
        */
        AsamaChiriAttackTimes++;
        if (AsamaChiriAttackTimes<3) {//AsamaChiriAttackTimes：攻击次数
            //判断攻击目标
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
                if (ResepectIs) {//判断敌方尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }//攻击目标是敌方刺客
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
                if (ResepectIs) {//尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
            }//攻击目标是敌方近战
            if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
                if(ResepectIs){//尊是否存在
                    if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                        UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    if (AIIsPresent) {//辅助是否存在
                        //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    //没有辅助但有尊
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //尊和辅助都不存在
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方射手
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
                if (AIIsTheMeleePresent) {//近战是否存在
                    if (ResepectIs) {//尊存在
                        //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                        UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
                if (ResepectIs) {//尊存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方特殊
        //给攻击目标叠加减速buff
        AICardBeAttackTimes[GetTheArrayOfAttackers]=AsamaChiriAttackTimes;
            SlowDown =true;
        }else{//攻击次数超过3
            //造成全体2点AOE伤害
            for (int i=0; i<7; i++) {
                AICardLifeDetails[i]=AICardLifeDetails[i]-2;
            }
            //重置攻击次数
            AsamaChiriAttackTimes =0;
        }
        if (AICardBeAttackTimes[GetTheArrayOfAttackers]==3) {
            //发送一个冻结消息
            FreezeNews =true;
            //重置被攻击卡牌的减速buff
            AICardBeAttackTimes[GetTheArrayOfAttackers]=0;
            //清除减速
            SlowDown =false;
        }
}//雾影
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==14) {//炮车
        NSLog(@"调用了炮车的攻击动作");
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//炮车
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==15) {//雅典娜
        NSLog(@"调用了雅典娜的攻击动作");
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            NSLog(@"攻击目标");
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//雅典娜
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==16) {//优
        NSLog(@"调用了优的攻击动作");
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            NSLog(@"攻击目标");
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//优
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==17) {//攻击者是大龙
        NSLog(@"调用了大龙的攻击动作");
        UltimateInjury =YouCauseHarm;
        //敌方全体生命值减4
        for (int i=0; i<7; i++) {
            if (AICardPassiveIDDetailes[i]==8) {
                //尼禄受到的伤害-1
                AICardLifeDetails[i]=AICardLifeDetails[i]-UltimateInjury-1;
            }else{
                AICardLifeDetails[i]=AICardLifeDetails[i]-UltimateInjury;
            }
        }
    }//大龙
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==18) {//僵尸
        NSLog(@"调用了僵尸的攻击动作");
        /*
         僵尸只能攻击敌方近战单位，没有就直接死亡
         */
        //判断AI场上是否有近战单位
        for (int i=0; i<7; i++) {
            if (AICardPassiveIDDetailes[i]>=7&&AICardPassiveIDDetailes[i]<=10) {
                //存在近战单位，可以攻击
                //攻击目标
                if (ResepectIs) {//尊是否存在
                        UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
                ZombieDieMark =true;
            }else{
                //没有近战单位，直接死亡
                ZombieDieMark =true;
            }
        }
}//僵尸
    if (CardDetailsPassiveID[GetAnArrayOfAttackers]==19) {//小龙
        NSLog(@"调用了小龙的攻击动作");
        //判断攻击目标
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>=0&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+1;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+1;
        }//攻击目标是敌方刺客
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>6&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==7) {//小兵
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction+1;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction+1;
        }//攻击目标是敌方近战
        if(AICardPassiveIDDetailes[GetTheArrayOfAttackers]>10&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened+1;
                    WhetherOrNotToUseIt =true;
                }
                if (AIIsPresent) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]==14) {
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction+1;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+1;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt+1;
        }//攻击目标是敌方射手
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>14&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=16) {//攻击目标是敌方辅助
            if (AIIsTheMeleePresent) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened+1;
                     WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened+1;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened+1;
        }
        if (AICardPassiveIDDetailes[GetTheArrayOfAttackers]>16&&AICardPassiveIDDetailes[GetTheArrayOfAttackers]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+1;
                 WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+1;
        }//攻击目标是敌方特殊
    }//小龙
    //如果最后伤害小于1，强制等于1
    if (UltimateInjury<1) {
        UltimateInjury =1;
    }
    //移除僵尸
    if (ZombieDieMark) {
        //标准动作，生命变成0
        CardDetailsLife[GetAnArrayOfAttackers]=0;
    }
    //如果使用了尊
    if (WhetherOrNotToUseIt) {
        int temp =UltimateInjury*0.3;
        //判断temp的值是否大于1
        if (temp<1) {
            temp =1;
        }
        //遍历获得尊
        for (int i=0; i<7; i++) {
            //减少尊的生命
            if (AICardPassiveIDDetailes[i]==10) {
                AICardLifeDetails[i]=AICardLifeDetails[i]-temp;
            }
            if (AICardLifeDetails[i]<=0) {
                //尊死亡(把编号发送出去)
                UnitDeath =AICardPassiveIDDetailes[i];
            }
        }
    }
    NSLog(@"youcause:%d yougetcut:%d",YouCauseHarm,YouGetHurt);
    //计算被攻击单位剩下的血量
    int TheRestOfthBloods =[self receiveAICardLifeMessage:GetTheArrayOfAttackers];
    NSLog(@"当前血量：%d",TheRestOfthBloods);
    //计算造成了多少伤害
    NSLog(@"造成了多少伤害：%d",UltimateInjury);
    //更新被攻击者的生命数据（不传到主界面，只在数据处理中心使用）<这东西之前一直没用，所以很不会更新被攻击者的生命值>（17.5.25成功）
    AICardLifeDetails[GetTheArrayOfAttackers]=AICardLifeDetails[GetTheArrayOfAttackers]-UltimateInjury;
    //更新AI数据
    [self UpdataData];
    //更新玩家数据
    [self UpdataPlayerData];
}//👈数据处理1的结尾
//数据处理2（处理玩家卡牌对AI人物的的攻击动作）
-(void)CalculateTheDamageToAIPerson:(int)PlayerCard andAIPerson:(int)AIPerson{
    NSLog(@"使用了卡牌攻击AI人物");
    //AIPerson 传进来的位置：8
    //获得攻击者的位置所对应的数组
    int AttackCardData =PlayerCard-1;
    //获得攻击者是谁(调用位置－1的数组)
    int WhoIsTheAttack =CardDetailsPassiveID[AttackCardData];
    NSLog(@"攻击者是：%d",WhoIsTheAttack);
    //获取被攻击的AI人物是谁
    AIPerson =AiNumber;
    //Pyrrha的反击伤害
    int CounterattackInjury =0;
    //Pyrrha反击触发
    bool PyrrhaCounterattack=false;
    //使用前初始化
    UltimateInjury =0;
    YouCauseHarm =0;
    AIPersonTriggerPassive =false;
    PlayerCardIsKilledByAIPerson =false;
    //初始化数据
    CardPassiveIsTrigger =false;
    //发送攻击者消息给处理器，获得攻击者基础攻击能造成多少伤害
    //攻击者是谁 攻击者数组
    [self UnitExistsForCalculation:AttackCardData andAttack:WhoIsTheAttack];
    NSLog(@"卡牌对人物能造成%d伤害",YouCauseHarm);
    //随机数，用于判断是否触发被动
    int RandomEvents =arc4random()%10;
    NSLog(@"随机不:%d",RandomEvents);
    switch (AIPerson) {
        case 0://Ruby
            //判断特殊卡牌(妖梦)
            if (WhoIsTheAttack==5) {
                UltimateInjury=YouCauseHarm+AiAttack/2;
            }else{
               UltimateInjury =YouCauseHarm/2;
            }
            break;
        case 1://Weiss
            //判断特殊卡牌(妖梦)
            if (WhoIsTheAttack==5) {
                UltimateInjury=YouCauseHarm+AiAttack/2;
            }else{
                UltimateInjury =YouCauseHarm/2;
            }
            break;
        case 2://Blake
            if (RandomEvents>=0&&RandomEvents<=3) {
                UltimateInjury=0;
                //发送一个提示消息给主界面，表示触发了Blake的被动
                AIPersonTriggerPassive  =true;
            }else{
            //没有触发人物被动
            //判断特殊卡牌(妖梦)
            if (WhoIsTheAttack==5) {
                UltimateInjury=YouCauseHarm+AiAttack/2;
                }else{
                    UltimateInjury =YouCauseHarm/2;
                }
            }
            break;
        case 3://yang
            if (RandomEvents>=0&&RandomEvents<=4) {
                if (WhoIsTheAttack==5) {
                    UltimateInjury =YouCauseHarm/2+AiAttack/2+1;
                }else{
                    UltimateInjury =YouCauseHarm/2+1;
                }
                //发送一个提示消息给主界面，表示触发了yang的被动
                AIPersonTriggerPassive  =true;
                //对玩家进行反击
                playerLife =playerLife-UltimateInjury;
            }else{
                //没有触发被动
                //判断特殊卡牌(妖梦)
                if (WhoIsTheAttack==5) {
                    UltimateInjury=YouCauseHarm+AiAttack/2+1;
                }else{
                    UltimateInjury =YouCauseHarm/2+1;
                }
            }
            break;
        case 4://Pyrrha
            if (RandomEvents>=0&&RandomEvents<=6) {
                PyrrhaCounterattack =true;
                int temps;
                if (WhoIsTheAttack ==5) {
                   temps =YouCauseHarm/2+AiAttack/2;
                }else{
                   temps =YouCauseHarm/2;
                }
                UltimateInjury =0;
                //发送一个提示消息给主界面，表示触发了Pyrrha的被动
                AIPersonTriggerPassive  =true;
                //反击伤害
                CounterattackInjury =temps;
                //计算卡牌被P姐反击的生命值
                CardDetailsLife[AttackCardData]=CardDetailsLife[AttackCardData]-CounterattackInjury;
                NSLog(@"被P姐反击后的卡牌生命值:%d",CardDetailsLife[AttackCardData]);
            }else{
            //判断特殊卡牌(妖梦)
            if (WhoIsTheAttack==5) {
                    UltimateInjury=YouCauseHarm+AiAttack/2;
            }else{
                    UltimateInjury =YouCauseHarm/2;
                }
            }
            break;
        default:
            break;
    }
    //强制伤害
    if(UltimateInjury<1&&PyrrhaCounterattack==false){
        UltimateInjury =1;
    }
    //AI人物被攻击后的生命值<测试17.5.24>(成功)
    AiLife =AiLife-UltimateInjury;
    NSLog(@"攻击后AI人物的生命值:%d",AiLife);
    //更新AI数据和玩家数据
    [self UpdataData];
    [self UpdataPlayerData];
    if (CardDetailsLife[AttackCardData]<=0) {
        //反馈玩家卡牌被P姐反杀消息
        PlayerCardIsKilledByAIPerson =true;
        //将剩余生命改成0
        CardDetailsLife[AttackCardData]=0;
    }
}//👈数据处理2的结尾
//数据处理3（处理玩家人物对AI人物的攻击动作）
-(void)DealWithPlayerAttackAIPerson{
    /*处理步骤
     0.判断是否该动作
     1.获得玩家人物是谁，即传递过来的PlayerPerson(playerNumber)
     2.获得玩家攻击的人物是谁，即AIPerson（AiNumber）
     3.获得玩家人物的攻击力和生命
     4.获得AI人物的生命和被动
     5.运算法则:最终伤害＝玩家攻击力／2+被动
     */
    NSLog(@"调用了数据处理3");
    //运算前初始化
    UltimateInjury =0;
    int RandomEvents =arc4random()%10;
    //初始化数据
    CardPassiveIsTrigger =false;
    NSLog(@"随机值有木有固定：%d",RandomEvents);
    if (AIPersonIsClicked&&PlayerPersonAttack) {//玩家攻击了AI人物
        /*
         1.判断攻击的人物是谁
         2.独立计算
         */
        switch (AiNumber) {
            case 0://攻击目标是Ruby
                UltimateInjury =[self getplayerAttack]/2;
                break;
            case 1://攻击目标是Weiss
                UltimateInjury =[self getplayerAttack]/2;
                break;
            case 2://攻击目标是Blake
                /*
                 1.随机数判断是否触发被动
                 2.触发被动发送一个触发被动的消息给主界面
                 */
                if (RandomEvents>=0&&RandomEvents<=3) {
                    NSLog(@"触发被动");
                    UltimateInjury=0;
                    //发送一个提示消息给主界面，表示触发了Blake的被动
                    AIPersonTriggerPassive  =true;
                }else{
                    //没有触发人物被动
                    UltimateInjury =YouCauseHarm/2;
                }
                break;
            case 3://攻击目标是yang
                if (RandomEvents>=0&&RandomEvents<=3) {
                    UltimateInjury =[self getplayerAttack]/2+1;
                    //发送一个提示消息给主界面，表示触发了yang的被动
                    AIPersonTriggerPassive  =true;
                    //玩家被反击后的生命值
                    playerLife =playerLife-UltimateInjury;
                    //更新玩家数据
                    [self UpdataPlayerData];
                }else{
                    //表示没有触发
                    UltimateInjury =[self getplayerAttack]/2+1;
                }
                break;
            case 4://攻击目标是Pyrrha
                if (RandomEvents>=0&&RandomEvents<=6) {
                    int temps =[self getplayerAttack]/2;
                    UltimateInjury =0;
                    //发送一个提示消息给主界面，表示触发了Blake的被动
                    AIPersonTriggerPassive  =true;
                    //反击伤害
                    int CounterattackInjury =temps/2;
                    //玩家被反击以后的生命值
                    playerLife =playerLife-CounterattackInjury;
                    //更新玩家数据
                    [self UpdataPlayerData];
                }else{
                    //没有触发被动
                    UltimateInjury =[self getplayerAttack]/2;
                }
            default:
                break;
        }
        /*
         1.计算AI玩家的剩余生命值
         2.更新AI玩家的数据
         3.判断玩家生命值和AI玩家的生命值
         */
        AiLife =AiLife-UltimateInjury;
        //更新AI数据
        [self UpdataData];
        //更新玩家数据
        [self UpdataPlayerData];
    }//👈if结尾
}//👈数据处理3的结尾
//数据处理4（处理玩家人物对AI卡牌的攻击动作）
-(void)DealWithPlayerAttackAICard{
    /*
     0.初始化数据
     1.获得人物的攻击力
     2.获得被攻击者的位置,以获取对应的数组数据
     3.获得AI卡牌（被攻击者的基础减伤）———AICardNumber
     4.计算（最终伤害＝（人物攻击力－被攻击者的基础减伤）／2）
     5.计算被攻击卡牌的剩余生命值
     6.判断被攻击卡牌的剩余生命值
     7.判断是否触发人物被动（即判断Ruby和Weiss的被动是否生效,YBP的被动不用判断是因为YBP的被动属于防御性被动）
     */
    //初始化数据
    CardPassiveIsTrigger =false;
    NSLog(@"调用了数据处理4");
    //判断条件是否满足，满足才做处理
    if (PlayerPersonAttack&&AICardIsClicked) {//即点击了玩家人物，又点击了AI卡牌
        //人物被动是否触发(玩家被动触发概率只有10%);
        int Passive =arc4random()%10;
        //判断攻击者是谁
        switch (playernumber) {
            case 0://Ruby
                NSLog(@"需要判断Ruby被动");
                if(Passive==0)
                {
                    //被动触发
                    PlayerPersonTriggerPassive =true;
                }else{
                    PlayerPersonTriggerPassive =false;
                }
                break;
            case 1://Weiss
                NSLog(@"需要判断Weiss被动");
                if (Passive==0) {
                    //被动触发
                    PlayerPersonTriggerPassive =true;
                }else{
                    PlayerPersonTriggerPassive =false;
                }
                break;
            case 2://Blake;
            case 3://yang
            case 4://Pyrrha
                NSLog(@"不需要要判断被动");
                PlayerPersonTriggerPassive =false;
                break;
            default:
                break;
        }
        //初始化
        UltimateInjury =0;
        int PersonAttack =[self getplayerAttack];
        //调用对应数据数据
        int AICardArrayData =SpecifiedLocation-1;
        //调用基础减伤数据
        [self AIUnitExistsForCalculation:AICurrentCards];
        //计算最终伤害
        UltimateInjury =(PersonAttack-YouGetHurt)/2;
        //更新被攻击卡牌的剩余生命值
        AICardLifeDetails[AICardArrayData]=AICardLifeDetails[AICardArrayData]-UltimateInjury;
        //更新AI数据
        [self UpdataData];
        //更新玩家数据
        [self UpdataPlayerData];
    }//👈if结尾
}//👈数据处理4点结尾
//返回造成的伤害
-(int)ReturnTheDamegeCaused
{
    return UltimateInjury;
}

//返回AI被动是否被触发
-(BOOL)ReturnAIToTriggerPassive
{
    return AIPersonTriggerPassive;
}
//返回玩家人物被动是否被触发
-(BOOL)ReturnPlayerToTriggerPassive{
    return PlayerPersonTriggerPassive;
}

//是否触发卡牌的被动啊，主动什么的
-(BOOL)WhetherTheTriggerCardPassive{
    return CardPassiveIsTrigger;
}

//单位计算(玩家能造成的伤害)(伤害等)
-(void)UnitExistsForCalculation:(int)Unit andAttack:(int)attack;
{
    //初始化数据
    CardPassiveIsTrigger =false;
    //随机数判定卡牌被动是否生效
    int PassiveTriggers =arc4random()%10;
    if (PassiveTriggers ==4) {//214被动触发
        CardPassiveIsTrigger =true;
    }else{
        CardPassiveIsTrigger =false;
    }
    switch (attack) {
        case 0://214
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        case 1://黑
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        case 2://剑心
            if (CardDetailsLife[Unit]>3&&CardDetailsLife[Unit]<=6) {
                switch (CardDetailsLife[Unit]) {
                    case 4:
                        YouCauseHarm =CardDetailsAttack[Unit]+4;
                        //攻击力上扬
                        CardDetailsAttack[Unit]=CardDetailsAttack[Unit]+4;
                        break;
                    case 5:
                        YouCauseHarm =CardDetailsAttack[Unit]+2;
                        //攻击力上扬
                        CardDetailsAttack[Unit]=CardDetailsAttack[Unit]+2;
                        break;
                    case 6:
                        YouCauseHarm =CardDetailsAttack[Unit];
                        //攻击力上扬
                        CardDetailsAttack[Unit]=CardDetailsAttack[Unit];
                        break;
                    default:
                        break;
                }
            }else{
                YouCauseHarm =8;//真实伤害
            }
            break;
        case 3://涅普顿
            YouCauseHarm =2;//固定伤害
            break;
        case 4://桐人
            YouCauseHarm =6;//固定伤害
            KazongIs =true;
            if (YasinaIs ==true) {
                CardDetailsAttack[Unit]++;
            }
            break;
        case 5://妖梦
            YouCauseHarm =2;//被动的前置条件（固定伤害2）
            break;
        case 6://亚丝娜
            YouCauseHarm =6;//真实伤害
            YasinaIs =true;
            if (KazongIs ==true) {
                CardDetailsAttack[Unit]++;
            }
            break;
        case 7://小兵
            PNumberOfSolders++;
            break;
        case 8://尼禄
            PMeleeNumber++;//近战英雄单位存在时数值＋1
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        case 9://萨菲罗斯
            PMeleeNumber++;
            YouCauseHarm =CardDetailsLife[Unit]*0.05;
            break;
        case 10://周防尊
            PMeleeNumber++;
            YouCauseHarm=1;//真实伤害
            break;
        case 11://黑岩<射手攻击力太高，所以除2>
            PShooterNumber++;
            YouCauseHarm =(CardDetailsAttack[Unit]/2)*1.5;
            break;
        case 12://诗乃
            PShooterNumber++;
            YouCauseHarm =CardDetailsAttack[Unit]/2+2;
            break;
        case 13://浅间智
            PShooterNumber++;
            YouCauseHarm =CardDetailsAttack[Unit]/2;
            break;
        case 14://炮车
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        case 15://雅典娜
            PAuxuliaryNumber++;
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        case 16://优
            PAuxuliaryNumber++;
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        case 17://大龙
            YouCauseHarm =4;//全体真实伤害
            break;
        case 18://僵尸
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        case 19://小龙
            YouCauseHarm =CardDetailsAttack[Unit];
            break;
        default:
            break;
    }
}
//AI卡牌能造成的伤害
-(void)AIcardCanDoDamage:(int)attack andArrayIndex:(int)index{
    //随机数判定卡牌被动是否生效
    int PassiveTriggers =arc4random()%10;
    //测试，概率100%
    if (PassiveTriggers ==4) {//214被动触发
        CardPassiveIsTrigger =true;
        NSLog(@"卡牌被动概率事件触发");
    }else{
        CardPassiveIsTrigger =false;
    }
    switch (index) {
        case 0://214
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        case 1://黑
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        case 2://剑心
            if (AICardLifeDetails[attack]>3&&AICardLifeDetails[attack]<=6) {
                switch (AICardLifeDetails[attack]) {
                    case 4:
                        YouCauseHarm =AICardLifeDetails[attack]+4;
                        //攻击力上扬
                        AICardAttackDetails[attack]=AICardAttackDetails[attack]+4;
                        break;
                    case 5:
                        YouCauseHarm =AICardLifeDetails[attack]+2;
                        //攻击力上扬
                        AICardAttackDetails[attack]=AICardAttackDetails[attack]+2;
                        break;
                    case 6:
                        YouCauseHarm =AICardAttackDetails[attack];
                        //攻击力上扬
                       AICardAttackDetails[attack]=AICardAttackDetails[attack];
                        break;
                    default:
                        break;
                }
            }else{
                YouCauseHarm =8;//真实伤害
            }
            break;
        case 3://涅普顿
            YouCauseHarm =6;//固定伤害
            break;
        case 4://桐人
            YouCauseHarm =6;//固定伤害
            KazongIs =true;
            if (YasinaIs ==true) {
                AICardAttackDetails[attack]++;
            }
            break;
        case 5://妖梦
            YouCauseHarm =2;//被动的前置条件（固定伤害2）
            break;
        case 6://亚丝娜
            YouCauseHarm =6;//真实伤害
            YasinaIs =true;
            if (KazongIs ==true) {
                AICardAttackDetails[attack]++;
            }
            break;
        case 7://小兵
            PNumberOfSolders++;
            break;
        case 8://尼禄
            AMeleeNumber++;//近战英雄单位存在时数值＋1
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        case 9://萨菲罗斯
            AMeleeNumber++;
            YouCauseHarm =AICardAttackDetails[attack]*0.05;
            break;
        case 10://周防尊
            AMeleeNumber++;
            YouCauseHarm=1;//真实伤害
            break;
        case 11://黑岩<射手攻击力太高，所以除2>
            AShooterNumber++;
            YouCauseHarm =(AICardAttackDetails[attack]/2)*1.5;
            break;
        case 12://诗乃
            AShooterNumber++;
            YouCauseHarm =AICardAttackDetails[attack]/2+2;
            break;
        case 13://浅间智
            AShooterNumber++;
            YouCauseHarm =AICardAttackDetails[attack]/2;
            break;
        case 14://炮车
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        case 15://雅典娜
            AAuxuliaryNumber++;
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        case 16://优
            AAuxuliaryNumber++;
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        case 17://大龙
            YouCauseHarm =4;//全体真实伤害
            break;
        case 18://僵尸
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        case 19://小龙
            YouCauseHarm =AICardAttackDetails[attack];
            break;
        default:
            break;
    }
}
//你受到的伤害（未算单位减免）
-(void)AIUnitExistsForCalculation:(int)AIUnit
{
    //使用前初始化
    BlueFeather =false;
    int se =arc4random()%10;
    switch (AIUnit) {
        case 0://214
            YouGetHurt =0;
            break;
        case 1://黑
            YouGetHurt =0;
            break;
        case 2://剑心
            YouGetHurt =0;
            break;
        case 3://涅普顿
            YouGetHurt =-1;
            break;
        case 4://桐人
            YouGetHurt =0;
            break;
        case 5://妖梦
            YouGetHurt =0;
            break;
        case 6://亚丝娜
            YouGetHurt =0;
            break;
        case 7://小兵
            ANumberOfSolders++;
            YouGetHurt =0;
            break;
        case 8://尼禄
            AMeleeNumber++;//近战英雄单位存在时数值＋1
            YouGetHurt =-1;
            break;
        case 9://萨菲罗斯
            AMeleeNumber++;
            YouGetHurt =0;
            break;
        case 10://周防尊
            AMeleeNumber++;
            YouGetHurt =0;
            break;
        case 11://黑岩
            AShooterNumber++;
            if (se==4) {
                YouCauseHarm =-1;
                BlueFeather =true;
            }else{
                YouGetHurt =0;
            }
            break;
        case 12://诗乃
            AShooterNumber++;
            YouGetHurt =1;
            break;
        case 13://浅间智
            AShooterNumber++;
            YouGetHurt =0;
            break;
        case 14://炮车
            YouGetHurt =0;
            break;
        case 15://雅典娜
            AAuxuliaryNumber++;
            YouGetHurt =0;//辅助伤害加深没算
            break;
        case 16://优
            AAuxuliaryNumber++;
            YouGetHurt =0;
            break;
        case 17://大龙
            YouGetHurt =0;
            break;
        case 18://僵尸
            YouGetHurt =0;
            break;
        case 19://小龙
            YouGetHurt =0;
            break;
        default:
            break;
    }
}
//单位计算
-(void)UnitExistCalculation
{
    if (PAuxuliaryNumber>0) {
        WhetherTheAuxuliaryUnitExists =true;
    }
    if (PShooterNumber>0) {
        WhetherTheShooterIsPresent =true;
    }
    if (PMeleeNumber>0) {
        WhetherTheMeleeUnitExists =true;
    }
    if (AAuxuliaryNumber>0) {
        AIIsPresent =true;
    }
    if (AMeleeNumber>0) {
        AIIsTheMeleePresent =true;
    }
    if (AShooterNumber>0) {
        AIStrikerExists =true;
    }
}
//移除AI数据工作
-(void)RemoveAIDataToWork:(int)Work
{
    AICardAttackDetails[Work]=0;
    AICardHerosDetailes[Work]=-1;
    AICardLifeDetails[Work]=0;
    AICardPassiveIDDetailes[Work]=-1;
    AICardInitiativeID[Work]=-1;
}
//移除玩家卡牌数据工作
-(void)RemovePlayerData:(int)data{
    CardDetailsAttack[data]=0;
    CardDetailsLife[data]=0;
    CardDetailsPassiveID[data]=-1;
    CardDetailsHeros[data]=-1;
    CardDetailsInitiativeID[data]=-1;
}
//接收大龙上场消息
-(void)ReceivedOshilisSkyDragon
{
    NSLog(@"传递了大龙上场消息");
    AIOshilisSkyInNews =true;
    //调用清除数据
    [self ClearData];
}
//AI大龙上场则清除AI的其它卡牌数据
-(void)ClearData
{
    if (AIOshilisSkyInNews) {
        for (int i=0; i<6; i++) {
            AICardLifeDetails[i]=-1;
            //测试更新数据
            [self UpdataData];
        }
    }
    NSLog(@"使用了清空AI其它卡牌数据");
}
-(void)UpdataData
{
    /*
     因为在主界面是通过判断AI剩余的生命值多少来判断是否击杀了AI，所以没必要再发送一个被击杀消息给主界面
     */
    //更新AI的所有卡牌生命数据和攻击数据(生命和攻击了经常改变)
    NSLog(@"调用了更新Ai数据");
    for (int i=0; i<7; i++) {
        [self receiveAICardLifeMessage:i];//更新AI生命
        [self receiveAICardAttackMessage:i];//更新AI攻击力
        //如果当前AI卡牌的生命值小于0，则清空当前AI卡牌的数据
        if ([self receiveAICardLifeMessage:i]<=0) {
            //清空数据
            [self RemoveAIDataToWork:i];
        }
    }
    //更新AI人物的生命
    [self getAiLife];
}
-(void)UpdataPlayerData
{
    /*
     因为在主界面是通过判断玩家剩余的生命值多少来判断是否击杀了玩家，所以没必要再发送一个被击杀消息给主界面
     */
    NSLog(@"调用了更新玩家数据");
    //更新玩家的所有卡牌生命数值和攻击数值
    for (int i=0; i<7; i++) {
        [self ReturnCardLifeMessage:i];
        [self ReturnCardAttackMessage:i];
        //玩家卡牌被击杀，移除玩家卡牌数据
        if (CardDetailsLife[i]<=0) {
            //清空数据
            [self RemovePlayerData:i];
        }
    }
    //更新玩家人物的生命值
    [self getplayerLife];
}
//接收玩家人物攻击动作
-(BOOL)ReceivePlayerAttackAction
{
    PlayerPersonAttack =true;
    return PlayerPersonAttack;
}
//接收AI
-(BOOL)ReceiveAIPersonIsClicked
{
    AIPersonIsClicked =true;
    return AIPersonIsClicked;
}
//接收AI卡牌被点击动作
-(BOOL)AICardIsClickedAction{
    AICardIsClicked =true;
    return AICardIsClicked;
}
//接收判定事件，通过值来确定攻击的是什么类型
-(void)ReceiveDecisionEvent:(int)Event
{
    //分发工作，通过不同的事件值，调用不同的事件
    switch (Event) {
            case 0://玩家人物攻击AI人物事件
                //调用对应处理事件
                [self DealWithPlayerAttackAIPerson];
                break;
            case 1://玩家卡牌攻击AI人物事件
                //调用相应处理事件
                [self sendTheCUrrentlyAttackedCardPosition:8];
                break;
            case 2://玩家攻击AI卡牌事件
                //调用对应处理事件
                [self DealWithPlayerAttackAICard];
                break;
            default:
                break;
        }
}
/*
 AI的攻击动作（4种）
 */
//AI卡牌攻击玩家卡牌
-(void)AICardAttackPlayerCard:(int)AICardPosition andPlayerPosition:(int)PCPositon{
    /*
     0.传进来的攻击者位置和被攻击者位置
     1.获取攻击者卡牌数组和被攻击者卡牌数组
     2.运算（分别计算）
     */
    //初始化使用的数据
    NSLog(@"调用了AI卡牌攻击玩家卡牌");
    YouCauseHarm =0;
    YouGetHurt =0;
    UltimateInjury =0;
    WhetherOrNotToUseIt =false;
    ZombieDieMark =false;
    //妖梦的伤害
    int DemonInjury;
    int AIAttackArray=AICardPosition-1;//获的攻击者对应的数组下标
    int PlayerArray =PCPositon-1;//获的被攻击者数组下标
    //获的攻击者和被攻击者的的数组数据
    int AA =AICardPassiveIDDetailes[AIAttackArray];//获的攻击者是谁（被动ID和ID相同）
    int PA =CardDetailsPassiveID[PlayerArray];//获的被攻击者是谁
    //初始化数据
    CardPassiveIsTrigger =false;
    //获的攻击者能造成的基础伤害
    [self AIcardCanDoDamage:AIAttackArray andArrayIndex:AA];
    //获的被攻击者的基础伤害减免
    [self AIUnitExistsForCalculation:PA];
    //获得所有单位存在信息，即是否有近战英雄单位／射手单位／辅助单位存在
    [self UnitExistCalculation];
    //判断玩家场上周防尊是否存在(或许用while会比较好)
    for (int i=0; i<7; i++) {
        if (CardDetailsPassiveID[i]==10) {
            if (CardDetailsPassiveID[i]>0) {//生命值必须大于10才可以
                ResepectIs =true;
                NSLog(@"玩家场上有尊存在!");
            }
        }
    }
   /*  *  *  *  *  *  *  *
    *      计算过程       *分开计算
    *  *  *  *  *  *  *  */
    if(AICardPassiveIDDetailes[AIAttackArray] ==0){//攻击者是214
        //判断214的被动是否生效
        //判断被动是否生效
        if (CardPassiveIsTrigger) {//被动生效
            //214生命＋1
            AICardLifeDetails[AIAttackArray]++;
            NSLog(@"触发了214的主动回血");
            //判断
            if (AICardLifeDetails[AIAttackArray]>6) {
                AICardLifeDetails[AIAttackArray]=6;
            }
        }else{
            AICardLifeDetails[AIAttackArray]=AICardLifeDetails[AIAttackArray];
            NSLog(@"没触发214的主动回血");
        }
        NSLog(@"调用了214的攻击动作");
        if (CardDetailsLife[AIAttackArray]>3) {//优先判断被攻击者的生命
            //判断攻击目标
            if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是玩家刺客
                if (ResepectIs) {//判断敌方尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }//攻击目标是敌方刺客
            if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
                if (ResepectIs) {//尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
            }//攻击目标是敌方近战
            if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
                if(ResepectIs){//尊是否存在
                    if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                        UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                        //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    //没有辅助但有尊
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //尊和辅助都不存在
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方射手
            if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
                if (WhetherTheMeleeUnitExists) {//近战是否存在
                    if (ResepectIs) {//尊存在
                        //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                        UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
                if (ResepectIs) {//尊存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方特殊
        }//优先判断被攻击者的生命
        else if (CardDetailsLife[AIAttackArray]<=3){
            UltimateInjury =100;
        }
    }//👈214结尾
    if (AICardPassiveIDDetailes[AIAttackArray]==1) {//攻击者是黑
        NSLog(@"调用了黑的攻击动作");
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"黑的主动生效");
            DizzyNews =true;
        }else{
            NSLog(@"没有触发主动");
        }
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//黑
    if(AICardPassiveIDDetailes[AIAttackArray]==2){//攻击者是剑心
        NSLog(@"调用了剑心的攻击动作");
        if(AICardLifeDetails[AIAttackArray]<=3){//先判断剑心的生命值
            UltimateInjury =8;//真实伤害
        }else{
            //判断攻击目标
            if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
                if (ResepectIs) {//判断敌方尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }//攻击目标是敌方刺客
            if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
                if (ResepectIs) {//尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
            }//攻击目标是敌方近战
            if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
                if(ResepectIs){//尊是否存在
                    if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                        UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                        //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    //没有辅助但有尊
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //尊和辅助都不存在
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方射手
            if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
                if (WhetherTheMeleeUnitExists) {//近战是否存在
                    if (ResepectIs) {//尊存在
                        //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                        UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
                if (ResepectIs) {//尊存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方特殊
        }
    }//剑心
    if (AICardPassiveIDDetailes[AIAttackArray]==3) {//攻击者是NEP
        NSLog(@"调用了NEP的攻击动作");
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//NEP
    if (AICardPassiveIDDetailes[AIAttackArray]==4) {//桐人
        /*
         固定伤害：只吃卡牌自身的被动，尊减伤无效
         */
        NSLog(@"调用了桐人的攻击动作");
        int EscapesValues =YouCauseHarm;
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]==3) {
            //攻击的是NEP
            UltimateInjury =EscapesValues+YouGetHurt;
        }else if (CardDetailsPassiveID[PlayerArray]==8) {
            //攻击的是尼禄
            UltimateInjury =EscapesValues+YouGetHurt;
        }else if(CardDetailsPassiveID[PlayerArray]>=11&&CardDetailsPassiveID[PlayerArray]<=14){
            //攻击的射手(射手加伤)
            UltimateInjury =EscapesValues+YouGetHurt+AIShooterDeepened;
        }else if(CardDetailsPassiveID[PlayerArray]==15||CardDetailsPassiveID[PlayerArray]==16){
            //攻击的是辅助（辅助有加伤）
            UltimateInjury =EscapesValues+AIAuxuliaryDeepened;
        }else{
            UltimateInjury =EscapesValues;
        }
    }//桐人
    if (AICardPassiveIDDetailes[AIAttackArray]==5) {//妖梦
        NSLog(@"调用了妖梦的攻击动作");
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"妖梦的主动生效，造成对敌人造成眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"妖梦主动没生效");
        }
        DemonInjury =YouCauseHarm+CardDetailsAttack[PlayerArray]/2;//妖梦被动（固定伤害2+敌方攻击力的一半）<吃伤害减免>
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+DemonInjury;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+DemonInjury+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+DemonInjury+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =DemonInjury+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =DemonInjury+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =DemonInjury+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =DemonInjury+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =DemonInjury+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =DemonInjury+YouGetHurt;
        }//攻击目标是敌方特殊
    }//妖梦
    if (AICardPassiveIDDetailes[AIAttackArray]==6) {//攻击者是亚丝娜
        NSLog(@"调用了亚丝娜的攻击动作");
        /*
         真实伤害：只有尼禄才有伤害减免
         */
        if (CardDetailsPassiveID[PlayerArray]==8) {
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }
        UltimateInjury =YouCauseHarm;//真实伤害
    }//亚丝娜
    if (AICardPassiveIDDetailes[AIAttackArray]==7) {//FFF团小兵
        NSLog(@"调用了小兵的攻击动作");
        BOOL MeleeHeroUnit =false;
        //先判断敌方场上是否有近战英雄单位
        for (int i=0; i<7; i++) {
            if (CardDetailsPassiveID[i]<=10&&CardDetailsPassiveID[i]>=8) {
                NSLog(@"返回一个消息，提示AI需要先攻击敌方近战英雄单位,实际上在计算的时候完全不会触发这个");
                MeleeHeroUnit =true;
            }
        }
        if (MeleeHeroUnit ==true) {
            //只能攻击敌方近战单位（近战减伤百分百存在）
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction;
        }else {
            //攻击目标是刺客
            if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
            //攻击目标是射手
            if(CardDetailsPassiveID[PlayerArray]>=11&&CardDetailsPassiveID[PlayerArray]<=14){
                if (AIIsPresent) {//辅助存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryReduction+AIShooterDeepened;
                }
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIShooterDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIShooterDeepened;
            }
            //攻击目标是辅助
            if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            //攻击目标是特殊
            if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
        }//对应else
    }//小兵
    if (AICardPassiveIDDetailes[AIAttackArray]==8) {//尼禄
        NSLog(@"调用了尼禄的攻击动作");
        BOOL MeleeHeroUnit =false;
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"尼禄的被动生效，造成眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"尼禄的被动没有生效");
        }
        //先判断敌方场上是否有近战英雄单位
        for (int i=0; i<7; i++) {
            if (CardDetailsPassiveID[i]<=10&&CardDetailsPassiveID[i]>=8) {
                NSLog(@"返回一个消息，提示AI需要先攻击敌方近战英雄单位,实际上在计算的时候完全不会触发这个");
                MeleeHeroUnit =true;
            }
        }
        if (MeleeHeroUnit ==true) {
            //只能攻击敌方近战单位（近战减伤百分百存在）
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction;
        }else {
            //攻击目标是刺客
            if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
            //攻击目标是射手
            if(CardDetailsPassiveID[PlayerArray]>=11&&CardDetailsPassiveID[PlayerArray]<=14){
                if (AIIsPresent) {//辅助存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryReduction+AIShooterDeepened;
                }
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIShooterDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIShooterDeepened;
            }
            //攻击目标是辅助
            if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            //攻击目标是特殊
            if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
        }//对应else
    }//尼禄
    if (AICardPassiveIDDetailes[AIAttackArray]==9) {//萨菲罗斯
        NSLog(@"调用了萨菲罗斯的攻击动作");
        BOOL MeleeHeroUnit =false;
        //先判断敌方场上是否有近战英雄单位
        for (int i=0; i<7; i++) {
            if (CardDetailsPassiveID[i]<=10&&CardDetailsPassiveID[i]>=8) {
                NSLog(@"返回一个消息，提示AI需要先攻击敌方近战英雄单位,实际上在计算的时候完全不会触发这个");
                MeleeHeroUnit =true;
            }
        }
        if (MeleeHeroUnit ==true) {
            //只能攻击敌方近战单位（近战减伤百分百存在）
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction;
        }else {
            //攻击目标是刺客
            if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
            //攻击目标是射手
            if(CardDetailsPassiveID[PlayerArray]>=11&&CardDetailsPassiveID[PlayerArray]<=14){
                if (AIIsPresent) {//辅助存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryReduction+AIShooterDeepened;
                }
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIShooterDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIShooterDeepened;
            }
            //攻击目标是辅助
            if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            //攻击目标是特殊
            if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }
        }//对应else
    }//罗斯
    if (AICardPassiveIDDetailes[AIAttackArray]==10) {//攻击者是尊
        NSLog(@"调用了尊的攻击动作");
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"尊的主动生效，造成眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"尊的主动没有生效");
        }
        UltimateInjury =YouCauseHarm;//真实伤害
    }//尊
    if (AICardPassiveIDDetailes[AIAttackArray]==11) {//黑岩
        NSLog(@"调用了黑岩的攻击动作");
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//黑岩
    if (AICardPassiveIDDetailes[AIAttackArray]==12) {//诗乃
        NSLog(@"调用了诗乃的攻击动作");
        //使用前初始化(防止其它单位触发了眩晕)
        DizzyNews =false;
        if (CardPassiveIsTrigger) {
            NSLog(@"诗乃的攻击造成了眩晕");
            DizzyNews =true;
        }else{
            NSLog(@"没有触发诗乃的主动");
        }
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//诗乃
    if (AICardPassiveIDDetailes[AIAttackArray]==13) {//雾影
        NSLog(@"调用了雾影的攻击动作");
        /*
         第三次攻击造成2点AOE伤害＋被攻击者百分百眩晕
         攻击会叠加减速buff，三层就冻结
         */
        AsamaChiriAttackTimes++;
        if (AsamaChiriAttackTimes<3) {//AsamaChiriAttackTimes：攻击次数
            //判断攻击目标
            if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
                if (ResepectIs) {//判断敌方尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm;
            }//攻击目标是敌方刺客
            if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
                if (ResepectIs) {//尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
            }//攻击目标是敌方近战
            if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
                if(ResepectIs){//尊是否存在
                    if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                        UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                        //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    //没有辅助但有尊
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //尊和辅助都不存在
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方射手
            if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
                if (AIIsTheMeleePresent) {//近战是否存在
                    if (ResepectIs) {//尊存在
                        //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                        UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
            }
            if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
                if (ResepectIs) {//尊存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt;
            }//攻击目标是敌方特殊
            //给攻击目标叠加减速buff
            PlayerBeAttackTimes[PlayerArray]=AsamaChiriAttackTimes;
            SlowDown =true;
        }else{//攻击次数超过3
            //造成全体2点AOE伤害
            for (int i=0; i<7; i++) {
                AICardLifeDetails[i]=AICardLifeDetails[i]-2;
            }
            //重置攻击次数
            AsamaChiriAttackTimes =0;
        }
        if (PlayerBeAttackTimes[PlayerArray]==3) {
            //发送一个冻结消息
            FreezeNews =true;
            //重置被攻击卡牌的减速buff
            PlayerBeAttackTimes[PlayerArray]=0;
            //清除减速
            SlowDown =false;
        }
    }//雾影
    if (AICardPassiveIDDetailes[AIAttackArray]==14) {//炮车
        NSLog(@"调用了炮车的攻击动作");
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//炮车
    if (AICardPassiveIDDetailes[AIAttackArray]==15) {//雅典娜
        NSLog(@"调用了雅典娜的攻击动作");
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            NSLog(@"攻击目标");
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//雅典娜
    if (AICardPassiveIDDetailes[AIAttackArray]==16) {//优
        NSLog(@"调用了优的攻击动作");
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            NSLog(@"攻击目标");
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt;
        }//攻击目标是敌方特殊
    }//优
    if (AICardPassiveIDDetailes[AIAttackArray]==17) {//攻击者是大龙
        NSLog(@"调用了大龙的攻击动作");
        UltimateInjury =0;
        //敌方全体生命值减4
        for (int i=0; i<7; i++) {
            if (CardDetailsPassiveID[i]==8) {
                //尼禄受到的伤害-1
                CardDetailsLife[i]=CardDetailsLife[i]-YouCauseHarm-1;
            }else{
                CardDetailsLife[i]=CardDetailsLife[i]-YouCauseHarm;
            }
        }
    }//大龙
    if (AICardPassiveIDDetailes[AIAttackArray]==18) {//僵尸
        NSLog(@"调用了僵尸的攻击动作");
        /*
         僵尸只能攻击敌方近战单位，没有就直接死亡
         */
        //判断AI场上是否有近战单位
        for (int i=0; i<7; i++) {
            if (CardDetailsPassiveID[i]>=7&&CardDetailsPassiveID[i]<=10) {
                //存在近战单位，可以攻击
                //攻击目标
                if (ResepectIs) {//尊是否存在
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction;
                ZombieDieMark =true;
            }else{
                //没有近战单位，直接死亡
                ZombieDieMark =true;
            }
        }
    }//僵尸
    if (AICardPassiveIDDetailes[AIAttackArray]==19) {//小龙
        NSLog(@"调用了小龙的攻击动作");
        //判断攻击目标
        if (CardDetailsPassiveID[PlayerArray]>=0&&CardDetailsPassiveID[PlayerArray]<=6) {//攻击目标是敌方刺客
            if (ResepectIs) {//判断敌方尊是否存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+1;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+1;
        }//攻击目标是敌方刺客
        if (CardDetailsPassiveID[PlayerArray]>6&&CardDetailsPassiveID[PlayerArray]<=10) {//攻击目标是敌方近战（近战减伤百分百存在）
            if (ResepectIs) {//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==7) {//小兵
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIMeleeReduction+1;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouGetHurt+YouCauseHarm+AIMeleeReduction+1;
        }//攻击目标是敌方近战
        if(CardDetailsPassiveID[PlayerArray]>10&&CardDetailsPassiveID[PlayerArray]<=14){//攻击目标是敌方射手
            if(ResepectIs){//尊是否存在
                if (CardDetailsPassiveID[PlayerArray]==12) {//诗乃这个可怜人
                    UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+AIShooterDeepened+1;
                    WhetherOrNotToUseIt =true;
                }
                if (WhetherTheAuxuliaryUnitExists) {//辅助是否存在
                    //辅助减伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害
                    if (CardDetailsPassiveID[PlayerArray]==14) {
                        UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction;
                        WhetherOrNotToUseIt =true;
                    }
                    UltimateInjury =YouGetHurt+YouCauseHarm+AIAuxuliaryReduction+ResepectPassiveReduction+1;
                    WhetherOrNotToUseIt =true;
                }
                //没有辅助但有尊
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+1;
                WhetherOrNotToUseIt =true;
            }
            //尊和辅助都不存在
            UltimateInjury =YouCauseHarm+YouGetHurt+1;
        }//攻击目标是敌方射手
        if (CardDetailsPassiveID[PlayerArray]>14&&CardDetailsPassiveID[PlayerArray]<=16) {//攻击目标是敌方辅助
            if (WhetherTheMeleeUnitExists) {//近战是否存在
                if (ResepectIs) {//尊存在
                    //辅助自身增伤＋尊减伤＋攻击能造成的基础伤害＋受到的基础伤害＋近战减伤
                    UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+ResepectPassiveReduction+AIAuxuliaryDeepened+1;
                    WhetherOrNotToUseIt =true;
                }
                UltimateInjury =YouCauseHarm+YouGetHurt+AIMeleeReduction+AIAuxuliaryDeepened+1;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+AIAuxuliaryDeepened+1;
        }
        if (CardDetailsPassiveID[PlayerArray]>16&&CardDetailsPassiveID[PlayerArray]<=19) {//攻击目标是敌方特殊
            if (ResepectIs) {//尊存在
                UltimateInjury =YouCauseHarm+YouGetHurt+ResepectPassiveReduction+1;
                WhetherOrNotToUseIt =true;
            }
            UltimateInjury =YouCauseHarm+YouGetHurt+1;
        }//攻击目标是敌方特殊
    }//小龙
    //如果最后伤害小于1，强制等于1
    if (UltimateInjury<1) {
        UltimateInjury =1;
    }
    //移除僵尸
    if (ZombieDieMark) {
        //标准动作，生命变成0
        AICardLifeDetails[AIAttackArray]=0;
    }
    //如果使用了尊
    if (WhetherOrNotToUseIt) {
        int temp =UltimateInjury*0.3;
        //判断temp的值是否大于1
        if (temp<1) {
            temp =1;
        }
        //遍历获得尊
        for (int i=0; i<7; i++) {
            //减少尊的生命
            if (CardDetailsPassiveID[i]==10) {
                CardDetailsLife[i]=CardDetailsLife[i]-temp;
            }
            if (CardDetailsLife[i]<=0) {
                //尊死亡(把编号发送出去)
                UnitDeath =CardDetailsLife[i];
            }
        }
    }
    NSLog(@"youcause:%d yougetcut:%d",YouCauseHarm,YouGetHurt);
    //计算被攻击单位剩下的血量
    int TheRestOfthBloods =[self ReturnCardLifeMessage:PlayerArray];
    NSLog(@"当前血量：%d",TheRestOfthBloods);
    //计算造成了多少伤害
    NSLog(@"造成了多少伤害：%d",UltimateInjury);
    //更新被攻击者的生命数据（不传到主界面，只在数据处理中心使用）<这东西之前一直没用，所以很不会更新被攻击者的生命值>（17.5.25成功）
    CardDetailsLife[PlayerArray]=CardDetailsLife[PlayerArray]-UltimateInjury;
    //更新AI数据
    [self UpdataData];
    //更新玩家数据
    [self UpdataPlayerData];
}//👈AI处理动作的结尾
//AI卡牌攻击玩家人物
-(void)AIcardAttackPlayerPerson:(int)AICardPosition{
    //获取AI卡牌的攻击位置和对应的数组下标
    int AICP =AICardPosition-1;
    int AIArray = AICardPassiveIDDetailes[AICP];
    //获取被攻击的AI人物是谁
    int PPerson  =playernumber;
    //Pyrrha的反击伤害
    int CounterattackInjury =0;
    //使用前初始化
    UltimateInjury =0;
    YouCauseHarm =0;
    PlayerPersonTriggerPassive =false;
    //初始化数据
    CardPassiveIsTrigger =false;
    //获取AI基础能造成的伤害
    [self AIcardCanDoDamage:AICP andArrayIndex:AIArray];
    NSLog(@"卡牌对人物能造成%d伤害",YouCauseHarm);
    int RandomEvents =arc4random()%10;
    NSLog(@"随机不:%d",RandomEvents);
    switch (PPerson) {
        case 0://Ruby
            //判断特殊卡牌(妖梦)
            if (AIArray==5) {
                UltimateInjury=YouCauseHarm+playerAttack/2;
            }else{
                UltimateInjury =YouCauseHarm/2;
            }
            break;
        case 1://Weiss
            //判断特殊卡牌(妖梦)
            if (AIArray==5) {
                UltimateInjury=YouCauseHarm+playerAttack/2;
            }else{
                UltimateInjury =YouCauseHarm/2;
            }
            break;
        case 2://Blake
            if (RandomEvents==0||RandomEvents==1) {
                UltimateInjury=0;
                //发送一个提示消息给主界面，表示触发了Blake的被动
                AIPersonTriggerPassive  =true;
            }else{
                //没有触发人物被动
                //判断特殊卡牌(妖梦)
                if (AIArray==5) {
                    UltimateInjury=YouCauseHarm+playerAttack/2;
                }else{
                    UltimateInjury =YouCauseHarm/2;
                }
            }
            break;
        case 3://yang
            if (RandomEvents==0||RandomEvents==1) {
                if (AIArray==5) {
                    UltimateInjury =YouCauseHarm/2+playerAttack/2+1;
                }else{
                    UltimateInjury =YouCauseHarm/2+1;
                }
                //发送一个提示消息给主界面，表示触发了yang的被动
                AIPersonTriggerPassive  =true;
                //对AI人物玩家进行反击
                AiLife=AiLife-UltimateInjury;
            }else{
                //没有触发被动
                //判断特殊卡牌(妖梦)
                if (AIArray==5) {
                    UltimateInjury=YouCauseHarm+playerAttack/2+1;
                }else{
                    UltimateInjury =YouCauseHarm/2+1;
                }
            }
            break;
        case 4://Pyrrha
            if (RandomEvents==1) {
                int temps;
                if (AIArray==5) {
                  temps =YouCauseHarm/2+playerAttack/2;
                }else{
                  temps =YouCauseHarm/2;
                }
                UltimateInjury =0;
                //发送一个提示消息给主界面，表示触发了Pyrrha的被动
                AIPersonTriggerPassive  =true;
                //反击伤害
                CounterattackInjury =temps/2;
                //计算卡牌被P姐反击的生命值
                AICardLifeDetails[AICP]=AICardLifeDetails[AICP]-CounterattackInjury;
                NSLog(@"被P姐反击后的卡牌生命值:%d",AICardLifeDetails[AICP]);
            }else{
                //判断特殊卡牌(妖梦)
                if (AIArray==5) {
                    UltimateInjury=YouCauseHarm+playerAttack/2;
                }else{
                    UltimateInjury =YouCauseHarm/2;
                }
            }
            break;
        default:
            break;
    }
    //玩家人物被攻击后的生命值<测试17.5.30>(成功)
    playerLife =playerLife-UltimateInjury;
    NSLog(@"攻击后玩家人物的生命值:%d",playerLife);
    //更新AI数据和玩家数据
    [self UpdataData];
    [self UpdataPlayerData];
    if (AICardLifeDetails[AICP]<=0) {
        //反馈AI卡牌被玩家姐反杀消息
        AICardIsKilledByPlayerPerson =true;
        //将剩余生命改成0
        AICardLifeDetails[AICP]=0;
    }
    //更新数据
    [self UpdataData];
    [self UpdataPlayerData];
}
//AI人物攻击玩家卡牌
-(void)AIPersonAttackPlayerCard:(int)PlayerCardPosition{
    /*
     1.获的被攻击卡牌的位置
     2.获的被攻击卡牌的数组数据
     3.获的被攻击卡牌的基础免伤
     */
    int temp =arc4random()%10;
    switch (AiNumber) {
        case 0://Ruby
            NSLog(@"需要判断Ruby被动");
            if(temp==0)
            {
                //被动触发
                PlayerPersonTriggerPassive =true;
            }else{
                PlayerPersonTriggerPassive =false;
            }
            break;
        case 1://Weiss
            NSLog(@"需要判断Weiss被动");
            if (temp==0) {
                //被动触发
                PlayerPersonTriggerPassive =true;
            }else{
                PlayerPersonTriggerPassive =false;
            }
            break;
        case 2://Blake;
        case 3://yang
        case 4://Pyrrha
            NSLog(@"不需要要判断被动");
            PlayerPersonTriggerPassive =false;
            break;
        default:
            break;
    }
    //初始化
    UltimateInjury =0;
    int PersonAttack =[self getAiAttack];
    int CardIndex =PlayerCardPosition-1;
    //初始化数据
    CardPassiveIsTrigger =false;
    //获的被攻击卡牌的对应下标人物被动ID（等同于获的攻击的人物是谁）
    int CardBeAttack=[self ReturnCardPassiveIDMessage:CardIndex];
    //调用基础减伤数据
    [self AIUnitExistsForCalculation:CardBeAttack];
    //计算最终伤害
    UltimateInjury =(PersonAttack-YouGetHurt)/2;
    //更新被攻击卡牌的剩余生命值
    CardDetailsLife[CardIndex]=CardDetailsLife[CardIndex]-UltimateInjury;
    //更新AI数据
    [self UpdataData];
    //更新玩家数据
    [self UpdataPlayerData];
}
//AI人物攻击玩家人物
-(void)AIPersonAttackPlayerPerson{
    //运算前初始化
    UltimateInjury =0;
    int RandomEvents =arc4random()%10;
    NSLog(@"随机值有木有固定：%d",RandomEvents);
    /*
    1.判断攻击的人物是谁
    2.知道被攻击的人物是谁
    3.独立计算
    */
    //初始化数据
    CardPassiveIsTrigger =false;
    switch (playernumber) {
            case 0://攻击目标是Ruby
                UltimateInjury =AiAttack/2;
            NSLog(@"Ruby的伤害：%d",UltimateInjury);
                break;
            case 1://攻击目标是Weiss
                UltimateInjury =AiAttack/2;
             NSLog(@"Weiss的伤害：%d",UltimateInjury);
                break;
            case 2://攻击目标是Blake
                /*
                 1.随机数判断是否触发被动
                 2.触发被动发送一个触发被动的消息给主界面
                 */
                if (RandomEvents>=0&&RandomEvents<=1) {
                    NSLog(@"触发被动");
                    UltimateInjury=0;
                    //发送一个提示消息给主界面，表示触发了Blake的被动
                    PlayerPersonTriggerPassive  =true;
                }else{
                    //没有触发人物被动
                    UltimateInjury =AiAttack/2;
                     NSLog(@"Blake的伤害：%d",UltimateInjury);
                }
                break;
            case 3://攻击目标是yang
                if (RandomEvents>=0&&RandomEvents<=1) {
                    UltimateInjury =[self getAiAttack]/2+1;
                    //发送一个提示消息给主界面，表示触发了yang的被动
                    AIPersonTriggerPassive  =true;
                    //玩家被反击后的生命值
                    AiLife =AiLife-UltimateInjury;
                }else{
                    //表示没有触发
                    UltimateInjury =AiAttack/2+1;
                     NSLog(@"Yang的伤害：%d",UltimateInjury);
                }
                break;
            case 4://攻击目标是Pyrrha
                if (RandomEvents>=0&&RandomEvents<=6) {
                    int temps =AiAttack/2;
                    UltimateInjury =0;
                    //发送一个提示消息给主界面，表示触发了Blake的被动
                    AIPersonTriggerPassive  =true;
                    //反击伤害
                    int CounterattackInjury =temps;
                    //AI被反击以后的生命值
                    AiLife =AiLife-CounterattackInjury;
                }else{
                    //没有触发被动
                    UltimateInjury =AiAttack/2;
                     NSLog(@"Pyrrha的伤害：%d",UltimateInjury);
                }
            default:
                break;
        }
        /*
         1.计算AI玩家的剩余生命值
         2.更新AI玩家的数据
         3.判断玩家生命值和AI玩家的生命值
         */
    //测试没除于2
    //UltimateInjury =[self getAiAttack];
    if (UltimateInjury<1) {
        UltimateInjury =1;
        }
        playerLife =playerLife-UltimateInjury;
        //更新AI数据
        [self UpdataData];
        //更新玩家数据
        [self UpdataPlayerData];
}
//雅典娜回血
-(void)AthenaBackBlood:(int)position{
    CardDetailsLife[position-1]=CardDetailsLife[position-1]+3;
    //更新玩家数据
    [self UpdataPlayerData];
}
@end
