//
//  ElectionViewController.m
//  NewHeros
//
//  Created by 洪天伟 on 17/4/22.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "ElectionViewController.h"
int stactInt =0;
struct playerData PD[] ={
    {0,"Ruby Rose",5,30,"Crescent Rose:Ruby挥舞新月玫瑰，有概率使一个单位再次行动",100},
    {1,"Weiss Schnee",5,30,"Myrtenaster:挥舞柳叶白菀的Weiss行动时有概率召唤特殊类单位",101},
    {2,"Blake Belladonna",5,30,"Gambol Shroud:Blake挥舞跃影飞绫，有概率使受到的伤害全部由残像承担",102},
    {3,"Yang xiao long",5,30,"Ember Celie:yang 承受的所有伤害＋1.当yang行动时，有概率将受到的伤害用灰烬天堂全部返还给对面玩家",103},
    {4,"Pyrrha Nikos",6,30,"Milo&Akouo:Pyrrha受到攻击时有概率格挡并对攻击者发起一次反击，反击造成攻击的50%伤害",104}
};
@interface ElectionViewController ()

@end

@implementation ElectionViewController
@synthesize playerAttack,playerID,playerImage,playerLife,playerName,playerLntroduction,playerPassive;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self Ruby];
    //定义图片的位置和尺寸
    UIImageView *subView =[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 667.0f, 375.0f)];
    //设定图片名称并拖放添加图片到image项目文件夹
    [subView setImage:[UIImage imageNamed:@"RWBY.jpeg"]];
    //在view中加入图片subview并使背景处于最底层
    [self.view insertSubview:subView atIndex:0];
    subView.alpha =0.8;
    [self setText];
}
-(void)setText
{
    //设置文本对齐方式(左对齐)
    playerLntroduction.textAlignment =NSTextAlignmentLeft;
    playerPassive.textAlignment =NSTextAlignmentLeft;
    //设置文本多行显示
    playerPassive.lineBreakMode =NSLineBreakByCharWrapping;
    playerLntroduction.numberOfLines =0;
    playerLntroduction.lineBreakMode =NSLineBreakByCharWrapping;
    playerPassive.numberOfLines =0;
    //设置文本颜色
    playerLntroduction.layer.borderColor =[UIColor lightGrayColor].CGColor;//边框颜色
    playerLntroduction.layer.borderWidth =1;//边框宽度
    playerPassive.layer.borderColor =[UIColor lightGrayColor].CGColor;//边框颜色
    playerPassive.layer.borderWidth =1;//边框宽度
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    //显示导航栏
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden =NO;

}
//- (IBAction)SelectPlayer:(id)sender {
//    // 根据指定线的ID跳转到目标Vc（因为push的指定，不需要再次指定了）
//   // [self performSegueWithIdentifier:@"SendValue" sender:self];
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // segue.identifier：获取连线的ID
    if ([segue.identifier isEqualToString:@"SendValue"]) {
        // segue.destinationViewController：获取连线时所指的界面（VC）
        GameStartViewController *receive = segue.destinationViewController;
        NSLog(@"%d",stactInt);
        switch (stactInt) {
            case 0:
                receive.ElectionNumber =0;
                break;
            case 1:
                receive.ElectionNumber =1;
                break;
            case 2:
                receive.ElectionNumber =2;
                break;
            case 3:
                receive.ElectionNumber =3;
                break;
            case 4:
                receive.ElectionNumber =4;
                break;
            default:
                break;
        }
    }
}
- (IBAction)NextPlayer:(id)sender {
    stactInt++;
    switch (stactInt) {
        case 0:
            [self Ruby];
            break;
        case 1:
            [self Weiss];
            break;
        case 2:
            [self Blake];
            break;
        case 3:
            [self Yang];
            break;
        case 4:
            [self Pyrrha];
            break;
        case 5:
             stactInt = -1;
        default:
            break;
    }
}
-(void)Ruby
{
    playerImage.image =[UIImage imageNamed:@"Ruby.jpg"];
    playerAttack.text =[NSString stringWithFormat:@"%d",PD[0].playerAttack];
    playerLife.text =[NSString stringWithFormat:@"%d",PD[0].playerLife];
    playerID.text =[NSString stringWithFormat:@"%d",PD[0].playerID];
    playerLntroduction.text =[NSString stringWithFormat:@"Ruby Rose,一个天然呆，好奇心旺盛的可爱妹子(其实你们不用吐槽我啦).相信我，相信Ruby Rose的外像力,Speed(急速)带来的不止是强大的力量，更是你获胜的信心"];
     NSString *str =[NSString stringWithCString:PD[0].playerPassive encoding:NSUTF8StringEncoding];
     NSString *str1 =[NSString stringWithCString:PD[0].playerName encoding:NSUTF8StringEncoding];
    [playerPassive setTextColor:[UIColor redColor]];
    [playerLntroduction setTextColor:[UIColor redColor]];
    [playerName setTextColor:[UIColor redColor]];
    [playerID setTextColor:[UIColor redColor]];
    [playerAttack setTextColor:[UIColor redColor]];
    [playerLife setTextColor:[UIColor redColor]];
    playerPassive.text =[NSString stringWithFormat:@"%@",str];
    playerName.text =[NSString stringWithFormat:@"%@",str1];
    
}
-(void)Weiss
{
    playerImage.image =[UIImage imageNamed:@"Weiss.jpg"];
    playerAttack.text =[NSString stringWithFormat:@"%d",PD[1].playerAttack];
    playerLife.text =[NSString stringWithFormat:@"%d",PD[1].playerLife];
    playerID.text =[NSString stringWithFormat:@"%d",PD[1].playerID];
    playerLntroduction.text =[NSString stringWithFormat:@"知识和优雅是Weiss的代言,傲娇和毒舌是Weiss的特点。"];
    NSString *str =[NSString stringWithCString:PD[1].playerPassive encoding:NSUTF8StringEncoding];
    NSString *str1 =[NSString stringWithCString:PD[1].playerName encoding:NSUTF8StringEncoding];
    [playerPassive setTextColor:[UIColor whiteColor]];
    [playerLntroduction setTextColor:[UIColor whiteColor]];
    [playerName setTextColor:[UIColor whiteColor]];
    [playerID setTextColor:[UIColor whiteColor]];
    [playerAttack setTextColor:[UIColor whiteColor]];
    [playerLife setTextColor:[UIColor whiteColor]];
    playerPassive.text =[NSString stringWithFormat:@"%@",str];
    playerName.text =[NSString stringWithFormat:@"%@",str1];
}
-(void)Blake
{
    playerImage.image =[UIImage imageNamed:@"Blake.jpg"];
    playerAttack.text =[NSString stringWithFormat:@"%d",PD[2].playerAttack];
    playerLife.text =[NSString stringWithFormat:@"%d",PD[2].playerLife];
    playerID.text =[NSString stringWithFormat:@"%d",PD[2].playerID];
    playerLntroduction.text =[NSString stringWithFormat:@"B喵，身为弗纳人一族，对白牙的所作所为感到不满而离开白牙。爱好读书(比如<<爱的忍者>>)，在和ZWei相处时总是显得很傲娇"];
    NSString *str =[NSString stringWithCString:PD[2].playerPassive encoding:NSUTF8StringEncoding];
    NSString *str1 =[NSString stringWithCString:PD[2].playerName encoding:NSUTF8StringEncoding];
    [playerPassive setTextColor:[UIColor blackColor]];
    [playerLntroduction setTextColor:[UIColor blackColor]];
    [playerName setTextColor:[UIColor blackColor]];
    [playerID setTextColor:[UIColor blackColor]];
    [playerAttack setTextColor:[UIColor blackColor]];
    [playerLife setTextColor:[UIColor blackColor]];
    playerPassive.text =[NSString stringWithFormat:@"%@",str];
    playerName.text =[NSString stringWithFormat:@"%@",str1];
}
-(void)Yang
{
    playerImage.image =[UIImage imageNamed:@"Yang.jpg"];
    playerAttack.text =[NSString stringWithFormat:@"%d",PD[3].playerAttack];
    playerLife.text =[NSString stringWithFormat:@"%d",PD[3].playerLife];
    playerID.text =[NSString stringWithFormat:@"%d",PD[3].playerID];
    playerLntroduction.text =[NSString stringWithFormat:@"Ruby同父异母的姐姐，热血，剽悍，健谈。典型的妹控。右手在保护Blake的时候被Adam切断了右手，V4已装上机械臂。顺便说一下，9⃣️yang扶他豆浆机"];
    NSString *str =[NSString stringWithCString:PD[3].playerPassive encoding:NSUTF8StringEncoding];
    NSString *str1 =[NSString stringWithCString:PD[3].playerName encoding:NSUTF8StringEncoding];
    [playerPassive setTextColor:[UIColor yellowColor]];
    [playerLntroduction setTextColor:[UIColor yellowColor]];
    [playerName setTextColor:[UIColor yellowColor]];
    [playerID setTextColor:[UIColor yellowColor]];
    [playerAttack setTextColor:[UIColor yellowColor]];
    [playerLife setTextColor:[UIColor yellowColor]];
    playerPassive.text =[NSString stringWithFormat:@"%@",str];
    playerName.text =[NSString stringWithFormat:@"%@",str1];
}
-(void)Pyrrha
{
    playerImage.image =[UIImage imageNamed:@"Pyrrha.jpg"];
    playerAttack.text =[NSString stringWithFormat:@"%d",PD[4].playerAttack];
    playerLife.text =[NSString stringWithFormat:@"%d",PD[4].playerLife];
    playerID.text =[NSString stringWithFormat:@"%d",PD[4].playerID];
    playerLntroduction.text =[NSString stringWithFormat:@"Pyrrha Nikos,一个有着强大实力，成熟冷静，幽默风趣，学识渊博，谦逊低调，善良正直的女武神。很可惜死在Cinder手里,秋之少女的力量被Cinder夺去。但说这么多，我只想说，P姐我老婆!"];
    NSString *str =[NSString stringWithCString:PD[4].playerPassive encoding:NSUTF8StringEncoding];
    NSString *str1 =[NSString stringWithCString:PD[4].playerName encoding:NSUTF8StringEncoding];
    [playerPassive setTextColor:[UIColor magentaColor]];
    [playerLntroduction setTextColor:[UIColor magentaColor]];
    [playerName setTextColor:[UIColor magentaColor]];
    [playerID setTextColor:[UIColor magentaColor]];
    [playerAttack setTextColor:[UIColor magentaColor]];
    [playerLife setTextColor:[UIColor magentaColor]];
    playerPassive.text =[NSString stringWithFormat:@"%@",str];
    playerName.text =[NSString stringWithFormat:@"%@",str1];
}
@end
