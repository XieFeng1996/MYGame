//
//  SetPage.m
//  NewHeros
//
//  Created by 洪天伟 on 17/5/25.
//  Copyright © 2017年 xiefeng. All rights reserved.
//

#import "SetPage.h"
#import "ScrollTextView.h"
@interface SetPage ()
{
    ScrollTextView *_scrollTextView;
    ScrollTextView *_scrollTextView1;
}
@end

@implementation SetPage
int number=0;
//加载背景图片
-(void)loadBackground{
    //定义图片的位置和尺寸
    UIImageView *subView =[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 667.0f, 375.0f)];
    //设定图片名称并拖放添加图片到image项目文件夹
    [subView setImage:[UIImage imageNamed:@"P姐.jpeg"]];
    //在view中加入图片subview并使背景处于最底层
    [self.view insertSubview:subView atIndex:0];
}
//设置文本
-(void)setText{
    _Rule.textAlignment =NSTextAlignmentCenter;//居中对齐
    _Rule.numberOfLines =0;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)addLabelWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel * label = [[UILabel alloc] initWithFrame:frame];
    label.text      = text;
    label.textColor = [UIColor greenColor];
    label.font      = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:label];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载背景
    [self loadBackground];
    //设置文本
    [self setText];
    //向左，控件外开始滚动
    [self addLabelWithFrame:CGRectMake(0, 0, 400, 20) text:@"制作人名单"];
    
    _scrollTextView = [[ScrollTextView alloc] initWithFrame:CGRectMake(0, 20, 300, 30) textScrollModel:TextScrollFromOutside direction:TextScrollMoveLeft];
    _scrollTextView.backgroundColor = [UIColor whiteColor];
    //设置透明度
    _scrollTextView.alpha =0.85;
    [self.view addSubview:_scrollTextView];
    
    [_scrollTextView startScrollWithText:@"程序:谢峰 UI设计:谢峰 谢峰他姐(感觉在给我姐招黑) 策划：谢峰 图源:度娘 思路来源:炉石传说 皇室战争 昆特牌 指导老师:孟辉" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16]];
    
    //向左，控件外开始滚动
    [self addLabelWithFrame:CGRectMake(0, 40, 400, 20) text:@"鸣谢"];
    
    _scrollTextView1 = [[ScrollTextView alloc] initWithFrame:CGRectMake(0, 60, 300, 30) textScrollModel:TextScrollFromOutside direction:TextScrollMoveLeft];
    _scrollTextView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollTextView1];
    //设置透明度
    _scrollTextView1.alpha =0.85;
    [_scrollTextView1 startScrollWithText:@"感谢洪天伟同学，杜剑老师              开发平台Xcode 语言：Object-c " textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:16]];
    //显示
    [self TextOutput:number];
}
-(void)viewDidAppear:(BOOL)animated
{
    //隐藏导航栏
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden =YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//改变速度
-(void)changeSpeed{
    [_scrollTextView setMoveSpeed:0.03];
}
//文字输出
-(void)TextOutput:(int)TN
{
    switch (TN) {
        case 0:
            _Rule.text=[NSString stringWithFormat:@"游戏规则\n手牌：玩家拥有4张手牌，其中手牌1固定生成近战牌，手牌2固定生成刺客牌，手牌3固定生成射手牌或者辅助牌"];
            break;
        case 1:
            _Rule.text=[NSString stringWithFormat:@"出牌\n出牌时，近战牌只能放置在场上1 2 3的位置上(即近战牌)，刺客牌只能放在4号位上(即刺客位),射手牌和辅助牌只能放在5号或者6号位上（即射手辅助位）,特殊牌只能放在7号位上(即特殊位)"];
            break;
        case 2:
            _Rule.text=[NSString stringWithFormat:@"攻击\n攻击时，近战牌只能攻击敌方近战牌，只有当敌方近战位上没有近战牌时，己方近战牌才可以攻击敌方其它位置的卡牌。刺客牌，射手牌，辅助牌，特殊牌可以攻击到对面任意一张牌"];
            break;
        case 3:
            _Rule.text=[NSString stringWithFormat:@"弃牌\n当你手中的牌不合你意时，你可以任意丢弃一张牌，当然，丢弃的手牌不同也会生成不同的手牌，当你丢弃的手牌数量达到5时，你可以选择召唤你手牌里的欧西里斯天空龙或者青眼白龙。"];
            break;
        case 4:
            _Rule.text=[NSString stringWithFormat:@"人物\n你可以选择Ruby,Weiss Blake,Yang,Pyrrha五个人物，不同的人物有不同的被动，而你的目标只有一个：击败对面的傻逼AI"];
            break;
        case 5:
            _Rule.text=[NSString stringWithFormat:@"关于概率\nAI人物被动的触发率分别如下: Ruby:60％ Weiss:50％ Blake:60％ Yang:60％ Pyrrha:80％，卡牌被动或者主动的触发概率：20％"];
            break;
        case 6:
            _Rule.text=[NSString stringWithFormat:@"关于回合\n你需要在20个回合内击败AI，否则算你输"];
            break;
        case 7:
            _Rule.text=[NSString stringWithFormat:@"关于伤害\n卡牌对卡牌发动攻击时，优先判定被动的类型，真实伤害不吃任何减免，固定伤害和普通伤害吃其它伤害减免，包括卡牌被动，场上卡牌存在与否等（有时间会加上天气牌 装备牌 场地牌等）"];
            break;
        case 8:
            _Rule.text =[NSString stringWithFormat:@"致歉\n我是想做一款比较完整的游戏，但限于自身水平问题，有些卡牌的主动被动并没有实现，没有实现的卡牌我会在后续一一标出"];
            break;
        case 9:
            _Rule.text =[NSString stringWithFormat:@"免责声明\n该游戏只是为了纪念Obeject-C的衰落（当我去问老师时，老师很奇怪问我为什么不用swift去写。其实我也想啊，可惜swift语言学的不咋滴，直接用swift写浪费的时间更多）和本人（谢"];
            break;
        case 10:
            _Rule.text=[NSString stringWithFormat:@"峰）做着玩的思想,在图源上已经对RWBY（鸡牙），300英雄（TYSB）造成侵权，请多见谅，本人表示该项目不会用于商业用途等牟利用途，上传视频的原因也只是因为电脑是我借的。（渣渣电脑玩个300都能卡"];
            break;
        case 11:
            _Rule.text=[NSString stringWithFormat:@"的你还指望他拉得起虚拟机么),最后说一句，本人是个RWBY厨！玩300！P姐我老婆！！我不是死肥宅！！！（虽然确实有点宅）"];
            break;
        default:
            break;
    }
}
- (IBAction)Previous:(id)sender {
    number--;
    if (number<=0) {
        number =0;
        [self TextOutput:number];
        //不允许继续点击上一页
        _PButton.hidden =YES;
    }
    [self TextOutput:number];
}
- (IBAction)Next:(id)sender {
    number++;
    if (number>0&&number<=11) {
        [self TextOutput:number];
        //允许点击上一页
        _PButton.hidden =NO;
    }
    if (number>11) {
        number =11;
        [self TextOutput:11];
        //不允许点击下一页
        _NButton.hidden =YES;
    }
}
@end
