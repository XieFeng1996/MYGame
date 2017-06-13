//
//  GameStartViewController.m
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "GameStartViewController.h"
@interface GameStartViewController ()

@end

@implementation GameStartViewController
int randomnumber;//随机一张
int RandomOfMelee;//近战随机数（这些随机数只在开始的手牌时成立）
int RandomOfArcherAndAssist;//射手和辅助随机数
int RandomOfAssassign;//刺客随机数
int AICardRandom;//AI卡牌随机数
bool OutOfTheCard =false;
bool position1,position2,position3,position4,position5,position6,position7;//玩家卡牌是否存在
bool allPosition;//判定全体的制定位置是否存在，为false才可以移动到卡牌位置上
bool leaveLocation1,leaveLocation2,leaveLocation3,leaveLovation4;//每个手牌是否离开了当前位置
//玩家卡牌位置
int PlayerCardPosition =-1;
//卡牌是否初登场
bool WhetherTheDebut;
//AI场上位置是否存在卡牌
bool AIField1,AIField2,AIField3,AIField4,AIField5,AIField6,AIField7;
//AI的位置
int AIPosition =-1;
//AI人物
int AIPerson;
//玩家生命最小值的位置
int PlayerCard_Life_Position;
/*
  NEP攻击次数
 */
int NEPAttackTimes;
bool NEPAttackAction;
/*
  玩家 AI卡牌是否可以攻击
 */
//AI的卡是否攻击过了
bool AICard1HadAttack,AICard2HadAttack,AICard3HadAttack,AICard4HadAttack,AICard5HadAttack,AICard6HadAttack,AICard7HadAttack;
//玩家卡牌是否可以攻击
bool PCard1HadAttack,PCard2HadAttack,PCard3HadAttack,PCard4HadAttack,PCard5HadAttack,PCard6HadAttack,PCard7HadAttack;
/*
  异常状态
 */
//AI的卡牌处于异常状态
bool AICard1Abnormal,AICard2Abnormal,AICard3Abnormal,AICard4Abnormal,AICard5Abnormal,AICard6Abnormal,AICard7Abnormal;
//AI人物异常状态
bool AIPersonAbnormal;
//玩家的卡牌处于异常状态
bool PlayerCard1Abnormal,PlayerCard2Abnormal,PlayerCard3Abnormal,PlayerCard4Abnormal,PlayerCard5Abnormal,PlayerCard6Abnormal,PlayerCard7Abnormal;
//玩家人物异常状态
bool PlayerPersonAbnoraml;
/*
  用于AI出牌的时候出克制玩家的牌
 */
//AI手上的卡牌(6张)(5张随机，一张固定小龙)
int AIHasAcard[6];
//玩家出的是什么类型的牌
int WhatKindOfPlayerOut;

/*
  Ruby被动触发问题
 */
bool RubyTriggeredPassive;
//是AI的哪张卡牌
int WhichCardIsAI[7];
//是玩家的哪张卡牌
int WhichCardIsPlayer[7];

/*
   记录AI场上有多少张卡牌，用于AI能攻击多少次和输出显示
   记录玩家场上有多少张卡牌，用于输出显示
 */
int HowManyCardsInAI;
int HowManyCardsInPlayer;

/*
   AI卡牌能够攻击的次数
   AI人物能够攻击的次数
 */
int AICardCanAttackNumber;
int AIPersonCanAttackNumber;
/*
  雅典娜的被动和回血
 */
