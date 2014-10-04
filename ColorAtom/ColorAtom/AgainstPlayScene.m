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

@interface AgainstPlayScene(){
    CGPoint againstPosition;
}
@end
@implementation AgainstPlayScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
    }
    return self;
}

#pragma mark override method

-(void)createAtomMinus{
    [self runAction:[SKAction runBlock:^{
        AtomNode *Atom = [[AtomMinusNode alloc] init];
        Atom.position = CGPointMake(againstPosition.x,self.size.height-AtomRadius);
        [self addChild:Atom];
    }]];
}

-(void)sendPosition:(CGPoint)position{
    NSError *error;
    MessagePosition mp;
    mp.message.messageType = kMessageTypePosition;
    mp.position = position;
    NSData *packet = [NSData dataWithBytes:&mp length:sizeof(MessagePosition)];
    
    [[GameKitHelper sharedGameKitHelper].match sendDataToAllPlayers: packet withDataMode: GKMatchSendDataUnreliable error:&error];
    if (error != nil)
    {
        // Handle the error.
    }
}

#pragma mark GCHelperDelegate


- (void)matchStarted {
    NSLog(@"Match started");
}

- (void)matchEnded {
    NSLog(@"Match ended");
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
//    NSLog(@"Received data");
    Message *message = (Message *) [data bytes];
    if (message->messageType == kMessageTypePosition) {
        MessagePosition* mp = (MessagePosition*)[data bytes];
        againstPosition = (*mp).position;
        [self createAtomMinus];
    }
    else if (message->messageType == kMessageTypeGameOver) {
        //Win!
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[AgainstResult alloc] initWithSize:self.scene.size score: 0 win:YES];
        [self.scene.view presentScene:gameOverScene transition: reveal];
    }
    

}

@end
