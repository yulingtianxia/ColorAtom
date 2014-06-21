//
//  PlayAgainButton.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-27.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PlayAgainButton : SKLabelNode
@property NSString *modeString;
-(id)initWithMode:(NSString *)newmode;
@end
