//
//  WormHolePlayScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-6-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "WormHolePlayScene.h"
#import "Define.h"

@implementation WormHolePlayScene
@synthesize wormHole_A;
@synthesize wormHole_B;
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        wormHole_A = [[WormHole alloc] init];
        wormHole_A.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)+AtomRadius);
        [self addChild:wormHole_A];
//        wormHole_B = [[WormHole alloc] init];
//        wormHole_B.position = CGPointMake(3*self.frame.size.width/4, 3*self.frame.size.height/4);
//        [self addChild:wormHole_B];
//        wormHole_B.anotherWH = wormHole_A;
//        wormHole_A.anotherWH = wormHole_B;
    }
    return self;
}
@end
