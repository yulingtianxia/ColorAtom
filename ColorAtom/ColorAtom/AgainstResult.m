//
//  AgainstResult.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-10-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AgainstResult.h"

@implementation AgainstResult
@synthesize background;
@synthesize score;
@synthesize sharingText;
@synthesize sharingImage;
@synthesize win;
- (id)initWithSize:(CGSize)size score:(NSInteger)newscore win:(BOOL)isWin{
    if (self = [super initWithSize:size]) {
        score = newscore;
        sharingText = @"";
        win = isWin;
        if (win) {
            NSLog(@"win");
        }
        else{
            NSLog(@"lose");
        }
        self.backgroundColor = [SKColor clearColor];
//        背景效果
        background = [[Background alloc] init];
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
    }
    return self;
}


#pragma mark MyMethod
- (UIImage*) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


- (UIImage*) imageFromNode:(SKNode*)node
{
    SKTexture*      tex     = [self.scene.view textureFromNode:node];
    SKView*         view    = [[SKView alloc]initWithFrame:CGRectMake(0, 0, tex.size.width, tex.size.height)];
    SKScene*        scene   = [SKScene sceneWithSize:tex.size];
    SKSpriteNode*   sprite  = [SKSpriteNode spriteNodeWithTexture:tex];
    sprite.position = CGPointMake( CGRectGetMidX(view.frame), CGRectGetMidY(view.frame) );
    [scene addChild:sprite];
    [view presentScene:scene];
    
    return [self imageWithView:view];
}
@end
