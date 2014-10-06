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
    kMessageTypeGameBeginRequest = 0,
    kMessageTypeGameBeginResponse,
    kMessageTypePosition,
    kMessageTypeGameOver,
    kMessageTypeReplayRequest,
    kMessageTypeReplayResponse
} MessageType;
typedef struct {
    MessageType messageType;
} Message;
typedef struct {
    Message message;
} MessageGameBeginRequest;
typedef struct {
    Message message;
} MessageGameBeginResponse;
typedef struct {
    Message message;
//    BOOL player1Won;
} MessageGameOver;
typedef struct {
    Message message;
    CGPoint position;
} MessagePosition;
typedef struct {
    Message message;
    
} MessageReplayRequest;
typedef struct {
    Message message;
    BOOL agree;
} MessageReplayResponse;
#endif
