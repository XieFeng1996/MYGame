//
//  CardSelectViewController.m
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "CardSelectViewController.h"
@interface CardSelectViewController ()

@end

@implementation CardSelectViewController
int buttonNumberAssassin =1;
int buttonNumberAssist =1;
int buttonNumberSpecial =1;
int buttonNumberMelee =1;
int buttonNumberArcher =1;
bool assassin,assist,special,melee,archer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置文本
    [self setCardText];
    //设置背景图片
    [self setCardBackgound];
}
-(void)viewDidAppear:(BOOL)animated
{
    //隐藏导航栏
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden =YES;
}
-(void)setCardText
{
    //设置文本
    //设置文本对齐方式(左对齐)
    _CardEffect.textAlignment =NSTextAlignmentLeft;
    _CardInitiative.textAlignment =NSTextAlignmentLeft;
    _CardPassive.textAlignment =NSTextAlignmentLeft;
    //设置文本多行显示
    _CardEffect.lineBreakMode =NSLineBreakByCharWrapping;
    _CardEffect.numberOfLines =0;
    _CardInitiative.lineBreakMode =NSLineBreakByCharWrapping;
    _CardInitiative.numberOfLines =0;
    _CardPassive.lineBreakMode =NSLineBreakByCharWrapping;
    _CardPassive.numberOfLines =0;
}
//设置背景图片
-(void)setCardBackgound
{
    //定义图片的位置和尺寸
    UIImageView *subView =[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 667.0f, 375.0f)];
    //设定图片名称并拖放添加图片到image项目文件夹
    switch (arc4random()%2+1) {
        case 1:
            [subView setImage:[UIImage imageNamed:@"狗黑.jpg"]];
            break;
        case 2:
            [subView setImage:[UIImage imageNamed:@"桐人.jpeg"]];
            break;
        default:
            break;
    }
    //在view中加入图片subview并使背景处于最底层
    [self.view insertSubview:subView atIndex:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//人物
-(void)Eryishi
{
    _CardImage.image =[UIImage imageNamed:@"eryishi.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"二仪式直接斩杀生命值低于或等于3的单位"];
    _CardPassive.text =[NSString stringWithFormat:@"猫返：攻击有概率回复自己一点生命"];
}
//刺客
-(void)Hei
{
    _CardImage.image =[UIImage imageNamed:@"hei.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"黑攻击后处于隐身状态"];
    _CardPassive.text =[NSString stringWithFormat:@"攻击一个目标，有概率使敌方进入麻痹状态"];
}
-(void)Tongren
{
    _CardImage.image =[UIImage imageNamed:@"tongren.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"笨蛋情侣：当亚丝娜在场上时，攻击力＋1"];
    _CardPassive.text =[NSString stringWithFormat:@"对任意单位释放星爆气流斩，造成6点固定伤害"];
}
-(void)Yasina
{
    _CardImage.image =[UIImage imageNamed:@"yasina.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"笨蛋情侣：当桐人在场上时，攻击＋1"];
    _CardPassive.text =[NSString stringWithFormat:@"亚丝娜发动［圣母圣咏］，对目标进行十一连刺，造成6点真实伤害"];
}
-(void)Feicunjianxin
{
    _CardImage.image =[UIImage imageNamed:@"jianxin.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"剑心的攻击力随着生命值的减少而增加，每减少1点生命值增加2点攻击力,生命值低于或等于3时被动失效"];
    _CardPassive.text =[NSString stringWithFormat:@"剑心对任意单位进行一次普通伤害，当生命值低于或等于3时对目标发动一场九头龙闪，造成8点真实伤害"];
}
-(void)Neipudun
{
    _CardImage.image =[UIImage imageNamed:@"neipudun.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"主人公补正：对涅普顿对伤害减少1"];
    _CardPassive.text =[NSString stringWithFormat:@"女神连斩：向目标发动三次攻击，每次造成2点伤害（最低1点）"];
}
-(void)Hunpoyaomeng
{
    _CardImage.image =[UIImage imageNamed:@"yaomeng.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"妖梦的攻击力会造成混合伤害，对敌人造成固定伤害2+敌人攻击力的一半"];
    _CardPassive.text =[NSString stringWithFormat:@"对敌方任意单位发的［未来永劫斩］，被击中者有概率造成眩晕，持续一回合"];
}
//近战
-(void)Zun
{
    _CardImage.image =[UIImage imageNamed:@"zun.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"伤害分担：敌人对队友的伤害－1，队员受到伤害的30％分担给尊"];
    _CardPassive.text =[NSString stringWithFormat:@"向敌人扔出达摩克斯之剑，造成1点真实伤害并有概率眩晕"];
}
-(void)Safeiluosi
{
    _CardImage.image =[UIImage imageNamed:@"safeiluosi.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"伤害分流：每受到2点伤害就会将下一次受到的伤害＊3平均分流给对面所有单位"];
    _CardPassive.text =[NSString stringWithFormat:@"萨菲罗斯挥舞正宗，对敌人造成自己最大生命值＊0.05的流血伤害，持续2回合"];
}
-(void)FFFxiaobing
{
    _CardImage.image =[UIImage imageNamed:@"Solider.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"当场上存在3个FFF团小兵时，小兵攻击力＋1"];
    _CardPassive.text =[NSString stringWithFormat:@"向敌方近战单位发动一次攻击"];
}
-(void)Nilu
{
    _CardImage.image =[UIImage imageNamed:@"nilu.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"皇帝的特权：所有对尼禄的伤害－1"];
    _CardPassive.text =[NSString stringWithFormat:@"黄金剧场：尼禄的攻击无视隐身等状态并有概率造成眩晕"];
}
//射手
-(void)Heiyansheshou
{
    _CardImage.image =[UIImage imageNamed:@"heiyan.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"攻击自带暴击，暴击伤害为150％"];
    _CardPassive.text =[NSString stringWithFormat:@"攻击后有概率进入蓝羽化，受到的伤害－1，持续一回合"];
}
-(void)Qianjianzhi
{
    _CardImage.image =[UIImage imageNamed:@"wuying.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"第三次攻击时，攻击造成2点AOE伤害并有概率眩晕"];
    _CardPassive.text =[NSString stringWithFormat:@"攻击附带减速效果，当减速buff达到3层时，该单位将冻结"];
}
-(void)FFFpaoche
{
    _CardImage.image =[UIImage imageNamed:@"Remote.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"当场上存在3个FFF团小兵时，小兵攻击力＋1"];
    _CardPassive.text =[NSString stringWithFormat:@"向敌方任意单位攻击一次"];
}
-(void)Chaotianshinai
{
    _CardImage.image =[UIImage imageNamed:@"shinai.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"诗乃必须死：诗乃受到的伤害＋1且不受辅助伤害减免，诗乃的最终伤害＋2"];
    _CardPassive.text =[NSString stringWithFormat:@"狙击镜：诗乃的攻击有概率造成眩晕"];
}
//辅助
-(void)You
{
    _CardImage.image =[UIImage imageNamed:@"you.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"死灵法师：每隔一个回合，优都会召唤一个僵尸进入战场"];
    _CardPassive.text =[NSString stringWithFormat:@"优挥舞镰刀攻击对方单位，如果该回合内有友方单位阵亡，优将会复活其中一个单位"];
}
-(void)Yadianna
{
    _CardImage.image =[UIImage imageNamed:@"yadianna.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"队友死亡时，雅典娜会复活队员，该被动只生效一次"];
    _CardPassive.text =[NSString stringWithFormat:@"雅典娜回复单一队友3点生命值"];
}
//特殊
-(void)Jiangshi
{
    _CardImage.image =[UIImage imageNamed:@"jiangshi.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"僵尸也有被动吗？"];
    _CardPassive.text =[NSString stringWithFormat:@"攻击敌方近战单位，攻击后死亡"];
}
-(void)Dalong
{
    _CardImage.image =[UIImage imageNamed:@"dalong.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"龙的存在时最高傲的，当欧西里斯天空龙存在时，除特殊类单位其余不能存在"];
    _CardPassive.text =[NSString stringWithFormat:@"欧西里斯天空龙对敌方全体造成4点真实伤害"];
}
-(void)Xiaolong
{
    _CardImage.image =[UIImage imageNamed:@"xiaolong.jpg"];
    _CardInitiative.text =[NSString stringWithFormat:@"当欧西里斯天空龙存在时，青眼白龙可以无消耗召唤"];
    _CardPassive.text =[NSString stringWithFormat:@"攻击敌方任意单位，对英雄单位伤害增加1"];
}
- (IBAction)Melee:(id)sender {
    _CardEffect.text =[NSString stringWithFormat:@"使你的近战单位和辅助单位受到的伤害减少1"];
    [self FFFxiaobing];
    buttonNumberMelee=1;
    melee =true;
    archer =false;
    assist =false;
    assassin =false;
    special =false;
}

- (IBAction)Assassin:(id)sender {
    _CardEffect.text =[NSString stringWithFormat:@"强势切入，对敌方造成大量伤害"];
    [self Eryishi];
    buttonNumberAssassin=1;
    melee =false;
    archer =false;
    assist =false;
    assassin =true;
    special =false;
}

- (IBAction)Archar:(id)sender {
    _CardEffect.text =[NSString stringWithFormat:@"听说过三爷么，我点地板就是一枪，但你自身受到的伤害会增加1."];
    [self Heiyansheshou];
    buttonNumberArcher=1;
    melee =false;
    archer =true;
    assist =false;
    assassin =false;
    special =false;
}

- (IBAction)Assist:(id)sender {
    _CardEffect.text =[NSString stringWithFormat:@"使你的射手单位受到的伤害减伤1，但你受到的伤害增加1."];
    [self Yadianna];
    buttonNumberAssist =1;
    melee =false;
    archer =false;
    assist =true;
    assassin =false;
    special =false;
}

- (IBAction)Special:(id)sender {
    _CardEffect.text =[NSString stringWithFormat:@"或许会很强，我也不知道."];
    [self Jiangshi];
    buttonNumberSpecial =1;
    melee =false;
    archer =false;
    assist =false;
    assassin =false;
    special =true;
}

- (IBAction)UnKnown:(id)sender {
    _CardEffect.text =[NSString stringWithFormat:@"或许有新卡的诞生？我也不清楚"];
    _CardPassive.text =NULL;
    _CardImage.image =NULL;
    _CardInitiative.text =NULL;
    melee =false;
    archer =false;
    assist =false;
    assassin =false;
    special =false;
}

- (IBAction)Next:(id)sender {
    if (melee == true) {
        buttonNumberMelee ++;
        switch (buttonNumberMelee) {
            case 1:
                [self FFFxiaobing];
                break;
            case 2:
                [self Nilu];
                break;
            case 3:
                [self Safeiluosi];
                break;
            case 4:
                [self Zun];
                buttonNumberMelee =0;
                break;
            default:
                break;
        }
    }
    else if (assassin == true) {
        buttonNumberAssassin++;
        switch (buttonNumberAssassin) {
            case 1:
                [self Eryishi];
                break;
            case 2:
                [self Hei];
                break;
            case 3:
                [self Feicunjianxin];
                break;
            case 4:
                [self Neipudun];
                break;
            case 5:
                [self Tongren];
                break;
            case 6:
                [self Yasina];
                break;
            case 7:
                [self Hunpoyaomeng];
                buttonNumberAssassin =0;
                break;
            default:
                break;
        }
    }
    else if (archer ==true)
    {
        buttonNumberArcher++;
        switch (buttonNumberArcher) {
            case 1:
                [self Heiyansheshou];
                break;
            case 2:
                [self Chaotianshinai];
                break;
            case 3:
                [self Qianjianzhi];
                break;
            case 4:
                [self FFFpaoche];
                buttonNumberArcher =0;
                break;
            default:
                break;
        }
    }
    else if (assist == true)
    {
        buttonNumberAssist++;
        switch (buttonNumberAssist) {
            case 1:
                [self Yadianna];
                break;
            case 2:
                [self You];   //为什么不能切换呢？
                buttonNumberAssist =0;
                break;
            default:
                break;
        }
    }
    else if(special ==true)
    {
        buttonNumberSpecial++;
        switch (buttonNumberSpecial) {
            case 1:
                [self Dalong];
                break;
            case 2:
                [self Jiangshi];
                break;
            case 3:
                [self Xiaolong];
                buttonNumberSpecial =0;
                break;
            default:
                break;
        }
    }
}

@end
