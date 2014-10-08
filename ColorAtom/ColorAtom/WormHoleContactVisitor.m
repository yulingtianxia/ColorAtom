//
//  WormHoleContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-8.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "WormHoleContactVisitor.h"
#import "AtomNode.h"
#import "AtomSharpNode.h"

@implementation WormHoleContactVisitor
-(void) visitAtomPlusNode:(SKPhysicsBody *) atomBody
{
    [((AtomNode *)atomBody.node) changeColorWithWormHole:(WormHole *)self.body.node];
}

-(void) visitAtomMinusNode:(SKPhysicsBody *) atomBody
{
    [((AtomNode *)atomBody.node) changeColorWithWormHole:(WormHole *)self.body.node];
}

-(void) visitAtomSharpNode:(SKPhysicsBody*) atomBody{
    AtomSharpNode * sharpNode = (AtomSharpNode*)atomBody.node;
    [sharpNode runAction:[SKAction runBlock:^{
        [sharpNode destroy];
    }]];
}
@end
