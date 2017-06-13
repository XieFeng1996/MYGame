//
//  MusicController.h
//  demo
//
//  Created by 洪天伟 on 16/12/17.
//  Copyright © 2016年 Pyrrha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MusicController : NSObject
+(instancetype)defaultManager;
-(AVAudioPlayer *)playingMusic:(NSString *)filename;//播放音乐
-(void)pauseMusic:(NSString *)filename;//暂停音乐
-(void)stopMusic:(NSString *)filename;//停止音乐

-(void)playSound:(NSString *)filename;//播放音乐
-(void)disposeSound:(NSString *)filename;
@end
