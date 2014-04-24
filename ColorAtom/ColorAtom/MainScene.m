//
//  MainScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene
@synthesize fire;
@synthesize background;
@synthesize plus;
@synthesize minus;
@synthesize audio;
@synthesize logo;
@synthesize normalPlay;
@synthesize nightPlay;

-(id)initWithSize:(CGSize)size {
    if (self=[super initWithSize:size]) {
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
        normalPlay = [[SKLabelNode alloc] initWithFontNamed:@"Chalkboard SE"];
        normalPlay.fontSize = 30;
        normalPlay.text = @"Nomal Mode";
        normalPlay.position = CGPointMake(self.size.width/2, self.size.height/2);
        normalPlay.name = (NSString *)NormalPlayButton;
        nightPlay = [[SKLabelNode alloc] initWithFontNamed:@"Chalkboard SE"];
        nightPlay.fontSize = 30;
        nightPlay.text = @"Night Mode";
        nightPlay.position = CGPointMake(self.size.width/2, CGRectGetMinY(normalPlay.frame)-2*normalPlay.frame.size.height);
        nightPlay.name = (NSString *)NightPlayButton;
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
        }]]]];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKLabelNode *touchedNode = (SKLabelNode *)[self nodeAtPoint:location];
    if ([touchedNode.name isEqualToString:(NSString *)NormalPlayButton]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[PlayFieldScene alloc] initWithSize:self.size];
        [self.view presentScene:myScene transition: reveal];
    }else if ([touchedNode.name isEqualToString:(NSString *)NightPlayButton]) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * myScene = [[NightPlayScene alloc] initWithSize:self.size];
        [self.view presentScene:myScene transition: reveal];
    }
    
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
