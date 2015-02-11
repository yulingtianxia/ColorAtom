//
//  YXYGameOverScene.h
//  MyFirstGame
//
//  Created by 杨萧玉 on 14-3-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Background.h"
#import "MainScene.h"
@import Social;
@interface GameOverScene : SKScene
@property Background *background;
@property NSInteger score;
@property (nonatomic) NSString *sharingText;
@property (nonatomic) UIImage *sharingImage;
@property (nonatomic) NSString *mode;
-(instancetype)initWithSize:(CGSize)size score:(NSInteger) newscore mode:(NSString *)newmode NS_DESIGNATED_INITIALIZER;
- (UIImage*) imageFromNode:(SKNode*)node;
@end
