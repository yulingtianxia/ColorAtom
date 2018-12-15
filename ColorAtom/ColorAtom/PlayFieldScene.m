//
//  YXYMyScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-11.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "PlayFieldScene.h"
#import "AtomPlusNode.h"
#import "AtomMinusNode.h"
#import "VisitablePhysicsBody.h"
#import "YXYDebugNode.h"
#import "PlayerArea.h"
#import "Background.h"
#import "DisplayScreen.h"
#import "AtomSharpNode.h"
#import "SharpNodeButton.h"
#import "StarRain.h"
#import "YXYViewController.h"

@implementation PlayFieldScene

-(instancetype)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        //添加debug信息
        self.debugOverlay = [[YXYDebugNode alloc] init];
        self.debugOverlay.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:self.debugOverlay];
//        添加记分显示屏
        self.displayScreen = [[DisplayScreen alloc] initWithAtomCount:10];
        [self addChild:self.displayScreen];
        [self.displayScreen setPosition];
//        添加玩家胜负区域
        self.playArea = [[PlayerArea alloc] init];
        [self addChild:self.playArea];
        [self.playArea beginWork];
//        添加游戏背景
        self.background = [[Background alloc] initWithSize:size];
        self.background.position = CGPointMake(self.size.width/2, self.size.height/2+AtomRadius);
        StarRain *starRain = [[StarRain alloc] init];
        starRain.position = CGPointMake(self.size.width/2, self.size.height);
        [self addChild:self.background];
        [self addChild:starRain];
//        添加＃按钮
        self.sharpButton = [[SharpNodeButton alloc]init];
        self.sharpButton.position = CGPointMake(self.scene.size.width/2, AtomRadius);
        self.sharpButton.zPosition = 100;
        [self addChild:self.sharpButton];
//        游戏区域场景设置
        self.name = (NSString*)PlayFieldName;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, 0, 0, self.size.height+100);
        CGPathAddLineToPoint(path, 0, 0, 0);
        CGPathAddLineToPoint(path, 0, self.size.width, 0);
        CGPathAddLineToPoint(path, 0, self.size.width, self.size.height+100);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:path];
        self.physicsBody.contactTestBitMask = 1;
        self.physicsBody.categoryBitMask = PlayFieldCategory;
        self.self.backgroundColor = [SKColor clearColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        self.updateScore = 500;
        self.rank = 1;
        self.sharpCount = 1;
        //添加暂停通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name:UIApplicationDidEnterBackgroundNotification object:nil];
//          产生负离子
        [self createAtomMinus];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipeUp2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeUp2.direction = UISwipeGestureRecognizerDirectionUp;
    swipeUp2.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:swipeUp2];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

-(void)didSimulatePhysics
{
    NSArray *children = self.children;
    for (int i=0; i<children.count; i++) {
        SKNode *node = (SKNode *)children[i];
        if ([node.name isEqualToString:(NSString*)AtomMinusName]&&node.position.y<3*AtomRadius) {
            [node removeFromParent];
            [self.displayScreen AtomMinusAttacked];
            break;
        }
        else if ([node.name isEqualToString:(NSString*)AtomPlusName]&&node.position.y>self.size.height+AtomRadius) {
            [node removeFromParent];
        }
        else if ([node.name isEqualToString:(NSString*)AtomMinusName]&&node.position.y>self.size.height+AtomRadius) {
            [node removeFromParent];
        }
        else if ([node.name isEqualToString:(NSString*)AtomSharpName]&&node.position.y>self.size.height+AtomRadius*2) {
            [node removeFromParent];
        }
        
    }
//    [self enumerateChildNodesWithName:(NSString*)AtomMinusName usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.y<3*AtomRadius) {
//            [node removeFromParent];
//            [self.displayScreen AtomMinusAttacked];
//            *stop=YES;
//
//        }
//        
//    }];
//    [self enumerateChildNodesWithName:(NSString *)AtomPlusName usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.y>self.size.height+AtomRadius) {
//            [node removeFromParent];
//        }
//    }];
//    [self enumerateChildNodesWithName:(NSString *)AtomMinusName usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.y>self.size.height+AtomRadius) {
//            [node removeFromParent];
//        }
//    }];
//    [self enumerateChildNodesWithName:(NSString *)AtomSharpName usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.y>self.size.height+AtomRadius*2) {
//            [node removeFromParent];
//        }
//    }];
    //add debug node
    [self addChild:self.debugOverlay];

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (self.displayScreen.score>=self.updateScore) {
        self.rank++;
        self.sharpCount++;
        self.updateScore+=500*self.rank;
        self.displayScreen.self.rank = self.rank;
        self.displayScreen.sharp = self.sharpCount;
        self.sharpButton.alpha = 1;
        [self.sharpButton runAction:[SKAction repeatAction:[SKAction sequence:@[[SKAction runBlock:^{
            [self.sharpButton setScale:1.3];
        }],
                                                                           [SKAction waitForDuration:0.1],
                                                                           [SKAction runBlock:^{
            [self.sharpButton setScale:1];
        }],
                                                                           [SKAction waitForDuration:0.1]]] count:3]];
    }
    
//    self.debugOverlay.label.text = [NSString stringWithFormat:@"%ld",(long)self.rank];
    //添加debug信息
    [self.debugOverlay removeFromParent];
//    [self.debugOverlay removeAllChildren];
}