bool AthenaPassive;//玩家
bool AIAthenaPassive;//AI
bool AthenaBackBlood;//雅典娜回血
//记录回合数
int RecondTheNumberOfRounds=0;
//Ai大龙登场
bool AIOsirisSkyDraonPlay;
//攻击音效播放数组(7个数)
int AttackSoundPlayArray[7];
//死亡音效播放数组(7个数)
int DeathSoundPlayArray[7];
//是否点击了玩家人物
bool ClickPlayerPerson;
//是否点击了玩家卡牌
bool ClickPlayerCard;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CP =[[CreatPlayer alloc] init];
    [CP creatPlayer]; //记得创建，没创建就为空
    CI =[[CardInformation alloc]init];
    MPC =[[MessageProcessingCenter alloc]init];
    //初始状态测试
    [_SPButton setBackgroundImage:[UIImage imageNamed:@"开始.png"] forState:UIControlStateNormal];
    //设置文本
    [self setText];
    //加载背景图片
    [self loadBackground];
    //加载卡牌背景
    [self AICardBackGround];
    //初始状态(不可视，不可点击)
    [self hideTheInitialState];
    //加载卡牌移动前置（不能移动）
    [self allHandCardCanBeMoved];
    //初始化数据（消息处理中心的数据）
    [MPC DataInitializationWork];
    //创建AI人物
    [self LoadAIPersonImage];
    //创建玩家人物
    [self Player:_ElectionNumber];
}
-(void)setText
{
    //设置文本
    //设置文本对齐方式(左对齐)
    _PromptInformation.textAlignment =NSTextAlignmentLeft;
    _FightingInformation.textAlignment =NSTextAlignmentLeft;
    //设置文本多行显示
    _PromptInformation.lineBreakMode =NSLineBreakByCharWrapping;
    _PromptInformation.numberOfLines =0;
    _FightingInformation.lineBreakMode =NSLineBreakByCharWrapping;
    _FightingInformation.numberOfLines =0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    //隐藏导航栏
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden =YES;
}
//初始状态隐藏
-(void)hideTheInitialState
{
    //状态隐藏
    _Dbutton1Attack.hidden =YES;
    _Dbutton1Life.hidden =YES;
    
    _Dbutton2Attack.hidden =YES;
    _Dbutton2Life.hidden =YES;
    
    _Dbutton3Attack.hidden =YES;
    _Dbutton3Life.hidden =YES;
    
    _Dbutton4Attack.hidden =YES;
    _Dbutton4Life.hidden =YES;
    
    _Dbutton5Attack.hidden =YES;
    _Dbutton5Life.hidden =YES;
    
    _Dbutton6Attack.hidden =YES;
    _Dbutton6Life.hidden =YES;
    
    _Dbutton7Attack.hidden =YES;
    _Dbutton7Life.hidden =YES;
    
    _AIbutton1Attack.hidden =YES;
    _AIbutton1Life.hidden =YES;
    
    _AIbutton2Attack.hidden =YES;
    _AIbutton2Life.hidden =YES;
    
    _AIbutton3Attack.hidden =YES;
    _AIbutton3Life.hidden =YES;
    
    _AIbutton4Attack.hidden =YES;
    _AIbutton4Life.hidden =YES;
    
    _AIbutton5Attack.hidden =YES;
    _AIbutton5Life.hidden =YES;
    
    _AIbutton6Attack.hidden =YES;
    _AIbutton6Life.hidden =YES;
    
    _AIbutton7Attack.hidden =YES;
    _AIbutton7Life.hidden =YES;
    //按钮不能点击（玩家）
    _Dbutton1.enabled =NO;
    _Dbutton2.enabled =NO;
    _Dbutton3.enabled =NO;
    _Dbutton4.enabled =NO;
    _Dbutton5.enabled =NO;
    _Dbutton6.enabled =NO;
    _Dbutton7.enabled =NO;
    //按钮不能点击（AI）
    _AIbutton1.enabled =NO;
    _AIbutton2.enabled =NO;
    _AIbutton3.enabled =NO;
    _AIbutton4.enabled =NO;
    _AIbutton5.enabled =NO;
    _AIbutton6.enabled =NO;
    _AIbutton7.enabled =NO;
    //玩家人物隐藏 不可点击
    _PersonButton.hidden =YES;
    _PersonButton.enabled =NO;
    //AI人物隐藏 不可点击
    _AIPersonButton.hidden =YES;
    _AIPersonButton.enabled =NO;
    //手牌移动按钮不能点击
    _button1.enabled =NO;
    _button2.enabled =NO;
    _button3.enabled =NO;
    _button4.enabled =NO;
    //下一回合按钮不能点击
    _NextButton.enabled =NO;
}
//设置卡牌在第二层
-(void)setallCardInTheSecondFloor
{
    [self.view insertSubview:_button1Image atIndex:1];
    [self.view insertSubview:_button2Image atIndex:1];
    [self.view insertSubview:_button3Image atIndex:1];
    [self.view insertSubview:_button4Image atIndex:1];
}
//创建卡牌1-近战
-(void)creatOneCardImage
{
    switch (RandomOfMelee) {
        case 0:
            //小兵
            _button1Image.image =[UIImage imageNamed:@"Solider.jpg"];
            break;
        case 1:
            //尼禄
            _button1Image.image =[UIImage imageNamed:@"nilu.jpg"];
            break;
        case 2:
            //萨菲罗斯
            _button1Image.image =[UIImage imageNamed:@"safeiluosi.jpg"];
            break;
        case 3:
            //尊
            _button1Image.image =[UIImage imageNamed:@"zun.jpg"];
            break;
        default:
            break;
    }
}
//创建卡牌2-刺客
-(void)creatTwoCardImage
{
    switch (RandomOfAssassign) {
        case 0:
            _button2Image.image =[UIImage imageNamed:@"eryishi.jpg"];
            break;
        case 1:
            _button2Image.image =[UIImage imageNamed:@"hei.jpg"];
            break;
        case 2:
            _button2Image.image =[UIImage imageNamed:@"jianxin.jpg"];
            break;
        case 3:
            _button2Image.image =[UIImage imageNamed:@"neipudun.jpg"];
            break;
        case 4:
            _button2Image.image =[UIImage imageNamed:@"tongren.jpg"];
            break;
        case 5:
            _button2Image.image =[UIImage imageNamed:@"yaomeng.jpg"];
            break;
        case 6:
            _button2Image.image =[UIImage imageNamed:@"yasina.jpg"];
            break;
        default:
            break;
    }
}
//创建卡牌3-射手／辅助
-(void)creatThreeCardImage
{
    switch (RandomOfArcherAndAssist) {
        case 0:
            _button3Image.image =[UIImage imageNamed:@"heiyan.jpg"];
            break;
        case 1:
            _button3Image.image =[UIImage imageNamed:@"shinai.jpg"];
            break;
        case 2:
            _button3Image.image =[UIImage imageNamed:@"wuying.jpg"];
            break;
        case 3:
            _button3Image.image =[UIImage imageNamed:@"Remote.jpg"];
            break;
        case 4:
            _button3Image.image =[UIImage imageNamed:@"yadianna.jpg"];
            break;
        case 5:
            _button3Image.image =[UIImage imageNamed:@"you.jpg"];
            break;
        default:
            break;
    }
}
//创建卡牌4-随机一张
-(void)creatFourCardImage
{
    switch (randomnumber) {
        case 0:
            _button4Image.image =[UIImage imageNamed:@"eryishi.jpg"];
            break;
        case 1:
            _button4Image.image =[UIImage imageNamed:@"hei.jpg"];
            break;
        case 2:
            _button4Image.image =[UIImage imageNamed:@"jianxin.jpg"];
            break;
        case 3:
            _button4Image.image =[UIImage imageNamed:@"neipudun.jpg"];
            break;
        case 4:
            _button4Image.image =[UIImage imageNamed:@"tongren.jpg"];
            break;
        case 5:
            _button4Image.image =[UIImage imageNamed:@"yaomeng.jpg"];
            break;
        case 6:
            _button4Image.image =[UIImage imageNamed:@"yasina.jpg"];
            break;
        case 7:
            _button4Image.image =[UIImage imageNamed:@"Solider.jpg"];
            break;
        case 8:
            _button4Image.image =[UIImage imageNamed:@"nilu.jpg"];
            break;
        case 9:
            _button4Image.image =[UIImage imageNamed:@"safeiluosi.jpg"];
            break;
        case 10:
            _button4Image.image =[UIImage imageNamed:@"zun.jpg"];
            break;
        case 11:
            _button4Image.image =[UIImage imageNamed:@"heiyan.jpg"];
            break;
        case 12:
            _button4Image.image =[UIImage imageNamed:@"shinai.jpg"];
            break;
        case 13:
            _button4Image.image =[UIImage imageNamed:@"wuying.jpg"];
            break;
        case 14:
            _button4Image.image =[UIImage imageNamed:@"Remote.jpg"];
            break;
        case 15:
            _button4Image.image =[UIImage imageNamed:@"yadianna.jpg"];
            break;
        case 16:
            _button4Image.image =[UIImage imageNamed:@"you.jpg"];
            break;
        case 17:
            _button4Image.image =[UIImage imageNamed:@"dalong.jpg"];
            break;
        case 18:
            _button4Image.image =[UIImage imageNamed:@"jiangshi.jpg"];
            break;
        case 19:
            _button4Image.image =[UIImage imageNamed:@"xiaolong.jpg"];
            break;
        default:
            break;
    }
}
//加载player按钮及图片
-(void)Player:(int)number
{
    switch (number) {
            //传进来的是Ruby
        case 0:
            [_PersonButton setBackgroundImage:[UIImage imageNamed:@"Ruby.jpg"] forState:UIControlStateNormal];
            [MPC initWithChangePlayer:0];
            [self PlayerSameValueanAttack];
            break;
        case 1:
            [_PersonButton setBackgroundImage:[UIImage imageNamed:@"Weiss.jpg"] forState:UIControlStateNormal];
            //测试（17.5.12）<测试成功>
            [MPC initWithChangePlayer:1];
            [self PlayerSameValueanAttack];
            break;
        case 2:
            [_PersonButton setBackgroundImage:[UIImage imageNamed:@"Blake.jpg"] forState:UIControlStateNormal];
            //测试（17.5.12）<测试成功>
            [MPC initWithChangePlayer:2];
            [self PlayerSameValueanAttack];
            break;
        case 3:
            //测试（17.5.12）<测试成功>
            [_PersonButton setBackgroundImage:[UIImage imageNamed:@"Yang.jpg"] forState:UIControlStateNormal];
            [MPC initWithChangePlayer:3];
            [self PlayerSameValueanAttack];
            break;
        case 4:
            //测试（17.5.12）<测试成功>
            [_PersonButton setBackgroundImage:[UIImage imageNamed:@"Pyrrha.jpg"] forState:UIControlStateNormal];
            [MPC initWithChangePlayer:4];
            [self PlayerSameValueanAttack];
            break;
        default:
            break;
    }
}
//加载AI图片
-(void)LoadAIPersonImage
{
    int tempRandom;
    tempRandom =arc4random()%20;
    NSLog(@"Random：%d",tempRandom);
//    //测试yang(没问题)
//    tempRandom =8;
//    //测试P姐(没问题)
//    tempRandom =12;
    if (tempRandom>=0&&tempRandom<=1) {
        //Ruby上场概率：10%
        [_AIPersonButton setBackgroundImage:[UIImage imageNamed:@"Ruby.jpg"] forState:UIControlStateNormal];
        _PromptInformation.text =[NSString stringWithFormat:@"AI选择了Ruby，请注意"];
        _FightingInformation.text =[NSString stringWithFormat:@"Crescent Rose:Ruby挥舞新月玫瑰，有概率使一个单位再次行动"];
        //发送选择人物消息
        [MPC initWithChangeAI:0];
        //加载生命 攻击力
        [self AISameValueanAttack];
        //告知按钮该张图片是哪个人物
        AIPerson =0;
    }else if(tempRandom>=2&&tempRandom<=3){
        //Weiss概率:10%
        [_AIPersonButton setBackgroundImage:[UIImage imageNamed:@"Weiss.jpg"] forState:UIControlStateNormal];
        _PromptInformation.text =[NSString stringWithFormat:@"AI选择了Weiss，请注意"];
        _FightingInformation.text =[NSString stringWithFormat:@"Myrtenaster:挥舞柳叶白菀的Weiss行动时有概率召唤特殊类单位"];
        //发送选择人物消息
        [MPC initWithChangeAI:1];
        //加载生命 攻击力
        [self AISameValueanAttack];
        //告知按钮该张图片是哪个人物
        AIPerson =1;
    }else if(tempRandom>=4&&tempRandom<=7){
        //Blake概率：20%
        [_AIPersonButton setBackgroundImage:[UIImage imageNamed:@"Blake.jpg"] forState:UIControlStateNormal];
        _PromptInformation.text =[NSString stringWithFormat:@"AI选择了Blake，请注意"];
        _FightingInformation.text =[NSString stringWithFormat:@"Gambol Shroud:Blake挥舞跃影飞绫，有概率使受到的伤害全部由残像承担"];
        //发送选择人物消息
        [MPC initWithChangeAI:2];
        //加载生命 攻击力
        [self AISameValueanAttack];
        //告知按钮该张图片是哪个人物
        AIPerson =2;
    }else if(tempRandom>=8&&tempRandom<=11){
        //Yang概率：20%
        [_AIPersonButton setBackgroundImage:[UIImage imageNamed:@"Yang.jpg"] forState:UIControlStateNormal];
        _PromptInformation.text =[NSString stringWithFormat:@"AI选择了Yang，请注意"];
        _FightingInformation.text =[NSString stringWithFormat:@"Ember Celie:yang 承受的所有伤害＋1.当yang行动时，有概率将受到的伤害用灰烬天堂全部返还给对面玩家"];
        //发送选择人物消息
        [MPC initWithChangeAI:3];
        //加载生命 攻击力
        [self AISameValueanAttack];
        //告知按钮该张图片是哪个人物
        AIPerson =3;
    }else if(tempRandom>11&&tempRandom<=19){
        //Pyrrha概率
        [_AIPersonButton setBackgroundImage:[UIImage imageNamed:@"Pyrrha.jpg"] forState:UIControlStateNormal];
        _PromptInformation.text =[NSString stringWithFormat:@"AI选择了Pyrrha，请注意,AI的被动触发概率为70％"];
        _FightingInformation.text =[NSString stringWithFormat:@"Milo&Akouo:Pyrrha受到攻击时有概率格挡并对攻击者发起一次反击，反击造成攻击的50％伤害"];
        //发送选择人物消息
        [MPC initWithChangeAI:4];
        //加载生命 攻击力
        [self AISameValueanAttack];
        //告知按钮该张图片是哪个人物
        AIPerson =4;
    }
}
//响应AI人物按钮被点击事件
-(void)ResponseToAIButton
{
    NSLog(@"响应了按钮被攻击");
    //更新生命值
    int tempLife =[MPC getAiLife];
    NSLog(@"%d",tempLife);
    _AILife.text =[NSString stringWithFormat:@"%d",tempLife];
    //调用记录回合数(肯定不是这样算的,以后还要改)
    [self RespondRoundsOfEvents];
    //AI人物被击杀
    if (tempLife==0) {
        _PromptInformation.text =[NSString stringWithFormat:@"你击杀了AI，恭喜！"];
        NSString *strout =[NSString stringWithFormat:@"你赢得了这场比赛，用了%d个回合",RecondTheNumberOfRounds];
        //初始化提示框
        UIAlertController *Alert =[UIAlertController alertControllerWithTitle:@"提示" message:strout preferredStyle:UIAlertControllerStyleAlert];
        //弹出提示框
        [self presentViewController:Alert animated:true completion:nil];
    }
}
-(void)loadBackground
{
    //定义图片的位置和尺寸
    UIImageView *subView =[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 667.0f, 375.0f)];
    //设定图片名称并拖放添加图片到image项目文件夹
    [subView setImage:[UIImage imageNamed:@"11.jpg"]];
    //在view中加入图片subview并使背景处于最底层
    [self.view insertSubview:subView atIndex:0];
}
-(void)PlayerSameValueanAttack
{//在加载人物图片的时候被调用了
    [MPC setPlayer];
    _PlayerLife.text =[NSString stringWithFormat:@"%d",[MPC getplayerLife]];
    _PlayerAttack.text =[NSString stringWithFormat:@"%d",[MPC getplayerAttack]];
}
-(void)AISameValueanAttack
{
    [MPC setAI];
    _AILife.text =[NSString stringWithFormat:@"%d",[MPC getAiLife]];
    _AIAttack.text =[NSString stringWithFormat:@"%d",[MPC getAiAttack]];
}
//响应手牌可以移动
-(void)handCardMoved
{
    if (OutOfTheCard ==true) {
        //手牌可移动
        [self.button1Image setUserInteractionEnabled:YES];
        [self.button2Image setUserInteractionEnabled:YES];
        [self.button3Image setUserInteractionEnabled:YES];
        [self.button4Image setUserInteractionEnabled:YES];
    }
}
//解禁初登场事件
-(void)RespondToDebutEvents
{
    //让玩家出牌以后可以点击
    if (position1&&PlayerCard1Abnormal==false) {
        _Dbutton1.hidden =NO;
        _Dbutton1.enabled =YES;
    }
    if (position2&&PlayerCard2Abnormal==false) {
        _Dbutton2.hidden =NO;
        _Dbutton2.enabled =YES;
    }
    if (position3&&PlayerCard3Abnormal==false) {
        _Dbutton3.hidden =NO;
        _Dbutton3.enabled =YES;
    }
    if (position4&&PlayerCard4Abnormal==false) {
        _Dbutton4.hidden =NO;
        _Dbutton4.enabled =YES;
    }
    if (position5&&PlayerCard5Abnormal==false) {
        _Dbutton5.hidden =NO;
        _Dbutton5.enabled =YES;
    }
    if (position6&&PlayerCard6Abnormal==false) {
        _Dbutton6.hidden =NO;
        _Dbutton6.enabled =YES;
    }
    if (position7&&PlayerCard7Abnormal==false) {
        _Dbutton7.hidden =NO;
        _Dbutton7.enabled =YES;
    }
}
//记录回合数事件
-(void)RespondRoundsOfEvents
{
    //记录回合数
    RecondTheNumberOfRounds++;
    //输出回合数
    _RoundsNumber.text =[NSString stringWithFormat:@"%d",RecondTheNumberOfRounds];
    //当回合数为20时，玩家输
    if (RecondTheNumberOfRounds>20) {
        _PromptInformation.text =[NSString stringWithFormat:@"你输了"];
        //所有按钮不可点击
        [self hideTheInitialState];
        NSString *GameOver =[NSString stringWithFormat:@"回合数超过20\nGameOver!!!"];
        //初始化提示框
        UIAlertController *Alert =[UIAlertController alertControllerWithTitle:@"提示" message:GameOver preferredStyle:UIAlertControllerStyleAlert];
        //弹出提示框
        [self presentViewController:Alert animated:true completion:nil];
    }
}
//AI出牌动作
-(void)AICardAction
{
    //出牌动作完成，虽然很傻
    int temp[4];
    bool WhetherCanBeACard=true;
    switch (arc4random()%4) {
            //近战牌
        case 0:
            temp[0]=7;
            break;
        case 1:
            temp[0]=8;
            break;
        case 2:
            temp[0]=9;
            break;
        case 3:
            temp[0]=10;
            break;
        default:
            break;
    }
    switch (arc4random()%7) {
            //刺客牌
        case 0:
            temp[1]=0;
            break;
        case 1:
            temp[1]=1;
            break;
        case 2:
            temp[1]=2;
            break;
        case 3:
            temp[1]=3;
            break;
        case 4:
            temp[1]=4;
            break;
        case 5:
            temp[1]=5;
            break;
        case 6:
            temp[1]=6;
            break;
        default:
            break;
    }
    switch (arc4random()%6) {
            //射手，辅助牌
        case 0:
            temp[2]=11;
            break;
        case 1:
            temp[2]=12;
            break;
        case 2:
            temp[2]=13;
            break;
        case 3:
            temp[2]=14;
            break;
        case 4:
            temp[2]=15;
            break;
        case 5:
            temp[2]=16;
            break;
        default:
            break;
    }
    switch (arc4random()%3) {
            //特殊牌
        case 0:
            temp[3]=17;
            break;
        case 1:
            temp[3]=18;
            break;
        case 2:
            temp[3]=19;
            break;
        default:
            break;
    }
    NSLog(@"(%d,%d,%d,%d)",temp[0],temp[1],temp[2],temp[3]);
    if (AIField1==false&&WhetherCanBeACard) {
        //发送卡牌的当前位置
        [MPC sendTheAICardPosition:1];
        //生成近战牌
        [self creatAPictureOfAIOneFiled:temp[0]];
        AIField1=true;
        WhetherCanBeACard =false;
    }
    if (AIField1&&AIField4==false&&WhetherCanBeACard) {
        //发送卡牌的当前位置
        [MPC sendTheAICardPosition:4];
        //生成刺客牌
        [self creatAPictureOfAIFourFiled:temp[1]];
        AIField4=true;
        WhetherCanBeACard =false;
    }
    if (AIField1&&AIField4&&WhetherCanBeACard&&AIField5==false) {
        //发送卡牌的当前位置
        [MPC sendTheAICardPosition:5];
        //判断手牌(保证这张牌是射手牌)
        while (temp[2]==15||temp[2]==16) {
           //满足条件（temp[2]=15或者temp[2]=16）
            int temps =arc4random()%4;
            switch (temps) {
                case 0:
                    temp[2]=11;
                    break;
                case 1:
                    temp[2]=12;
                    break;
                case 2:
                    temp[2]=13;
                    break;
                case 3:
                    temp[2]=14;
                    break;
                default:
                    break;
            }
        }
        //生成射手牌
        [self creatAPictureOfAIFiveFiled:temp[2]];
        AIField5=true;
        WhetherCanBeACard =false;
    }
    if (AIField1&&AIField4&&AIField5&&WhetherCanBeACard&&AIField6==false) {
        //发送卡牌的当前位置
        [MPC sendTheAICardPosition:6];
        //判断手牌(保证这张牌是射手牌)
        while (temp[2]>=11&&temp[2]<=14) {
            int temps =arc4random()%2;
            switch (temps) {
                case 0:
                    temp[2]=15;
                    break;
                case 1:
                    temp[2]=16;
                    break;
            }
        }
        //生成辅助牌
        [self creatAPictureOfAISixFiled:temp[2]];
        AIField6=true;
        WhetherCanBeACard =false;
    }
    if (AIField1&&AIField4&&AIField5&&WhetherCanBeACard&&AIField6&&AIField7==false) {
        //发送卡牌的当前位置
        [MPC sendTheAICardPosition:7];
        //生成特殊牌
        [self creatAPictureOfAISevenFiled:temp[3]];
        //判断是否是大龙
        if (temp[3]==17) {
            //如果特殊牌是大龙，要发送登场消息
            [MPC ReceivedOshilisSkyDragon];
            AIOsirisSkyDraonPlay =true;
            [self EmptyTheAICurrentData];
        }
        AIField7=true;
        WhetherCanBeACard =false;
    }
    if (AIField1&&AIField4&&AIField5&&WhetherCanBeACard&&AIField6&&AIField7&&AIField2==false) {
        //发送卡牌的当前位置
        [MPC sendTheAICardPosition:2];
        //生成近战牌2
        [self creatAPictureOfAITwoFiled:temp[0]];
        AIField2=true;
        WhetherCanBeACard =false;
    }
    if (AIField1&&AIField4&&AIField5&&WhetherCanBeACard&&AIField6&&AIField7&&AIField2&&AIField3==false&&AIOsirisSkyDraonPlay==false) {
        //发送卡牌的当前位置
        [MPC sendTheAICardPosition:3];
        //生成特殊牌
        [self creatAPictureOfAIThreeFiled:temp[0]];
        AIField3=true;
        WhetherCanBeACard =false;
    }
    if (AIField1&&AIField4&&AIField5&&AIField6&&AIField7&&AIField2&&AIField3) {
        _PromptInformation.text =[NSString stringWithFormat:@"AI场上卡牌已全部存在，不再出牌"];
        WhetherCanBeACard =true;
    }
    if (AIOsirisSkyDraonPlay) {
        _PromptInformation.text =[NSString stringWithFormat:@"龙被动存在，不允许上场任何卡牌"];
        //设置全场存在卡牌
        AIField1 =true;
        AIField2 =true;
        AIField3 =true;
        AIField4 =true;
        AIField5 =true;
        AIField6 =true;
    }
}
//AI出牌动作方法2
-(void)AICardAction2{
    /*
     针对出牌方法：
     1.获的AI手中的5张牌分别是哪几张
     2.获的玩家当前出了类型牌
     3.从5张牌中选一张最克制玩家当前出的类型牌的牌
     */
    //获的AI的5张牌
    [self AIGetMeleeCard];
    [self AIGetAssassinCard];
    [self AIGetAssistCard];
    [self AIGetArcharCard];
    [self AIGEtRandomCard];
    [self AIgetSpecialCard];
    bool WhetherCanBeACard=true;
    //获的玩家当前出了什么牌(可以从创建场上的动作获知)
    switch (WhatKindOfPlayerOut) {
        case 1001://玩家创建的是近战牌
            if (AIField4==false&&WhetherCanBeACard) {//位置4上可以生成卡牌
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:4];
                //生成刺客牌
                [self creatAPictureOfAIFourFiled:AIHasAcard[1]];
                //重置信息
                AIField4=true;
                WhetherCanBeACard =false;
            }else if (AIField4&&AIField5==false&&WhetherCanBeACard){ //刺客位已经存在，但射手位还没有
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:5];
                //生成射手牌
                [self creatAPictureOfAIFiveFiled:AIHasAcard[2]];
                //重置信息
                AIField5=true;
                WhetherCanBeACard =false;
            }else if (AIField4&&AIField5&&AIField6==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:6];
                int nu =arc4random()%2;
                switch (nu) {
                    case 0:
                        //生成射手牌
                        [self creatAPictureOfAISixFiled:AIHasAcard[2]];
                        break;
                    case 1:
                        //生成射手牌或者辅助牌
                        [self creatAPictureOfAISixFiled:AIHasAcard[3]];
                        break;
                    default:
                        break;
                }
                //重置信息
                AIField6=true;
                WhetherCanBeACard =false;
            }else if(AIField4&&AIField5&&AIField6&&WhetherCanBeACard&&(AIField1==false||AIField2==false||AIField3==false)){//刺客位，射手位都满了，出近战牌
                if (AIField1==false) {//近战位1
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:1];
                    //生成刺客牌
                    [self creatAPictureOfAIOneFiled:AIHasAcard[0]];
                    //重置信息
                    AIField1=true;
                    WhetherCanBeACard =false;
                }else if (AIField2==false){//近战位2
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:2];
                    //生成刺客牌
                    [self creatAPictureOfAITwoFiled:AIHasAcard[0]];
                    //重置信息
                    AIField2=true;
                    WhetherCanBeACard =false;
                }else if (AIField3 ==false){
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:3];
                    //生成刺客牌
                    [self creatAPictureOfAIThreeFiled:AIHasAcard[0]];
                    //重置信息
                    AIField3=true;
                    WhetherCanBeACard =false;
                }
            }else{//AI位置1-6都有位置了,特殊牌固定生成一张
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:7];
                //生成刺客牌
                [self creatAPictureOfAISevenFiled:AIHasAcard[5]];
                //重置信息
                AIField7=true;
                WhetherCanBeACard =false;
            }
            break;
        case 1002://玩家出的是刺客牌(AI优先出一张近战牌)
            if(AIField1==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:1];
                //生成近战
                [self creatAPictureOfAIOneFiled:AIHasAcard[0]];
                //重置信息
                AIField1=true;
                WhetherCanBeACard =false;
            }else if (AIField1&&AIField4==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:4];
                //生成刺客牌
                [self creatAPictureOfAIFourFiled:AIHasAcard[1]];
                //重置信息
                AIField4=true;
                WhetherCanBeACard =false;
            }else if (AIField1&&AIField4&&AIField5==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:5];
                //生成射手牌
                [self creatAPictureOfAIFiveFiled:AIHasAcard[2]];
                //重置信息
                AIField5=true;
                WhetherCanBeACard =false;
            }else if (AIField1&&AIField4&&AIField5&&AIField6 ==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:6];
                //生成射手牌
                [self creatAPictureOfAISixFiled:AIHasAcard[2]];
                //重置信息
                AIField6=true;
                WhetherCanBeACard =false;
            }else if (AIField1&&AIField4&&AIField5&&AIField6&&AIField2==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:2];
                //生成近战牌
                [self creatAPictureOfAITwoFiled:AIHasAcard[0]];
                //重置信息
                AIField2=true;
                WhetherCanBeACard =false;
            }else if (AIField1&&AIField4&&AIField5&&AIField6&&AIField2&&AIField3==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:3];
                //生成近战牌
                [self creatAPictureOfAIThreeFiled:AIHasAcard[0]];
                //重置信息
                AIField3=true;
                WhetherCanBeACard =false;
            }else if (AIField1&&AIField4&&AIField5&&AIField6&&AIField2&&AIField3&&AIField7==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:7];
                //生成近战牌
                [self creatAPictureOfAIThreeFiled:AIHasAcard[5]];
                //重置信息
                AIField3=true;
                WhetherCanBeACard =false;
            }
            break;
        case 1003:
            if (AIField4==false&&WhetherCanBeACard) {//位置4上可以生成卡牌
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:4];
                //生成刺客牌
                [self creatAPictureOfAIFourFiled:AIHasAcard[1]];
                //重置信息
                AIField4=true;
                WhetherCanBeACard =false;
            }else if (AIField4&&AIField5==false&&WhetherCanBeACard){ //刺客位已经存在，但射手位还没有
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:5];
                //生成射手牌
                [self creatAPictureOfAIFiveFiled:AIHasAcard[2]];
                //重置信息
                AIField5=true;
                WhetherCanBeACard =false;
            }else if (AIField4&&AIField5&&AIField6==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:6];
                //生成辅助牌
                [self creatAPictureOfAISixFiled:AIHasAcard[3]];
                //重置信息
                AIField6=true;
                WhetherCanBeACard =false;
            }else if(AIField4&&AIField5&&AIField6&&WhetherCanBeACard&&(AIField1==false||AIField2==false||AIField3==false)){//刺客位，射手位都满了，出近战牌
                if (AIField1==false) {//近战位1
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:1];
                    //生成刺客牌
                    [self creatAPictureOfAIOneFiled:AIHasAcard[0]];
                    //重置信息
                    AIField1=true;
                    WhetherCanBeACard =false;
                }else if (AIField2==false){//近战位2
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:2];
                    //生成刺客牌
                    [self creatAPictureOfAITwoFiled:AIHasAcard[0]];
                    //重置信息
                    AIField2=true;
                    WhetherCanBeACard =false;
                }else if (AIField3 ==false){
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:3];
                    //生成刺客牌
                    [self creatAPictureOfAIThreeFiled:AIHasAcard[0]];
                    //重置信息
                    AIField3=true;
                    WhetherCanBeACard =false;
                }
            }else{//AI位置1-6都有位置了,特殊牌固定生成一张
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:7];
                //生成刺客牌
                [self creatAPictureOfAISevenFiled:AIHasAcard[5]];
                //重置信息
                AIField7=true;
                WhetherCanBeACard =false;
            }
            break;
        case 1004:
            if (AIField4==false&&WhetherCanBeACard) {//位置4上可以生成卡牌
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:4];
                //生成刺客牌
                [self creatAPictureOfAIFourFiled:AIHasAcard[1]];
                //重置信息
                AIField4=true;
                WhetherCanBeACard =false;
            }else if (AIField4&&AIField5==false&&WhetherCanBeACard){ //刺客位已经存在，但射手位还没有
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:5];
                //生成射手牌
                [self creatAPictureOfAIFiveFiled:AIHasAcard[2]];
                //重置信息
                AIField5=true;
                WhetherCanBeACard =false;
            }else if (AIField4&&AIField5&&AIField6==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:6];
                //生成射手牌
                [self creatAPictureOfAISixFiled:AIHasAcard[3]];
                //重置信息
                AIField6=true;
                WhetherCanBeACard =false;
            }else if (AIField4&&AIField5&&AIField6&&(AIField1==false||AIField2==false||AIField3==false)&&WhetherCanBeACard){
                if (AIField1==false) {
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:1];
                    //生成近战牌
                    [self creatAPictureOfAIOneFiled:AIHasAcard[2]];
                    //重置信息
                    AIField1=true;
                    WhetherCanBeACard =false;
                }
                if (AIField2==false) {
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:2];
                    //生成近战牌
                    [self creatAPictureOfAITwoFiled:AIHasAcard[2]];
                    //重置信息
                    AIField2=true;
                    WhetherCanBeACard =false;
                }
                if (AIField3 ==false) {
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:3];
                    //生成近战牌
                    [self creatAPictureOfAIThreeFiled:AIHasAcard[2]];
                    //重置信息
                    AIField3=true;
                    WhetherCanBeACard =false;
                }
            }else if (AIField1&&AIField2&&AIField3&&AIField4&&AIField5&&AIField6&&AIField7==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:7];
                //生成特殊牌
                [self creatAPictureOfAISevenFiled:AIHasAcard[5]];
                //重置信息
                AIField7=true;
                WhetherCanBeACard =false;
            }
            break;
        case 1005:
            if (AIField7==false&&WhetherCanBeACard) {
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:7];
                NSLog(@"值：%d",AIHasAcard[5]);
                //生成特殊牌
                [self creatAPictureOfAISevenFiled:AIHasAcard[5]];
                //重置信息
                AIField7=true;
                WhetherCanBeACard =false;
            }else if (AIField7&&AIField4==false&&WhetherCanBeACard) {//位置4上可以生成卡牌
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:4];
                //生成刺客牌
                [self creatAPictureOfAIFourFiled:AIHasAcard[1]];
                //重置信息
                AIField4=true;
                WhetherCanBeACard =false;
            }else if (AIField7&&AIField4&&AIField5==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:5];
                //生成刺客牌
                [self creatAPictureOfAIFiveFiled:AIHasAcard[2]];
                //重置信息
                AIField5=true;
                WhetherCanBeACard =false;
            }else if (AIField7&&AIField4&&AIField5&&AIField6==false&&WhetherCanBeACard){
                //发送卡牌的当前位置
                [MPC sendTheAICardPosition:6];
                //生成刺客牌
                [self creatAPictureOfAISixFiled:AIHasAcard[2]];
                //重置信息
                AIField6=true;
                WhetherCanBeACard =false;
            }else if (AIField7&&AIField4&&AIField5&&AIField6&&(AIField1==false||AIField2==false||AIField3==false)){
                if (AIField1==false) {
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:1];
                    //生成近战牌
                    [self creatAPictureOfAIOneFiled:AIHasAcard[2]];
                    //重置信息
                    AIField1=true;
                    WhetherCanBeACard =false;
                }
                if (AIField2==false) {
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:2];
                    //生成近战牌
                    [self creatAPictureOfAITwoFiled:AIHasAcard[2]];
                    //重置信息
                    AIField2=true;
                    WhetherCanBeACard =false;
                }
                if (AIField3 ==false) {
                    //发送卡牌的当前位置
                    [MPC sendTheAICardPosition:3];
                    //生成近战牌
                    [self creatAPictureOfAIThreeFiled:AIHasAcard[2]];
                    //重置信息
                    AIField3=true;
                    WhetherCanBeACard =false;
                }
            }
            break;
        default:
            break;
    }
}//👈出牌动作2结尾
//AI获取近战牌
-(void)AIGetMeleeCard{
     NSArray *allNumber =[NSArray arrayWithObjects:@"7",@"8",@"9",@"10",nil];
    //对数组进行随机取值
    int temp =arc4random()%4;
    //取数组对应下标对数值
    NSString *str =[allNumber objectAtIndex:temp];
    NSLog(@"Str:%@",str);
    //将取到的值赋值给AI的手牌
    AIHasAcard[0]=[str intValue];
    NSLog(@"AI手牌0：%d",AIHasAcard[0]);
}
//AI获取刺客牌
-(void)AIGetAssassinCard{
    NSArray *allNumber =[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",nil];
    //对数组进行随机取值
    int temp =arc4random()%7;
    //取数组对应下标对数值
    NSString *str =[allNumber objectAtIndex:temp];
    NSLog(@"Str:%@",str);
    //将取到的值赋值给AI的手牌
    AIHasAcard[1]=[str intValue];
    NSLog(@"AI手牌1：%d",AIHasAcard[1]);
}
//AI获取射手牌
-(void)AIGetArcharCard{
    NSArray *allNumber =[NSArray arrayWithObjects:@"11",@"12",@"13",@"14",nil];
    //对数组进行随机取值
    int temp =arc4random()%4;
    //取数组对应下标对数值
    NSString *str =[allNumber objectAtIndex:temp];
    NSLog(@"Str:%@",str);
    //将取到的值赋值给AI的手牌
    AIHasAcard[2]=[str intValue];
    NSLog(@"AI手牌2：%d",AIHasAcard[2]);
}
//AI获取辅助牌
-(void)AIGetAssistCard{
    int temp =arc4random()%2;
    switch (temp) {
        case 0:
            AIHasAcard[3]=15;
            break;
        case 1:
            AIHasAcard[3]=16;
            break;
        default:
            break;
    }
    NSLog(@"AI手牌3:%d",AIHasAcard[3]);
}
//AI获取随机牌
-(void)AIGEtRandomCard{
      NSArray *allNumber =[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",nil];
    int temp =arc4random()%20;
    //取数组对应下标对数值
    NSString *str =[allNumber objectAtIndex:temp];
    NSLog(@"Str:%@",str);
    //将取到的值赋值给AI的手牌
    AIHasAcard[4]=[str intValue];
    NSLog(@"AI手牌4：%d",AIHasAcard[4]);
}
//AI获取特殊牌
-(void)AIgetSpecialCard{
    int temp =arc4random()%3;
    switch (temp) {
        case 0:
            AIHasAcard[5]=17;
            break;
        case 1:
            AIHasAcard[5]=18;
            break;
        case 2:
            AIHasAcard[5]=19;
            break;
        default:
            break;
    }
    NSLog(@"AI手牌5:%d",AIHasAcard[5]);
}
//因为AI大龙清空Ai其它卡牌
-(void)EmptyTheAICurrentData
{
    //清空当前数据
    _AIbutton1Attack.text =[NSString stringWithFormat:@"0"];
    _AIbutton1Life.text =[NSString stringWithFormat:@"0"];
    _AIbutton2Attack.text =[NSString stringWithFormat:@"0"];
    _AIbutton2Life.text =[NSString stringWithFormat:@"0"];
    _AIbutton3Attack.text =[NSString stringWithFormat:@"0"];
    _AIbutton3Life.text =[NSString stringWithFormat:@"0"];
    _AIbutton4Attack.text =[NSString stringWithFormat:@"0"];
    _AIbutton4Life.text =[NSString stringWithFormat:@"0"];
    _AIbutton5Attack.text =[NSString stringWithFormat:@"0"];
    _AIbutton5Life.text =[NSString stringWithFormat:@"0"];
    _AIbutton6Attack.text =[NSString stringWithFormat:@"0"];
    _AIbutton6Life.text =[NSString stringWithFormat:@"0"];
    
    _FightingInformation.text =[NSString stringWithFormat:@"龙的被动发动"];
    //重置可以出新一轮的牌
    AIField1 =false;
    AIField2 =false;
    AIField3 =false;
    AIField4 =false;
    AIField5 =false;
    AIField6 =false;
    
}
//创建AI场上卡牌1的图片(近战)
-(void)creatAPictureOfAIOneFiled:(int)AI
{
    _AIbutton1Attack.hidden =NO;
    _AIbutton1Life.hidden =NO;
    _AIbutton1.hidden =NO;
    //记录AI场上有多少张牌
    HowManyCardsInAI++;
    switch (AI) {
        case 7:
            [_AIbutton1 setBackgroundImage:[UIImage imageNamed:@"Solider.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[0] =7;//之所以要转一次是因为与判断状态有关
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[0]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"FFF团小兵登场位置1"];
            //赋值音效（死亡）
            DeathSoundPlayArray[0]=-1;
            break;
        case 8:
            [_AIbutton1 setBackgroundImage:[UIImage imageNamed:@"nilu.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[0] =8;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[0]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"尼禄登场位置1"];
            //赋值音效（死亡）
            DeathSoundPlayArray[0]=8;
            break;
        case 9:
            [_AIbutton1 setBackgroundImage:[UIImage imageNamed:@"safeiluosi.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[0] =9;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[0]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"萨菲罗斯登场位置1"];
            //赋值音效（死亡）
            DeathSoundPlayArray[0]=9;
            break;
        case 10:
            [_AIbutton1 setBackgroundImage:[UIImage imageNamed:@"zun.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[0] =10;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[0]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"周防尊登场位置1"];
            //赋值音效（死亡）
            DeathSoundPlayArray[0]=-1;
            break;
        default:
            break;
    }
    _AIbutton1Attack.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardAttackMessage:0]];
    _AIbutton1Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:0]];
//    //按钮可点击及可视(不知道这个要干嘛的)
//    _Dbutton1.enabled =YES;
//    _Dbutton1.hidden =YES;
}
//创建AI场上卡牌2的图片
-(void)creatAPictureOfAITwoFiled:(int)AI
{
    _AIbutton2Attack.hidden =NO;
    _AIbutton2Life.hidden =NO;
    _AIbutton2.hidden =NO;
    //记录AI场上有多少张牌
    HowManyCardsInAI++;
    switch (AI) {
        case 7:
            [_AIbutton2 setBackgroundImage:[UIImage imageNamed:@"Solider.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[1] =7;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[1]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"FFF团小兵登场位置2"];
            //赋值音效（死亡）
            DeathSoundPlayArray[1]=-1;
            break;
        case 8:
            [_AIbutton2 setBackgroundImage:[UIImage imageNamed:@"nilu.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[1] =8;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[1]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"尼禄登场位置2"];
            //赋值音效（死亡）
            DeathSoundPlayArray[1]=8;
            break;
        case 9:
            [_AIbutton2 setBackgroundImage:[UIImage imageNamed:@"safeiluosi.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[1] =9;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[1]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"萨菲罗斯登场位置2"];
            //赋值音效（死亡）
            DeathSoundPlayArray[1]=9;
            break;
        case 10:
            [_AIbutton2 setBackgroundImage:[UIImage imageNamed:@"zun.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[1] =10;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[1]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"周防尊登场位置2"];
            //赋值音效（死亡）
            DeathSoundPlayArray[1]=-1;
            break;
        default:
            break;
    }
    _AIbutton2Attack.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardAttackMessage:1]];
    _AIbutton2Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:1]];
//    //按钮可点击及可视
//    _Dbutton2.enabled =YES;
//    _Dbutton2.hidden =YES;
}
//创建AI场上卡牌3的图片
-(void)creatAPictureOfAIThreeFiled:(int)AI
{
    _AIbutton3Attack.hidden =NO;
    _AIbutton3Life.hidden =NO;
    _AIbutton3.hidden =NO;
    //记录AI场上有多少张牌
    HowManyCardsInAI++;
    switch (AI) {
        case 7:
            [_AIbutton3 setBackgroundImage:[UIImage imageNamed:@"Solider.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[2] =7;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[2]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"FFF团小兵登场位置3"];
            //赋值音效（死亡）
            DeathSoundPlayArray[2]=-1;
            break;
        case 8:
            [_AIbutton3 setBackgroundImage:[UIImage imageNamed:@"nilu.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[2] =8;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[2]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"尼禄登场位置3"];
            //赋值音效（死亡）
            DeathSoundPlayArray[2]=8;
            break;
        case 9:
            [_AIbutton3 setBackgroundImage:[UIImage imageNamed:@"safeiluosi.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[2] =9;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[2]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"萨菲罗斯登场位置3"];
            //赋值音效（死亡）
            DeathSoundPlayArray[2]=9;
            break;
        case 10:
            [_AIbutton3 setBackgroundImage:[UIImage imageNamed:@"zun.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[2] =10;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[2]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"周防尊登场位置3"];
            //赋值音效（死亡）
            DeathSoundPlayArray[2]=-1;
            break;
        default:
            break;
    }
    _AIbutton3Attack.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardAttackMessage:2]];
    _AIbutton3Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:2]];
//    //按钮可点击及可视
//    _Dbutton3.enabled =YES;
//    _Dbutton3.hidden =YES;
}
//创建AI场上卡牌4的图片
-(void)creatAPictureOfAIFourFiled:(int)AI
{
    _AIbutton4Attack.hidden =NO;
    _AIbutton4Life.hidden =NO;
    _AIbutton4.hidden =NO;
    //记录AI场上有多少张牌
    HowManyCardsInAI++;
    switch (AI) {
        case 0:
            [_AIbutton4 setBackgroundImage:[UIImage imageNamed:@"eryishi.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[3] =0;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[3]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"二仪式登场位置4"];
            //赋值音效（死亡）
            DeathSoundPlayArray[3]=0;
            break;
        case 1:
            [_AIbutton4 setBackgroundImage:[UIImage imageNamed:@"hei.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[3] =1;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[3]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"黑登场位置4"];
            //赋值音效（死亡）
            DeathSoundPlayArray[3]=1;
            break;
        case 2:
            [_AIbutton4 setBackgroundImage:[UIImage imageNamed:@"jianxin.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[3] =2;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[3]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"剑心登场位置4"];
            //赋值音效（死亡）
            DeathSoundPlayArray[3]=2;
            break;
        case 3:
            [_AIbutton4 setBackgroundImage:[UIImage imageNamed:@"neipudun.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[3]=3;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[3]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"涅普顿登场位置4"];
            //赋值音效（死亡）
            DeathSoundPlayArray[3]=3;
            break;
        case 4:
            [_AIbutton4 setBackgroundImage:[UIImage imageNamed:@"tongren.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[3] =4;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[3]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"桐人登场位置4"];
            //赋值音效（死亡）
            DeathSoundPlayArray[3]=4;
            break;
        case 5:
            [_AIbutton4 setBackgroundImage:[UIImage imageNamed:@"yaomeng.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[3] =5;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[3]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"魂魄妖梦登场位置4"];
            //赋值音效（死亡）
            DeathSoundPlayArray[3]=5;
            break;
        case 6:
            [_AIbutton4 setBackgroundImage:[UIImage imageNamed:@"yasina.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[3] =6;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[3]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"亚丝娜登场位置4"];
            //赋值音效（死亡）
            DeathSoundPlayArray[3]=6;
            break;
        default:
            break;
    }
    _AIbutton4Attack.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardAttackMessage:3]];
    _AIbutton4Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:3]];
//    //按钮可点击及可视
//    _Dbutton4.enabled =YES;
//    _Dbutton4.hidden =YES;
}
//创建AI场上卡牌5的图片
-(void)creatAPictureOfAIFiveFiled:(int)AI
{
    _AIbutton5Attack.hidden =NO;
    _AIbutton5Life.hidden =NO;
     _AIbutton5.hidden =NO;
    //记录AI场上有多少张牌
    HowManyCardsInAI++;
    switch (AI) {
        case 11:
            [_AIbutton5 setBackgroundImage:[UIImage imageNamed:@"heiyan.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[4] =11;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[4]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"你们的麻麻：黑岩射手强势登场位置5"];
            //赋值音效（死亡）
            DeathSoundPlayArray[4]=11;
            break;
        case 12:
            [_AIbutton5 setBackgroundImage:[UIImage imageNamed:@"shinai.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[4] =12;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[4]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"集火这个诗乃！她登场位置5"];
            //赋值音效（死亡）
            DeathSoundPlayArray[4]=12;
            break;
        case 13:
            [_AIbutton5 setBackgroundImage:[UIImage imageNamed:@"wuying.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[4] =13;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[4]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"雾影大神登场位置5"];
            //赋值音效（死亡）
            DeathSoundPlayArray[4]=-1;
            break;
        case 14:
            [_AIbutton5 setBackgroundImage:[UIImage imageNamed:@"Remote.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[4]=14;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[4]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"FFF团炮车登场位置5"];
            //赋值音效（死亡）
            DeathSoundPlayArray[4]=-1;
            break;
        case 15:
            [_AIbutton5 setBackgroundImage:[UIImage imageNamed:@"yadianna.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[4] =15;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[4]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"雅典娜登场位置5"];
            //AI雅典娜被动生效
            AIAthenaPassive =true;
            //赋值音效（死亡）
            DeathSoundPlayArray[4]=15;
            break;
        case 16:
            [_AIbutton5 setBackgroundImage:[UIImage imageNamed:@"you.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[4] =16;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[4]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"优克莉伍徳登场位置5"];
            //赋值音效（死亡）
            DeathSoundPlayArray[4]=-1;
            break;
        default:
            break;
    }
    _AIbutton5Attack.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardAttackMessage:4]];
    _AIbutton5Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:4]];
//    //按钮可点击及可视
//    _Dbutton5.enabled =YES;
//    _Dbutton5.hidden =YES;
}
//创建AI场上卡牌6的图片
-(void)creatAPictureOfAISixFiled:(int)AI
{
    _AIbutton6Attack.hidden =NO;
    _AIbutton6Life.hidden =NO;
     _AIbutton6.hidden =NO;
    //记录AI场上有多少张牌
    HowManyCardsInAI++;
    switch (AI) {
        case 11:
            [_AIbutton6 setBackgroundImage:[UIImage imageNamed:@"heiyan.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[5] =11;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[5]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"你们的麻麻：黑岩射手强势登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[5]=11;
            break;
        case 12:
            [_AIbutton6 setBackgroundImage:[UIImage imageNamed:@"shinai.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[5] =12;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[5]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"集火这个诗乃！她登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[5]=12;
            break;
        case 13:
            [_AIbutton6 setBackgroundImage:[UIImage imageNamed:@"wuying.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[5] =13;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[5]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
             _PromptInformation.text =[NSString stringWithFormat:@"雾影大神登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[5]=-1;
            break;
        case 14:
            [_AIbutton6 setBackgroundImage:[UIImage imageNamed:@"Remote.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[5] =14;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[5]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
             _PromptInformation.text =[NSString stringWithFormat:@"FFF团炮车登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[5]=-1;
            break;
        case 15:
            [_AIbutton6 setBackgroundImage:[UIImage imageNamed:@"yadianna.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[5] =15;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[5]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
             _PromptInformation.text =[NSString stringWithFormat:@"雅典娜登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[5]=15;
            break;
        case 16:
            [_AIbutton6 setBackgroundImage:[UIImage imageNamed:@"you.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[5] =16;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[5]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
             _PromptInformation.text =[NSString stringWithFormat:@"优克莉伍徳登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[5]=-1;
            break;
        default:
            break;
    }
    _AIbutton6Attack.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardAttackMessage:5]];
    _AIbutton6Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:5]];
//    //按钮可点击及可视
//    _Dbutton6.enabled =YES;
//    _Dbutton6.hidden =YES;
}
//创建AI场上卡牌7的图片
-(void)creatAPictureOfAISevenFiled:(int)AI{
    _AIbutton7Attack.hidden =NO;
    _AIbutton7Life.hidden =NO;
     _AIbutton7.hidden =NO;
    //记录AI场上有多少张牌
    HowManyCardsInAI++;
    switch (AI) {
        case 17:
            [_AIbutton7 setBackgroundImage:[UIImage imageNamed:@"dalong.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[6] =17;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[6]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"欧西里斯天空龙登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[6]=-1;
            break;
        case 18:
            [_AIbutton7 setBackgroundImage:[UIImage imageNamed:@"jiangshi.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[6] =18;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[6]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"僵尸登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[6]=-1;
            break;
        case 19:
            [_AIbutton7 setBackgroundImage:[UIImage imageNamed:@"xiaolong.jpg"] forState:UIControlStateNormal];
            WhichCardIsAI[6]=19;
            //发送AI卡牌的信息
            [MPC sendAICurrentCard:WhichCardIsAI[6]];
            //加载消息
            [MPC AIAtLoadSpecifiedCardInformation];
            _PromptInformation.text =[NSString stringWithFormat:@"青眼白龙登场位置6"];
            //赋值音效（死亡）
            DeathSoundPlayArray[6]=-1;
            break;
        default:
            break;
    }
    _AIbutton7Attack.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardAttackMessage:6]];
    _AIbutton7Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:6]];
//    //按钮可点击及可视
//    _Dbutton7.enabled =NO;
//    _Dbutton7.hidden =NO;
}
-(void)AICardBackGround
{
    _IB1.image =[UIImage imageNamed:@"beijing.jpg"];
    _IB2.image =[UIImage imageNamed:@"beijing.jpg"];
    _IB3.image =[UIImage imageNamed:@"beijing.jpg"];
    _IB4.image =[UIImage imageNamed:@"beijing.jpg"];
}
-(void)addGestureRecoginizerToView:(UIView *)view
{
    //旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer =[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    //缩放手势
    UIPinchGestureRecognizer *pinchGestureRecongnizer =[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecongnizer];
}
//处理旋转手势
-(void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecongnizer
{
    UIView *view =rotationGestureRecongnizer.view;
    if (rotationGestureRecongnizer.state == UIGestureRecognizerStateBegan||rotationGestureRecongnizer.state == UIGestureRecognizerStateChanged) {
        view.transform =CGAffineTransformRotate(view.transform, rotationGestureRecongnizer.rotation);
        [rotationGestureRecongnizer setRotation:0];
    }
}
//处理缩放手势
-(void)pinchView:(UIPinchGestureRecognizer *)pinchGestureReconginzer
{
    UIView *view =pinchGestureReconginzer.view;
    if (pinchGestureReconginzer.state == UIGestureRecognizerStateBegan||pinchGestureReconginzer.state == UIGestureRecognizerStateChanged) {
        view.transform =CGAffineTransformScale(view.transform,pinchGestureReconginzer.scale,pinchGestureReconginzer.scale);
        pinchGestureReconginzer.scale =1;
    }
}
//处理移动手势1（目的是处理卡牌1移动到指定的三个位置）
-(void)panView1:(UIPanGestureRecognizer *)panGestureReconginzer{
    //移动了卡牌1，则其它卡牌不能移动
    _button2.enabled =NO;
    _button3.enabled =NO;
    _button4.enabled =NO;
    //开始按钮不可点击
    _SPButton.enabled =NO;
    UIView *view =panGestureReconginzer.view;
    if (panGestureReconginzer.state == UIGestureRecognizerStateBegan||
        panGestureReconginzer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation =[panGestureReconginzer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x+translation.x,view.center.y+translation.y}];
        //判定移动到手牌1
        if (view.center.x !=293) {
            if ((view.center.x>=24&&view.center.x<=26)&&(view.center.y>=212&view.center.y<=215)&&position1==false) {
                //把按钮里的图片变成null
                _button1Image.image =NULL;
                //在指定位置生成对应图片
                [self creatOneForCardImage:RandomOfMelee];
                //发送一个该位置已经被占领了
                position1 =true;
                
            }
            else if ((view.center.x>=107&&view.center.x<=110)&&(view.center.y>=212&view.center.y<=215)&&position2==false) {
                //把按钮里的图片变成null
                _button1Image.image =NULL;
                //在指定位置生成对应图片
                [self creatTwoForCardImage:RandomOfMelee];
                position2 =true;
            }
            else if ((view.center.x>=201&&view.center.x<=205)&&(view.center.y>=212&view.center.y<=215)&&position3 ==false) {
                //把按钮里的图片变成null
                _button1Image.image =NULL;
                //在指定位置生成对应图片
                [self creatThreeForCardImage:RandomOfMelee];
                position3 =true;
            }
        }
        [panGestureReconginzer setTranslation:CGPointZero inView:view.superview];
    }
}
//处理移动手势2(目的是处理卡牌2移动到指定位置)
-(void)panView2:(UIPanGestureRecognizer *)panGestureReconginzer
{
    //移动了卡牌2，则其它卡牌不能移动
    _button1.enabled =NO;
    _button3.enabled =NO;
    _button4.enabled =NO;
    //开始按钮不可点击
    _SPButton.enabled =NO;
    UIView *view =panGestureReconginzer.view;
    if (panGestureReconginzer.state == UIGestureRecognizerStateBegan||
        panGestureReconginzer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation =[panGestureReconginzer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x+translation.x,view.center.y+translation.y}];
        //判定移动的手牌2
        if (view.center.x !=341) {
            if ((view.center.x>=299&&view.center.x<=302)&&(view.center.y>=212&view.center.y<=215)&&position4 ==false) {
                //把按钮里的图片变成null
                _button2Image.image =NULL;
                //在指定位置生成对应图片
                [self creatFourTypeForCardImage:RandomOfAssassign];
                position4 =true;
            }
        }
     [panGestureReconginzer setTranslation:CGPointZero inView:view.superview];
    }
}
//处理移动手势3(目的是处理卡牌3移动到指定位置)
-(void)panView3:(UIPanGestureRecognizer *)panGestureReconginzer
{
    //移动了卡牌2，则其它卡牌不能移动
    _button1.enabled =NO;
    _button2.enabled =NO;
    _button4.enabled =NO;
    //开始按钮不可点击
    _SPButton.enabled =NO;
    UIView *view =panGestureReconginzer.view;
    if (panGestureReconginzer.state == UIGestureRecognizerStateBegan||
        panGestureReconginzer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation =[panGestureReconginzer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x+translation.x,view.center.y+translation.y}];
        //判定移动的手牌3
        if (view.center.x !=387) {
            if ((view.center.x>=401&&view.center.x<=405)&&(view.center.y>=212&view.center.y<=215)&&position5 ==false) {
                _button3Image.image =NULL;
                [self creatFiveForCardImage:RandomOfArcherAndAssist];
                position5 =true;
            }
            else if ((view.center.x>=499&&view.center.x<=503)&&(view.center.y>=212&view.center.y<=215)&&position6 ==false) {
                _button3Image.image =NULL;
                [self creatSixForCardImage:RandomOfArcherAndAssist];
                position6 =true;
            }
        }
    [panGestureReconginzer setTranslation:CGPointZero inView:view.superview];
    }
}
//处理移动手势4(目的是处理卡牌4移动到指定位置)
-(void)panView4:(UIPanGestureRecognizer *)panGestureReconginzer
{
    //移动了卡牌2，则其它卡牌不能移动
    _button1.enabled =NO;
    _button2.enabled =NO;
    _button3.enabled =NO;
    //开始按钮不可点击
    _SPButton.enabled =NO;
    UIView *view =panGestureReconginzer.view;
    if (panGestureReconginzer.state == UIGestureRecognizerStateBegan||
        panGestureReconginzer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation =[panGestureReconginzer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x+translation.x,view.center.y+translation.y}];
        [panGestureReconginzer setTranslation:CGPointZero inView:view.superview];
        int tempNumber;
        //移动到场上卡牌1的位置
                if ((view.center.x>=24&&view.center.x<=26)&&(view.center.y>=212&view.center.y<=215)&&position1==false) {
            //把按钮图片变成空白
            _button4Image.image =NULL;
                    switch (randomnumber) {
                        case 7:
                            tempNumber =0;
                            [self creatOneForCardImage:tempNumber];
                            position1 =true;
                            break;
                        case 8:
                            tempNumber =1;
                            [self creatOneForCardImage:tempNumber];
                            position1 =true;
                            break;
                        case 9:
                            tempNumber =2;
                            [self creatOneForCardImage:tempNumber];
                            position1 =true;
                            break;
                        case 10:
                            tempNumber =3;
                            [self creatOneForCardImage:tempNumber];
                            position1 =true;
                            break;
                        default:
                            break;
                    }}
        //移动到场上卡牌2的位置
        else if ((view.center.x>=107&&view.center.x<=110)&&(view.center.y>=212&view.center.y<=215)&&position2==false) {
            _button4Image.image =NULL;
            //当卡牌移动到位置2的时候
            switch (randomnumber) {
                case 7:
                    tempNumber =0;
                    [self creatTwoForCardImage:tempNumber];
                    position2 =true;
                    break;
                case 8:
                    tempNumber =1;
                    [self creatTwoForCardImage:tempNumber];
                    position2 =true;
                    break;
                case 9:
                    tempNumber =2;
                    [self creatTwoForCardImage:tempNumber];
                    position2 =true;
                    break;
                case 10:
                    tempNumber =3;
                    [self creatTwoForCardImage:tempNumber];
                    position2 =true;
                    break;
                default:
                    break;
            }}
        //移动到场上卡牌3的位置(测试17.5.12)<成功>
        else if ((view.center.x>=201&&view.center.x<=205)&&(view.center.y>=212&view.center.y<=215)&&position3 ==false) {
            _button4Image.image =NULL;
            //当卡牌移动到位置3的时候
            switch (randomnumber) {
                case 7:
                    tempNumber =0;
                    [self creatThreeForCardImage:tempNumber];
                    position3 =true;
                    break;
                case 8:
                    tempNumber =1;
                    [self creatThreeForCardImage:tempNumber];
                    position3 =true;
                    break;
                case 9:
                    tempNumber =2;
                    [self creatThreeForCardImage:tempNumber];
                    position3 =true;
                    break;
                case 10:
                    tempNumber =3;
                    [self creatThreeForCardImage:tempNumber];
                    position3 =true;
                    break;
                default:
                    break;
            }}
    //移动到场上卡牌4的位置
       else  if ((view.center.x>=299&&view.center.x<=302)&&(view.center.y>=212&view.center.y<=215)&&position4 ==false) {
            _button4Image.image =NULL;
            [self creatFourTypeForCardImage:randomnumber];
            position4 =true;
        }
    //移动到场上卡牌5的位置
       else if ((view.center.x>=401&&view.center.x<=405)&&(view.center.y>=212&view.center.y<=215)&&position5 ==false) {
            _button4Image.image =NULL;
            switch (randomnumber) {
                case 11:
                    //黑岩
                    tempNumber =0;
                    [self creatFiveForCardImage:tempNumber];
                    position5 =true;
                    break;
                case 12:
                    //诗乃
                    tempNumber =1;
                    [self creatFiveForCardImage:tempNumber];
                    position5 =true;
                    break;
                case 13:
                    //浅间智
                    tempNumber =2;
                    [self creatFiveForCardImage:tempNumber];
                    position5 =true;
                    break;
                case 14:
                    //炮车
                    tempNumber =3;
                    [self creatFiveForCardImage:tempNumber];
                    position5 =true;
                    break;
                case 15:
                    //雅典娜
                    tempNumber =4;
                    [self creatFiveForCardImage:tempNumber];
                    position5 =true;
                    break;
                case 16:
                    //优
                    tempNumber =5;
                    [self creatFiveForCardImage:tempNumber];
                    position5 =true;
                    break;
                default:
                    break;
            }}
        //移动到场上卡牌6的位置
      else  if ((view.center.x>=499&&view.center.x<=503)&&(view.center.y>=212&view.center.y<=215)&&position6 ==false) {
            _button4Image =NULL;
            //移动到6号位
            switch (randomnumber) {
                case 11:
                    //黑岩
                    tempNumber =0;
                    [self creatSixForCardImage:tempNumber];
                    position6 =true;
                    break;
                case 12:
                    //诗乃
                    tempNumber =1;
                    [self creatSixForCardImage:tempNumber];
                    position6 =true;
                    break;
                case 13:
                    //浅间智
                    tempNumber =2;
                    [self creatSixForCardImage:tempNumber];
                    position6 =true;
                    break;
                case 14:
                    //炮车
                    tempNumber =3;
                    [self creatSixForCardImage:tempNumber];
                    position6 =true;
                    break;
                case 15:
                    //雅典娜
                    tempNumber =4;
                    [self creatSixForCardImage:tempNumber];
                    position6 =true;
                    break;
                case 16:
                    //优
                    tempNumber =5;
                    [self creatSixForCardImage:tempNumber];
                    position6 =true;
                    break;
                default:
                    break;
            }}
        //移动到场上卡牌7的位置
       else if ((view.center.x>=600&&view.center.x<=604)&&(view.center.y>=212&view.center.y<=215)&&position7 ==false) {
            _button4Image.image =NULL;
            switch (randomnumber) {
                case 17:
                    tempNumber =0;
                    [self creatSevenForCardImage:tempNumber];
                    break;
                case 18:
                    tempNumber =1;
                    [self creatSevenForCardImage:tempNumber];
                    break;
                case 19:
                    tempNumber =2;
                    [self creatSevenForCardImage:tempNumber];
                    break;
                default:
                    break;
            }}
    }
}
//创建场上卡牌1的图片
-(void)creatOneForCardImage:(int)RD
{
    //发送移动到位置1的消息(测试17.5.12)<成功>
    [MPC moveToTheSpecifiedLocation:1];
    //用于告知AI出牌动作玩家出了什么牌
    WhatKindOfPlayerOut =1001;
    _Dbutton1Life.hidden =NO;
    _Dbutton1Attack.hidden =NO;
    _Dbutton1.hidden =NO;
    //按钮可点击
    _Dbutton1.enabled =YES;
    //记录玩家场上的卡牌数
    HowManyCardsInPlayer++;
    //重做初登场(根据回合数来决定)
    if (RecondTheNumberOfRounds<=1) {
        _FightingInformation.text =[NSString stringWithFormat:@"玩家先手，卡牌初登场，当前回合不可进行攻击."];
        //当前按钮不可点击
        _Dbutton1.enabled =NO;
    }
    switch (RD) {
        case 0:
            //小兵
            [_Dbutton1 setBackgroundImage:[UIImage imageNamed:@"Solider.jpg"] forState:UIControlStateNormal];
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            WhichCardIsPlayer[0] =7;
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[0]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];//加载消息
            _PromptInformation.text =[NSString stringWithFormat:@"你把FFF团小兵放到了一号位"];
            //赋值音效
            AttackSoundPlayArray[0]=-1;
            //死亡音效
            DeathSoundPlayArray[0]=-1;
            break;
        case 1:
            //尼禄
            [_Dbutton1 setBackgroundImage:[UIImage imageNamed:@"nilu.jpg"] forState:UIControlStateNormal];
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            WhichCardIsPlayer[0] =8;
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[0]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];//加载消息
            _PromptInformation.text =[NSString stringWithFormat:@"你把尼禄放到了一号位"];
            //赋值音效
            AttackSoundPlayArray[0]=8;
            //死亡音效
            DeathSoundPlayArray[0]=8;
            break;
        case 2:
            //萨菲罗斯
            [_Dbutton1 setBackgroundImage:[UIImage imageNamed:@"safeiluosi.jpg"] forState:UIControlStateNormal];
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            WhichCardIsPlayer[0]=9;
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[0]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];//加载消息
            _PromptInformation.text =[NSString stringWithFormat:@"你把萨菲罗斯放到了一号位"];
            //赋值音效
            AttackSoundPlayArray[0]=9;
            //死亡音效
            DeathSoundPlayArray[0]=9;
            break;
        case 3:
            //尊
            [_Dbutton1 setBackgroundImage:[UIImage imageNamed:@"zun.jpg"] forState:UIControlStateNormal];
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            WhichCardIsPlayer[0] =10;
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[0]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];//加载消息
            _PromptInformation.text =[NSString stringWithFormat:@"你把尊放到了一号位"];
            //赋值音效
            AttackSoundPlayArray[0]=-1;
            //死亡音效
            DeathSoundPlayArray[0]=-1;
            break;
        default:
            break;
    }
    _Dbutton1Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:0]];
    _Dbutton1Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:0]];
}
//创建场上卡牌2的图片
-(void)creatTwoForCardImage:(int)RD
{
    //发送移动到位置2的消息(测试17.5.12)<成功>
    [MPC moveToTheSpecifiedLocation:2];
    //用于告知AI出牌动作玩家出了什么牌
    WhatKindOfPlayerOut =1001;
    _Dbutton2Life.hidden =NO;
    _Dbutton2Attack.hidden =NO;
    _Dbutton2.enabled =YES;
    _Dbutton2.hidden =NO;
    //记录玩家场上的卡牌数
    HowManyCardsInPlayer++;
    //重做初登场(根据回合数来决定)
    if (RecondTheNumberOfRounds<=1) {
        _FightingInformation.text =[NSString stringWithFormat:@"玩家先手，卡牌初登场，当前回合不可进行攻击."];
        //当前按钮不可点击
        _Dbutton2.enabled =NO;
    }
    switch (RD) {
        case 0:
            //小兵
            [_Dbutton2 setBackgroundImage:[UIImage imageNamed:@"Solider.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[1] =7;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[1]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];//加载消息
            _PromptInformation.text =[NSString stringWithFormat:@"你把FFF团小兵放到了二号位"];
            //赋值音效
            AttackSoundPlayArray[1]=-1;
            //死亡音效
            DeathSoundPlayArray[1]=-1;
            break;
        case 1:
            //尼禄
             [_Dbutton2 setBackgroundImage:[UIImage imageNamed:@"nilu.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[1] =8;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[1]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把尼禄放到了二号位"];
            //赋值音效
            AttackSoundPlayArray[1]=8;
            //死亡音效
            DeathSoundPlayArray[1]=8;
            break;
        case 2:
            //萨菲罗斯
            [_Dbutton2 setBackgroundImage:[UIImage imageNamed:@"safeiluosi.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[1] =9;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[1]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把萨菲罗斯放到了二号位"];
            //赋值音效
            AttackSoundPlayArray[1]=9;
            //死亡音效
            DeathSoundPlayArray[1]=9;
            break;
        case 3:
            //尊
            [_Dbutton2 setBackgroundImage:[UIImage imageNamed:@"zun.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[1]=10;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[1]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把尊放到了二号位"];
            //赋值音效
            AttackSoundPlayArray[1]=-1;
            //死亡音效
            DeathSoundPlayArray[1]=-1;
            break;
        default:
            break;
    }
    _Dbutton2Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:1]];
    _Dbutton2Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:1]];

}
//创建场上卡牌3的图片
-(void)creatThreeForCardImage:(int)RD
{
    //发送移动到位置1的消息(测试17.5.12)<成功>
    [MPC moveToTheSpecifiedLocation:3];
    //用于告知AI出牌动作玩家出了什么牌
    WhatKindOfPlayerOut =1001;
    _Dbutton3Life.hidden =NO;
    _Dbutton3Attack.hidden =NO;
    _Dbutton3.enabled =YES;
    _Dbutton3.hidden =NO;
    //记录玩家场上的卡牌数
    HowManyCardsInPlayer++;
    //重做初登场(根据回合数来决定)
    if (RecondTheNumberOfRounds<=1) {
        _FightingInformation.text =[NSString stringWithFormat:@"玩家先手，卡牌初登场，当前回合不可进行攻击."];
        //当前按钮不可点击
        _Dbutton3.enabled =NO;
    }
    switch (RD) {
        case 0:
            //小兵
            [_Dbutton3 setBackgroundImage:[UIImage imageNamed:@"Solider.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[2]=7;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[2]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把FFF团小兵放到了三号位"];
            //赋值音效
            AttackSoundPlayArray[2]=-1;
            //死亡音效
            DeathSoundPlayArray[2]=-1;
            break;
        case 1:
            //尼禄
            [_Dbutton3 setBackgroundImage:[UIImage imageNamed:@"nilu.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[2] =8;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[2]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把尼禄放到了三号位"];
            //赋值音效
            AttackSoundPlayArray[2]=8;
            //死亡音效
            DeathSoundPlayArray[2]=8;
            break;
        case 2:
            //萨菲罗斯
            [_Dbutton3 setBackgroundImage:[UIImage imageNamed:@"safeiluosi.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[2] =9;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[2]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把萨菲罗斯放到了三号位"];
            //赋值音效
            AttackSoundPlayArray[2]=9;
            //死亡音效
            DeathSoundPlayArray[2]=9;
            break;
        case 3:
            //尊
            [_Dbutton3 setBackgroundImage:[UIImage imageNamed:@"zun.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[2] =10;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[2]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把尊放到了三号位"];
            //赋值音效
            AttackSoundPlayArray[2]=-1;
            //死亡音效
            DeathSoundPlayArray[2]=-1;
            break;
        default:
            break;
    }
    _Dbutton3Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:2]];
    _Dbutton3Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:2]];
}
//创建场上卡牌4的图片
-(void)creatFourTypeForCardImage:(int)RD
{
    //发送移动到位置4的消息(测试17.5.12)<成功>
    [MPC moveToTheSpecifiedLocation:4];
    //用于告知AI出牌动作玩家出了什么牌
    WhatKindOfPlayerOut =1002;
    _Dbutton4Attack.hidden =NO;
    _Dbutton4Life.hidden =NO;
    _Dbutton4.enabled =YES;
    _Dbutton4.hidden =NO;
    //记录玩家场上的卡牌数
    HowManyCardsInPlayer++;
    //重做初登场(根据回合数来决定)
    if (RecondTheNumberOfRounds<=1) {
        _FightingInformation.text =[NSString stringWithFormat:@"玩家先手，卡牌初登场，当前回合不可进行攻击."];
        //当前按钮不可点击
        _Dbutton4.enabled =NO;
    }
    switch (RD) {
        case 0:
            [_Dbutton4 setBackgroundImage:[UIImage imageNamed:@"eryishi.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[3]=0;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[3]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把二仪式放到了四号位"];
            //赋值音效
            AttackSoundPlayArray[3]=0;
            //死亡音效
            DeathSoundPlayArray[3]=0;
            break;
        case 1:
            [_Dbutton4 setBackgroundImage:[UIImage imageNamed:@"hei.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[3] =1;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[3]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把黑放到了四号位"];
            //赋值音效
            AttackSoundPlayArray[3]=1;
            //死亡音效
            DeathSoundPlayArray[3]=1;
            break;
        case 2:
            [_Dbutton4 setBackgroundImage:[UIImage imageNamed:@"jianxin.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[3]=2;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[3]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把剑心放到了四号位"];
            //赋值音效
            AttackSoundPlayArray[3]=2;
            //死亡音效
            DeathSoundPlayArray[3]=2;
            break;
        case 3:
            [_Dbutton4 setBackgroundImage:[UIImage imageNamed:@"neipudun.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[3] =3;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[3]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把涅普顿放到了四号位"];
            //赋值音效
            AttackSoundPlayArray[3]=3;
            //死亡音效
            DeathSoundPlayArray[3]=3;
            break;
        case 4:
            [_Dbutton4 setBackgroundImage:[UIImage imageNamed:@"tongren.jpg"]forState:UIControlStateNormal];
            WhichCardIsPlayer[3] =4;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[3]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把桐人放到了四号位"];
            //赋值音效
            AttackSoundPlayArray[3]=4;
            //死亡音效
            DeathSoundPlayArray[3]=4;
            break;
        case 5:
            [_Dbutton4 setBackgroundImage:[UIImage imageNamed:@"yaomeng.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[3] =5;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[3]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把妖梦放到了四号位"];
            //赋值音效
            AttackSoundPlayArray[3]=5;
            //死亡音效
            DeathSoundPlayArray[3]=5;
            break;
        case 6:
            [_Dbutton4 setBackgroundImage:[UIImage imageNamed:@"yasina.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[3] =6;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[3]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把亚丝娜放到了四号位"];
            //赋值音效
            AttackSoundPlayArray[3]=6;
            //死亡音效
            DeathSoundPlayArray[3]=6;
            break;
        default:
            break;
    }
    _Dbutton4Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:3]];
    _Dbutton4Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:3]];
}
//创建场上卡牌5的图片
-(void)creatFiveForCardImage:(int)RD
{
    //发送移动到位置5的消息(测试17.5.12)<成功>
    [MPC moveToTheSpecifiedLocation:5];
    _Dbutton5Attack.hidden =NO;
    _Dbutton5Life.hidden =NO;
    _Dbutton5.enabled =YES;
    _Dbutton5.hidden =NO;
    //记录玩家场上的卡牌数
    HowManyCardsInPlayer++;
    //重做初登场(根据回合数来决定)
    if (RecondTheNumberOfRounds<=1) {
        _FightingInformation.text =[NSString stringWithFormat:@"玩家先手，卡牌初登场，当前回合不可进行攻击."];
        //当前按钮不可点击
        _Dbutton5.enabled =NO;
    }
    switch (RD) {
        case 0:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton5 setBackgroundImage:[UIImage imageNamed:@"heiyan.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[4]=11;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[4]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把黑岩射手放到了五号位"];
            //赋值音效
            AttackSoundPlayArray[4]=11;
            //死亡音效
            DeathSoundPlayArray[4]=11;
            break;
        case 1:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton5 setBackgroundImage:[UIImage imageNamed:@"shinai.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[4] =12;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[4]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把朝田诗乃放到了五号位"];
            //赋值音效
            AttackSoundPlayArray[4]=12;
            //死亡音效
            DeathSoundPlayArray[4]=12;
            break;
        case 2:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton5 setBackgroundImage:[UIImage imageNamed:@"wuying.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[4] =13;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[4]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把浅间智放到了五号位"];
            //赋值音效
            AttackSoundPlayArray[4]=-1;
            //死亡音效
            DeathSoundPlayArray[4]=-1;
            break;
        case 3:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton5 setBackgroundImage:[UIImage imageNamed:@"Remote.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[4] =14;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[4]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把FFF团炮车放到了五号位"];
            //赋值音效
            AttackSoundPlayArray[4]=-1;
            //死亡音效
            DeathSoundPlayArray[4]=-1;
            break;
        case 4:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1004;
            [_Dbutton5 setBackgroundImage:[UIImage imageNamed:@"yadianna.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[4] =15;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[4]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把雅典娜放到了五号位"];
            //赋值音效
            AttackSoundPlayArray[4]=15;
            //死亡音效
            DeathSoundPlayArray[4]=15;
            break;
        case 5:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1004;
            [_Dbutton5 setBackgroundImage:[UIImage imageNamed:@"you.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[4] =16;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[4]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把优放到了五号位"];
            //赋值音效
            AttackSoundPlayArray[4]=-1;
            //死亡音效
            DeathSoundPlayArray[4]=-1;
            break;
        default:
            break;
    }
    _Dbutton5Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:4]];
    _Dbutton5Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:4]];
}
//创建场上卡牌6的图片
-(void)creatSixForCardImage:(int)RD
{
    //发送移动到位置6的消息(测试17.5.12)<成功>
    [MPC moveToTheSpecifiedLocation:6];
    _Dbutton6Attack.hidden =NO;
    _Dbutton6Life.hidden =NO;
    _Dbutton6.enabled =YES;
    //记录玩家场上的卡牌数
    HowManyCardsInPlayer++;
    //重做初登场(根据回合数来决定)
    if (RecondTheNumberOfRounds<=1) {
        _FightingInformation.text =[NSString stringWithFormat:@"玩家先手，卡牌初登场，当前回合不可进行攻击."];
        //当前按钮不可点击
        _Dbutton6.enabled =NO;
    }
    switch (RD) {
        case 0:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton6 setBackgroundImage:[UIImage imageNamed:@"heiyan.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[5] =11;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[5]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把黑岩射手放到了六号位"];
            //赋值音效
            AttackSoundPlayArray[5]=11;
            //死亡音效
            DeathSoundPlayArray[5]=11;
            break;
        case 1:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton6 setBackgroundImage:[UIImage imageNamed:@"shinai.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[5] =12;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[5]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把朝田诗乃放到了六号位"];
            //赋值音效
            AttackSoundPlayArray[5]=12;
            //死亡音效
            DeathSoundPlayArray[5]=12;
            break;
        case 2:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton6 setBackgroundImage:[UIImage imageNamed:@"wuying.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[5] =13;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[5]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把浅间智放到了六号位"];
            //赋值音效
            AttackSoundPlayArray[5]=-1;
            //死亡音效
            DeathSoundPlayArray[5]=-1;
            break;
        case 3:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1003;
            [_Dbutton6 setBackgroundImage:[UIImage imageNamed:@"Remote.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[5] =14;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[5]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把FFF团炮车放到了六号位"];
            //赋值音效
            AttackSoundPlayArray[5]=-1;
            //死亡音效
            DeathSoundPlayArray[5]=-1;
            break;
        case 4:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1004;
            [_Dbutton6 setBackgroundImage:[UIImage imageNamed:@"yadianna.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[5] =15;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[5]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把雅典娜放到了六号位"];
            //雅典娜被动存在
            AthenaPassive=true;
            //赋值音效
            AttackSoundPlayArray[5]=15;
            //死亡音效
            DeathSoundPlayArray[5]=15;
            break;
        case 5:
            //用于告知AI出牌动作玩家出了什么牌
            WhatKindOfPlayerOut =1004;
            [_Dbutton6 setBackgroundImage:[UIImage imageNamed:@"you.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[5] =16;
            //发送当前卡牌消息(测试阶段)17.5.12<成功>
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[5]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把优放到了六号位"];
            //赋值音效
            AttackSoundPlayArray[5]=-1;
            //死亡音效
            DeathSoundPlayArray[5]=-1;
            break;
        default:
            break;
    }
    _Dbutton6Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:5]];
    _Dbutton6Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:5]];
}
//创建场上卡牌7的图片
-(void)creatSevenForCardImage:(int)RD
{
    //发送移动到位置7的消息(测试17.5.12)<成功>
    [MPC moveToTheSpecifiedLocation:7];
    //用于告知AI出牌动作玩家出了什么牌
    WhatKindOfPlayerOut =1005;
    _Dbutton7Attack.hidden =NO;
    _Dbutton7Life.hidden =NO;
    //解锁可以点击事件
    _Dbutton7.enabled =YES;
    _Dbutton7.hidden =NO;
    //记录玩家场上的卡牌数
    HowManyCardsInPlayer++;
    //测试显示<显示没有问题>
    [_Dbutton7 setBackgroundImage:[UIImage imageNamed:@"xiaolong.jpg"] forState:UIControlStateNormal];
    //重做初登场(根据回合数来决定)
    if (RecondTheNumberOfRounds<=1) {
        _FightingInformation.text =[NSString stringWithFormat:@"玩家先手，卡牌初登场，当前回合不可进行攻击."];
        //当前按钮不可点击
        _Dbutton7.enabled =NO;
    }
    switch (RD) {
        case 17:
            [_Dbutton7 setBackgroundImage:[UIImage imageNamed:@"dalong.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[6]=17;
            //发送当前卡牌消息(测试阶段)
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[6]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把大龙放到了特殊位"];
            //赋值音效
            AttackSoundPlayArray[6]=-1;
            //死亡音效
            DeathSoundPlayArray[6]=-1;
            break;
        case 18:
            [_Dbutton7 setBackgroundImage:[UIImage imageNamed:@"jiangshi.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[6] =18;
            //发送当前卡牌消息(测试阶段)
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[6]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把僵尸放到了特殊位"];
            //赋值音效
            AttackSoundPlayArray[6]=-1;
            //死亡音效
            DeathSoundPlayArray[6]=-1;
            break;
        case 19:
            [_Dbutton7 setBackgroundImage:[UIImage imageNamed:@"xiaolong.jpg"] forState:UIControlStateNormal];
            WhichCardIsPlayer[6] =19;
            //发送当前卡牌消息(测试阶段)
            [MPC passTheCurrentlySelected:WhichCardIsPlayer[6]];
            [MPC LoadTheSpecifiedCardAtTheSpecifiedLoaction];
            _PromptInformation.text =[NSString stringWithFormat:@"你把小龙放到了特殊位"];
            //赋值音效
            AttackSoundPlayArray[6]=-1;
            //死亡音效
            DeathSoundPlayArray[6]=-1;
            break;
        default:
            break;
    }
    _Dbutton7Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:6]];
    _Dbutton7Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:6]];
}
//处理所有手牌不可移动，其余牌不可移动(要点击了按钮才给移动)
-(void)allHandCardCanBeMoved
{
    //手牌不可移动
    [self.button1Image setUserInteractionEnabled:NO];
    [self.button2Image setUserInteractionEnabled:NO];
    [self.button3Image setUserInteractionEnabled:NO];
    [self.button4Image setUserInteractionEnabled:NO];
}
//响应移动手牌1调用
-(void)moveTheHandCall1:(UIView *)view
{
    //移动手势1
    UIPanGestureRecognizer *panGestureRecongnizer1 =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView1:)];
    [view addGestureRecognizer:panGestureRecongnizer1];
    //移动了手牌1
    leaveLocation1 =true;

}
//响应移动手牌2调用
-(void)moveTheHandCall2:(UIView *)view
{
    //移动手势2
    UIPanGestureRecognizer *panGestureRecongnizer2 =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView2:)];
    [view addGestureRecognizer:panGestureRecongnizer2];
    //移动了手牌2
    leaveLocation2 =true;
}
//响应移动手牌3调用
-(void)moveTheHandCall3:(UIView *)view
{
    //移动手势3
    UIPanGestureRecognizer *panGestureRecongnizer3 =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView3:)];
    [view addGestureRecognizer:panGestureRecongnizer3];
    //移动了手牌3
    leaveLocation3 =true;
}
//响应移动手牌4调用
-(void)moveTheHandCall4:(UIView *)view
{
    //移动手势4
    UIPanGestureRecognizer *panGestureRecongnizer4 =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panView4:)];
    [view addGestureRecognizer:panGestureRecongnizer4];
    //移动了手牌4
    leaveLovation4 =true;
}
-(void)showCardinformation:(int)cardNumberID
{
    NSString *tempCard;
    switch (cardNumberID) {
        case 1001:
            tempCard =[CI creatCardInformation:0];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了二仪式,%@",tempCard];
            break;
        case 1002:
            tempCard =[CI creatCardInformation:1];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了黑,%@",tempCard];
            break;
        case 1003:
            tempCard =[CI creatCardInformation:2];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了绯村剑心,%@",tempCard];
            break;
        case 1004:
            tempCard =[CI creatCardInformation:3];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了涅普顿,%@",tempCard];
            break;
        case 1005:
            tempCard =[CI creatCardInformation:4];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了桐人,%@",tempCard];
            break;
        case 1006:
            tempCard =[CI creatCardInformation:5];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了妖梦,%@",tempCard];
            break;
        case 1007:
            tempCard =[CI creatCardInformation:6];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了亚丝娜,%@",tempCard];
            break;
            
        
        case 1031:
            tempCard =[CI creatCardInformation:7];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了FFF团小兵,%@",tempCard];
            break;
        case 1032:
            tempCard =[CI creatCardInformation:8];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了尼禄,%@",tempCard];
            break;
        case 1033:
            tempCard =[CI creatCardInformation:9];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了萨菲罗斯,%@",tempCard];
            break;
        case 1034:
            tempCard =[CI creatCardInformation:10];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了周防尊,%@",tempCard];
            break;
            
            
        case 1061:
            tempCard =[CI creatCardInformation:11];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了黑岩,%@",tempCard];
            break;
        case 1062:
            tempCard =[CI creatCardInformation:12];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了诗乃,%@",tempCard];
            break;
        case 1063:
            tempCard =[CI creatCardInformation:13];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了浅间智,%@",tempCard];
            break;
        case 1064:
            tempCard =[CI creatCardInformation:14];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了FFF团炮车,%@",tempCard];
            break;
            
            
        case 1091:
            tempCard =[CI creatCardInformation:15];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了雅典娜,%@",tempCard];
            break;
        case 1092:
            tempCard =[CI creatCardInformation:16];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了优,%@",tempCard];
            break;
        
        case 3011:
            tempCard =[CI creatCardInformation:17];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了天空龙,%@",tempCard];
            break;
        case 3012:
            tempCard =[CI creatCardInformation:18];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了僵尸,%@",tempCard];
            break;
        case 3013:
            tempCard =[CI creatCardInformation:19];
            _PromptInformation.text =[NSString stringWithFormat:@"你选择了青眼白龙,%@",tempCard];
            break;
        default:
            break;
    }
}
- (IBAction)button1:(id)sender {
    //调用手牌移动1
    [self moveTheHandCall1:_button1Image];
    //解禁手牌初登场
    [self RespondToDebutEvents];
   
}
- (IBAction)button2:(id)sender {
    //调用手牌移动2
    [self moveTheHandCall2:_button2Image];
    //解禁手牌初登场
    [self RespondToDebutEvents];
}
- (IBAction)button3:(id)sender {
    //调用手牌移动3
    [self moveTheHandCall3:_button3Image];
    //解禁手牌初登场
    [self RespondToDebutEvents];
    
}
- (IBAction)button4:(id)sender {
    //调用手牌移动4
    [self moveTheHandCall4:_button4Image];
    //解禁手牌初登场
    [self RespondToDebutEvents];
    
}
/*
 AI卡牌可以点击
 */
-(void)AIcardCanClick{
    if (AIField1) {
        _AIbutton1.enabled =YES;
    }
    if (AIField2) {
        _AIbutton2.enabled =YES;
    }
    if (AIField3) {
        _AIbutton3.enabled =YES;
    }
    if (AIField4) {
        _AIbutton4.enabled =YES;
    }
    if (AIField5) {
        _AIbutton5.enabled =YES;
    }
    if (AIField6) {
        _AIbutton6.enabled =YES;
    }
    if (AIField7) {
        _AIbutton7.enabled =YES;
    }
    _AIPersonButton.enabled =YES;
}
- (IBAction)Dbutton1:(id)sender {
    if (AthenaBackBlood) {
        _FightingInformation.text =[NSString stringWithFormat:@"雅典娜回复卡牌1 3点生命值"];
        //调用回血动作
        [MPC AthenaBackBlood:1];
        //将全体换回到不可点击状态
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        //重置回血状态
        AthenaBackBlood =false;
    }else if (RubyTriggeredPassive) {
        _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，卡牌1可以再行动一次"];
        //重置消息
        RubyTriggeredPassive =false;
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        
        PlayerCardPosition =1;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];//发送点击了那个按钮消息
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[0]];
        //设置可攻击范围
        if (AIField1==true||AIField2==true||AIField3==true) {
            //可以攻击的目标
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            //敌方近战单位存在,不允许攻击其它单位
            _AIbutton4.enabled =NO;
            _AIbutton5.enabled =NO;
            _AIbutton6.enabled =NO;
            _AIbutton7.enabled =NO;
            //AI人物也不能攻击
            _AIPersonButton.enabled =NO;
            //提示
            _PromptInformation.text =[NSString stringWithFormat:@"敌方近战单位还存在，只能攻击敌方敌方近战单位"];
        }
        if (AIField1==false&&AIField2==false&&AIField3==false) {
            _PromptInformation.text =[NSString stringWithFormat:@"随意开火，有基佬开我裤链......好像走错片场了"];
            //显示可以攻击的目标
            [self AIcardCanClick];
        }
         ClickPlayerCard=true;
    }else{
        PlayerCardPosition =1;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];//发送点击了那个按钮消息
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[0]];
        //设置可攻击范围
        if (AIField1==true||AIField2==true||AIField3==true) {
            //可以攻击的目标
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            //敌方近战单位存在,不允许攻击其它单位
            _AIbutton4.enabled =NO;
            _AIbutton5.enabled =NO;
            _AIbutton6.enabled =NO;
            _AIbutton7.enabled =NO;
            //AI人物也不能攻击
            _AIPersonButton.enabled =NO;
            //提示
            _PromptInformation.text =[NSString stringWithFormat:@"敌方近战单位还存在，只能攻击敌方敌方近战单位"];
        }
        if (AIField1==false&&AIField2==false&&AIField3==false) {
            _PromptInformation.text =[NSString stringWithFormat:@"随意开火，有基佬开我裤链......好像走错片场了"];
            //显示可以攻击的目标
            [self AIcardCanClick];
        }
        //点击了玩家卡牌
        ClickPlayerCard =true;
    }
    //更新玩家数据
    [self updataPlayerData];
}
- (IBAction)Dbutton2:(id)sender {
    if (AthenaBackBlood) {
        _FightingInformation.text =[NSString stringWithFormat:@"雅典娜回复卡牌2 3点生命值"];
        //调用回血动作
        [MPC AthenaBackBlood:2];
        //将全体换回到不可点击状态
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        //重置回血状态
        AthenaBackBlood =false;
    }else if (RubyTriggeredPassive) {
        _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，卡牌2可以再行动一次"];
        //重置消息
        RubyTriggeredPassive =false;
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        PlayerCardPosition =2;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[1]];
        //设置可攻击范围
        if (AIField1==false||AIField2==false||AIField3==false) {
            //可以攻击的目标
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            //敌方近战单位存在,不允许攻击其它单位
            _AIbutton4.enabled =NO;
            _AIbutton5.enabled =NO;
            _AIbutton6.enabled =NO;
            _AIbutton7.enabled =NO;
            //AI人物也不能攻击
            _AIPersonButton.enabled =NO;
            //提示
            _PromptInformation.text =[NSString stringWithFormat:@"敌方近战单位还存在，只能攻击敌方敌方近战单位"];
        }
        if (AIField1==false&&AIField2==false&&AIField3==false) {
            _PromptInformation.text =[NSString stringWithFormat:@"随意开火，有基佬开我裤链......好像走错片场了"];
            //显示可以攻击的目标
            [self AIcardCanClick];
        }
         ClickPlayerCard=true;
    }else{
        PlayerCardPosition =2;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[1]];
        //设置可攻击范围
        if (AIField1==false||AIField2==false||AIField3==false) {
            //可以攻击的目标
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            //敌方近战单位存在,不允许攻击其它单位
            _AIbutton4.enabled =NO;
            _AIbutton5.enabled =NO;
            _AIbutton6.enabled =NO;
            _AIbutton7.enabled =NO;
            //AI人物也不能攻击
            _AIPersonButton.enabled =NO;
            //提示
            _PromptInformation.text =[NSString stringWithFormat:@"敌方近战单位还存在，只能攻击敌方敌方近战单位"];
        }
        if (AIField1==false&&AIField2==false&&AIField3==false) {
            _PromptInformation.text =[NSString stringWithFormat:@"随意开火，有基佬开我裤链......好像走错片场了"];
            //显示可以攻击的目标
            [self AIcardCanClick];
        }
    }
    //点击了卡牌
    ClickPlayerCard =true;
    //更新玩家数据
    [self updataPlayerData];
}
- (IBAction)Dbutton3:(id)sender {
    if (AthenaBackBlood) {
        _FightingInformation.text =[NSString stringWithFormat:@"雅典娜回复卡牌3 3点生命值"];
        //调用回血动作
        [MPC AthenaBackBlood:3];
        //将全体换回到不可点击状态
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        //重置回血状态
        AthenaBackBlood =false;
    }else if (RubyTriggeredPassive) {
        _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，卡牌3可以再行动一次"];
        //重置消息
        RubyTriggeredPassive =false;
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        PlayerCardPosition =3;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[2]];
        //设置可攻击范围
        if (AIField1==true||AIField2==true||AIField3==true) {
            //可以攻击的目标
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            //敌方近战单位存在,不允许攻击其它单位
            _AIbutton4.enabled =NO;
            _AIbutton5.enabled =NO;
            _AIbutton6.enabled =NO;
            _AIbutton7.enabled =NO;
            //AI人物也不能攻击
            _AIPersonButton.hidden =NO;
            //提示
            _PromptInformation.text =[NSString stringWithFormat:@"敌方近战单位还存在，只能攻击敌方敌方近战单位"];
        }
        if (AIField1==false&&AIField2==false&&AIField3==false) {
            _PromptInformation.text =[NSString stringWithFormat:@"随意开火，有基佬开我裤链......好像走错片场了"];
            //显示可以攻击的目标
            [self AIcardCanClick];
        }
         ClickPlayerCard=true;
    }else{
        PlayerCardPosition =3;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[2]];
        //设置可攻击范围
        if (AIField1==true||AIField2==true||AIField3==true) {
            //可以攻击的目标
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            //敌方近战单位存在,不允许攻击其它单位
            _AIbutton4.enabled =NO;
            _AIbutton5.enabled =NO;
            _AIbutton6.enabled =NO;
            _AIbutton7.enabled =NO;
            //AI人物也不能攻击
            _AIPersonButton.hidden =NO;
            //提示
            _PromptInformation.text =[NSString stringWithFormat:@"敌方近战单位还存在，只能攻击敌方敌方近战单位"];
        }
        if (AIField1==false&&AIField2==false&&AIField3==false) {
            _PromptInformation.text =[NSString stringWithFormat:@"随意开火，有基佬开我裤链......好像走错片场了"];
            //显示可以攻击的目标
            [self AIcardCanClick];
        }
    }
    //点击了卡牌
    ClickPlayerCard =true;
    //更新数据
    [self updataPlayerData];
}
- (IBAction)Dbutton4:(id)sender {
    [self NEPAttackAction];
    if (AthenaBackBlood) {
        _FightingInformation.text =[NSString stringWithFormat:@"雅典娜回复卡牌4 3点生命值"];
        //调用回血动作
        [MPC AthenaBackBlood:2];
        //将全体换回到不可点击状态
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        //重置回血状态
        AthenaBackBlood =false;
        }else if (RubyTriggeredPassive) {
        _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，卡牌4可以再行动一次"];
        //重置消息
        RubyTriggeredPassive =false;
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
            PlayerCardPosition =4;
            [MPC sendTheCurrentCardPosition:PlayerCardPosition];
            _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
            //播放攻击者的音效
            [self AttackSoundEffectsPlay:AttackSoundPlayArray[3]];
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            _AIbutton4.enabled =YES;
            _AIbutton5.enabled =YES;
            _AIbutton6.enabled =YES;
            _AIbutton7.enabled =YES;
            _AIPersonButton.enabled =YES;
            //点击了卡牌
            ClickPlayerCard =true;
        }else{
            PlayerCardPosition =4;
            [MPC sendTheCurrentCardPosition:PlayerCardPosition];
            _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
            //播放攻击者的音效
            [self AttackSoundEffectsPlay:AttackSoundPlayArray[3]];
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            _AIbutton4.enabled =YES;
            _AIbutton5.enabled =YES;
            _AIbutton6.enabled =YES;
            _AIbutton7.enabled =YES;
            _AIPersonButton.enabled =YES;
            //点击了卡牌
            ClickPlayerCard =true;
        }
    //更新玩家数据
    [self updataPlayerData];
}
- (IBAction)Dbutton5:(id)sender {
    if ([MPC ReturnCardPassiveIDMessage:4]==15) {
        AthenaBackBlood=true;
    }
    if (AthenaBackBlood) {
        _FightingInformation.text =[NSString stringWithFormat:@"雅典娜回复卡牌5 3点生命值"];
        //调用回血动作
        [MPC AthenaBackBlood:5];
        //将全体换回到不可点击状态
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        //重置回血状态
        AthenaBackBlood =false;
    }else if (RubyTriggeredPassive) {
        _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，卡牌5可以再行动一次"];
        //重置消息
        RubyTriggeredPassive =false;
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        PlayerCardPosition =5;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[4]];
        
        _AIbutton1.enabled =YES;
        _AIbutton2.enabled =YES;
        _AIbutton3.enabled =YES;
        _AIbutton4.enabled =YES;
        _AIbutton5.enabled =YES;
        _AIbutton6.enabled =YES;
        _AIbutton7.enabled =YES;
        _AIPersonButton.enabled =YES;
        //点击了卡牌
        ClickPlayerCard =true;
    }else{
        PlayerCardPosition =5;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[4]];
        
        _AIbutton1.enabled =YES;
        _AIbutton2.enabled =YES;
        _AIbutton3.enabled =YES;
        _AIbutton4.enabled =YES;
        _AIbutton5.enabled =YES;
        _AIbutton6.enabled =YES;
        _AIbutton7.enabled =YES;
        _AIPersonButton.enabled =YES;
        //点击了卡牌
        ClickPlayerCard =true;
    }
    //更新玩家数据
    [self updataPlayerData];
}
- (IBAction)Dbutton6:(id)sender {
    if ([MPC ReturnCardPassiveIDMessage:5]==15) {
        AthenaBackBlood=true;
    }
    if (AthenaBackBlood) {
        _FightingInformation.text =[NSString stringWithFormat:@"雅典娜回复卡牌6 3点生命值"];
        //调用回血动作
        [MPC AthenaBackBlood:6];
        //将全体换回到不可点击状态
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        //重置回血状态
        AthenaBackBlood =false;
    }else if (RubyTriggeredPassive) {
        _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，卡牌6可以再行动一次"];
        //重置消息
        RubyTriggeredPassive =false;
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        PlayerCardPosition =6;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[5]];
        //显示可以攻击的目标
        _AIbutton1.enabled =YES;
        _AIbutton2.enabled =YES;
        _AIbutton3.enabled =YES;
        _AIbutton4.enabled =YES;
        _AIbutton5.enabled =YES;
        _AIbutton6.enabled =YES;
        _AIbutton7.enabled =YES;
        _AIPersonButton.enabled =YES;
        //点击了卡牌
        ClickPlayerCard =true;
    }else{
        PlayerCardPosition =6;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[5]];
        //显示可以攻击的目标
        _AIbutton1.enabled =YES;
        _AIbutton2.enabled =YES;
        _AIbutton3.enabled =YES;
        _AIbutton4.enabled =YES;
        _AIbutton5.enabled =YES;
        _AIbutton6.enabled =YES;
        _AIbutton7.enabled =YES;
        _AIPersonButton.enabled =YES;
        //点击了卡牌
        ClickPlayerCard =true;
    }
   //更新玩家数据
    [self updataPlayerData];
}
- (IBAction)Dbutton7:(id)sender {
    if (AthenaBackBlood) {
        _FightingInformation.text =[NSString stringWithFormat:@"雅典娜回复卡牌7 3点生命值"];
        //调用回血动作
        [MPC AthenaBackBlood:7];
        //将全体换回到不可点击状态
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
    }else if (RubyTriggeredPassive) {
        _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，卡牌7可以再行动一次"];
        //重置消息
        RubyTriggeredPassive =false;
        _Dbutton1.enabled =NO;
        _Dbutton2.enabled =NO;
        _Dbutton3.enabled =NO;
        _Dbutton4.enabled =NO;
        _Dbutton5.enabled =NO;
        _Dbutton6.enabled =NO;
        _Dbutton7.enabled =NO;
        
        PlayerCardPosition =7;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[6]];
        _AIbutton1.enabled =YES;
        _AIbutton2.enabled =YES;
        _AIbutton3.enabled =YES;
        _AIbutton4.enabled =YES;
        _AIbutton5.enabled =YES;
        _AIbutton6.enabled =YES;
        _AIbutton7.enabled =YES;
        //点击了卡牌
        ClickPlayerCard =true;
    }else{
        PlayerCardPosition =7;
        [MPC sendTheCurrentCardPosition:PlayerCardPosition];
        _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
        //播放攻击者的音效
        [self AttackSoundEffectsPlay:AttackSoundPlayArray[6]];
        _AIbutton1.enabled =YES;
        _AIbutton2.enabled =YES;
        _AIbutton3.enabled =YES;
        _AIbutton4.enabled =YES;
        _AIbutton5.enabled =YES;
        _AIbutton6.enabled =YES;
        _AIbutton7.enabled =YES;
        //点击了卡牌
        ClickPlayerCard =true;
    }
   //更新玩家数据
    [self updataPlayerData];
}
//音效播放（攻击）
-(void)AttackSoundEffectsPlay:(int)Sound
{
    switch (Sound) {
        case -1:
            //没音效
            break;
        case 0: //214
            [[MusicController defaultManager]playingMusic:@"214Attack.mp3"];
            break;
        case 1://黑
            [[MusicController defaultManager]playingMusic:@"BlakeAttack.mp3"];
            break;
        case 2://剑心
            [[MusicController defaultManager]playingMusic:@"KenshinAttack.mp3"];
            break;
        case 3://NEP
            [[MusicController defaultManager]playingMusic:@"NEPAttack.mp3"];
            break;
        case 4://桐人
            [[MusicController defaultManager]playingMusic:@"KazongAttack.mp3"];
            break;
        case 5://妖梦
            [[MusicController defaultManager]playingMusic:@"DemonAttack.mp3"];
            break;
        case 6://亚丝娜
            [[MusicController defaultManager]playingMusic:@"YasinaAttack.mp3"];
            break;
        case 8://尼禄
            [[MusicController defaultManager]playingMusic:@"NeroAttack.mp3"];
            break;
        case 9://萨菲罗斯
            [[MusicController defaultManager]playingMusic:@"SafirusAttack.mp3"];
            break;
        case 11://黑岩
            [[MusicController defaultManager]playingMusic:@"RockAttack.mp3"];
            break;
        case 12://诗乃
            [[MusicController defaultManager]playingMusic:@"ShinoAttack.mp3"];
            break;
        case 15://雅典娜
            [[MusicController defaultManager]playingMusic:@"AthenaAttack.mp3"];
            break;
        default:
            break;
    }
}
//音效播放（死亡）
-(void)DeathSoundPlay:(int)Sound
{
    NSLog(@"调用了死亡音效播放");
    switch (Sound) {
        case -1:
            //没音效
            break;
        case 0: //214
            [[MusicController defaultManager]playingMusic:@"214Death.mp3"];
            break;
        case 1://黑
            [[MusicController defaultManager]playingMusic:@"BlackDeath.mp3"];
            break;
        case 2://剑心
            [[MusicController defaultManager]playingMusic:@"KenShinDeath.mp3"];
            break;
        case 3://NEP
            [[MusicController defaultManager]playingMusic:@"NEPDeath.mp3"];
            break;
        case 4://桐人
            [[MusicController defaultManager]playingMusic:@"KazongDeath.mp3"];
            break;
        case 5://妖梦
            [[MusicController defaultManager]playingMusic:@"DemonDeath.mp3"];
            break;
        case 6://亚丝娜
            [[MusicController defaultManager]playingMusic:@"YasinaDeath.mp3"];
            break;
        case 8://尼禄
            [[MusicController defaultManager]playingMusic:@"NeroDeath.mp3"];
            break;
        case 9://萨菲罗斯
            [[MusicController defaultManager]playingMusic:@"SafirusDeath.mp3"];
            break;
        case 11://黑岩
            [[MusicController defaultManager]playingMusic:@"RockDeath.mp3"];
            break;
        case 12://诗乃
            [[MusicController defaultManager]playingMusic:@"ShinoDeath.mp3"];
            break;
        case 15://雅典娜
            [[MusicController defaultManager]playingMusic:@"AthenaDeath.mp3"];
            break;
        default:
            break;
    }
}
//使攻击者进入不可点击状态
-(void)AttackerCanNotClick:(int)Click{
    //使攻击者进入不可点击状态
    switch (Click) {
        case 1:
            //卡牌1对AI1进行了攻击
            _Dbutton1.enabled =NO;
            break;
        case 2:
            _Dbutton2.enabled =NO;
            break;
        case 3:
            _Dbutton3.enabled =NO;
            break;
        case 4:
            if (NEPAttackAction) {
                _Dbutton4.enabled =YES;
            }else{
                _Dbutton4.enabled =NO;
            }
            break;
        case 5:
            _Dbutton5.enabled =NO;
            break;
        case 6:
            _Dbutton6.enabled =NO;
            break;
        case 7:
            _Dbutton7.enabled =NO;
            break;
        default:
            break;
    }
}
/*
 玩家的异常状态处理和AI的异常处理
 */
-(void)PlayerExceptionStatus:(int)Position{
    //改进判断
    switch (Position) {
        case 1://位置1
            if ([MPC FeedbackDizzyNews]) {//玩家卡牌1受到眩晕
                _StatusReminder1.image =[UIImage imageNamed:@"眩晕.png"];
                //玩家进入异常状态
                PlayerCard1Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//玩家卡牌1受到麻痹
                _StatusReminder1.image =[UIImage imageNamed:@"麻痹.png"];
                //玩家进入异常状态
                PlayerCard1Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//玩家卡牌1受到冻结
                _StatusReminder1.image =[UIImage imageNamed:@"冻结.png"];
                //玩家进入异常状态
                PlayerCard1Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//玩家卡牌1受到减速
                _StatusReminder1.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 2:
            if ([MPC FeedbackDizzyNews]) {//玩家卡牌2受到眩晕
                _StatusReminder2.image =[UIImage imageNamed:@"眩晕.png"];
                //玩家进入异常状态
                PlayerCard2Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//玩家卡牌2受到麻痹
                _StatusReminder2.image =[UIImage imageNamed:@"麻痹.png"];
                //玩家进入异常状态
                PlayerCard2Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//玩家卡牌2受到冻结
                _StatusReminder2.image =[UIImage imageNamed:@"冻结.png"];
                //玩家进入异常状态
                PlayerCard2Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//玩家卡牌2受到减速
                _StatusReminder2.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 3:
            if ([MPC FeedbackDizzyNews]) {//玩家卡牌3受到眩晕
                _StatusReminder3.image =[UIImage imageNamed:@"眩晕.png"];
                //玩家进入异常状态
                PlayerCard3Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//玩家卡牌3受到麻痹
                _StatusReminder3.image =[UIImage imageNamed:@"麻痹.png"];
                //玩家进入异常状态
                PlayerCard3Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//玩家卡牌3受到冻结
                _StatusReminder3.image =[UIImage imageNamed:@"冻结.png"];
                //玩家进入异常状态
                PlayerCard3Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//玩家卡牌3受到减速
                _StatusReminder3.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 4:
            if ([MPC FeedbackDizzyNews]) {//玩家卡牌4受到眩晕
                _StatusReminder4.image =[UIImage imageNamed:@"眩晕.png"];
                //玩家进入异常状态
                PlayerCard4Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//玩家卡牌4受到麻痹
                _StatusReminder4.image =[UIImage imageNamed:@"麻痹.png"];
                //玩家进入异常状态
                PlayerCard4Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//玩家卡牌4受到冻结
                _StatusReminder4.image =[UIImage imageNamed:@"冻结.png"];
                //玩家进入异常状态
                PlayerCard4Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//玩家卡牌4受到减速
                _StatusReminder4.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 5:
            if ([MPC FeedbackDizzyNews]) {//玩家卡牌5受到眩晕
                _StatusReminder5.image =[UIImage imageNamed:@"眩晕.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//玩家卡牌5受到麻痹
                _StatusReminder5.image =[UIImage imageNamed:@"麻痹.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//玩家卡牌1受到冻结
                _StatusReminder5.image =[UIImage imageNamed:@"冻结.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//玩家卡牌1受到减速
                _StatusReminder5.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 6:
            if ([MPC FeedbackDizzyNews]) {//玩家卡牌1受到眩晕
                _StatusReminder6.image =[UIImage imageNamed:@"眩晕.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//玩家卡牌1受到麻痹
                _StatusReminder6.image =[UIImage imageNamed:@"麻痹.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//玩家卡牌1受到冻结
                _StatusReminder6.image =[UIImage imageNamed:@"冻结.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//玩家卡牌1受到减速
                _StatusReminder6.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 7:
            if ([MPC FeedbackDizzyNews]) {//玩家卡牌7受到眩晕
                _StatusReminder7.image =[UIImage imageNamed:@"眩晕.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//玩家卡牌7受到麻痹
                _StatusReminder7.image =[UIImage imageNamed:@"麻痹.png"];
                //玩家进入异常状态
                PlayerCard5Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//玩家卡牌7受到冻结
                _StatusReminder7.image =[UIImage imageNamed:@"冻结.png"];
                //玩家进入异常状态
                PlayerCard7Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//玩家卡牌7受到减速
                _StatusReminder7.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 8://AI卡牌位置5黑岩蓝羽化
            if ([MPC FeedbackBlueFeatherNews]) {
                _AIStatusReminder5.image =[UIImage imageNamed:@"蓝羽化.png"];
            }
            break;
        case 9://AI卡牌位置6黑岩蓝羽化
            if ([MPC FeedbackBlueFeatherNews]) {
                _AIStatusReminder6.image =[UIImage imageNamed:@"蓝羽化.png"];
            }
            break;
        case 10://AI人物
            if ([MPC FeedbackDizzyNews]) {//AI人物受到眩晕
                _AIPersonStatus.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AIPersonAbnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI人物受到麻痹
                _AIPersonStatus.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AIPersonAbnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI人物受到冻结
                _AIPersonStatus.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AIPersonAbnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI人物受到减速
                _AIPersonStatus.image =[UIImage imageNamed:@"减速.png"];
            }
        default:
            break;
    }
}
-(void)AIExceptionStatus:(int)Position{
    //改进判断
    switch (Position) {
        case 1://位置1
            if ([MPC FeedbackDizzyNews]) {//AI卡牌1受到眩晕
                _AIStatusReminder1.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AICard1Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI卡牌1受到麻痹
                _AIStatusReminder1.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AICard1Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI卡牌1受到冻结
                _AIStatusReminder1.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AICard1Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI卡牌1受到减速
                _AIStatusReminder1.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 2:
            if ([MPC FeedbackDizzyNews]) {//AI卡牌2受到眩晕
                _AIStatusReminder2.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AICard2Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI卡牌2受到麻痹
                _AIStatusReminder2.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AICard2Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI卡牌2受到冻结
                _AIStatusReminder2.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AICard2Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI卡牌2受到减速
                _AIStatusReminder2.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 3:
            if ([MPC FeedbackDizzyNews]) {//AI卡牌3受到眩晕
                _AIStatusReminder3.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AICard3Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI卡牌3受到麻痹
                _AIStatusReminder3.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AICard3Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI卡牌3受到冻结
                _AIStatusReminder3.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AICard3Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI卡牌3受到减速
                _AIStatusReminder3.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 4:
            if ([MPC FeedbackDizzyNews]) {//AI卡牌4受到眩晕
                _AIStatusReminder4.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AICard4Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI卡牌4受到麻痹
                _AIStatusReminder4.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AICard4Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI卡牌4受到冻结
                _AIStatusReminder4.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AICard4Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI卡牌4受到减速
                _AIStatusReminder4.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 5:
            if ([MPC FeedbackDizzyNews]) {//AI卡牌5受到眩晕
                _AIStatusReminder5.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AICard5Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI卡牌5受到麻痹
                _AIStatusReminder5.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AICard5Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI卡牌1受到冻结
                _AIStatusReminder5.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AICard5Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI卡牌1受到减速
                _AIStatusReminder5.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 6:
            if ([MPC FeedbackDizzyNews]) {//AI卡牌1受到眩晕
                _AIStatusReminder6.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AICard6Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI卡牌1受到麻痹
                _AIStatusReminder6.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AICard6Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI卡牌1受到冻结
                _AIStatusReminder6.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AICard6Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI卡牌1受到减速
                _AIStatusReminder6.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 7:
            if ([MPC FeedbackDizzyNews]) {//AI卡牌7受到眩晕
                _AIStatusReminder7.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AICard7Abnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI卡牌7受到麻痹
                _AIStatusReminder7.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AICard7Abnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI卡牌7受到冻结
                _AIStatusReminder7.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AICard1Abnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI卡牌7受到减速
                _AIStatusReminder7.image =[UIImage imageNamed:@"减速.png"];
            }
            break;
        case 8://玩家卡牌位置5黑岩蓝羽化
            if ([MPC FeedbackBlueFeatherNews]) {
                _StatusReminder5.image =[UIImage imageNamed:@"蓝羽化.png"];
            }
            break;
        case 9://玩家卡牌位置6黑岩蓝羽化
            if ([MPC FeedbackBlueFeatherNews]) {
                _StatusReminder6.image =[UIImage imageNamed:@"蓝羽化.png"];
            }
            break;
        case 10://AI人物
            if ([MPC FeedbackDizzyNews]) {//AI人物受到眩晕
                _AIPersonStatus.image =[UIImage imageNamed:@"眩晕.png"];
                //AI进入异常状态
                AIPersonAbnormal=true;
            }else if ([MPC FeedbackParalysisNews]){//AI人物受到麻痹
                _AIPersonStatus.image =[UIImage imageNamed:@"麻痹.png"];
                //AI进入异常状态
                AIPersonAbnormal=true;
            }else if ([MPC FeedbackFreezeNews]){//AI人物受到冻结
                _AIPersonStatus.image =[UIImage imageNamed:@"冻结.png"];
                //AI进入异常状态
                AIPersonAbnormal=true;
            }else if ([MPC FeedbackSlowdownNews]){//AI人物受到减速
                _AIPersonStatus.image =[UIImage imageNamed:@"减速.png"];
            }
        default:
            break;
    }
}
- (IBAction)AIbutton1:(id)sender {
    //发送AI卡牌被点击事件
    [MPC AICardIsClickedAction];
    //AI卡牌位置信息
    AIPosition =1;
    if (ClickPlayerCard) {//玩家卡牌攻击AI卡牌
        _PromptInformation.text=[NSString stringWithFormat:@"你攻击了AI的位置1"];
        [MPC sendTheCUrrentlyAttackedCardPosition:AIPosition];
        //更新被攻击者的生命值
        _AIbutton1Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:0]];
        //显示战斗信息
        int temp =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"你的攻击造成%d点伤害.",temp];
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //异常判断
        [self AIExceptionStatus:1];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //调用死亡判断
        [self DeathJugement:0];
        //判断AI卡牌的异常状态
        [self AIExceptionStatus:1];
    }else if (ClickPlayerPerson){//玩家攻击AI卡牌
        NSLog(@"使用了这个条件判定");
        //发送当前位置
        [MPC moveToTheSpecifiedLocation:AIPosition];
        //发送要调用何种动作
        [MPC ReceiveDecisionEvent:2];
        //更新AI数据//先更新数据，再输出
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //进攻型被动的判定
        [self PlayerAttackPassvieTriggered];
        //文字输出玩家的被动是否生效
        [self PlayerPassivelyEffective];
        //调用死亡判断
        [self DeathJugement:0];
        //解锁下一回合点击事件
        _NextButton.enabled =YES;
    }else{
        //没有攻击目标,让卡牌不能被点击
        _AIbutton1.hidden =YES;
        //输出提示消息
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择攻击者！"];
    }
    //重置消息
    ClickPlayerCard =false;
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //使AI卡牌进入不可点击状态
    [self AIClockButton];
}
- (IBAction)AIbutton2:(id)sender {
    //发送AI卡牌被点击事件
    [MPC AICardIsClickedAction];
    //AI卡牌位置信息
    AIPosition =2;
    if (ClickPlayerCard) {//玩家卡牌攻击AI卡牌
        _PromptInformation.text =[NSString stringWithFormat:@"你攻击了AI的位置2"];
        [MPC sendTheCUrrentlyAttackedCardPosition:AIPosition];
        //更新被攻击者的生命值
        _AIbutton2Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:1]];
        //显示战斗信息
        int temp =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"你的攻击造成%d点伤害.",temp];
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //异常判断
        [self AIExceptionStatus:2];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //调用死亡判断
        [self DeathJugement:1];
        //判断AI卡牌的异常状态
        [self AIExceptionStatus:2];
    }else if (ClickPlayerPerson){
        //发送当前位置
        [MPC moveToTheSpecifiedLocation:AIPosition];
        //发送要调用何种动作
        [MPC ReceiveDecisionEvent:2];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //进攻型被动的判定
        [self PlayerAttackPassvieTriggered];
        //调用死亡判断
        [self DeathJugement:1];
        //人物被动输出
        [self PlayerPassivelyEffective];
        //解锁下一回合点击事件
        _NextButton.enabled =YES;
    }else{
        //没有攻击目标,让卡牌不能被点击
        _AIbutton2.hidden =YES;
        //输出提示消息
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择攻击者！"];
    }
    //重置消息
    ClickPlayerCard =false;
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //使AI卡牌进入不可点击状态
    [self AIClockButton];
}
- (IBAction)AIbutton3:(id)sender {
    //发送AI卡牌被点击事件
    [MPC AICardIsClickedAction];
    //AI卡牌位置信息
    AIPosition =3;
    if (ClickPlayerCard) {
        _PromptInformation.text =[NSString stringWithFormat:@"你攻击了AI的位置3"];
        [MPC sendTheCUrrentlyAttackedCardPosition:AIPosition];
        //更新被攻击者的生命值
        _AIbutton3Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:2]];
        //显示战斗信息
        int temp =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"你的攻击造成%d点伤害.",temp];
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //异常判断
        [self AIExceptionStatus:3];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //调用死亡判断
        [self DeathJugement:2];
        //判断AI卡牌的异常状态
        [self AIExceptionStatus:3];
    }else if (ClickPlayerPerson){
        //发送当前位置
        [MPC moveToTheSpecifiedLocation:AIPosition];
        //发送要调用何种动作
        [MPC ReceiveDecisionEvent:2];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //进攻型被动的判定
        [self PlayerAttackPassvieTriggered];
        //调用死亡判断
        [self DeathJugement:2];
        //人物被动输出
        [self PlayerPassivelyEffective];
        //解锁下一回合点击事件
        _NextButton.enabled =YES;
    }else{
        //没有攻击目标,让卡牌不能被点击
        _AIbutton3.hidden =YES;
        //输出提示消息
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择攻击者！"];
    }
    //重置消息
    ClickPlayerCard =false;
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //使AI卡牌进入不可点击状态
    [self AIClockButton];
}
- (IBAction)AIbutton4:(id)sender {
    //发送AI卡牌被点击事件
    [MPC AICardIsClickedAction];
    //AI卡牌位置信息
    AIPosition =4;
    if (ClickPlayerCard) {
        _PromptInformation.text =[NSString stringWithFormat:@"你攻击了AI的位置4"];
        [MPC sendTheCUrrentlyAttackedCardPosition:AIPosition];
        //更新被攻击者的生命值
        _AIbutton4Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:3]];
        //显示战斗信息
        int temp =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"你的攻击造成%d点伤害.",temp];
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //异常判断
        [self AIExceptionStatus:4];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //进攻型被动的判定
        [self PlayerAttackPassvieTriggered];
        //调用死亡判断
        [self DeathJugement:3];
        //判断AI卡牌的异常状态
        [self AIExceptionStatus:4];
    }else if(ClickPlayerPerson){
        //发送当前位置
        [MPC moveToTheSpecifiedLocation:AIPosition];
        //发送要调用何种动作
        [MPC ReceiveDecisionEvent:2];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //调用死亡判断
        [self DeathJugement:3];
        //人物被动输出
        [self PlayerPassivelyEffective];
        //解锁下一回合点击事件
        _NextButton.enabled =YES;
    }else{
        //没有攻击目标,让卡牌不能被点击
        _AIbutton4.hidden =YES;
        //输出提示消息
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择攻击者！"];
    }
    //重置消息
    ClickPlayerCard =false;
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //使AI卡牌进入不可点击状态
    [self AIClockButton];
}
- (IBAction)AIbutton5:(id)sender {
    //发送AI卡牌被点击事件
    [MPC AICardIsClickedAction];
    //AI卡牌位置信息
    AIPosition =5;
    if (ClickPlayerCard) {
        _PromptInformation.text =[NSString stringWithFormat:@"你攻击了AI的位置5"];
        [MPC sendTheCUrrentlyAttackedCardPosition:AIPosition];
        //更新被攻击者的生命值
        _AIbutton5Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:4]];
        //显示战斗信息
        int temp =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"你的攻击造成%d点伤害.",temp];
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //异常判断
        [self AIExceptionStatus:4];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //进攻型被动的判定
        [self PlayerAttackPassvieTriggered];
        //调用死亡判断
        [self DeathJugement:4];
        //判断AI卡牌的异常状态
        [self AIExceptionStatus:5];
        [self AIExceptionStatus:8];
    }else if (ClickPlayerPerson){
        //发送当前位置
        [MPC moveToTheSpecifiedLocation:AIPosition];
        //发送要调用何种动作
        [MPC ReceiveDecisionEvent:2];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //调用死亡判断
        [self DeathJugement:4];
        //人物被动输出
        [self PlayerPassivelyEffective];
        //解锁下一回合点击事件
        _NextButton.enabled =YES;
    }else{
        //没有攻击目标,让卡牌不能被点击
        _AIbutton5.hidden =YES;
        //输出提示消息
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择攻击者！"];
    }
    //重置消息
    ClickPlayerCard =false;
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //使AI卡牌进入不可点击状态
    [self AIClockButton];
}
- (IBAction)AIbutton6:(id)sender {
    //发送AI卡牌被点击事件
    [MPC AICardIsClickedAction];
    //AI卡牌位置信息
    AIPosition =6;
    if (ClickPlayerCard) {
        _PromptInformation.text =[NSString stringWithFormat:@"你攻击了AI的位置6"];
        [MPC sendTheCUrrentlyAttackedCardPosition:AIPosition];
        //更新被攻击者的生命值
        _AIbutton6Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:5]];
        //显示战斗信息
        int temp =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"你的攻击造成%d点伤害.",temp];
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //异常判断
        [self AIExceptionStatus:6];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //进攻型被动的判定
        [self PlayerAttackPassvieTriggered];
        //调用死亡判断
        [self DeathJugement:5];
        //判断AI卡牌的异常状态
        [self AIExceptionStatus:6];
        [self AIExceptionStatus:9];
    }else if (ClickPlayerPerson){
        //发送当前位置
        [MPC moveToTheSpecifiedLocation:AIPosition];
        //发送要调用何种动作
        [MPC ReceiveDecisionEvent:2];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //调用死亡判断
        [self DeathJugement:5];
        //人物被动输出
        [self PlayerPassivelyEffective];
        //解锁下一回合点击事件
        _NextButton.enabled =YES;
    }else{
        //没有攻击目标,让卡牌不能被点击
        _AIbutton6.hidden =YES;
        //输出提示消息
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择攻击者！"];
    }
    //重置消息
    ClickPlayerCard =false;
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //使AI卡牌进入不可点击状态
    [self AIClockButton];
}
- (IBAction)AIbutton7:(id)sender {
    //发送AI卡牌被点击事件
    [MPC AICardIsClickedAction];
    //AI卡牌位置信息
    AIPosition =7;
    if (ClickPlayerCard) {
        _PromptInformation.text =[NSString stringWithFormat:@"你攻击了AI的位置7"];
        [MPC sendTheCUrrentlyAttackedCardPosition:AIPosition];
        //更新被攻击者的生命值
        _AIbutton7Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:6]];
        //显示战斗信息
        int temp =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"你的攻击造成%d点伤害.",temp];
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //异常判断
        [self AIExceptionStatus:7];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //调用死亡判断
        [self DeathJugement:6];
        //判断AI卡牌的异常状态
        [self AIExceptionStatus:7];
    }else if (ClickPlayerPerson){
        //发送当前位置
        [MPC moveToTheSpecifiedLocation:AIPosition];
        //发送要调用何种动作
        [MPC ReceiveDecisionEvent:2];
        //更新AI数据
        [self UpdataAIData];
        //更新玩家数据
        [self updataPlayerData];
        //进攻型被动的判定
        [self PlayerAttackPassvieTriggered];
        //调用死亡判断
        [self DeathJugement:6];
        //人物被动输出
        [self PlayerPassivelyEffective];
        //解锁下一回合点击事件
        _NextButton.enabled =YES;
    }else{
        //没有攻击目标,让卡牌不能被点击
        _AIbutton7.hidden =YES;
        //输出提示消息
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择攻击者！"];
    }
    //重置消息
    ClickPlayerCard =false;
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //使AI卡牌进入不可点击状态
    [self AIClockButton];
}
//死亡判断
-(void)DeathJugement:(int)Jugement{
    int onJury =[MPC ReturnTheDamegeCaused];
    switch (Jugement) {
        case 0:
            //如果被攻击者的生命值小于或等于0，移除当前图片
            if ([MPC receiveAICardLifeMessage:0]<=0) {
                [_AIbutton1 setBackgroundImage:NULL forState:UIControlStateNormal];
                _AIbutton1Attack.text =[NSString stringWithFormat:@"0"];
                _AIbutton1Life.text =[NSString stringWithFormat:@"0"];
                //重置AI场上卡牌的存在
                AIField1 =false;
                _PromptInformation.text=[NSString stringWithFormat:@"你击杀了目标"];
                _FightingInformation.text =[NSString stringWithFormat:@"你造成了%d的伤害",onJury];
                //调用相应死亡音效<测试 17.5.21>(成功)
                [self DeathSoundPlay:DeathSoundPlayArray[0]];
                //AI场上的牌减少
                HowManyCardsInAI--;
                //按钮不可点击
                _AIbutton1.hidden =YES;
                if (AIAthenaPassive) {//雅典娜被动存在
                    //获取死亡的是谁并重新创建对应卡牌
                    [self creatAPictureOfAIOneFiled:[MPC receiveAICardPassiveIDMessage:0]];
                    //重置雅典娜被动
                    AIAthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 1:
            if ([MPC receiveAICardLifeMessage:1]<=0) {
                [_AIbutton2 setBackgroundImage:NULL forState:UIControlStateNormal];
                _AIbutton2Attack.text =[NSString stringWithFormat:@"0"];
                _AIbutton2Life.text =[NSString stringWithFormat:@"0"];
                //重置AI场上卡牌的存在
                AIField2 =false;
                _FightingInformation.text =[NSString stringWithFormat:@"你击造成了%d的伤害",onJury];
                //调用相应死亡音效<测试 17.5.21>(成功)
                [self DeathSoundPlay:DeathSoundPlayArray[1]];
                //按钮不可点击
                _AIbutton2.hidden =YES;
                //AI场上的牌减少
                HowManyCardsInAI--;
                if (AIAthenaPassive) {//雅典娜被动存在
                    //获取死亡的是谁并重新创建对应卡牌
                    [self creatAPictureOfAITwoFiled:[MPC receiveAICardPassiveIDMessage:1]];
                    //重置雅典娜被动
                    AIAthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 2:
            if ([MPC receiveAICardLifeMessage:2]<=0) {
                [_AIbutton3 setBackgroundImage:NULL forState:UIControlStateNormal];
                _AIbutton3Attack.text =[NSString stringWithFormat:@"0"];
                _AIbutton3Life.text =[NSString stringWithFormat:@"0"];
                //重置AI场上卡牌的存在
                AIField3 =false;
                _FightingInformation.text =[NSString stringWithFormat:@"你造成了%d的伤害",onJury];
                //调用相应死亡音效<测试 17.5.21>(成功)
                [self DeathSoundPlay:DeathSoundPlayArray[2]];
                //按钮不可点击
                _AIbutton3.hidden =YES;
                //AI场上的牌减少
                HowManyCardsInAI--;
                if (AIAthenaPassive) {//雅典娜被动存在
                    //获取死亡的是谁并重新创建对应卡牌
                    [self creatAPictureOfAIThreeFiled:[MPC receiveAICardPassiveIDMessage:2]];
                    //重置雅典娜被动
                    AIAthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 3:
            if ([MPC receiveAICardLifeMessage:3]<=0) {
                [_AIbutton4 setBackgroundImage:NULL forState:UIControlStateNormal];
                _AIbutton4Attack.text =[NSString stringWithFormat:@"0"];
                _AIbutton4Life.text =[NSString stringWithFormat:@"0"];
                //重置AI场上卡牌的存在
                AIField4 =false;
                _FightingInformation.text =[NSString stringWithFormat:@"你造成了%d的伤害",onJury];
                //调用相应死亡音效<测试 17.5.21>(成功)
                NSLog(@"死亡编号的代码是：%d",DeathSoundPlayArray[3]);
                [self DeathSoundPlay:DeathSoundPlayArray[3]];
                //按钮不可点击
                _AIbutton4.hidden =YES;
                //AI场上的牌减少
                HowManyCardsInAI--;
                if (AIAthenaPassive) {//雅典娜被动存在
                    //获取死亡的是谁并重新创建对应卡牌
                    [self creatAPictureOfAIFourFiled:[MPC receiveAICardPassiveIDMessage:3]];
                    //重置雅典娜被动
                    AIAthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 4:
            if ([MPC receiveAICardLifeMessage:4]<=0) {
                [_AIbutton5 setBackgroundImage:NULL forState:UIControlStateNormal];
                _AIbutton5Attack.text =[NSString stringWithFormat:@"0"];
                _AIbutton5Life.text =[NSString stringWithFormat:@"0"];
                //重置AI场上卡牌的存在
                AIField5 =false;
                _FightingInformation.text =[NSString stringWithFormat:@"造成了%d的伤害",onJury];
                //调用相应死亡音效<测试 17.5.21>(成功)
                [self DeathSoundPlay:DeathSoundPlayArray[4]];
                //按钮不可点击
                _AIbutton5.hidden =YES;
                //AI场上的牌减少
                HowManyCardsInAI--;
                if (AIAthenaPassive) {//雅典娜被动存在
                    //获取死亡的是谁并重新创建对应卡牌
                    [self creatAPictureOfAIFiveFiled:[MPC receiveAICardPassiveIDMessage:4]];
                    //重置雅典娜被动
                    AIAthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 5:
            if ([MPC receiveAICardLifeMessage:5]<=0) {
                [_AIbutton6 setBackgroundImage:NULL forState:UIControlStateNormal];
                _AIbutton6Attack.text =[NSString stringWithFormat:@"0"];
                _AIbutton6Life.text =[NSString stringWithFormat:@"0"];
                //重置AI场上卡牌的存在
                AIField6 =false;
                _FightingInformation.text =[NSString stringWithFormat:@"你造成了%d的伤害",onJury];
                //调用相应死亡音效<测试 17.5.21>(成功)
                [self DeathSoundPlay:DeathSoundPlayArray[5]];
                //按钮不可点击
                _AIbutton6.hidden =YES;
                //AI场上的牌减少
                HowManyCardsInAI--;
                if (AIAthenaPassive) {//雅典娜被动存在
                    //获取死亡的是谁并重新创建对应卡牌
                    [self creatAPictureOfAISixFiled:[MPC receiveAICardPassiveIDMessage:5]];
                    //重置雅典娜被动
                    AIAthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 6:
            if ([MPC receiveAICardLifeMessage:6]<=0) {
                [_AIbutton7 setBackgroundImage:NULL forState:UIControlStateNormal];
                _AIbutton7Attack.text =[NSString stringWithFormat:@"0"];
                _AIbutton7Life.text =[NSString stringWithFormat:@"0"];
                //重置AI场上卡牌的存在
                AIField7 =false;
                _FightingInformation.text =[NSString stringWithFormat:@"你造成了%d的伤害",onJury];
                //调用相应死亡音效<测试 17.5.21>(成功)
                [self DeathSoundPlay:DeathSoundPlayArray[6]];
                //按钮不可点击
                _AIbutton7.hidden =YES;
                //AI场上的牌减少
                HowManyCardsInAI--;
                if (AIAthenaPassive) {//雅典娜被动存在
                    //获取死亡的是谁并重新创建对应卡牌
                    [self creatAPictureOfAISevenFiled:[MPC receiveAICardPassiveIDMessage:6]];
                    //重置雅典娜被动
                    AIAthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        default:
            break;
    }
}
//玩家的死亡判断
-(void)PlayerDeathJugement:(int)Jugement{
    switch (Jugement) {
        case 1:
            if ([MPC ReturnCardLifeMessage:0]==0) {
                [_Dbutton1 setBackgroundImage:NULL forState:UIControlStateNormal];
                _Dbutton1Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:0]];
                _Dbutton1Life.text=[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:0]];
                _FightingInformation.text =[NSString stringWithFormat:@"你的卡牌1被击杀"];
                //重置存在
                position1 =false;
                //按钮不可点击
                _Dbutton1.enabled =NO;
                //减少玩家场上的卡牌数量
                HowManyCardsInPlayer--;
                if (AthenaPassive) {
                    //重新生成对应卡牌
                    [self creatOneForCardImage:[MPC ReturnCardPassiveIDMessage:0]];
                    //重置消息
                    AthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 2:
            if ([MPC ReturnCardLifeMessage:1]==0) {
                [_Dbutton2 setBackgroundImage:NULL forState:UIControlStateNormal];
                _Dbutton2Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:1]];
                _Dbutton2Life.text=[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:1]];
                 _FightingInformation.text =[NSString stringWithFormat:@"你的卡牌2被击杀"];
                //重置存在
                position2 =false;
                //按钮不可点击
                _Dbutton2.enabled =NO;
                //减少玩家场上的卡牌数量
                HowManyCardsInPlayer--;
                if (AthenaPassive) {
                    //重新生成对应卡牌
                    [self creatTwoForCardImage:[MPC ReturnCardPassiveIDMessage:1]];
                    //重置消息
                    AthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 3:
            if ([MPC ReturnCardLifeMessage:2]==0) {
                [_Dbutton3 setBackgroundImage:NULL forState:UIControlStateNormal];
                _Dbutton3Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:2]];
                _Dbutton3Life.text=[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:2]];
                _FightingInformation.text =[NSString stringWithFormat:@"你的卡牌3被击杀"];
                //重置存在
                position3 =false;
                //按钮不可点击
                _Dbutton3.enabled =NO;
                //减少玩家场上的卡牌数量
                HowManyCardsInPlayer--;
                if (AthenaPassive) {
                    //重新生成对应卡牌
                    [self creatThreeForCardImage:[MPC ReturnCardPassiveIDMessage:2]];
                    //重置消息
                    AthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 4:
            if ([MPC ReturnCardLifeMessage:3]==0) {
                [_Dbutton4 setBackgroundImage:NULL forState:UIControlStateNormal];
                _Dbutton4Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:3]];
                _Dbutton4Life.text=[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:3]];
                _FightingInformation.text =[NSString stringWithFormat:@"你的卡牌4被击杀"];
                //重置存在
                position4 =false;
                //按钮不可点击
                _Dbutton4.enabled =NO;
                //减少玩家场上的卡牌数量
                HowManyCardsInPlayer--;
                if (AthenaPassive) {
                    //重新生成对应卡牌
                    [self creatFourTypeForCardImage:[MPC ReturnCardPassiveIDMessage:3]];
                    //重置消息
                    AthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 5:
            if ([MPC ReturnCardLifeMessage:4]==0) {
                [_Dbutton5 setBackgroundImage:NULL forState:UIControlStateNormal];
                _Dbutton5Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:4]];
                _Dbutton5Life.text=[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:4]];
                _FightingInformation.text =[NSString stringWithFormat:@"你的卡牌5被击杀"];
                //重置存在
                position5 =false;
                //按钮不可点击
                _Dbutton5.enabled =NO;
                //减少玩家场上的卡牌数量
                HowManyCardsInPlayer--;
                if (AthenaPassive) {
                    //重新生成对应卡牌
                    [self creatFiveForCardImage:[MPC ReturnCardPassiveIDMessage:4]];
                    //重置消息
                    AthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 6:
            if ([MPC ReturnCardLifeMessage:5]==0) {
                [_Dbutton6 setBackgroundImage:NULL forState:UIControlStateNormal];
                _Dbutton6Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:5]];
                _Dbutton6Life.text=[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:5]];
                _FightingInformation.text =[NSString stringWithFormat:@"你的卡牌6被击杀"];
                //重置存在
                position6 =false;
                //按钮不可点击
                _Dbutton6.enabled =NO;
                //减少玩家场上的卡牌数量
                HowManyCardsInPlayer--;
                if (AthenaPassive) {
                    //重新生成对应卡牌
                    [self creatSixForCardImage:[MPC ReturnCardPassiveIDMessage:5]];
                    //重置消息
                    AthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        case 7:
            if ([MPC ReturnCardLifeMessage:6]==0) {
                [_Dbutton7 setBackgroundImage:NULL forState:UIControlStateNormal];
                _Dbutton7Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:3]];
                _Dbutton7Life.text=[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:3]];
                _FightingInformation.text =[NSString stringWithFormat:@"你的卡牌7被击杀"];
                //重置存在
                position7 =false;
                //按钮不可点击
                _Dbutton7.enabled =NO;
                //减少玩家场上的卡牌数量
                HowManyCardsInPlayer--;
                if (AthenaPassive) {
                    //重新生成对应卡牌
                    [self creatSevenForCardImage:[MPC ReturnCardPassiveIDMessage:6]];
                    //重置消息
                    AthenaPassive =false;
                    //提示消息
                    _PromptInformation.text =[NSString stringWithFormat:@"雅典娜的被动触发，复活已死亡的队友"];
                }
            }
            break;
        default:
            break;
    }
}
- (IBAction)PlayerPerson:(id)sender {
    /*
     1.确定攻击者是谁
     2.确定攻击目标，可能是卡牌，可能是AI玩家
     */
    //发送玩家攻击动作（即点击）
    [MPC ReceivePlayerAttackAction];
    //点击了当前按钮
    ClickPlayerPerson =true;
    //解锁可点击卡牌的按钮
    if(AIField1){
        _AIbutton1.hidden =NO;
        _AIbutton1.enabled =YES;
    }
    if (AIField2) {
        _AIbutton2.hidden =NO;
        _AIbutton2.enabled =YES;
    }
    if (AIField3) {
        _AIbutton3.hidden =NO;
        _AIbutton3.enabled =YES;
    }
    if (AIField4) {
        _AIbutton4.hidden =NO;
        _AIbutton4.enabled =YES;
    }
    if (AIField5) {
        _AIbutton5.hidden =NO;
        _AIbutton5.enabled =YES;
    }
    if (AIField6) {
        _AIbutton6.hidden =NO;
        _AIbutton6.enabled =YES;
    }
    if (AIField7) {
        _AIbutton7.hidden =NO;
        _AIbutton7.enabled =YES;
    }
    //解锁AI人物按钮
    _AIPersonButton.enabled =YES;
    _AIPersonButton.hidden =NO;
    /*
      人物的被动在玩家攻击完以后再进行
    */
    //锁定当前按钮
    _PersonButton.enabled =NO;
}
- (IBAction)AIPerson:(id)sender {
    /*
      当AI人物被点击时
     1.发送被点击消息
     2.发送判断事件
     3.更新数据
     */
    if (ClickPlayerPerson){//玩家人物先点击，然后再点击了AI人物
     //发送AI人物被点击动作
     [MPC ReceiveAIPersonIsClicked];
     //发送事件消息
     [MPC ReceiveDecisionEvent:0];
     //反馈消息判断(AI被动的判断)
     [self AIPassivelyEffective];
     //进攻型被动的判定
     [self PlayerAttackPassvieTriggered];
     //解锁下一回合点击事件(只有玩家点击了玩家按钮后才解锁下一回合)
     _NextButton.enabled =YES;
    }else if (ClickPlayerCard) {//点击卡牌以后在点击AI人物
        NSLog(@"点击卡牌后再点击AI人物");
        if ([MPC ReturnCardPassiveIDMessage:4]==15) {//玩家卡牌5雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton6.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        if ([MPC ReturnCardPassiveIDMessage:5]==15) {//玩家卡牌6雅典娜回血
            AthenaBackBlood =true;
            //解禁所有可点击按钮(不包括自身和人物)
            _Dbutton1.enabled =YES;
            _Dbutton2.enabled =YES;
            _Dbutton3.enabled =YES;
            _Dbutton4.enabled =YES;
            _Dbutton5.enabled =YES;
            _Dbutton7.enabled =YES;
        }
        //发送AI人物被点击动作
        [MPC ReceiveAIPersonIsClicked];
        //发送卡牌攻击玩家动作
        [MPC ReceiveDecisionEvent:1];
        //反馈消息判断(AI被动的判断)
        [self AIPassivelyEffective];
        //提示信息
        _PromptInformation.text =[NSString stringWithFormat:@"攻击了AI人物"];
        //异常判断
        [self AIExceptionStatus:10];
    }else{
        _PromptInformation.text =[NSString stringWithFormat:@"请先选择卡牌或者人物"];
    }
    //使攻击者进入不可点击状态
    [self AttackerCanNotClick:PlayerCardPosition];
    //更新AI数据
    [self UpdataAIData];
    //更新玩家数据
    [self updataPlayerData];
    //锁定当前按钮
    _AIPersonButton.enabled =NO;
    //重置点击事件
    ClickPlayerPerson =false;
    ClickPlayerCard =false;
}
//更新主界面AI的数据(实际上是重新输出一次AI的各项数据)
-(void)UpdataAIData{
    NSLog(@"调用了主界面更新Ai数据");
    //先判断，后输出
    //判断AI的剩余生命
    if ([MPC getAiLife]<=0) {
        //初始化提示框
        UIAlertController *Alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"You Win!!!" preferredStyle:UIAlertControllerStyleAlert];
        //弹出提示框
        [self presentViewController:Alert animated:true completion:nil];
    }
    //更新AI人物消息
    _AIAttack.text =[NSString stringWithFormat:@"%d",[MPC getAiAttack]];
    _AILife.text =[NSString stringWithFormat:@"%d",[MPC getAiLife]];
    //更新AI场上所有牌的消息(7张牌)<只更新生命值即可>
    _AIbutton1Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:0]];
    _AIbutton2Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:1]];
    _AIbutton3Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:2]];
    _AIbutton4Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:3]];
    _AIbutton5Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:4]];
    _AIbutton6Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:5]];
    _AIbutton7Life.text =[NSString stringWithFormat:@"%d",[MPC receiveAICardLifeMessage:6]];
    //更新AI场上有多少牌
    _AIFieldCard.text =[NSString stringWithFormat:@"%d",HowManyCardsInAI];
}
//更新主界面玩家的数据(实际上是重新输出一次玩家的各项数据)
-(void)updataPlayerData{
    NSLog(@"调用了主界面更新玩家数据");
    //先判断，后输出
    //判断玩家的剩余生命
    if ([MPC getplayerLife]<=0) {
        //初始化提示框
        UIAlertController *Alert =[UIAlertController alertControllerWithTitle:@"提示" message:@"You Lose!!!" preferredStyle:UIAlertControllerStyleAlert];
        //弹出提示框
        [self presentViewController:Alert animated:true completion:nil];
    }
    //判断玩家的状态
    if ([MPC PlayerCardIsKilledByAIPerson]&&AIPerson==4) {//玩家卡牌被P姐反杀
        _PromptInformation.text =[NSString stringWithFormat:@"Pyrrha对你的卡牌进行了格挡反击，成功击杀了你的卡牌"];
        //清除工作(即死亡判断)
        [self PlayerDeathJugement:PlayerCardPosition];
    }
    //如果玩家卡牌攻击的AI是yang，并触发了被动
    if ([MPC ReturnAIToTriggerPassive]&&AIPerson==3) {
        //更新玩家的生命值
        _PlayerLife.text =[NSString stringWithFormat:@"%d",[MPC getplayerLife]];
    }
    //如果玩家卡牌攻击的Ai是P姐且触发被动
    if([MPC ReturnAIToTriggerPassive]&&AIPerson==4){
        //更新被反击后的玩家生命值
        int number=PlayerCardPosition-1;
        //根据不同的位置显示不同的生命值
        switch (PlayerCardPosition) {//位置判定（1-7）
            case 1:
                _Dbutton1Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:number]];
                _Dbutton1Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:number]];
                break;
            case 2:
                _Dbutton2Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:number]];
                _Dbutton2Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:number]];
                break;
            case 3:
                _Dbutton3Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:number]];
                _Dbutton3Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:number]];
                break;
            case 4:
                _Dbutton4Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:number]];
                _Dbutton4Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:number]];
                break;
            case 5:
                _Dbutton5Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:number]];
                _Dbutton5Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:number]];
                break;
            case 6:
                _Dbutton6Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:number]];
                _Dbutton6Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:number]];
                break;
            case 7:
                _Dbutton7Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:number]];
                _Dbutton7Attack.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardAttackMessage:number]];
                break;
            default:
                break;
        }
    }
    //更新玩家人物消息
    _PlayerAttack.text =[NSString stringWithFormat:@"%d",[MPC getplayerAttack]];
    _PlayerLife.text =[NSString stringWithFormat:@"%d",[MPC getplayerLife]];
    //更新玩家场上所有牌的消息(7张)<只更新生命值即可>
    _Dbutton1Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:0]];
    _Dbutton2Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:1]];
    _Dbutton3Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:2]];
    _Dbutton4Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:3]];
    _Dbutton5Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:4]];
    _Dbutton6Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:5]];
    _Dbutton7Life.text =[NSString stringWithFormat:@"%d",[MPC ReturnCardLifeMessage:6]];
    //更新玩家场上有多少张卡牌
    _PlayerFieldCard.text =[NSString stringWithFormat:@"%d",HowManyCardsInPlayer];
}
//AI被动生效
-(void)AIPassivelyEffective{
    NSString *strPassive;
    int Injury =[MPC ReturnTheDamegeCaused];
    if ([MPC ReturnAIToTriggerPassive]) {//判断被动是否触发
        //判断是哪个人物
        switch (AIPerson) {
            case 2:
                strPassive =[NSString stringWithFormat:@"触发Blake的被动"];
                break;
            case 3:
                strPassive =[NSString stringWithFormat:@"触发Yang的被动,对你造成反击伤害"];
                break;
            case 4:
                strPassive =[NSString stringWithFormat:@"触发Pyrrha的被动,格挡伤害并对攻击者造成反击伤害"];
                break;
            default:
                break;
        }
        _PromptInformation.text =[NSString stringWithFormat:@"%@",strPassive];
        _FightingInformation.text =[NSString stringWithFormat:@"被动触发玩家对AI人物造成%d点伤害",Injury];
    }else{
        switch (AIPerson) {
            case 0:
                _PromptInformation.text=[NSString stringWithFormat:@"Red like roses fills my dreams and bring me to the place you rest!"];
                _FightingInformation.text =[NSString stringWithFormat:@"Ruby is hurt by %d points",Injury];
                break;
            case 1:
                _PromptInformation.text=[NSString stringWithFormat:@"White is cold and always yearning burdened by a royal test"];
                _FightingInformation.text =[NSString stringWithFormat:@"Weiss is hurt by %d points",Injury];
                break;
            case 2:
                _PromptInformation.text=[NSString stringWithFormat:@"Black the beast descends from shadows"];
                _FightingInformation.text =[NSString stringWithFormat:@"Blake is hurt by %d points",Injury];
                break;
            case 3:
                _PromptInformation.text=[NSString stringWithFormat:@"Yellow beauty burns gold"];
                _FightingInformation.text =[NSString stringWithFormat:@"Yang is hurt by %d points",Injury];
                break;
            case 4:
                _PromptInformation.text=[NSString stringWithFormat:@"Do you belive in destiny?Looks like we'll be doing this the hard way."];
                break;
            default:
                break;
        }
        _FightingInformation.text =[NSString stringWithFormat:@"对AI人物造成%d点伤害",Injury];
    }
}
//玩家被动生效
-(void)PlayerPassivelyEffective
{
    NSString *strPassive;
    NSString *strFight;
    
    int Injury =[MPC ReturnTheDamegeCaused];
    if ([MPC ReturnPlayerToTriggerPassive]) {//判断被动是否触发
        //判断是哪个人物
        switch (_ElectionNumber) {
            case 0:
                strPassive =[NSString stringWithFormat:@"触发Ruby的被动，你的任意一张卡牌将再次行动一次"];
                strFight =[NSString stringWithFormat:@"Ruby对位置造成%d的伤害",Injury];
                //需要返回一个消息才行
                
                break;
            case 1:
                strPassive =[NSString stringWithFormat:@"触发Weiss的被动,召唤一张特殊单位（不包括欧西里斯天空龙）"];
                strFight =[NSString stringWithFormat:@"Weiss对位置造成%d的伤害",Injury];
                break;
            default:
                break;
        }
        _PromptInformation.text =[NSString stringWithFormat:@"%@",strPassive];
        _FightingInformation.text =[NSString stringWithFormat:@"%@",strFight];
    }else{
        switch (_ElectionNumber) {
            case 0:
                _PromptInformation.text =[NSString stringWithFormat:@"Ruby对位置%d上的卡牌发动一次攻击",AIPosition];
                _FightingInformation.text =[NSString stringWithFormat:@"Ruby对位置%d上的卡牌造成%d点伤害",AIPosition,Injury];
                break;
            case 1:
                _PromptInformation.text =[NSString stringWithFormat:@"Weiss对位置%d上的卡牌发动一次攻击",AIPosition];
                _FightingInformation.text =[NSString stringWithFormat:@"Weiss对位置%d上的卡牌造成%d点伤害",AIPosition,Injury];
                break;
            case 2:
                _PromptInformation.text =[NSString stringWithFormat:@"Blake对位置%d上的卡牌发动一次攻击",AIPosition];
                _FightingInformation.text =[NSString stringWithFormat:@"Blake对位置%d上的卡牌造成%d点伤害",AIPosition,Injury];
                break;
            case 3:
                _PromptInformation.text =[NSString stringWithFormat:@"Yang对位置%d上的卡牌发动一次攻击",AIPosition];
                _FightingInformation.text =[NSString stringWithFormat:@"Yang对位置%d上的卡牌造成%d点伤害",AIPosition,Injury];
                break;
            case 4:
                _PromptInformation.text =[NSString stringWithFormat:@"Pyrrha对位置%d上的卡牌发动一次攻击",AIPosition];
                _FightingInformation.text =[NSString stringWithFormat:@"Pyrrha对位置%d上的卡牌造成%d点伤害",AIPosition,Injury];
                break;
            default:
                break;
        }
    }
}
- (IBAction)StarButton:(id)sender {
    /*
     开始按钮的工作：
      1.解禁初始状态(全状态锁定)部分
      2.点击以后加载出牌图片，游戏开始图片清空
      3.手牌可以移动，但不能点击场上按钮
      4.控制出牌数，只能出一张牌
      5.记录回合数（保证是在AI处理完工作以后才进行回合＋1）
      6.当点击了下一个回合时，解禁第一张出的牌
     */
    if (RecondTheNumberOfRounds<1) {
        //调用数据，改变各个随机数的值
        randomnumber =[MPC random];
        RandomOfMelee =[MPC randomofmelee];
        RandomOfAssassign =[MPC randomofassassign];
        RandomOfArcherAndAssist =[MPC randomofarcherandassist];
        //创建图片
        [self creatOneCardImage];
        [self creatTwoCardImage];
        [self creatThreeCardImage];
        [self creatFourCardImage];
    }
    //锁定当前卡牌
    _SPButton.enabled =NO;
    //解锁卡牌可以移动按钮
    _button1.enabled =YES;
    _button2.enabled =YES;
    _button3.enabled =YES;
    _button4.enabled =YES;
    //解锁玩家人物可以点击事件
    _PersonButton.hidden =NO;
    _PersonButton.enabled =YES;
    //解锁AI人物显示
    _AIPersonButton.hidden =NO;
    //清空游戏开始图片
    [_SPButton setBackgroundImage:NULL forState:UIControlStateNormal];
    //重新加载游戏出牌图片
    [_SPButton setBackgroundImage:[UIImage imageNamed:@"出牌.png"] forState:UIControlStateNormal];
    //加载下一回合按钮
    [_NextButton setBackgroundImage:[UIImage imageNamed:@"下一回合.png"] forState:UIControlStateNormal];
    //状态切换
    OutOfTheCard =true;
    //调用手牌可以移动
    [self handCardMoved];
    //调用记录回合数
    [self RespondRoundsOfEvents];
    //重新发牌给玩家
    [self LicensingAction];
    //解锁AI状态
    [self UnlockAIState];
}
- (IBAction)Next:(id)sender {
    /*
     下一个回合的工作：
     1.AI的对应动作(出牌和攻击)
     2.解禁开始按钮
     */
    //AI出牌方法1（固定方法）
    //[self AICardAction];
    /*
      判断AI场上有多少张牌，小于7就出牌，大于等于7就弃牌（弃牌生命＋1）
     */
    _PromptInformation.text =[NSString stringWithFormat:@"AI正在思考出牌"];
    if(HowManyCardsInAI<7){
        //AI出牌方法2（比较针对）
        //1秒后调用
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(AICardAction2) userInfo:nil repeats:NO];
    }else{
        _PromptInformation.text =[NSString stringWithFormat:@"AI场上卡牌已满，弃牌"];
        _FightingInformation.text =[NSString stringWithFormat:@"AI人物的生命值＋1"];
    }
    /*
     AI的攻击动作
     1.AI场上有几张牌则攻击几次
     2.优先攻击玩家场上的牌（优先攻击对面血量最低的，然后攻击对面刺客，射手，辅助，近战）
     3.在玩家没有卡牌的情况下攻击玩家
     */
    //更新数据AI数据
    [self UpdataAIData];
    //更新玩家数据
    [self updataPlayerData];
    //发送玩家场上有多少张卡牌
    [MPC RecordPlayerCardsNumber:HowManyCardsInPlayer];
    //发送AI场上有多少牌给数据处理中心
    [MPC RecordAICardsNumber:HowManyCardsInAI];
    NSLog(@"当前AI场上有多少张牌:%d",HowManyCardsInAI);
    float time =(float)HowManyCardsInAI+1.0f;
    //用for循环来调用测试
    for (int i=0; i<=HowManyCardsInAI; i++) {
        //调用攻击动作
        //设定事件，0.1秒
        [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(AICardAttackAction) userInfo:nil repeats:NO];
    }
    //根据卡牌数量来确定什么时候调用AI人物攻击动作
    float Time =(float)HowManyCardsInAI+3.7f;//有0.7的原因是确保场上有7张牌的时候能保证先出完牌再调用AI人物的攻击动作
    if (AIPersonAbnormal) {
        _PromptInformation.text =[NSString stringWithFormat:@"AI人物处于异常状态"];
    }else if(AIPersonAbnormal==false){
        //调用AI人物攻击动作(调用前需要判断AI人物是否有异常状态)
        [NSTimer scheduledTimerWithTimeInterval:Time target:self selector:@selector(AIpersonAttackAction) userInfo:nil repeats:NO];
    }
    //解锁玩家异常状态
    [self UnlockPlayerState];
    //攻击完重置次数
    NEPAttackTimes=0;
}
//发牌动作
-(void)LicensingAction{
    //判断移动的是哪张牌
    if(leaveLocation1){//移动了手牌1
        //重新发牌给手牌1
        RandomOfMelee =[MPC randomofmelee];
        [self creatOneCardImage];
        //重置手牌1
        leaveLocation1 =false;
    }else if (leaveLocation2){//移动了手牌2
        //重新发牌给手牌2
        RandomOfAssassign =[MPC randomofassassign];
        [self creatTwoCardImage];
        //重置手牌2
        leaveLocation2 =false;
    }else if (leaveLocation3){//移动了手牌3
        //重新发牌给手牌3
        RandomOfArcherAndAssist =[MPC randomofarcherandassist];
        [self creatThreeCardImage];
        //重置手牌3
        leaveLocation3 =false;
    }else if (leaveLovation4){
        //重新发牌给手牌4
        randomnumber =[MPC random];
        [self creatFourCardImage];
        //重置手牌4
        leaveLovation4 =false;
    }
}

