//
//  BlackHole.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "BlackHole.h"

@implementation BlackHole
- (id)init{
    if (self=[super init]) {
        self = (BlackHole *)[SKFieldNode radialGravityField];
        SKShapeNode *blackhole = [SKShapeNode node];
    }
    return self;
}
@end
