//
//  WeiboShareButton.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-27.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "WeiboShareButton.h"
#import "GameOverScene.h"
#import "SendWX.h"

@implementation WeiboShareButton
-(id)init{
    if (self = [super init]) {
        self.fontName = @"Transformers";
        self.text = NSLocalizedString(@"SHARE SCORE", @"");
        self.fontSize = 20;
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    GameOverScene *gameover = (GameOverScene *)self.scene;
    gameover.sharingImage = [gameover imageFromNode:gameover];
    NSArray *activityItems;
    if (gameover.sharingImage != nil) {
        activityItems = @[gameover.sharingText, gameover.sharingImage];
    } else {
        activityItems = @[gameover.sharingText];
    }
    
    NSString * lang = (NSString *)[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    if ([lang isEqualToString:@"zh-Hans"]) {
        [SendWX sendLinkContentWithSharingText:gameover.sharingText];
    }
    else{
        UIActivityViewController *activityController =
        [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                          applicationActivities:nil];
        
        [(UIViewController *)[gameover.view nextResponder] presentViewController:activityController
                                                                        animated:YES completion:nil];
    }
    
}
@end
