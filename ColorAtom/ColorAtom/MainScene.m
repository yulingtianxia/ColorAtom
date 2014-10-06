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

@implementation MainScene
@synthesize fire;
@synthesize background;
@synthesize plus;
@synthesize minus;
@synthesize audio;
@synthesize logo;
@synthesize normalPlay;
@synthesize nightPlay;
@synthesize secretPlay;
@synthesize bhPlay;
@synthesize againstPlay;

-(id)initWithSize:(CGSize)size {
    if (self=[super initWithSize:size]) {
        [[GameKitHelper sharedGameKitHelper]
         authenticateLocalPlayer];
        self.backgroundColor = [SKColor clearColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BigColorFire" ofType:@"sks"];
        fire = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        fire.position = CGPointMake(self.size.width/2, 25);
        [self addChild:fire];
        background = [[Background alloc] init];
        background.position = CGPointMake(self.size.width/2, self.size.height/2+25);
        [self addChild:background];
        audio = [[AudioButton alloc] init];
        audio.position = CGPointMake(audio.size.width/2, self.size.height-audio.size.height/2);
        [self addChild:audio];
        plus = [[AtomPlusNode alloc] init];
        plus.position = CGPointMake(self.size.width/2, 0);
        plus.physicsBody.velocity = CGVectorMake(0, 600);
        minus = [[AtomMinusNode alloc] init];
        minus.position = CGPointMake(self.size.width/2, self.size.height);
        minus.physicsBody.velocity = CGVectorMake(0, -200);
        logo = [[SKLabelNode alloc] initWithFontNamed:@"Chalkboard SE"];
        logo.fontSize = 50;
        logo.text = @"ColorAtom";
        logo.position = CGPointMake(self.size.width/2, 3*self.size.height/4);
        normalPlay = [[NormalPlayButton alloc] init];
        normalPlay.position = CGPointMake(self.size.width/2, 2*self.size.height/3);
        nightPlay = [[NightPlayButton alloc] init];
        nightPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(normalPlay.frame)-2*normalPlay.frame.size.height);
        secretPlay = [[SecretPlayButton alloc] init];
        secretPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(nightPlay.frame)-2*secretPlay.frame.size.height);
        bhPlay = [[WHPlayButton alloc] init];
        bhPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(secretPlay.frame)-2*secretPlay.frame.size.height);
        againstPlay = [[AgainstPlayButton alloc] init];
        againstPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(bhPlay.frame)-2*bhPlay.frame.size.height);
        [self runAction:[SKAction sequence:@[[SKAction runBlock:^{
            [self addChild:plus];
            [self addChild:minus];
        }],
                                             [SKAction waitForDuration:1],
                                             [SKAction runBlock:^{
            [self addChild:logo];
            [logo setScale:0.5];
        }],
                                             [SKAction waitForDuration:0.1],
                                             [SKAction runBlock:^{
            [logo setScale:0.8];
        }],
                                             [SKAction waitForDuration:0.1],
                                             [SKAction runBlock:^{
            [logo setScale:1];
        }],
                                             [SKAction waitForDuration:0.2],
                                             [SKAction runBlock:^{
            [self addChild:normalPlay];
            [self addChild:nightPlay];
            [self addChild:secretPlay];
            [self addChild:bhPlay];
            [self addChild:againstPlay];
        }]]]];
    }
    return self;
}

#pragma mark SKPhysicsContactDelegate
-(void)didBeginContact:(SKPhysicsContact *)contact
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