//AI卡牌的攻击动作
-(void)AICardAttackAction{
    /*
     通过是否有卡牌的存在来确定攻击
     */
    //设定AI卡牌能够攻击的次数(要加异常状态)
    AICardCanAttackNumber =HowManyCardsInAI;
    NSString *stres[1];
    switch (AICardCanAttackNumber) {
        case 0:
            stres[0]=[NSString stringWithFormat:@"AI场上没有卡牌，跳过这个回合"];
            break;
        case 1:
            stres[0]=[NSString stringWithFormat:@"AI场上有1张卡牌，攻击一次"];
            break;
        case 2:
            stres[0]=[NSString stringWithFormat:@"AI场上有2张卡牌，攻击两次"];
            break;
        case 3:
            stres[0]=[NSString stringWithFormat:@"AI场上有3张卡牌，攻击三次"];
            break;
        case 4:
            stres[0]=[NSString stringWithFormat:@"AI场上有4张卡牌，攻击四次"];
            break;
        case 5:
            stres[0]=[NSString stringWithFormat:@"AI场上有5张卡牌，攻击五次"];
            break;
        case 6:
            stres[0]=[NSString stringWithFormat:@"AI场上有6张卡牌，攻击六次"];
            break;
        case 7:
            stres[0]=[NSString stringWithFormat:@"AI场上有7张卡牌，攻击七次"];
            break;
        default:
            break;
    }
    _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击",stres[0]];
    if (AIField1&&AICard1HadAttack==false&&AICard1Abnormal==false) {
        _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击\nAI正在思考卡牌1的攻击动作",stres[0]];
        [self AIcardOneAttackAction];
        //重置消息(在游戏开始按钮要改成false)
        AICard1HadAttack=true;
    }else if (AIField2&&AICard2HadAttack==false&&AICard2Abnormal==false) {
        _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击\nAI正在思考卡牌2的攻击动作",stres[0]];
        [self AIcardTwoAttackAction];
        //重置消息(在游戏开始按钮要改成false)
        AICard2HadAttack=true;
    }else if (AIField3&&AICard3HadAttack==false&&AICard3Abnormal==false) {
       _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击\nAI正在思考卡牌3的攻击动作",stres[0]];
        [self AIcardThreeAttackAction];
        //重置消息(在游戏开始按钮要改成false)
        AICard3HadAttack=true;
    }else if (AIField4&&AICard4HadAttack==false&&AICard4Abnormal==false) {
        _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击\nAI正在思考卡牌4的攻击动作",stres[0]];
        [self AIcardFourAttackAction];
        //重置消息(在游戏开始按钮要改成false)
        AICard4HadAttack=true;
    }else if (AIField5&&AICard5HadAttack==false&&AICard5Abnormal==false) {
        _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击\nAI正在思考卡牌5的攻击动作",stres[0]];
        [self AIcardFiveAttackAction];
        //重置消息(在游戏开始按钮要改成false)
        AICard5HadAttack=true;
    }else if (AIField6&&AICard6HadAttack==false&&AICard6Abnormal==false) {
        _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击\nAI正在思考卡牌6的攻击动作",stres[0]];
        [self AIcardSixAttackAction];
        //重置消息(在游戏开始按钮要改成false)
        AICard6HadAttack=true;
    }else if (AIField7&&AICard7HadAttack==false&&AICard7Abnormal==false) {
        _PromptInformation.text =[NSString stringWithFormat:@"%@\nAI正在思考攻击\nAI正在思考卡牌7的攻击动作",stres[0]];
        [self AIcardSevenAttackAction];
        //重置消息(在游戏开始按钮要改成false)
        AICard7HadAttack=true;
    }
}
//AI卡牌1攻击动作
-(void)AIcardOneAttackAction{
    /*
      近战卡牌的攻击动作
     1.优先判断玩家是否有近战牌
     2.有的情况下对玩家卡牌的生命值进行遍历，攻击生命值最低的卡牌
     3.玩家没有近战牌，攻击顺序：刺客>射手>辅助>玩家>特殊
     */
    NSLog(@"AI调用了卡牌1的攻击动作");
    int temp[3];
    int Life_Min;//生命最小值
    int Min_Index;//最小值对应的下标
    if (position1||position2||position3) {//存在近战牌
        //获的这个三个卡牌的生命值
        temp[0]=[MPC ReturnCardLifeMessage:0];
        temp[1]=[MPC ReturnCardLifeMessage:1];
        temp[2]=[MPC ReturnCardLifeMessage:2];
        //判断谁的生命值最低
        Life_Min =temp[0];
        Min_Index =0;
        //for循环输出最小的值和下标
        for (int i=1; i<3; i++) {
            if (Life_Min>temp[i]) {
                Life_Min =temp[i];
                Min_Index =i;
            }
        }
        NSLog(@"玩家近战牌中生命值最小值是:%d,位置是:%d",Life_Min,Min_Index+1);
        //对最小值的下标发动攻击
        [MPC AICardAttackPlayerCard:1 andPlayerPosition:Min_Index+1];
        //造成了多少伤害
        int HowMuchDamageCaused =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"AI的攻击造成了%d点伤害",HowMuchDamageCaused];
        //判断该位置卡牌是否被击杀
        [self PlayerDeathJugement:Min_Index+1];
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:Min_Index+1];
    }else if(position1==false&&position2==false&&position3==false&&(position4||position5||position6||position7)){
       /*
         当敌方场上没有近战牌,但有其它卡牌存在时
         按照攻击顺序攻击
        */
        NSLog(@"攻击了玩家卡牌");
        if (position4) {//攻击刺客位
            [MPC AICardAttackPlayerCard:1 andPlayerPosition:4];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:4];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:4];
        }else if (position5) {//攻击射手位
            [MPC AICardAttackPlayerCard:1 andPlayerPosition:5];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:5];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:5];
        }else if (position6) {//攻击射手／辅助位
            [MPC AICardAttackPlayerCard:1 andPlayerPosition:6];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:6];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:6];
        }else if (position7) {//攻击特殊位
            [MPC AICardAttackPlayerCard:1 andPlayerPosition:7];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:7];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:7];
        }
    }else{//玩家场上没有卡牌，攻击玩家人物
        [MPC AIcardAttackPlayerPerson:1];
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:10];
    }
    //攻击动作完成，更新玩家数据
    [self updataPlayerData];
}
//AI卡牌2攻击动作
-(void)AIcardTwoAttackAction{
    /*
     近战卡牌的攻击动作
     1.优先判断玩家是否有近战牌
     2.有的情况下对玩家卡牌的生命值进行遍历，攻击生命值最低的卡牌
     3.玩家没有近战牌，攻击顺序：刺客>射手>辅助>玩家>特殊
     */
    NSLog(@"AI调用了卡牌2的攻击动作");
    int temp[3];
    int Life_Min;//生命最小值
    int Min_Index;//最小值对应的下标
    if (position1||position2||position3) {//存在近战牌
        //获的这个三个卡牌的生命值
        temp[0]=[MPC ReturnCardLifeMessage:0];
        temp[1]=[MPC ReturnCardLifeMessage:1];
        temp[2]=[MPC ReturnCardLifeMessage:2];
        //判断谁的生命值最低
        Life_Min =temp[0];
        Min_Index =0;
        //for循环输出最小的值和下标
        for (int i=1; i<3; i++) {
            if (Life_Min>temp[i]) {
                Life_Min =temp[i];
                Min_Index =i;
            }
        }
        NSLog(@"玩家近战牌中生命值最小值是:%d,位置是:%d",Life_Min,Min_Index+1);
        //对最小值的下标发动攻击
        [MPC AICardAttackPlayerCard:2 andPlayerPosition:Min_Index+1];
        //造成了多少伤害
        int HowMuchDamageCaused =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"AI的攻击造成了%d点伤害",HowMuchDamageCaused];
        //判断该位置卡牌是否被击杀
        [self PlayerDeathJugement:Min_Index+1];
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:Min_Index+1];
    }else if(position1==false&&position2==false&&position3==false&&(position4||position5||position6||position7)){
        /*
         当敌方场上没有近战牌,但有其它卡牌存在时
         按照攻击顺序攻击
         */
        NSLog(@"攻击了玩家卡牌");
        if (position4) {//攻击刺客位
            [MPC AICardAttackPlayerCard:2 andPlayerPosition:4];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:4];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:4];
        }else if (position5) {//攻击射手位
            [MPC AICardAttackPlayerCard:2 andPlayerPosition:5];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:5];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:5];
        }else if (position6) {//攻击射手／辅助位
            [MPC AICardAttackPlayerCard:2 andPlayerPosition:6];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:6];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:6];
        }else if (position7) {//攻击特殊位
            [MPC AICardAttackPlayerCard:2 andPlayerPosition:7];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:7];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:7];
        }
    }else{//玩家场上没有卡牌，攻击玩家人物
        [MPC AIcardAttackPlayerPerson:2];
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:10];
    }
    //攻击动作完成，更新玩家数据
    [self updataPlayerData];
}
//AI卡牌3攻击动作
-(void)AIcardThreeAttackAction{
    /*
     近战卡牌的攻击动作
     1.优先判断玩家是否有近战牌
     2.有的情况下对玩家卡牌的生命值进行遍历，攻击生命值最低的卡牌
     3.玩家没有近战牌，攻击顺序：刺客>射手>辅助>玩家>特殊
     */
    NSLog(@"AI调用了卡牌3的攻击动作");
    int temp[3];
    int Life_Min;//生命最小值
    int Min_Index;//最小值对应的下标
    if (position1||position2||position3) {//存在近战牌
        //获的这个三个卡牌的生命值
        temp[0]=[MPC ReturnCardLifeMessage:0];
        temp[1]=[MPC ReturnCardLifeMessage:1];
        temp[2]=[MPC ReturnCardLifeMessage:2];
        //判断谁的生命值最低
        Life_Min =temp[0];
        Min_Index =0;
        //for循环输出最小的值和下标
        for (int i=1; i<3; i++) {
            if (Life_Min>temp[i]) {
                Life_Min =temp[i];
                Min_Index =i;
            }
        }
        NSLog(@"玩家近战牌中生命值最小值是:%d,位置是:%d",Life_Min,Min_Index+1);
        //对最小值的下标发动攻击
        [MPC AICardAttackPlayerCard:3 andPlayerPosition:Min_Index+1];
        //造成了多少伤害
        int HowMuchDamageCaused =[MPC ReturnTheDamegeCaused];
        _FightingInformation.text =[NSString stringWithFormat:@"AI的攻击造成了%d点伤害",HowMuchDamageCaused];
        //判断该位置卡牌是否被击杀
        [self PlayerDeathJugement:Min_Index+1];
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:Min_Index+1];
    }else if(position1==false&&position2==false&&position3==false&&(position4||position5||position6||position7)){
        /*
         当敌方场上没有近战牌,但有其它卡牌存在时
         按照攻击顺序攻击
         */
        NSLog(@"攻击了玩家卡牌");
        if (position4) {//攻击刺客位
            [MPC AICardAttackPlayerCard:3 andPlayerPosition:4];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:4];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:4];
        }else if (position5) {//攻击射手位
            [MPC AICardAttackPlayerCard:3 andPlayerPosition:5];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:5];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:5];
        }else if (position6) {//攻击射手／辅助位
            [MPC AICardAttackPlayerCard:3 andPlayerPosition:6];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:6];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:6];
        }else if (position7) {//攻击特殊位
            [MPC AICardAttackPlayerCard:3 andPlayerPosition:7];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:7];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:7];
        }
    }else{//玩家场上没有卡牌，攻击玩家人物
        [MPC AIcardAttackPlayerPerson:3];
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:10];
    }
    //攻击动作完成，更新玩家数据
    [self updataPlayerData];
}
//AI卡牌4攻击动作
-(void)AIcardFourAttackAction{
    /*
     刺客卡牌的攻击动作
     1.攻击顺序：刺客>射手>辅助>近战>玩家>特殊
     2.最优法则:优先攻击血量最少的卡牌
    */
    /*
        攻击实现方法（循环要用逆序）<没实现>
     1.做两个可变数组A B，同时储存玩家场上的生命值数据（需要将int改成NSNumber类型）
     2.对可变数组B进行筛选，移除其中数据为0的元素
     3.排序，将元素值最小的进行输出，使其成为最小值
     4.用最小值和可变数组A中的元素进行比较，将具有相同数据（值相等）进行输出，输出其下标
     5.记录下标个数
     6.如果下标个数为1，直接卡牌直接攻击该下标对应的玩家卡牌
     7.如果下标个数大于1，判断这几个下标分别对应玩家卡牌的哪个位置
     8.进行攻击，攻击符合攻击顺序
     */
    NSLog(@"AI调用了卡牌4的攻击动作");
    if (HowManyCardsInPlayer<1) {
        NSLog(@"攻击了玩家人物");
        [MPC AIcardAttackPlayerPerson:4];//攻击玩家人物
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:10];
    }else{
        NSLog(@"攻击了玩家卡牌");
        if (position4) {
            [MPC AICardAttackPlayerCard:4 andPlayerPosition:4];//优先攻击刺客牌
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:4];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:4];
        }else if (position5){
             [MPC AICardAttackPlayerCard:4 andPlayerPosition:5];//攻击射手牌
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:5];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:5];
        }else if (position6){
            [MPC AICardAttackPlayerCard:4 andPlayerPosition:6];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:6];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:6];
        }else if (position1||position2||position3){
            if (position1) {
                [MPC AICardAttackPlayerCard:4 andPlayerPosition:1];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:1];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:1];
            }
            if (position2) {
                [MPC AICardAttackPlayerCard:4 andPlayerPosition:2];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:2];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:2];
            }
            if (position3) {
                [MPC AICardAttackPlayerCard:4 andPlayerPosition:3];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:3];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:3];
            }
        }else{
            [MPC AICardAttackPlayerCard:4 andPlayerPosition:7];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:7];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:10];
        }
    }
    //攻击动作完成，更新玩家数据
    [self updataPlayerData];
}//👈动作4的结尾
//AI卡牌5攻击动作
-(void)AIcardFiveAttackAction{
    /*
     射手卡牌的攻击动作（AI第五号位百分百是射手）
     1.攻击顺序：射手>刺客>特殊>辅助>近战>玩家
     2.最优法则:优先攻击血量最少的卡牌
     */
    NSLog(@"AI调用了卡牌5的攻击动作");
    if (HowManyCardsInPlayer<1) {
        [MPC AIcardAttackPlayerPerson:5];//攻击玩家人物
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:10];
        //判断AI的状态（实际上是黑岩）
        [self AIExceptionStatus:8];
    }else{
        NSLog(@"攻击了玩家卡牌");
        if (position5||position6) {
            if (position5) {
                [MPC AICardAttackPlayerCard:5 andPlayerPosition:5];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:5];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:5];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:8];
            }else if (position6) {
                [MPC AICardAttackPlayerCard:5 andPlayerPosition:6];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:6];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:6];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:8];
            }
        }else if (position4){
            [MPC AICardAttackPlayerCard:5 andPlayerPosition:4];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:4];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:4];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:8];
        }else if (position7){
            [MPC AICardAttackPlayerCard:5 andPlayerPosition:7];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:7];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:7];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:8];
        }else if (position1||position2||position3){
            if (position1) {
                [MPC AICardAttackPlayerCard:5 andPlayerPosition:1];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:1];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:1];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:8];
            }else if (position2) {
                [MPC AICardAttackPlayerCard:5 andPlayerPosition:2];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:2];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:2];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:8];
            }else if (position3) {
                [MPC AICardAttackPlayerCard:5 andPlayerPosition:3];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:3];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:3];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:8];
            }
        }
    }
    //攻击动作完成，更新玩家数据
    [self updataPlayerData];
}
//AI卡牌6攻击动作
-(void)AIcardSixAttackAction{
    /*
     射手/辅助卡牌的攻击动作（可能是射手，也可以能辅助）
     1.先判断是什么牌，射手牌使用2，辅助牌使用4
     2.攻击顺序：射手>刺客>特殊>辅助>近战>玩家
     3.攻击顺序: 辅助>射手>刺客>特殊>近战>玩家
     4.最优法则:优先攻击血量最少的卡牌
     */
    NSLog(@"AI调用了卡牌6的攻击动作");
    int AIID =[MPC receiveAICardPassiveIDMessage:5];
    if (HowManyCardsInPlayer<1) {
        [MPC AIcardAttackPlayerPerson:6];//攻击玩家人物
        //判断玩家卡牌的异常状态
        [self PlayerExceptionStatus:10];
        //判断AI的状态（实际上是黑岩）
        [self AIExceptionStatus:9];
    }
    if (AIID>=11&&AIID<=14) {//这个位置是射手牌
        NSLog(@"攻击了玩家卡牌");
        if (position5) {
            [MPC AICardAttackPlayerCard:6 andPlayerPosition:5];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:5];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:5];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:9];
        }else if (position6){
            [MPC AICardAttackPlayerCard:6 andPlayerPosition:6];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:6];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:6];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:9];
        }else if (position7){
            [MPC AICardAttackPlayerCard:6 andPlayerPosition:7];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:7];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:7];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:9];
        }else if (position4){
            [MPC AICardAttackPlayerCard:6 andPlayerPosition:4];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:4];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:4];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:9];
        }else if (position1||position2||position3){
            if (position1) {
                [MPC AICardAttackPlayerCard:6 andPlayerPosition:1];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:1];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:1];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:9];
            }
            if (position2) {
                [MPC AICardAttackPlayerCard:6 andPlayerPosition:2];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:2];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:2];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:9];
            }
            if (position3) {
                [MPC AICardAttackPlayerCard:6 andPlayerPosition:3];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:3];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:3];
                //判断AI的状态（实际上是黑岩）
                [self AIExceptionStatus:9];
            }
        }
    }else{//这个位置是辅助牌
        NSLog(@"攻击了玩家卡牌");
        if (position6) {
            [MPC AICardAttackPlayerCard:6 andPlayerPosition:6];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:6];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:6];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:9];
        }else if (position5){
            [MPC AICardAttackPlayerCard:6 andPlayerPosition:5];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:5];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:5];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:9];
        }else{
             [MPC AIcardAttackPlayerPerson:6];//攻击玩家人物
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:8];
            //判断AI的状态（实际上是黑岩）
            [self AIExceptionStatus:9];
        }
    }
    //攻击动作完成，更新玩家数据
    [self updataPlayerData];
}
//AI卡牌7攻击动作
-(void)AIcardSevenAttackAction{
    /*
     特殊卡牌的攻击动作
     1.攻击顺序：刺客>射手>特殊>辅助>近战>玩家
     2.最优法则:优先攻击血量最少的卡牌
     */
    NSLog(@"AI调用了卡牌7的攻击动作");
    if (HowManyCardsInPlayer<1) {
        [MPC AIcardAttackPlayerPerson:7];//攻击玩家人物
    }else{
        if (position4) {
            NSLog(@"AI卡牌7攻击了卡牌4");
            [MPC AICardAttackPlayerCard:7 andPlayerPosition:4];
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:4];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:4];
        }else if (position5){
            [MPC AICardAttackPlayerCard:7 andPlayerPosition:5];
            NSLog(@"AI卡牌7攻击了卡牌5");
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:5];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:5];
        }else if (position7){
            [MPC AICardAttackPlayerCard:7 andPlayerPosition:7];
            NSLog(@"AI卡牌7攻击了卡牌7");
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:7];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:7];
        }else if (position6){
            [MPC AICardAttackPlayerCard:7 andPlayerPosition:6];
            NSLog(@"AI卡牌7攻击了卡牌6");
            //判断该位置卡牌是否被击杀
            [self PlayerDeathJugement:6];
            //判断玩家卡牌的异常状态
            [self PlayerExceptionStatus:6];
        }else if (position1||position2||position3){
            if (position1) {
                [MPC AICardAttackPlayerCard:7 andPlayerPosition:1];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:1];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:1];
                NSLog(@"AI卡牌7攻击了卡牌1");
            }
            if (position2) {
                [MPC AICardAttackPlayerCard:7 andPlayerPosition:2];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:2];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:2];
                NSLog(@"AI卡牌7攻击了卡牌2");
            }
            if (position3) {
                [MPC AICardAttackPlayerCard:7 andPlayerPosition:3];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:3];
                //判断玩家卡牌的异常状态
                [self PlayerExceptionStatus:3];
                NSLog(@"AI卡牌7攻击了卡牌3");
            }
        }
    }
    //攻击动作完成，更新玩家数据
    [self updataPlayerData];
}
//AI人物的攻击动作
-(void)AIpersonAttackAction{
    NSString *strs[5];
    int rendom =arc4random()%10;
    switch (AIPerson) {
        case 0://AI选择了Ruby
            if (rendom==1) {
                //按照顺序
                if (AIField4) {
                    strs[0]=@"AI选择了卡牌4,再次攻击";
                    //调用攻击动作
                    [self AIcardFourAttackAction];
                }
                if (AIField5) {
                    strs[0]=@"AI选择了卡牌5,再次攻击";
                    [self AIcardFiveAttackAction];
                }
                if (AIField6) {
                    strs[0]=@"AI选择了卡牌6,再次攻击";
                    [self AIcardSixAttackAction];
                }
                if (AIField1) {
                    strs[0]=@"AI选择了卡牌1,再次攻击";
                    [self AIcardOneAttackAction];
                }
                if (AIField2) {
                    strs[0]=@"AI选择了卡牌2,再次攻击";
                    [self AIcardTwoAttackAction];
                }
                if (AIField3) {
                    strs[0]=@"AI选择了卡牌3,再次攻击";
                    [self AIcardThreeAttackAction];
                }
                if (AIField7) {
                    strs[0]=@"AI选择了卡牌7";
                    [self AIcardSevenAttackAction];
                }
            }else{
                strs[0]=@"Ruby的被动没有触发";
            }
            break;
        case 1://选择了Weiss
            if (rendom==1) {
                if (AIField7==false) {
                    //固定生成青眼白龙
                    [self creatAPictureOfAISevenFiled:19];
                    _FightingInformation.text =[NSString stringWithFormat:@"Weiss的被动触发，召唤一个特殊物"];
                }else{
                    strs[0]=@"Weiss的被动没有触发";
                }
            }
            break;
        case 2://Blake
            strs[0]=@"Blake发动了攻击";
            break;
        case 3://Yang
            strs[0]=@"Yang你快女装（对对对，RWBY群里的那个）";
            break;
        case 4://Pyrrha
            strs[0]=@"其实我很想写P姐的攻击无法被格挡的，哎，算了";
        default:
            break;
    }
    strs[1]=@"AI人物发动了攻击";
    //调用AI人物攻击动作
    _PromptInformation.text =[NSString stringWithFormat:@"%@\n%@",strs[0],strs[1]];
    //判断玩家场上有多少张牌
    if (HowManyCardsInPlayer<1) {
        NSLog(@"场上没牌，调用攻击玩家人物动作");
        //玩家场上没有牌，直接攻击目标
        [MPC AIPersonAttackPlayerPerson];
        //显示伤害
        _FightingInformation.text=[NSString stringWithFormat:@"AI人物对玩家人物造成%d点伤害",[MPC ReturnTheDamegeCaused]];
        //解禁开始按钮
        _SPButton.enabled =YES;
    }else{
        //概率攻击事件 30概率攻击卡牌，70概率攻击人物
        int AttackRandom =arc4random()%10;
        if (AttackRandom<=6) {
            [MPC AIPersonAttackPlayerPerson];
            //显示伤害
            _FightingInformation.text=[NSString stringWithFormat:@"AI人物对玩家人物造成%d点伤害",[MPC ReturnTheDamegeCaused]];
            //解禁开始按钮
            _SPButton.enabled =YES;
            NSLog(@"攻击玩家人物");
        }else{
            NSLog(@"攻击玩家卡牌");
            //攻击卡牌
            if (position4) {
                [MPC AIPersonAttackPlayerCard:4];
                //显示伤害
                _FightingInformation.text=[NSString stringWithFormat:@"AI人物对玩家卡牌造成%d点伤害",[MPC ReturnTheDamegeCaused]];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:4];
                   _PromptInformation.text=[NSString stringWithFormat:@"AI攻击完毕,轮到你了，召唤师！"];
                //解禁开始按钮
                _SPButton.enabled =YES;
            }
            if (position5) {
                [MPC AIPersonAttackPlayerCard:5];
                //显示伤害
                _FightingInformation.text=[NSString stringWithFormat:@"AI人物对玩家卡牌造成%d点伤害",[MPC ReturnTheDamegeCaused]];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:5];
                   _PromptInformation.text=[NSString stringWithFormat:@"AI攻击完毕,轮到你了，召唤师！"];
                //解禁开始按钮
                _SPButton.enabled =YES;
            }
            if (position6) {
                [MPC AIPersonAttackPlayerCard:6];
                //显示伤害
                _FightingInformation.text=[NSString stringWithFormat:@"AI人物对玩家卡牌造成%d点伤害",[MPC ReturnTheDamegeCaused]];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:6];                   _PromptInformation.text=[NSString stringWithFormat:@"AI攻击完毕,轮到你了，召唤师！"];
                //解禁开始按钮
                _SPButton.enabled =YES;
            }
            if (position1||position2||position3) {
                //显示伤害
                _FightingInformation.text=[NSString stringWithFormat:@"AI人物对玩家卡牌造成%d点伤害",[MPC ReturnTheDamegeCaused]];
                if (position3) {
                    [MPC AIPersonAttackPlayerCard:3];
                    //判断该位置卡牌是否被击杀
                    [self PlayerDeathJugement:3];
                       _PromptInformation.text=[NSString stringWithFormat:@"AI攻击完毕,轮到你了，召唤师！"];
                    //解禁开始按钮
                    _SPButton.enabled =YES;
                }
                if (position2) {
                    [MPC AIPersonAttackPlayerCard:2];
                    //判断该位置卡牌是否被击杀
                    [self PlayerDeathJugement:2];
                       _PromptInformation.text=[NSString stringWithFormat:@"AI攻击完毕,轮到你了，召唤师！"];
                    //解禁开始按钮
                    _SPButton.enabled =YES;
                }
                if (position1) {
                    [MPC AIPersonAttackPlayerCard:1];
                    //判断该位置卡牌是否被击杀
                    [self PlayerDeathJugement:1];
                    _PromptInformation.text=[NSString stringWithFormat:@"AI攻击完毕,轮到你了，召唤师！"];
                    //解禁开始按钮
                    _SPButton.enabled =YES;
                }
            }
            if (position7) {
                [MPC AIPersonAttackPlayerCard:7];
                //显示伤害
                _FightingInformation.text=[NSString stringWithFormat:@"AI人物对玩家卡牌造成%d点伤害",[MPC ReturnTheDamegeCaused]];
                //判断该位置卡牌是否被击杀
                [self PlayerDeathJugement:7];
                _PromptInformation.text=[NSString stringWithFormat:@"AI攻击完毕,轮到你了，召唤师！"];
                //解禁开始按钮
                _SPButton.enabled =YES;
            }
        }
    }
    //更新数据
    [self UpdataAIData];
    [self updataPlayerData];
}
//调阵AI的定时器时间输出(用于攻击动作)
-(void)AdjustTheAINSTimerOutput{
    AICardCanAttackNumber =HowManyCardsInAI;//没更新卡牌数
    for (int i=0; i<AICardCanAttackNumber; i++) {
        //设定事件，0.1秒
        [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(AICardAttackAction) userInfo:nil repeats:NO];
    }
}
//Ruby被动触发事件
-(void)RubyPassiveTriggerEvents{
    NSLog(@"调用Ruby被动触发后的选择动作");
        _Dbutton1.enabled =YES;
        _Dbutton2.enabled =YES;
        _Dbutton3.enabled =YES;
        _Dbutton4.enabled =YES;
        _Dbutton5.enabled =YES;
        _Dbutton6.enabled =YES;
        _Dbutton7.enabled =YES;
}
/*
 解锁AI和玩家的状态
 */
