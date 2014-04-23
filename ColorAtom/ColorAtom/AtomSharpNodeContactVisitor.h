//
//  AtomSharpNodeContactVisitor.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "ContactVisitor.h"

@interface AtomSharpNodeContactVisitor : ContactVisitor
-(void) visitAtomPlusNode:(SKPhysicsBody *) atomBody;
-(void) visitAtomMinusNode:(SKPhysicsBody *) atomBody;
@end
