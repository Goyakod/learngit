//
//  ZXAVAudioPlayer.h
//  ZXChatTableView
//
//  Created by pro on 15/8/21.
//  Copyright (c) 2015年 vickyTest. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@protocol ZXAVAudioPlayerDelegate <NSObject>

- (void)ZXAVAudioPlayerBeginLoadVoice;
- (void)ZXAVAudioPlayerBeginPlay;
- (void)ZXAVAudioPlayerDidFinishPlay;

@end



@interface ZXAVAudioPlayer : NSObject
@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,assign) id<ZXAVAudioPlayerDelegate>delegate;

+ (ZXAVAudioPlayer *)sharedInstance;

- (void)playSongWithFilePath:(NSString *)filePath;

- (void)stopSound;

@end