-(void)UnlockAIState{
    //更新AI卡牌可以攻击动作
    AICard1HadAttack =false;
    AICard2HadAttack =false;
    AICard3HadAttack =false;
    AICard4HadAttack =false;
    AICard5HadAttack =false;
    AICard6HadAttack =false;
    AICard7HadAttack =false;
    //解锁AI身上的状态图片
    _AIStatusReminder1.image =NULL;
    _AIStatusReminder2.image =NULL;
    _AIStatusReminder3.image =NULL;
    _AIStatusReminder4.image =NULL;
    _AIStatusReminder5.image =NULL;
    _AIStatusReminder6.image =NULL;
    _AIStatusReminder7.image =NULL;
    //重置异常状态消息
    AICard1Abnormal=false;
    AICard2Abnormal=false;
    AICard3Abnormal=false;
    AICard4Abnormal=false;
    AICard5Abnormal=false;
    AICard6Abnormal=false;
    AICard7Abnormal=false;
}
-(void)UnlockPlayerState{
    //更新玩家卡牌可攻击
    PCard1HadAttack =false;
    PCard2HadAttack =false;
    PCard3HadAttack =false;
    PCard4HadAttack =false;
    PCard5HadAttack =false;
    PCard6HadAttack =false;
    PCard7HadAttack =false;
    //解锁玩家身上的状态图片
    _StatusReminder1.image =NULL;
    _StatusReminder2.image =NULL;
    _StatusReminder3.image =NULL;
    _StatusReminder4.image =NULL;
    _StatusReminder5.image =NULL;
    _StatusReminder6.image =NULL;
    _StatusReminder7.image =NULL;
    //重置异常状态消息
    PlayerCard1Abnormal=false;
    PlayerCard2Abnormal=false;
    PlayerCard3Abnormal=false;
    PlayerCard4Abnormal=false;
    PlayerCard5Abnormal=false;
    PlayerCard6Abnormal=false;
    PlayerCard7Abnormal=false;
}
/*
 攻击完成以后锁定状态
 */
