//
//  AtomMinusNode.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomMinusNode.h"

@implementation AtomMinusNode
-(id)init
{
    if (self = [super initWithName:(NSString*)AtomMinusName ImageName:@"Atomminus"]) {
        self.physicsBody.categoryBitMask = AtomMinusCategory;
        self.physicsBody.velocity = CGVectorMake(skRand(-200, 200), -skRand(400, 600));

//        self.fire.position = CGPointMake(0, AtomRadius*2);
//        self.fire.emissionAngle = 90;
    }
    return self;
}
@end
