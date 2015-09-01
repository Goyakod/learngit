//
//  ZXAVAudioPlayer.m
//  ZXChatTableView
//
//  Created by pro on 15/8/21.
//  Copyright (c) 2015年 vickyTest. All rights reserved.
//

#import "ZXAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface ZXAVAudioPlayer()<ZXAVAudioPlayerDelegate>

@end

@implementation ZXAVAudioPlayer

+ (ZXAVAudioPlayer *)sharedInstance
{
    static ZXAVAudioPlayer *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)stopSound
{
    if (self.player && self.player.isPlaying) {
        [self.player stop];
    }
}

- (void)playSongWithFilePath:(NSString *)filePath
{
    [self setupPlaySound];
    [self playSoundWithFilePath:filePath];
}

- (void)setupPlaySound
{
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
}

- (void)playSoundWithFilePath:(NSString *)filePath
{
    if (self.player) {
        [self.player stop];
        self.player.delegate = nil;
        self.player = nil;
    }
    NSError *playerError;
    NSURL *url = [NSURL fileURLWithPath:@""];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&playerError];
    self.player.volume = 1.0f;
    if (self.player == nil) {
        NSLog(@"player Error:%@",playerError);
    }
    self.player.delegate = self;
    [self.player play];
    [self.delegate ZXAVAudioPlayerBeginPlay];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    [self.delegate ZXAVAudioPlayerDidFinishPlay];
}

@end
