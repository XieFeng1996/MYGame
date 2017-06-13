//
//  MusicController.m
//  demo
//
//  Created by 洪天伟 on 16/12/17.
//  Copyright © 2016年 Pyrrha. All rights reserved.
//

#import "MusicController.h"
@interface MusicController()
@property (nonatomic,strong)NSMutableDictionary *musicplays;
@property (nonatomic,strong)NSMutableDictionary *soundIDs;
@end
static MusicController *_instance =nil;
@implementation MusicController
+(instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{_instance = [[self alloc]init];});
    return _instance;
}
-(instancetype)init
{
    __block MusicController *temp = self;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{if((temp =[super init])!= nil){
        _musicplays =[NSMutableDictionary dictionary];
        _soundIDs =[NSMutableDictionary dictionary];}
    });
    self =temp;
    return self;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{_instance = [super allocWithZone:zone];});
    return _instance;
}
//播放音乐
-(AVAudioPlayer *)playingMusic:(NSString *)filename
{
    if (filename == nil||filename.length == 0) return nil;
    AVAudioPlayer *player =self.musicplays[filename];//先查询对象是否缓存了
    if (!player) {
        NSURL * url =[[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (!url)return  nil;
        player =[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        if (![player prepareToPlay]) return nil;
        self.musicplays[filename] = player;//对象是最新创建的，那么对它进行一次缓存
    }
    if (![player isPlaying]) {
        [player play];//如果没有正在播放，那么开始播放，如果正在播放，那么不需要改变什么
    }
    return player;
}
-(void)pauseMusic:(NSString *)filename
{
    if (filename == nil||filename.length == 0) return;
    AVAudioPlayer *player =self.musicplays[filename];
    if ([player isPlaying]) {
        [player pause];
    }
}
-(void)stopMusic:(NSString *)filename
{
    if (filename == nil||filename.length == 0) return;
    AVAudioPlayer *player =self.musicplays[filename];
    [player stop];
}
//播放音效
-(void)playSound:(NSString *)filename
{
    if (!filename) return;
    //取出对应的音效ID
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (!url) return;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        self.soundIDs[filename] = @(soundID);
    }
    //播放
    AudioServicesPlayAlertSound(soundID);
}
//摧毁音效
-(void)disposeSound:(NSString *)filename
{
    if (!filename) return;
    SystemSoundID soundID =(int)[self.soundIDs[filename]unsignedIntegerValue];
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        [self.soundIDs removeObjectForKey:filename];//音效被摧毁，那么对应的对象应该从缓存中移除
    }
}
@end
