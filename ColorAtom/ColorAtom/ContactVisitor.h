//
//  ContactVisitor.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
@interface ContactVisitor : NSObject

@property (nonatomic,readonly, strong) SKPhysicsBody *body;
@property (nonatomic, readonly, strong) SKPhysicsContact *contact;

+ (instancetype)contactVisitorWithBody:(SKPhysicsBody *)body forContact:(SKPhysicsContact *)contact;
- (void)visit:(SKPhysicsBody *)body;

@end
