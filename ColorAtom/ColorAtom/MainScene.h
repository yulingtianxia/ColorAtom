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
@class WHPlayButton;
@class AgainstPlayButton;
@class GameCenterButton;

@interface MainScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKEmitterNode *fire;
@property (nonatomic, strong) Background *background;
@property (nonatomic, strong) AtomPlusNode *plus;
@property (nonatomic, strong) AtomMinusNode *minus;
@property (nonatomic, strong) AudioButton *audio;
@property (nonatomic, strong) SKLabelNode *logo;
@property (nonatomic, strong) NormalPlayButton *normalPlay;
@property (nonatomic, strong) NightPlayButton *nightPlay;
@property (nonatomic, strong) SecretPlayButton *secretPlay;
@property (nonatomic, strong) WHPlayButton *bhPlay;
@property (nonatomic, strong) AgainstPlayButton *againstPlay;
@property (nonatomic, strong) GameCenterButton *gameCenter;

@end
