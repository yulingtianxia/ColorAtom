//
//  AudioButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-27.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AudioButton.h"
#import "YXYViewController.h"
@implementation AudioButton
-(id)init{
    if (self = [super init]) {
        self.size = CGSizeMake(20, 20);
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void) setAudioTexture{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if ([[standardDefaults stringForKey:@"audio"] isEqualToString:@"on"]) {
        self.texture = [SKTexture textureWithImageNamed:@"audio_on"];
    }else if ([[standardDefaults stringForKey:@"audio"] isEqualToString:@"off"]) {
        self.texture = [SKTexture textureWithImageNamed:@"audio_off"];
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    if ([[standardDefaults stringForKey:@"audio"] isEqualToString:@"on"]){
        [standardDefaults setObject:@"off" forKey:@"audio"];
        [((YXYViewController *)[self.scene.view nextResponder]).backgroundMusicPlayer stop];
    }else if ([[standardDefaults stringForKey:@"audio"] isEqualToString:@"off"]){
        [standardDefaults setObject:@"on" forKey:@"audio"];
        [((YXYViewController *)[self.scene.view nextResponder]).backgroundMusicPlayer play];
    }
    
    [self setAudioTexture];
}
@end
