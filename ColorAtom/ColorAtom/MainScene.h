//
//  MainScene.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-24.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class AtomPlusNode;
@class AtomMinusNode;
@class Background;
@class ContactVisitor;
@class VisitablePhysicsBody;
@class NightPlayScene;
@class AudioButton;
@class NormalPlayButton;
@class NightPlayButton;
@class SecretPlayButton;
@class BHPlayButton;
@class AgainstPlayButton;

@interface MainScene : SKScene <SKPhysicsContactDelegate>
@property SKEmitterNode *fire;
@property Background *background;
@property AtomPlusNode *plus;
@property AtomMinusNode *minus;
@property AudioButton *audio;
@property SKLabelNode *logo;
@property NormalPlayButton *normalPlay;
@property NightPlayButton *nightPlay;
@property SecretPlayButton *secretPlay;
@property BHPlayButton *bhPlay;
@property AgainstPlayButton *againstPlay;
@end
