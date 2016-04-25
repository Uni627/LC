//
//  DialogModel.h
//  TimeFaceV2
//
//  Created by zguanyu on 12/17/14.
//  Copyright (c) 2014 TimeFace. All rights reserved.
//

#import "TFModel.h"

@interface DialogModel : TFModel

/**
 *  对话类型 0：我的 1：对方的
 */
@property (nonatomic, assign) NSInteger from;

/**
 *  对话内容
 */
@property (nonatomic, copy) NSString *content;

/**
 *  对话时间戳
 */
@property (nonatomic, assign) NSTimeInterval time;

/**
 *  对话Id
 */
@property (nonatomic, copy) NSString *dialogId;

/**
 *  时间分组
 */
@property (nonatomic, copy) NSString *timeGroup;

/**
 *  用户头像
 */
@property (nonatomic, copy) NSString *avatarIcon;
/**
 *  用户Id
 */
@property (nonatomic, copy) NSString *userId;
/**
 *  朋友Id
 */
@property (nonatomic, copy) NSString *friendId;

@end
