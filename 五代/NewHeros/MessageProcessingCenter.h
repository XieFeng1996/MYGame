//
//  MessageProcessingCenter.h
//  NewHeros
//
//  Created by 洪天伟 on 17/5/4.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageProcessingCenter : NSObject
//手牌设计规则（开始时）：卡牌1-近战 卡牌2-刺客 卡牌3-射手和辅助 卡牌4-随机一个
-(int)random;
-(int)randomofmelee;
-(int)randomofarcherandassist;
-(int)randomofassassign;
//获得AI的随机数
-(int)AICardRandom;
//传递人物方法
-(int)initWithChangePlayer:(int)play;
-(void)setPlayer;
-(int)getplayerID;
-(int)getplayerLife;
-(int)getplayerAttack;
-(int)getPassiveID;
//传递AI人物方法
-(int)initWithChangeAI:(int)play;
-(void)setAI;
-(int)getAiPassiveID;
-(int)getAiLife;
-(int)getAiAttack;
//传递手牌移动到指定位置的信息
-(int)moveToTheSpecifiedLocation:(int)play;
-(void)setCardInformation:(int)somenumber;//设置卡牌信息
//传递当前选择的手牌
-(int)passTheCurrentlySelected:(int)PTCS;
//在指定位置上加载指定卡牌信息
-(void)LoadTheSpecifiedCardAtTheSpecifiedLoaction;
//返回卡牌攻击力信息
-(int)ReturnCardAttackMessage:(int)a;
//返回卡牌生命值信息
-(int)ReturnCardLifeMessage:(int)l;
//返回卡牌主动ID信息
-(int)ReturnCardInitiativeIDMessage:(int)i;
//返回卡牌被动ID信息
-(int)ReturnCardPassiveIDMessage:(int)p;
//返回卡牌是否为英雄信息
-(int)ReturnCardHeroMessage:(int)h;
//发送当前的卡牌位置
-(int)sendTheCurrentCardPosition:(int)CardPosition;
//发送当前被攻击卡牌位置
-(int)sendTheCUrrentlyAttackedCardPosition:(int)attackPosition;

//发送AI当前卡牌
-(int)sendAICurrentCard:(int)AICurrentCard;
//发送AI卡牌位置
-(int)sendTheAICardPosition:(int)AIPosition;
//AI在指定位置上加载指定卡牌信息
-(void)AIAtLoadSpecifiedCardInformation;
//返回AI卡牌攻击力信息
-(int)receiveAICardAttackMessage:(int)AIa;
//返回AI卡牌生命值信息
-(int)receiveAICardLifeMessage:(int)AIl;
//返回AI卡牌主动ID信息
-(int)receiveAICardInitiativeIDMessage:(int)AIi;
//返回AI卡牌被动ID信息
-(int)receiveAICardPassiveIDMessage:(int)AIp;
//返回AI卡牌是否为英雄信息
-(int)receiveAICardHeroMessage:(int)AIh;

//数据处理1(处理玩家卡牌对AI卡牌的攻击动作)
-(void)DealWithLifeMessages:(int)playerAttackMessage andAI:(int)AIAttackMessage;
//数据处理2（处理玩家卡牌对AI人物的的攻击动作）
-(void)CalculateTheDamageToAIPerson:(int)PlayerCard andAIPerson:(int)AIPerson;
//数据处理3（处理玩家对AI人物的攻击动作）
-(void)DealWithPlayerAttackAIPerson;
//数据处理4（处理玩家对AI卡牌的攻击动作）
-(void)DealWithPlayerAttackAICard;
//你能造成的伤害
-(void)UnitExistsForCalculation:(int)Unit andAttack:(int)attack;
//你受到的伤害（未算单位减免）
-(void)AIUnitExistsForCalculation:(int)AIUnit;
//单位计算
-(void)UnitExistCalculation;
//移除AI卡牌数据工作
-(void)RemoveAIDataToWork:(int)Work;
//移除玩家卡牌数据工作
-(void)RemovePlayerData:(int)data;
//返回造成的伤害
-(int)ReturnTheDamegeCaused;

//接收大龙上场消息
-(void)ReceivedOshilisSkyDragon;
//AI大龙上场则清除AI的其它卡牌数据
-(void)ClearData;
//返回玩家卡牌被击杀消息
-(BOOL)PlayerCardIsKilledByAIPerson;
//返回AI卡牌被玩家人物击杀消息
-(BOOL)AICardIsKilledByPlayerPerson;
//更新AI数据
-(void)UpdataData;
//更新玩家数据
-(void)UpdataPlayerData;

//返回AI被动是否被触发
-(BOOL)ReturnAIToTriggerPassive;
//返回玩家人物被动是否被触发
-(BOOL)ReturnPlayerToTriggerPassive;

//是否触发卡牌的被动啊，主动什么的
-(BOOL)WhetherTheTriggerCardPassive;

//接收玩家攻击动作
-(BOOL)ReceivePlayerAttackAction;
//接收AI人物
-(BOOL)ReceiveAIPersonIsClicked;
//接收AI卡牌被点击动作
-(BOOL)AICardIsClickedAction;
//接收判定事件，通过值来确定攻击的是什么类型
-(void)ReceiveDecisionEvent:(int)Event;


//回馈眩晕消息
-(BOOL)FeedbackDizzyNews;
//回馈麻痹消息
-(BOOL)FeedbackParalysisNews;
//回馈蓝羽化消息
-(BOOL)FeedbackBlueFeatherNews;
//回馈减速消息
-(BOOL)FeedbackSlowdownNews;
//回馈冻结消息
-(BOOL)FeedbackFreezeNews;

//数据初始化工作
-(void)DataInitializationWork;
/*
  记录玩家场上有多少张卡牌
  记录Ai场上有多少张卡牌
 */
-(int)RecordPlayerCardsNumber:(int)number;//玩家卡牌
-(int)RecordAICardsNumber:(int)number;//AI卡牌
/*
  AI的攻击动作（4种）
 */
//AI卡牌攻击玩家卡牌
-(void)AICardAttackPlayerCard:(int)AICardPosition andPlayerPosition:(int)PCPositon;
//AI卡牌攻击玩家人物
-(void)AIcardAttackPlayerPerson:(int)AICardPosition;
//AI人物攻击玩家卡牌
-(void)AIPersonAttackPlayerCard:(int)PlayerCardPosition;
//AI人物攻击卡牌人物
-(void)AIPersonAttackPlayerPerson;

//AI卡牌能造成的伤害
-(void)AIcardCanDoDamage:(int)attack andArrayIndex:(int)index;

//雅典娜回血
-(void)AthenaBackBlood:(int)position;
@end
