//
//  BlackHolePlayScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "BlackHolePlayScene.h"

@implementation BlackHolePlayScene
@synthesize secretForce;
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        secretForce = [[BlackHole alloc] init];
        secretForce.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:secretForce];
        SKSpriteNode *blackhole = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"blackhole"]];
        blackhole.position = secretForce.position;
        blackhole.size = CGSizeMake(50, 50);
        [self addChild:blackhole];
        [blackhole runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:2*M_PI duration:1]]];
    }
    return self;
}
@end
