//
//  VisitablePhysicsBody.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactVisitor.h"
@interface VisitablePhysicsBody : NSObject
@property (nonatomic, readonly, strong) SKPhysicsBody *body;

- (instancetype)initWithBody:(SKPhysicsBody *)body;
- (void)acceptVisitor:(ContactVisitor *)visitor;

@end
