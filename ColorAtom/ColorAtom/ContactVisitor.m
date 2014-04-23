//
//  ContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "ContactVisitor.h"
#import <objc/runtime.h>
#import "NodeCategories.h"
#import "AtomPlusNodeContactVisitor.h"
#import "AtomMinusNodeContactVisitor.h"
#import "PlayFieldSceneContactVisitor.h"
#import "AtomSharpNodeContactVisitor.h"
@implementation ContactVisitor

+ (id)contactVisitorWithBody:(SKPhysicsBody *)body forContact:(SKPhysicsContact *)contact
{
    //第一次dispatch，通过node类别返回对应的实例
    if ((body.categoryBitMask&AtomPlusCategory)!=0) {
        return [[AtomPlusNodeContactVisitor alloc] initWithBody:body forContact:contact];
    }
    if ((body.categoryBitMask&AtomMinusCategory)!=0) {
        return [[AtomMinusNodeContactVisitor alloc] initWithBody:body forContact:contact];
    }
    if ((body.categoryBitMask&PlayFieldCategory)!=0) {
        return [[PlayFieldSceneContactVisitor alloc] initWithBody:body forContact:contact];
    }
    if ((body.categoryBitMask&AtomSharpCategory)!=0) {
        return [[AtomSharpNodeContactVisitor alloc] initWithBody:body forContact:contact];
    }
    else{
        return nil;
    }
}

- (id)initWithBody:(SKPhysicsBody *)body forContact:(SKPhysicsContact *)contact
{
    self = [super init];
    if (self) {
        _contact = contact;
        _body = body;
    }
    return self;
}

- (void)visit:(SKPhysicsBody *)body
{
    //第二次dispatch，通过构造方法名来执行对应方法
    // 生成node的名字，比如"AtomNode"
    NSString *bodyClassName = [NSString stringWithUTF8String:class_getName(body.node.class)];
    
    // 生成方法名，比如"visitAtomBody"
    NSMutableString *contactSelectorString = [NSMutableString stringWithFormat:@"visit"];
    [contactSelectorString appendString:bodyClassName];
    [contactSelectorString appendString:@":"];
    
    SEL selector = NSSelectorFromString(contactSelectorString);
    //判断是否存在此方法
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:body];
    }
    
}

@end
