//
//  WormHole.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class AtomNode;
@interface WormHole : SKSpriteNode

@property SKFieldNode *wormHole;
@property (weak) WormHole * anotherWH;

-(void) shootAtomNodeWithCategory:(uint32_t)category;

@end
