//
//  AgainstPlayButton.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class AgainstPlayScene;
@interface AgainstPlayButton : SKLabelNode
@property AgainstPlayScene* myScene;

-(void)presentScene;
@end
