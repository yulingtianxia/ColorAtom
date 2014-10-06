//
//  WormHole.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "WormHole.h"

@implementation WormHole
@synthesize vortex;
@synthesize wormHole;
- (id)init{
    if (self=[super init]) {
        
        wormHole = [SKFieldNode radialGravityField];
        wormHole.strength = 1;
        [self addChild:wormHole];
        vortex = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"blackhole"]];
        vortex.size = CGSizeMake(50, 50);
        vortex.physicsBody.collisionBitMask = 0;
        [self addChild:vortex];
        [vortex runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:2*M_PI duration:1]]];
    }
    return self;
}
@end
