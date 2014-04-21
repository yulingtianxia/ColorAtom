//
//  AtomNodePlus.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomPlusNode.h"

@implementation AtomPlusNode
-(id)init
{
    if (self = [super initWithName:AtomPlusName ImageName:@"Atomplus"]) {
        self.physicsBody.categoryBitMask  = AtomPlusCategory;
        self.physicsBody.velocity = CGVectorMake(AtomPlusVx, AtomPlusVy);
        self.fire.position = CGPointMake(0, 0);
//        self.fire.emissionAngle = 180;
    }
    return self;
}

@end
