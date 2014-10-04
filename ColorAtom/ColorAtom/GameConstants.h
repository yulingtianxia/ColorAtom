//
//  GameConstants.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-9-14.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#ifndef ColorAtom_GameConstants_h
#define ColorAtom_GameConstants_h
#define kHighScoreLeaderboardIdentifier @"com.yulingtianxia.ColorAtom.HighScores"
typedef enum {
    kMessageTypeGameBegin = 0,
    kMessageTypePosition,
    kMessageTypeGameOver
} MessageType;
typedef struct {
    MessageType messageType;
} Message;
typedef struct {
    Message message;
//    BOOL player1Won;
} MessageGameOver;
typedef struct {
    Message message;
    CGPoint position;
} MessagePosition;

#endif
