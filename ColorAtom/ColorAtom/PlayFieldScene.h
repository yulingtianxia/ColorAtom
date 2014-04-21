//
//  YXYMyScene.h
//  ColorAtom
//

//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Define.h"
#import "NodeCategories.h"
#import "RandomHelper.h"
#import "AtomNode.h"
#import "AtomPlusNode.h"
#import "AtomMinusNode.h"
#import "VisitablePhysicsBody.h"
#import "YXYDebugNode.h"
#import "PlayerArea.h"
#import "GameOverScene.h"
#import "Background.h"
#import "DisplayScreen.h"
@interface PlayFieldScene : SKScene <SKPhysicsContactDelegate>

@property YXYDebugNode* debugOverlay;
@property CGPoint longPressPosition;
@property CGPoint panPosition;
@property PlayerArea *playArea;
@property Background *background;
@property DisplayScreen *displayScreen;
@property NSInteger rank;
@end
