//
//  SendWX.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14/10/22.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
@interface SendWX : NSObject
+ (void) sendLinkContentWithSharingText:(NSString *) text;
@end
