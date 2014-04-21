//
//  PlayFieldSceneContactVisitor.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "ContactVisitor.h"

@interface PlayFieldSceneContactVisitor : ContactVisitor
//边界被atom撞了
-(void) visitAtomPlusNode:(SKPhysicsBody *) atomBody;
-(void) visitAtomMinusNode:(SKPhysicsBody *) atomBody;

@end
