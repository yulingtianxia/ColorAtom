//
//  YXYGameOverScene.h
//  MyFirstGame
//
//  Created by 杨萧玉 on 14-3-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Background.h"
@import Social;
@interface GameOverScene : SKScene
@property Background *background;
@property NSInteger score;
@property (nonatomic) NSString *sharingText;
@property (nonatomic) UIImage *sharingImage;

-(id)initWithSize:(CGSize)size Score:(NSInteger) score;
@end
