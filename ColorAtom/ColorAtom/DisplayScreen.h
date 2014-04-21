//
//  DisplayScreen.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DisplayScreen : SKSpriteNode
@property NSInteger atomCount;
@property NSInteger score;
@property NSInteger rank;
@property SKLabelNode *atomCountLabel;
@property SKLabelNode *scoreLabel;
@property SKLabelNode *rankLabel;
@property SKSpriteNode *atomIcon;
-(void)AtomMinusKilled;
-(void)AtomPlusUsed:(NSInteger) num;
-(void)setPosition;
-(void)AtomMinusAttacked;
@end
