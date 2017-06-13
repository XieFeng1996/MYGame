//
//  GameStartViewController.h
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatPlayer.h"
#import "CardInformation.h"
#import "MessageProcessingCenter.h"
#import "MusicController.h"
@interface GameStartViewController : UIViewController<UIGestureRecognizerDelegate>
{
    CreatPlayer *CP;
    CardInformation *CI; //用于获取卡牌消息的接口
    int RandomNumberAIPlayer;//AI随机人物
    CGFloat lastScale;
    CGRect oldFrame;//保存图片原来的大小
    CGRect largeFrame;//确定图片放大最大的程度
    MessageProcessingCenter *MPC;//消息处理中心接口
}
//显示卡牌信息,根据传进来的卡牌消息（实际上是卡牌的ID）的不同来显示不同消息
-(void)showCardinformation:(int)cardNumberID;
@property (assign, nonatomic) int ElectionNumber;
//玩家
- (IBAction)PlayerPerson:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *PersonButton;
//Ai
- (IBAction)AIPerson:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIPersonButton;
//加载玩家图片
-(void)Player:(int)number;
//加载AI图片
-(void)LoadAIPersonImage;



//创建卡牌1的图片
-(void)creatOneCardImage;
//创建卡牌2的图片
-(void)creatTwoCardImage;
//创建卡牌3的图片
-(void)creatThreeCardImage;
//创建卡牌4的图片
-(void)creatFourCardImage;
//创建场上卡牌1的图片
-(void)creatOneForCardImage:(int)RD;
//创建场上卡牌2的图片
-(void)creatTwoForCardImage:(int)RD;
//创建场上卡牌3的图片
-(void)creatThreeForCardImage:(int)RD;
//创建场上卡牌4的图片
-(void)creatFourTypeForCardImage:(int)RD;
//创建场上卡牌5的图片
-(void)creatFiveForCardImage:(int)RD;
//创建场上卡牌6的图片
-(void)creatSixForCardImage:(int)RD;
//创建场上卡牌7的图片
-(void)creatSevenForCardImage:(int)RD;

//AI出牌动作
-(void)AICardAction;
//AI出牌动作方法2
-(void)AICardAction2;
//用于针对出牌
//AI获取近战牌
-(void)AIGetMeleeCard;
//AI获取刺客牌
-(void)AIGetAssassinCard;
//AI获取射手牌
-(void)AIGetArcharCard;
//AI获取辅助牌
-(void)AIGetAssistCard;
//AI获取特殊牌
-(void)AIgetSpecialCard;
//AI获取随机牌
-(void)AIGEtRandomCard;

//创建AI场上卡牌1的图片
-(void)creatAPictureOfAIOneFiled:(int)AI;
//创建AI场上卡牌2的图片
-(void)creatAPictureOfAITwoFiled:(int)AI;
//创建AI场上卡牌3的图片
-(void)creatAPictureOfAIThreeFiled:(int)AI;
//创建AI场上卡牌4的图片
-(void)creatAPictureOfAIFourFiled:(int)AI;
//创建AI场上卡牌5的图片
-(void)creatAPictureOfAIFiveFiled:(int)AI;
//创建AI场上卡牌6的图片
-(void)creatAPictureOfAISixFiled:(int)AI;
//创建AI场上卡牌7的图片
-(void)creatAPictureOfAISevenFiled:(int)AI;