-(void)AIClockButton{
    _AIbutton1.enabled =NO;
    _AIbutton2.enabled =NO;
    _AIbutton3.enabled =NO;
    _AIbutton4.enabled =NO;
    _AIbutton5.enabled =NO;
    _AIbutton6.enabled =NO;
    _AIbutton7.enabled =NO;
}
/*
 玩家人物（进攻型被动）的触发
 */
-(void)PlayerAttackPassvieTriggered{
    //玩家被动的实现
    int Random =arc4random()%10;
    //对玩家人物的被动进行实现(成功)
    //修改概率测试
    Random=1;
    switch (_ElectionNumber) {
        case 0://Ruby(实现概率只有10%)
            if (Random==1) {
                _PromptInformation.text =[NSString stringWithFormat:@"Ruby被动发动，可以选择一张卡牌行动一次"];
                RubyTriggeredPassive =true;
                //调用选择动作
                [self RubyPassiveTriggerEvents];
            }else{
                NSLog(@"Ruby被动没有触发");
            }
            break;
        case 1://Weiss
            if (Random==1) {
                //判断特殊位是否有卡牌，没有就召唤一张青眼白龙
                if (position7==false) {
                    //创建卡牌7(出问题了，不能显示图片)
                    [self creatSevenForCardImage:19];
                    _FightingInformation.text=[NSString stringWithFormat:@"Weiss被动触发"];
                }else{
                    _PromptInformation.text =[NSString stringWithFormat:@"位置已被占领，Weiss的被动不发动"];
                }
            }
            break;
        default:
            break;
    }
}
/*
 NEP攻击动作
 */
-(void)NEPAttackAction{
    if ([MPC ReturnCardPassiveIDMessage:3]==3) {//攻击者是NEP
        if (NEPAttackTimes<2) {
            [MPC sendTheCurrentCardPosition:PlayerCardPosition];
            _PromptInformation.text =[NSString stringWithFormat:@"请选择攻击对象!"];
            //播放攻击者的音效
            [self AttackSoundEffectsPlay:AttackSoundPlayArray[3]];
            _AIbutton1.enabled =YES;
            _AIbutton2.enabled =YES;
            _AIbutton3.enabled =YES;
            _AIbutton4.enabled =YES;
            _AIbutton5.enabled =YES;
            _AIbutton6.enabled =YES;
            _AIbutton7.enabled =YES;
            _AIPersonButton.enabled =YES;
            //点击了卡牌
            ClickPlayerCard =true;
            //次数增加
            NEPAttackTimes++;
            PlayerCardPosition =4;
            NEPAttackAction =true;
        }else{
            NEPAttackAction =false;
        }
    }
}
@end
