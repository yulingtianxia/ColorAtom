//
//  MainScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "MainScene.h"
#import "YXYViewController.h"
#import "AudioButton.h"
#import "AtomPlusNode.h"
#import "AtomMinusNode.h"
#import "Background.h"
#import "ContactVisitor.h"
#import "VisitablePhysicsBody.h"
#import "NormalPlayButton.h"
#import "NightPlayButton.h"
#import "SecretPlayButton.h"
#import "WHPlayButton.h"
#import "AgainstPlayButton.h"
#import "GameCenterButton.h"

@implementation MainScene

- (instancetype)initWithSize:(CGSize)size {
    if (self=[super initWithSize:size]) {
        [[GameKitHelper sharedGameKitHelper]
         authenticateLocalPlayer];
        self.backgroundColor = [SKColor clearColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BigColorFire" ofType:@"sks"];
        self.fire = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        self.fire.particlePositionRange = CGVectorMake(size.width, 50);
        self.fire.position = CGPointMake(self.size.width/2, 25);
        [self addChild:self.fire];
        self.background = [[Background alloc] initWithSize:size];
        self.background.position = CGPointMake(self.size.width/2, self.size.height/2+25);
        [self addChild:self.background];
        self.audio = [[AudioButton alloc] init];
        self.audio.position = CGPointMake(self.audio.size.width/2, self.size.height-self.audio.size.height/2);
        [self addChild:self.audio];
        self.plus = [[AtomPlusNode alloc] init];
        self.plus.position = CGPointMake(self.size.width/2, 0);
        self.plus.physicsBody.velocity = CGVectorMake(0, 600);
        self.minus = [[AtomMinusNode alloc] init];
        self.minus.position = CGPointMake(self.size.width/2, self.size.height);
        self.minus.physicsBody.velocity = CGVectorMake(0, -200);
        self.logo = [[SKLabelNode alloc] initWithFontNamed:@"Transformers"];
        self.logo.fontSize = 50;
        self.logo.text = @"ColorAtom";
        self.logo.position = CGPointMake(self.size.width/2, 3*self.size.height/4);
        self.normalPlay = [[NormalPlayButton alloc] init];
        self.normalPlay.position = CGPointMake(self.size.width/2, 2*self.size.height/3);
        self.nightPlay = [[NightPlayButton alloc] init];
        self.nightPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(self.normalPlay.frame)-self.logo.frame.size.height);
        self.secretPlay = [[SecretPlayButton alloc] init];
        self.secretPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(self.nightPlay.frame)-self.logo.frame.size.height);
        self.bhPlay = [[WHPlayButton alloc] init];
        self.bhPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(self.secretPlay.frame)-self.logo.frame.size.height);
        self.againstPlay = [[AgainstPlayButton alloc] init];
        self.againstPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(self.bhPlay.frame)-self.logo.frame.size.height);
        self.gameCenter = [[GameCenterButton alloc] init];
        self.gameCenter.position = CGPointMake(self.size.width-self.gameCenter.size.width/2, self.size.height-self.gameCenter.size.height/2);
        [self addChild:self.gameCenter];
        
        [self runAction:[SKAction sequence:@[[SKAction runBlock:^{
            [self addChild:self.plus];
            [self addChild:self.minus];
        }],
                                             [SKAction waitForDuration:1],
                                             [SKAction runBlock:^{
            [self addChild:self.logo];
            [self.logo setScale:0.5];
        }],
                                             [SKAction waitForDuration:0.1],
                                             [SKAction runBlock:^{
            [self.logo setScale:0.8];
        }],
                                             [SKAction waitForDuration:0.1],
                                             [SKAction runBlock:^{
            [self.logo setScale:1];
        }],
                                             [SKAction waitForDuration:0.2],
                                             [SKAction runBlock:^{
            [self addChild:self.normalPlay];
            [self addChild:self.nightPlay];
            [self addChild:self.secretPlay];
            [self addChild:self.bhPlay];
            [self addChild:self.againstPlay];
        }]]]];
    }
    return self;
}

#pragma mark SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    //A->B
    ContactVisitor *visitorA = [ContactVisitor contactVisitorWithBody:contact.bodyA forContact:contact];
    VisitablePhysicsBody *visitableBodyB = [[VisitablePhysicsBody alloc] initWithBody:contact.bodyB];
    [visitableBodyB acceptVisitor:visitorA];
    //B->A
    ContactVisitor *visitorB = [ContactVisitor contactVisitorWithBody:contact.bodyB forContact:contact];
    VisitablePhysicsBody *visitableBodyA = [[VisitablePhysicsBody alloc] initWithBody:contact.bodyA];
    [visitableBodyA acceptVisitor:visitorB];
}
@end
