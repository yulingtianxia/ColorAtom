//
//  YXYMyScene.h
//  ColorAtom
//

//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class PlayerArea;
@class Background;
@class DisplayScreen;
@class YXYDebugNode;
@class SharpNodeButton;
@interface PlayFieldScene : SKScene <SKPhysicsContactDelegate>

@property YXYDebugNode* debugOverlay;
@property CGPoint swipePosition;
@property PlayerArea *playArea;
@property Background *background;
@property DisplayScreen *displayScreen;
@property NSInteger rank;
@property NSInteger sharpCount;
@property NSInteger updateScore;
@property SharpNodeButton *sharpButton;

-(void)createAtomMinus;
- (BOOL) sendPosition:(CGPoint) position;
-(void)createAtomSharpByButton:(SharpNodeButton *)button;
-(void) pause;
-(void) resume;
-(void) hideGame;
-(void) showGame;

@end
