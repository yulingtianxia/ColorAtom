//
//  AgainstResult.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class Background;
@class PlayAgainButton;
@import Social;

@interface AgainstResult : SKScene <GameKitHelperProtocol>
@property Background *background;
@property (nonatomic) NSString *sharingText;
@property (nonatomic) UIImage *sharingImage;
@property (nonatomic) BOOL win;
@property (nonatomic) PlayAgainButton *playAgain;

- (instancetype)initWithSize:(CGSize)size win:(BOOL)win NS_DESIGNATED_INITIALIZER;
- (UIImage*) imageFromNode:(SKNode*)node;

@end
