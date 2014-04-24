//
//  MainScene.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AtomPlusNode.h"
#import "AtomMinusNode.h"
#import "Background.h"
#import "ContactVisitor.h"
#import "VisitablePhysicsBody.h"
#import "NightPlayScene.h"
@interface MainScene : SKScene <SKPhysicsContactDelegate>
@property SKEmitterNode *fire;
@property Background *background;
@property AtomPlusNode *plus;
@property AtomMinusNode *minus;
@property SKSpriteNode *audio;
@property SKLabelNode *logo;
@property SKLabelNode *normalPlay;
@property SKLabelNode *nightPlay;
@end
