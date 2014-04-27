//
//  YXYAtomNode.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Define.h"
#import "RandomHelper.h"
#import "NodeCategories.h"
#import "Spark.h"
@interface AtomNode : SKSpriteNode

- (id)initWithName:(NSString *)name ImageName:(NSString *)imageName;
-(void) changeColorWithSameAtom:(AtomNode *) atom;
-(void) changeColorWithDiffAtom:(SKSpriteNode *) atom;
@end
