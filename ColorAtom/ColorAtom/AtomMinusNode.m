//
//  AtomMinusNode.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomMinusNode.h"

@implementation AtomMinusNode
@synthesize fire;
-(id)init
{
    if (self = [super initWithName:(NSString*)AtomMinusName ImageName:@"Atomminus"]) {
        self.physicsBody.categoryBitMask = AtomMinusCategory;
        self.physicsBody.velocity = CGVectorMake(skRand(-200, 200), -skRand(400, 600));
        self.physicsBody.charge = -1;
        self.physicsBody.collisionBitMask = AtomSharpCategory|AtomPlusCategory|PlayFieldCategory;
        self.electric.strength = -1;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Fire" ofType:@"sks"];
        fire = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        fire.particleColor = self.color;
        fire.position = CGPointMake(0, AtomRadius);
        [self addChild:fire];
    }
    return self;
}
@end
