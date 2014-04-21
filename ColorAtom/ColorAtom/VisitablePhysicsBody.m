//
//  VisitablePhysicsBody.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "VisitablePhysicsBody.h"

@implementation VisitablePhysicsBody
- (id)initWithBody:(SKPhysicsBody *)body
{
    self = [super init];
    if (self) {
        _body = body;
    }
    return self;
}

- (void)acceptVisitor:(ContactVisitor *)visitor
{
    [visitor visit:self.body];
}

@end
