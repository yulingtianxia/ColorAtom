//
//  DisplayScreen.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DisplayScreen : SKSpriteNode

@property (nonatomic, assign) NSInteger atomCount;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger sharp;
@property (nonatomic, strong) SKLabelNode *atomCountLabel;
@property (nonatomic, strong) SKLabelNode *scoreLabel;
@property (nonatomic, strong) SKLabelNode *rankLabel;
@property (nonatomic, strong) SKSpriteNode *atomIcon;
@property (nonatomic, strong) SKLabelNode *pauseLabel;

- (void)AtomMinusKilled;
- (void)AtomPlusUsed:(NSInteger) num;
- (void)setPosition;
- (void)AtomMinusAttacked;
- (instancetype)initWithAtomCount:(NSInteger)count;
- (void)pause;
- (void)resume;

@end
