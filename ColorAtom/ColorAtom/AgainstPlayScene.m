//
//  AgainstPlayScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AgainstPlayScene.h"
#import"YXYAppDelegate.h"
#import "MainScene.h"
#import "AtomMinusNode.h"
#import "GameConstants.h"
#import "AgainstResult.h"
#import "ReadyButton.h"
#import "DisplayScreen.h"

@interface AgainstPlayScene ()

@property (nonatomic, assign) CGPoint againstPosition;
@property (nonatomic, strong) ReadyButton *readyStatusLabel;

@end

@implementation AgainstPlayScene

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        _playerReady = NO;
        self.gameReady = NO;
        self.readyStatusLabel = [[ReadyButton alloc] init];
        self.readyStatusLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidX(self.frame));
        [self addChild:self.readyStatusLabel];
        //        添加记分显示屏
        [self.displayScreen removeFromParent];
        self.displayScreen = [[DisplayScreen alloc] initWithAtomCount:100];
        [self insertChild:self.displayScreen atIndex:0];
        [self.displayScreen setPosition];
    }
    return self;
}

#pragma mark override method

- (void)createAtomMinus{
    if (self.gameReady) {
        [self runAction:[SKAction runBlock:^{
            AtomNode *atom = [[AtomMinusNode alloc] init];
            atom.position = CGPointMake(self.againstPosition.x,self.size.height-AtomRadius);
            [self addChild:atom];
        }]];
    }
    
}

- (BOOL)sendPosition:(CGPoint)position{
    if (self.gameReady) {
        MessagePosition mp;
        mp.message.messageType = kMessageTypePosition;
        mp.position = position;
        NSData *packet = [NSData dataWithBytes:&mp length:sizeof(MessagePosition)];
        [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:nil];
        return YES;
    }
    else{
        return NO;
    }
}

-(void)pause{
    
}

-(void)resume{
    
}

#pragma mark GameKitHelperProtocol

- (void)inviteReceived{
    [[GameKitHelper sharedGameKitHelper] findMatchWithViewController:[UIApplication sharedApplication].keyWindow.rootViewController delegate:self];
}

- (void)matchStarted {
//    NSLog(@"Match started");
}

- (void)matchEnded {
//    NSLog(@"Match ended");
    NSString *title = NSLocalizedString(@"GameOver", "");
    NSString *message = NSLocalizedString(@"Connection lost", "");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", "") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[MainScene alloc] initWithSize:self.scene.size];
        [self.scene.view presentScene:myScene transition: reveal];
    }];
    [alert addAction:ok];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromRemotePlayer:(GKPlayer *)playerID {
//    NSLog(@"Received data");
    Message *message = (Message *) data.bytes;
    if (message->messageType == kMessageTypePosition) {
        MessagePosition* mp = (MessagePosition*)data.bytes;
        self.againstPosition = (*mp).position;
        [self createAtomMinus];
    }
    else if (message->messageType == kMessageTypeGameOver) {
        //Win!
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        AgainstResult * gameOverScene = [[AgainstResult alloc] initWithSize:self.scene.size  win:YES];
        [GameKitHelper sharedGameKitHelper].delegate = gameOverScene;
        [self.scene.view presentScene:gameOverScene transition: reveal];
    }
    else if (message->messageType == kMessageTypeGameBeginRequest) {
        if (self.playerReady) {
            MessageGameBeginResponse response;
            response.message.messageType = kMessageTypeGameBeginResponse;
            NSData *packet = [NSData dataWithBytes:&response length:sizeof(MessageGameBeginResponse)];
            [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:^{
                self.gameReady = YES;
                [self.readyStatusLabel removeFromParent];
            }];
        }
    }
    else if (message->messageType == kMessageTypeGameBeginResponse){
        if (self.playerReady) {
            self.gameReady = YES;
            [self.readyStatusLabel removeFromParent];
        }
    }
    else if (message->messageType == kMessageTypeReplayRequest) {
        MessageReplayResponse response;
        response.message.messageType = kMessageTypeReplayResponse;
        response.agree = YES;
        NSData *packet = [NSData dataWithBytes:&response length:sizeof(MessageReplayResponse)];
        [[GameKitHelper sharedGameKitHelper] sendData:packet withCompleteBlock:^{
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            AgainstPlayScene * gameOverScene = [[AgainstPlayScene alloc] initWithSize:self.size];
            [GameKitHelper sharedGameKitHelper].delegate = gameOverScene;
            [self.scene.view presentScene:gameOverScene transition: reveal];
        }];
    }
}

@end
