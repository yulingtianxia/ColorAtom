//
//  SendWX.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14/10/22.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "SendWX.h"

@implementation SendWX

+ (void) sendLinkContentWithSharingText:(NSString *) text
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = text;
    message.description = @"速度与激情！荣耀与勇气！快来与全球的玩家在排行榜上争夺冠军吧！或是与好基友们来一发对战，炫耀出你的辉煌！";
    [message setThumbImage:[UIImage imageNamed:@"shareThumb"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"https://itunes.apple.com/cn/app/coloratom/id918469696?mt=8";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

@end