#pragma mark FactoryMethods

-(void)createAtomPlusAtPosition:(CGPoint) position
{
    if (self.displayScreen.atomCount>0) {
        if (![self sendPosition:position]) {
            return;
        }
        [self.displayScreen AtomPlusUsed:1];
        AtomNode *plusAtom = [[AtomPlusNode alloc] init];
        plusAtom.position = CGPointMake(position.x,AtomRadius);
        self.playArea.fillColor = plusAtom.color;
        self.playArea.strokeColor = plusAtom.color;
        [self addChild:plusAtom];
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        if ([[standardDefaults stringForKey:@"audio"] isEqualToString:@"on"]) {
            [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO]];
        }
    }
    
}

-(void)createAtomMinus{
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
        AtomNode *minusAtom = [[AtomMinusNode alloc] init];
        minusAtom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),self.size.height-AtomRadius);
        
        [self addChild:minusAtom];
    }],
                                                                       [SKAction waitForDuration:AtomMinusCreateInterval/self.rank withRange:0.5/self.rank]]]]];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
        for (int i=0; i<self.rank; i++) {
            AtomNode *minusAtom = [[AtomMinusNode alloc] init];
            minusAtom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),self.size.height-AtomRadius);
            
            [self addChild:minusAtom];
        }
        
    }],
                                                                       [SKAction waitForDuration:AtomMinusCreateInterval*self.rank*10]]]]];
    
}

-(void)createAtomSharpByButton:(SharpNodeButton *)button{
    if (![self sendPosition:button.position]) {
        return;
    }
    if (self.sharpCount>0) {
        AtomSharpNode *atomSharp = [[AtomSharpNode alloc] init];
        atomSharp.position = CGPointMake(self.size.width/2, self.playArea.frame.size.height);
        [self addChild:atomSharp];
        self.sharpCount--;
        self.displayScreen.sharp = self.sharpCount;
        if (self.sharpCount>0) {
            button.alpha = 1;
        }else{
            button.alpha = 0.5;
        }
    }
}

#pragma mark handleGestures

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        //        self.debugOverlay.label.text = @"Began";
        [self resume];
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        self.swipePosition = touchLocation;
        [self createAtomPlusAtPosition:self.swipePosition];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        [self pause];
    }
}

#pragma mark pause&resume

-(void)pause{
    [self runAction:[SKAction runBlock:^{
        [self.displayScreen pause];
    }] completion:^{
        self.view.paused = YES;
    }];
}

-(void)resume{
    if (self.view.paused == YES) {
        [self.displayScreen resume];
        self.view.paused = NO;
    }
}

- (BOOL) sendPosition:(CGPoint) position{
    return YES;
}

-(void) hideGame{
    NSArray *children = self.children;
    for (int i=0; i<children.count; i++) {
        SKNode *node = (SKNode *)children[i];
        if (![node.name isEqualToString:(NSString*)DisplayScreenName]) {
            node.alpha = 0.2;
        }
    }
}

-(void) showGame{
    NSArray *children = self.children;
    for (int i=0; i<children.count; i++) {
        SKNode *node = (SKNode *)children[i];
        if (![node.name isEqualToString:(NSString*)DisplayScreenName]) {
            node.alpha = 1;
        }
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
