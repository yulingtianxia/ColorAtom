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

@synthesize debugOverlay;
@synthesize swipePosition;
@synthesize playArea;
@synthesize background;
@synthesize displayScreen;
@synthesize rank;
@synthesize sharpCount;
@synthesize updateScore;
@synthesize sharpButton;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        //添加debug信息
        debugOverlay = [[YXYDebugNode alloc] init];
        debugOverlay.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:debugOverlay];
//        添加记分显示屏
        displayScreen = [[DisplayScreen alloc] initWithAtomCount:10];
        [self addChild:displayScreen];
        [displayScreen setPosition];
//        添加玩家胜负区域
        playArea = [[PlayerArea alloc] init];
        [self addChild:playArea];
        [playArea beginWork];
//        添加游戏背景
        background = [[Background alloc] initWithSize:size];
        background.position = CGPointMake(self.size.width/2, self.size.height/2+AtomRadius);
        StarRain *starRain = [[StarRain alloc] init];
        starRain.position = CGPointMake(self.size.width/2, self.size.height);
        [self addChild:background];
        [self addChild:starRain];
//        添加＃按钮
        sharpButton = [[SharpNodeButton alloc]init];
        sharpButton.position = CGPointMake(self.scene.size.width/2, AtomRadius);
        sharpButton.zPosition = 100;
        [self addChild:sharpButton];
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
        self.backgroundColor = [SKColor clearColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        updateScore = 500;
        rank = 1;
        sharpCount = 1;
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
    [[self view] addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipeUp2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeUp2.direction = UISwipeGestureRecognizerDirectionUp;
    swipeUp2.numberOfTouchesRequired = 2;
    [[self view] addGestureRecognizer:swipeUp2];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[self view] addGestureRecognizer:swipeDown];
}

-(void)didSimulatePhysics
{
    NSArray *children = [self children];
    for (int i=0; i<children.count; i++) {
        SKNode *node = (SKNode *)children[i];
        if ([node.name isEqualToString:(NSString*)AtomMinusName]&&node.position.y<3*AtomRadius) {
            [node removeFromParent];
            [displayScreen AtomMinusAttacked];
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
//            [displayScreen AtomMinusAttacked];
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
    [self addChild:debugOverlay];

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (displayScreen.score>=updateScore) {
        rank++;
        sharpCount++;
        updateScore+=500*rank;
        displayScreen.rank = rank;
        displayScreen.sharp = sharpCount;
        sharpButton.alpha = 1;
        [sharpButton runAction:[SKAction repeatAction:[SKAction sequence:@[[SKAction runBlock:^{
            [sharpButton setScale:1.3];
        }],
                                                                           [SKAction waitForDuration:0.1],
                                                                           [SKAction runBlock:^{
            [sharpButton setScale:1];
        }],
                                                                           [SKAction waitForDuration:0.1]]] count:3]];
    }
    
//    debugOverlay.label.text = [NSString stringWithFormat:@"%ld",(long)rank];
    //添加debug信息
    [debugOverlay removeFromParent];
//    [debugOverlay removeAllChildren];
}

#pragma mark FactoryMethods

-(void)createAtomPlusAtPosition:(CGPoint) position
{
    if (displayScreen.atomCount>0) {
        if (![self sendPosition:position]) {
            return;
        }
        [displayScreen AtomPlusUsed:1];
        AtomNode *plusAtom = [[AtomPlusNode alloc] init];
        plusAtom.position = CGPointMake(position.x,AtomRadius);
        playArea.fillColor = plusAtom.color;
        playArea.strokeColor = plusAtom.color;
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
                                                                       [SKAction waitForDuration:AtomMinusCreateInterval/rank withRange:0.5/rank]]]]];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
        for (int i=0; i<rank; i++) {
            AtomNode *minusAtom = [[AtomMinusNode alloc] init];
            minusAtom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),self.size.height-AtomRadius);
            
            [self addChild:minusAtom];
        }
        
    }],
                                                                       [SKAction waitForDuration:AtomMinusCreateInterval*rank*10]]]]];
    
}

-(void)createAtomSharpByButton:(SharpNodeButton *)button{
    if (![self sendPosition:button.position]) {
        return;
    }
    if (sharpCount>0) {
        AtomSharpNode *atomSharp = [[AtomSharpNode alloc] init];
        atomSharp.position = CGPointMake(self.size.width/2, playArea.frame.size.height);
        [self addChild:atomSharp];
        sharpCount--;
        displayScreen.sharp = sharpCount;
        if (sharpCount>0) {
            button.alpha = 1;
        }else{
            button.alpha = 0.5;
        }
    }
}

#pragma mark handleGestures

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        //        debugOverlay.label.text = @"Began";
        [self resume];
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        swipePosition = touchLocation;
        [self createAtomPlusAtPosition:swipePosition];
    }
    else if (recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        [self pause];
    }
}

#pragma mark pause&resume

-(void)pause{
    [self runAction:[SKAction runBlock:^{
        [displayScreen pause];
    }] completion:^{
        self.view.paused = YES;
    }];
}

-(void)resume{
    if (self.view.paused == YES) {
        [displayScreen resume];
        self.view.paused = NO;
    }
}

- (BOOL) sendPosition:(CGPoint) position{
    return YES;
}

-(void) hideGame{
    NSArray *children = [self children];
    for (int i=0; i<children.count; i++) {
        SKNode *node = (SKNode *)children[i];
        if (![node.name isEqualToString:(NSString*)DisplayScreenName]) {
            node.alpha = 0.2;
        }
    }
}

-(void) showGame{
    NSArray *children = [self children];
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
