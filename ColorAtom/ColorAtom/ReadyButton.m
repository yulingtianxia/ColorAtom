//
//  ReadyButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-5.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "ReadyButton.h"
#import "AgainstPlayScene.h"
#import "GameConstants.h"

@implementation ReadyButton
-(id)init{
    if (self = [super init]) {
        self.fontName = @"Chalkboard SE";
        self.fontSize = 40;
        self.text = NSLocalizedString(@"Get Ready", @"");
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    AgainstPlayScene *scene = (AgainstPlayScene *)self.scene;
    scene.playerReady = YES;
//    self.userInteractionEnabled = NO;
    [self sendBeginMessage];
    if (![GameKitHelper sharedGameKitHelper].opponentReady) {
        scene.gameReady = NO;
        self.text = NSLocalizedString(@"Waiting opponent", @"");
    }
    else{
        scene.gameReady = YES;
        [self removeFromParent];
    }
    
}

-(void)sendBeginMessage{
    MessageGameBeginRequest begin;
    begin.message.messageType = kMessageTypeGameBeginRequest;
    NSData *packet = [NSData dataWithBytes:&begin length:sizeof(MessageGameBeginRequest)];
    [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:nil];
}

@end
