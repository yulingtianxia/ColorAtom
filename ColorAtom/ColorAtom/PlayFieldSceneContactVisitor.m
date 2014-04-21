//
//  PlayFieldSceneContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "PlayFieldSceneContactVisitor.h"
#import "AtomNode.h"
#import "PlayFieldScene.h"
@implementation PlayFieldSceneContactVisitor
-(void) visitAtomPlusNode:(SKPhysicsBody *) atomBody
{
    PlayFieldScene * playfield = (PlayFieldScene*)self.body.node;
    AtomNode * atom = (AtomNode*)atomBody.node;
    //球撞边界后边界的反馈
//        NSLog(@"%@->%@",playfield.name,atom.name);
    
}

-(void) visitAtomMinusNode:(SKPhysicsBody *) atomBody
{
    PlayFieldScene * playfield = (PlayFieldScene*)self.body.node;
    AtomNode * atom = (AtomNode*)atomBody.node;
    //球撞边界后边界的反馈
//    NSLog(@"%@->%@",playfield.name,atom.name);
    
}

@end
