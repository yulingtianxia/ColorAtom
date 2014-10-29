//
//  AtomMinusContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomMinusNodeContactVisitor.h"
#import "AtomNode.h"
#import "PlayFieldScene.h"
#import "AtomMinusNode.h"
#import "AtomPlusNode.h"
#import "DisplayScreen.h"
#import "AtomSharpNode.h"
@implementation AtomMinusNodeContactVisitor
-(void) visitAtomPlusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomMinusNode *thisAtom = (AtomMinusNode*)self.body.node;
    AtomPlusNode *anotherAtom = (AtomPlusNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    //    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    
    thisAtom.fire.particleBirthRate = 0;
    [thisAtom changeColorWithDiffAtom:anotherAtom];
    [((DisplayScreen *)[thisAtom.scene childNodeWithName:(NSString *)DisplayScreenName]) AtomMinusKilled];
    
}

-(void) visitAtomMinusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomMinusNode *thisAtom = (AtomMinusNode*)self.body.node;
    AtomMinusNode *anotherAtom = (AtomMinusNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    //    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    if ([thisAtom.userData objectForKey:ATOMCOLOR] == [anotherAtom.userData objectForKey:ATOMCOLOR]) {
        return;
    }
    thisAtom.fire.particleBirthRate = 0;
    
    [thisAtom changeColorWithSameAtom:anotherAtom];
//    SKPhysicsJointFixed *fix = [SKPhysicsJointFixed jointWithBodyA:self.body bodyB:anotherAtomBody anchor:self.contact.contactPoint];
    SKPhysicsJointLimit *limit = [SKPhysicsJointLimit jointWithBodyA:self.body bodyB:anotherAtomBody anchorA:[thisAtom convertPoint:self.contact.contactPoint fromNode:thisAtom.scene]  anchorB:[anotherAtom convertPoint:self.contact.contactPoint fromNode:thisAtom.scene]];
//    [self.body.node.scene.physicsWorld addJoint:limit];
}

-(void) visitAtomSharpNode:(SKPhysicsBody*) anotherAtomBody{
    AtomMinusNode *thisAtom = (AtomMinusNode*)self.body.node;
    AtomSharpNode *anotherAtom = (AtomSharpNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    //    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    [((DisplayScreen *)[thisAtom.scene childNodeWithName:(NSString *)DisplayScreenName]) AtomMinusKilled];
    thisAtom.fire.particleBirthRate = 0;
    [thisAtom changeColorWithDiffAtom:anotherAtom];
}
-(void) visitPlayFieldScene:(SKPhysicsBody*) playfieldBody
{
    AtomMinusNode *atom = (AtomMinusNode*)self.body.node;
    PlayFieldScene *playfield = (PlayFieldScene*) playfieldBody.node;
//    NSLog(@"%@->%@",atom.name,playfield.name);
    atom.fire.particleBirthRate = 0;
}
@end
