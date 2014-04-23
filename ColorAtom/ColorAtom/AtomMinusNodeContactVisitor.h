//
//  AtomMinusContactVisitor.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "ContactVisitor.h"

@interface AtomMinusNodeContactVisitor : ContactVisitor
/*Atom访问了Atom，同类碰撞*/
-(void) visitAtomPlusNode:(SKPhysicsBody*) anotherAtomBody;
-(void) visitAtomMinusNode:(SKPhysicsBody*) anotherAtomBody;
/*Atom访问了边界，也就是球撞墙上了*/
-(void) visitPlayFieldScene:(SKPhysicsBody*) playfieldBody;
/*撞上了sharp*/
-(void) visitAtomSharpNode:(SKPhysicsBody*) anotherAtomBody;
@end
