//
//  AtomNodeContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomPlusNodeContactVisitor.h"
#import "AtomNode.h"
#import "PlayFieldScene.h"
#import "AtomMinusNode.h"
#import "AtomPlusNode.h"

@implementation AtomPlusNodeContactVisitor



-(void) visitAtomPlusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomPlusNode *thisAtom = (AtomPlusNode*)self.body.node;
    AtomPlusNode *anotherAtom = (AtomPlusNode*)anotherAtomBody.node;
    //处理碰撞后的结果
//    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);

//    thisAtom.fire.particleBirthRate = 0;
    [thisAtom changeColorWithSameAtom:anotherAtom];
//    SKPhysicsJointFixed *fix = [SKPhysicsJointFixed jointWithBodyA:self.body bodyB:anotherAtomBody anchor:self.contact.contactPoint];
    SKPhysicsJointLimit *limit = [SKPhysicsJointLimit jointWithBodyA:self.body bodyB:anotherAtomBody anchorA:[thisAtom convertPoint:self.contact.contactPoint fromNode:thisAtom.scene]  anchorB:[anotherAtom convertPoint:self.contact.contactPoint fromNode:thisAtom.scene]];
    [self.body.node.scene.physicsWorld addJoint:limit];
}

-(void) visitAtomMinusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomPlusNode *thisAtom = (AtomPlusNode*)self.body.node;
    AtomMinusNode *anotherAtom = (AtomMinusNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    //    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    Spark *spark = [[Spark alloc] initWithPosition:self.contact.contactPoint];
    [spark runAction:[SKAction sequence:@[[SKAction waitForDuration:0.1],
                                          [SKAction removeFromParent]]]];
    [thisAtom.scene addChild:spark];
//    thisAtom.fire.particleBirthRate = 0;
    [thisAtom changeColorWithDiffAtom:anotherAtom];
    
}

-(void) visitPlayFieldScene:(SKPhysicsBody*) playfieldBody
{
    AtomPlusNode *atom = (AtomPlusNode*)self.body.node;
    PlayFieldScene *playfield = (PlayFieldScene*) playfieldBody.node;
//    NSLog(@"%@->%@",atom.name,playfield.name);
//    atom.fire.particleBirthRate = 0;
}

@end
