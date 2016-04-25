//
//  DialogDatabaseManager.h
//  TimeFace
//
//  Created by zguanyu on 3/29/14.
//  Copyright (c) 2014 TNMP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "DialogModel.h"


@interface DialogDatabaseManager : NSObject
{
    FMDatabase *_dialogDatabase;
}

@property (nonatomic, retain) FMDatabase *dialogDatabase;
/**
 *  判断表格是否存在
 *
 *  @return
 */
- (BOOL)isTableDataExist;

/**
 *  打开数据库，若第一次打开则创建数据库
 *
 *  @return
 */
- (BOOL)openDataBase;
/**
 *  创建表结构
 */
- (void)createTable;

/**
 *  插入一条对话信息
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)insertDialogInfoToDatabase:(DialogModel*)model;

/**
 *  判断表中是否已经存在该条对话信息
 *
 *  @param model
 *
 *  @return
 */
- (BOOL)isDialogExist:(DialogModel*)model;

/**
 *  插入一个对话的数组
 *
 *  @param array 
 */
- (void)insertDialogArrayToDatabase:(NSArray*)array;

/**
 *  返回某条对话之前的n条对话数组
 *
 *  @param model
 *  @param num
 *
 *  @return 
 */
- (NSArray*)getDialogArrayBeforDialog:(NSString*)dialogId userId:(NSString*)userId friendId:(NSString*)friendId arraySize:(int)num;


- (NSArray*)getDialogArrayByUserId:(NSString *)userId friendId:(NSString *)friendId arraySize:(int)arraySize;

/**
 *  返回dialogId最大的一条对话信息
 *
 *  @param userId
 *  @param friendId
 *
 *  @return 
 */
- (DialogModel*)getLastDialogInfoByUserId:(NSString*)userId friendId:(NSString*)friendId;

/**
 *  删除某条对话
 *
 *  @param dialogId
 *  @param userId
 *  @param friendId     
 */
- (void)deleteDialogByDialogId:(NSString*)dialogId UserId:(NSString*)userId friendId:(NSString*)friendId;

/**
 *  删除和某好友之间的对话
 *
 *  @param userId
 *  @param friendId 
 */
- (void)deleteDialogsByUserId:(NSString*)userId friendId:(NSString*)friendId;

/**
 *  删除所有对话
 */
- (void)deleteAllDialog;


@end