//响应所有的手势
-(void)addGestureRecoginizerToView:(UIView *)view;
//旋转手势
-(void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecongnizer;
//缩放手势
-(void)pinchView:(UIPinchGestureRecognizer *)pinchGestureReconginzer;
//移动手势1
-(void)panView1:(UIPanGestureRecognizer *)panGestureReconginzer;
//移动手势2
-(void)panView2:(UIPanGestureRecognizer *)panGestureReconginzer;
//移动手势3
-(void)panView3:(UIPanGestureRecognizer *)panGestureReconginzer;
//移动手势4
-(void)panView4:(UIPanGestureRecognizer *)panGestureReconginzer;
//设置所有手牌可移动
-(void)allHandCardCanBeMoved;
//响应手牌可以移动
-(void)handCardMoved;
//设置移动手牌1调用
-(void)moveTheHandCall1:(UIView *)view;
//设置移动手牌2调用
-(void)moveTheHandCall2:(UIView *)view;
//设置移动手牌3调用
-(void)moveTheHandCall3:(UIView *)view;
//设置移动手牌4调用
-(void)moveTheHandCall4:(UIView *)view;
//设置卡牌在第二层
-(void)setallCardInTheSecondFloor;
//初始状态隐藏
-(void)hideTheInitialState;
//显示玩家当前血量
@property (weak, nonatomic) IBOutlet UILabel *PlayerLife;
//显示玩家当前攻击力
@property (weak, nonatomic) IBOutlet UILabel *PlayerAttack;
//AI的攻击力
@property (weak, nonatomic) IBOutlet UILabel *AIAttack;
//AI的生命值
@property (weak, nonatomic) IBOutlet UILabel *AILife;
-(void)PlayerSameValueanAttack;//玩家选择相同的生命值和攻击力
-(void)AISameValueanAttack;//AI选择
//提示信息
@property (weak, nonatomic) IBOutlet UILabel *PromptInformation;
//战斗信息
@property (weak, nonatomic) IBOutlet UILabel *FightingInformation;
-(void)setText;//设置文本
//加载背景图片
-(void)loadBackground;

//音效播放（攻击）
-(void)AttackSoundEffectsPlay:(int)Sound;
//音效播放（死亡）
-(void)DeathSoundPlay:(int)Sound;

//创建AI卡牌背景
@property (weak, nonatomic) IBOutlet UIImageView *IB1;
@property (weak, nonatomic) IBOutlet UIImageView *IB2;
@property (weak, nonatomic) IBOutlet UIImageView *IB3;
@property (weak, nonatomic) IBOutlet UIImageView *IB4;
-(void)AICardBackGround;

//Button1
- (IBAction)button1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIImageView *button1Image;
//Button2
- (IBAction)button2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIImageView *button2Image;
//Button3
- (IBAction)button3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIImageView *button3Image;
//Button4
- (IBAction)button4:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIImageView *button4Image;
//场上的卡牌
//卡牌1
- (IBAction)Dbutton1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton1;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton1Life;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton1Attack;
//卡牌2
- (IBAction)Dbutton2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton2;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton2Life;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton2Attack;
//卡牌3
- (IBAction)Dbutton3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton3;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton3Life;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton3Attack;
//卡牌4
- (IBAction)Dbutton4:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton4;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton4Life;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton4Attack;
//卡牌5
- (IBAction)Dbutton5:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton5;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton5Life;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton5Attack;
//卡牌6
- (IBAction)Dbutton6:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton6;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton6Life;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton6Attack;
//卡牌7
- (IBAction)Dbutton7:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton7;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton7Life;
@property (weak, nonatomic) IBOutlet UILabel *Dbutton7Attack;


//AI的卡牌1
@property (weak, nonatomic) IBOutlet UILabel *AIbutton1Life;
@property (weak, nonatomic) IBOutlet UILabel *AIbutton1Attack;
- (IBAction)AIbutton1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIbutton1;


//AI的卡牌2
@property (weak, nonatomic) IBOutlet UILabel *AIbutton2Attack;
@property (weak, nonatomic) IBOutlet UILabel *AIbutton2Life;
- (IBAction)AIbutton2:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIbutton2;


//AI的卡牌3
@property (weak, nonatomic) IBOutlet UILabel *AIbutton3Attack;
@property (weak, nonatomic) IBOutlet UILabel *AIbutton3Life;
- (IBAction)AIbutton3:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIbutton3;


//AI的卡牌4
@property (weak, nonatomic) IBOutlet UILabel *AIbutton4Attack;
@property (weak, nonatomic) IBOutlet UILabel *AIbutton4Life;
- (IBAction)AIbutton4:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIbutton4;

//AI的卡牌5
@property (weak, nonatomic) IBOutlet UILabel *AIbutton5Attack;
@property (weak, nonatomic) IBOutlet UILabel *AIbutton5Life;
- (IBAction)AIbutton5:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIbutton5;

//AI的卡牌6
@property (weak, nonatomic) IBOutlet UILabel *AIbutton6Attack;
@property (weak, nonatomic) IBOutlet UILabel *AIbutton6Life;
- (IBAction)AIbutton6:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIbutton6;

//AI的卡牌7
@property (weak, nonatomic) IBOutlet UILabel *AIbutton7Life;
@property (weak, nonatomic) IBOutlet UILabel *AIbutton7Attack;
- (IBAction)AIbutton7:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *AIbutton7;

//响应AI人物按钮被点击事件
-(void)ResponseToAIButton;
//解禁初登场事件
-(void)RespondToDebutEvents;
//记录回合数事件（AI完成了攻击动作后）
-(void)RespondRoundsOfEvents;
//因为AI大龙清空Ai其它卡牌
-(void)EmptyTheAICurrentData;
//更新主界面AI的数据(实际上是重新输出一次AI的各项数据)
-(void)UpdataAIData;
//更新主界面玩家的数据(实际上是重新输出一次玩家的各项数据)
-(void)updataPlayerData;
//AI的死亡判断
-(void)DeathJugement:(int)Jugement;
//玩家的死亡判断
-(void)PlayerDeathJugement:(int)Jugement;

//AI被动生效
-(void)AIPassivelyEffective;
//玩家被动生效
-(void)PlayerPassivelyEffective;
//发牌动作
-(void)LicensingAction;
//使攻击者进入不可点击状态
-(void)AttackerCanNotClick:(int)Click;

//游戏开局和出牌按钮系列
- (IBAction)StarButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SPButton;
//下一回合按钮系列
- (IBAction)Next:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *NextButton;

//状态提醒图片(玩家卡牌)
@property (weak, nonatomic) IBOutlet UIImageView *StatusReminder1;
@property (weak, nonatomic) IBOutlet UIImageView *StatusReminder2;
@property (weak, nonatomic) IBOutlet UIImageView *StatusReminder3;
@property (weak, nonatomic) IBOutlet UIImageView *StatusReminder4;
@property (weak, nonatomic) IBOutlet UIImageView *StatusReminder5;
@property (weak, nonatomic) IBOutlet UIImageView *StatusReminder6;
@property (weak, nonatomic) IBOutlet UIImageView *StatusReminder7;
@property (weak, nonatomic) IBOutlet UIImageView *PlayerPersonStatus;


//状态提醒图片（AI）
@property (weak, nonatomic) IBOutlet UIImageView *AIStatusReminder1;
@property (weak, nonatomic) IBOutlet UIImageView *AIStatusReminder2;
@property (weak, nonatomic) IBOutlet UIImageView *AIStatusReminder3;
@property (weak, nonatomic) IBOutlet UIImageView *AIStatusReminder4;
@property (weak, nonatomic) IBOutlet UIImageView *AIStatusReminder5;
@property (weak, nonatomic) IBOutlet UIImageView *AIStatusReminder6;
@property (weak, nonatomic) IBOutlet UIImageView *AIStatusReminder7;
@property (weak, nonatomic) IBOutlet UIImageView *AIPersonStatus;


//记录己方 AI卡牌数和回合数
@property (weak, nonatomic) IBOutlet UILabel *PlayerFieldCard;//玩家场上卡牌数量
@property (weak, nonatomic) IBOutlet UILabel *AIFieldCard;
@property (weak, nonatomic) IBOutlet UILabel *RoundsNumber;//回合数

//AI卡牌的攻击动作
-(void)AICardAttackAction;
//AI卡牌1攻击动作
-(void)AIcardOneAttackAction;
//AI卡牌2攻击动作
-(void)AIcardTwoAttackAction;
//AI卡牌3攻击动作
-(void)AIcardThreeAttackAction;
//AI卡牌4攻击动作
-(void)AIcardFourAttackAction;
//AI卡牌5攻击动作
-(void)AIcardFiveAttackAction;
//AI卡牌6攻击动作
-(void)AIcardSixAttackAction;
//AI卡牌7攻击动作
-(void)AIcardSevenAttackAction;
//AI人物的攻击动作
-(void)AIpersonAttackAction;

//调阵AI的定时器时间输出(用于攻击动作)
-(void)AdjustTheAINSTimerOutput;
//Ruby被动触发事件
-(void)RubyPassiveTriggerEvents;


/*
  玩家的异常状态处理和AI的异常处理
 */
-(void)PlayerExceptionStatus:(int)Position;
-(void)AIExceptionStatus:(int)Position;

/* 
 解锁AI和玩家的状态
 */
-(void)UnlockAIState;
-(void)UnlockPlayerState;
/*
  AI卡牌可以点击
 */
-(void)AIcardCanClick;
/*
  攻击完成以后锁定状态
 */
-(void)AIClockButton;
/*
  玩家人物（进攻型被动）的触发
 */
-(void)PlayerAttackPassvieTriggered;
/*
  NEP攻击动作
 */
-(void)NEPAttackAction;
@end
