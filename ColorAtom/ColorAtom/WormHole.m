//
//  WormHole.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "WormHole.h"
#import "NodeCategories.h"
#import "AtomNode.h"
#import "AtomPlusNode.h"
#import "AtomMinusNode.h"

@implementation WormHole
@synthesize anotherWH;
@synthesize wormHole;
- (instancetype)init{
    if (self=[super init]) {
        self.texture = [SKTexture textureWithImageNamed:@"wormhole"];
        wormHole = [SKFieldNode radialGravityField];
        wormHole.strength = 0.7;
//        wormHole.falloff = 1;
        [self addChild:wormHole];
        self.size = CGSizeMake(50, 50);
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
        self.physicsBody.categoryBitMask = WormHoleCategory;
        self.physicsBody.contactTestBitMask = AtomPlusCategory|AtomMinusCategory|AtomSharpCategory;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.usesPreciseCollisionDetection = YES;
//        self.shader = [SKShader shaderWithFileNamed:@"vortexShader.fsh"];
        [self runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:2*M_PI duration:1]]];
    }
    return self;
}

-(void) shootAtomNodeWithCategory:(uint32_t)category{
    if ((category&AtomPlusCategory)!=0) {
        AtomNode *atom = [[AtomPlusNode alloc] init];
        atom.position = CGPointMake(self.position.x,self.position.y+15);
        [self.scene addChild:atom];
    }
    else if ((category&AtomMinusCategory)!=0) {
        AtomNode *atom = [[AtomMinusNode alloc] init];
        atom.position = CGPointMake(self.position.x,self.position.y-15);
        [self.scene addChild:atom];
    }
}
@end
