//
//  Define.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-11.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#ifndef ColorAtom_Define_h
#define ColorAtom_Define_h

#define WEIBO_APP_KEY  @"2357960990"
#define WEIBO_APP_SECRET @"a3f965bb0d903cb4d8f1523c70e1ecb2"

static CGFloat const ZERO  = 0.5;
static CGFloat const AtomRadius = 25;

static NSString const *AtomName = @"atom";
static NSString const *AtomPlusName = @"atomplus";
static NSString const *AtomMinusName = @"atomminus";
static NSString const *AtomSharpName = @"atomsharp";
static NSString const *PlayFieldName = @"playfield";
static NSString const *DisplayScreenName = @"displayscreen";


static NSString const *ATOMCOLOR = @"atomcolor";

static CGFloat const AtomPlusVx = 0;
static CGFloat const AtomPlusVy = 1000;
static CGFloat const AtomMinusVx = 300;
static CGFloat const AtomMinusVy = -1000;
static CGFloat const AtomSharpVx = 0;
static CGFloat const AtomSharpVy = 500;

static CGFloat const AtomPlusCreateInterval = 0.5;
static CGFloat const AtomMinusCreateInterval = 1;

static NSString const *CreateAtomPlus = @"createatomplus";

static NSString const *NormalMode = @"NORMAL MODE";
static NSString const *NightMode = @"NIGHT MODE";
static NSString const *SecretMode = @"SECRET MODE";
#endif
