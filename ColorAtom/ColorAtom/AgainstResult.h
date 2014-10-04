//
//  AgainstResult.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Background.h"
@import Social;

@interface AgainstResult : SKScene
@property Background *background;
@property NSInteger score;
@property (nonatomic) NSString *sharingText;
@property (nonatomic) UIImage *sharingImage;
@property (nonatomic) BOOL win;
- (id)initWithSize:(CGSize)size score:(NSInteger)newscore win:(BOOL)win;
- (UIImage*) imageFromNode:(SKNode*)node;

@end
