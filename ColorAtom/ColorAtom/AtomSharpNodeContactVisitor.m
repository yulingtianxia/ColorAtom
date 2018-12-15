//
//  AtomSharpNodeContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomSharpNodeContactVisitor.h"
#import "AtomNode.h"
#import "AtomSharpNode.h"
#import "AtomPlusNode.h"
#import "PlayFieldScene.h"
@implementation AtomSharpNodeContactVisitor
-(void) visitAtomPlusNode:(SKPhysicsBody *) atomBody
{
//    AtomSharpNode * sharpNode = (AtomSharpNode*)self.body.node;
//    AtomNode * atom = (AtomNode*)atomBody.node;
    //球撞Sharp后Sharp的反馈
    //        NSLog(@"%@->%@",playfield.name,atom.name);
    
}

-(void) visitAtomMinusNode:(SKPhysicsBody *) atomBody
{
    AtomSharpNode * sharpNode = (AtomSharpNode*)self.body.node;
//    AtomNode * atom = (AtomNode*)atomBody.node;
    //球撞Sharp后Sharp的反馈
    //    NSLog(@"%@->%@",playfield.name,atom.name);
    [sharpNode runAction:[SKAction runBlock:^{
        [sharpNode destroy];
    }]];
    
    
    
}
@end
