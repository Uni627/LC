//
//  DialogDatabaseManager.m
//  TimeFace
//
//  Created by zguanyu on 3/29/14.
//  Copyright (c) 2014 TNMP. All rights reserved.
//

#import "DialogDatabaseManager.h"
//#import "Utility.h"
#import "NSString+Emojize.h"

@implementation DialogDatabaseManager
@synthesize dialogDatabase = _dialogDatabase;


- (BOOL)openDataBase {
    NSString *dbPath = [[Utility sharedUtility] getDirectoryDBPath:@"timeFaceDatabase"];
    self.dialogDatabase = [FMDatabase databaseWithPath:dbPath];
    if (![self.dialogDatabase open]) {
        NSLog(@"could not open dialog db");
        return NO;
    }
    return YES;
}

- (void)createTable {
    if (![self openDataBase]) {
        return;
    }
    [self.dialogDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS Table_dialogV2(userId text,friendId text,dialogId double,avatarIcon text,dialogContent text,dialogType int,dialogTime double,dialogGroup text) "];
    
    [self.dialogDatabase close];
}

- (BOOL)isTableDataExist {
    if (![self openDataBase]) {
        return NO;
    }
    FMResultSet *rs = [self.dialogDatabase executeQuery:@"select count(*) from Table_dialogV2"];
    [rs next];
    int value = [rs intForColumn:@"count(*)"];
    [rs close];
    if (value > 0) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)insertDialogInfoToDatabase:(DialogModel *)model {
    [self openDataBase];
    if ([self isDialogExist:model]) {
        return YES;
    }
    NSString *sql_insert = [NSString stringWithFormat:@"insert into Table_dialogV2 (userId,friendId,dialogId,avatarIcon,dialogContent,dialogType,dialogTime,dialogGroup)values('%@','%@',%ld,'%@','%@',%ld,%f,'%@')",model.userId,model.friendId,(long)[model.dialogId doubleValue],model.avatarIcon,[model.content stringEmojized],(long)model.from,model.time,model.timeGroup];
    [self.dialogDatabase executeUpdate:sql_insert];
    [self.dialogDatabase close];
    return YES;
}

- (BOOL)isDialogExist:(DialogModel *)model {
    if (![self isTableDataExist]) {
        return NO;
    }
    NSString *sql_string = [NSString stringWithFormat:@"select count(*) from Table_dialogV2 where dialogId = %ld and userId = '%@' and friendId = '%@'",(long)[model.dialogId doubleValue],model.userId,model.friendId];
    FMResultSet *rs = [self.dialogDatabase executeQuery:sql_string,model.dialogId];
    [rs next];
    int value = [rs intForColumn:@"count(*)"];
    [rs close];
    if (value > 0) {
        return YES;
    }else {
        return NO;
    }
    
}

- (void)insertDialogArrayToDatabase:(NSArray *)array {
    [self openDataBase];
    for (DialogModel *model in array) {
        if (![self isDialogExist:model]) {
            NSString *sql_insert = [NSString stringWithFormat:@"insert into Table_dialogV2 (userId,friendId,dialogId,avatarIcon,dialogContent,dialogType,dialogTime,dialogGroup)values('%@','%@',%ld,'%@','%@',%ld,%f,'%@')",model.userId,model.friendId,(long)[model.dialogId doubleValue] ,model.avatarIcon,[model.content stringEmojized],(long)model.from,model.time,model.timeGroup];
            NSLog(@"sql_string : %@",sql_insert);
            [self.dialogDatabase executeUpdate:sql_insert];
        }
    }
    [self.dialogDatabase close];
}

- (NSArray*)getDialogArrayBeforDialog:(NSString *)dialogId userId:(NSString *)userId friendId:(NSString *)friendId arraySize:(int)num {
    [self openDataBase];
    NSString *sql_string = [NSString stringWithFormat:@" select  * from (select  * from Table_dialogV2 where dialogId < %ld and userId = '%@' and friendId = '%@' order by dialogId desc limit 0,%d ) a order by dialogId asc",(long)[dialogId doubleValue],userId,friendId, num];
    NSLog(@"sql_string = %@",sql_string);
    FMResultSet *rs = [self.dialogDatabase executeQuery:sql_string];
    NSLog(@"resultset size %@",rs );
    NSMutableArray *array = [self parseDataFromDatabase:rs];
    [self.dialogDatabase close];
    return array;
}


- (NSArray*)getDialogArrayByUserId:(NSString *)userId friendId:(NSString *)friendId arraySize:(int)arraySize {
    [self openDataBase];
    NSString *sql_string = [NSString stringWithFormat:@" select  * from (select  * from Table_dialogV2 where userId = '%@' and friendId = '%@' order by dialogId desc  ) a order by dialogId asc",userId,friendId];
    NSLog(@"sql_string = %@",sql_string);
    FMResultSet *rs = [self.dialogDatabase executeQuery:sql_string];
    NSLog(@"resultset size %@",rs );
    NSMutableArray *array = [self parseDataFromDatabase:rs];
    [self.dialogDatabase close];
    return array;
}

- (DialogModel*)getLastDialogInfoByUserId:(NSString *)userId friendId:(NSString *)friendId {
    [self openDataBase];
    NSString *sql_string = [NSString stringWithFormat:@"select * from Table_dialogV2 where userId = '%@' and friendId = '%@' order by dialogId desc limit 0,1",userId,friendId];
    NSLog(@"sql_string = %@",sql_string);
    FMResultSet *rs = [self.dialogDatabase executeQuery:sql_string];
    NSMutableArray *array = [self parseDataFromDatabase:rs];
    DialogModel *model = nil;
    if (array.count) {
        model = [array objectAtIndex:0];
    }
    [self.dialogDatabase close];
    return model;
}

- (NSMutableArray*)parseDataFromDatabase:(FMResultSet*)rs {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    while ([rs  next]) {
        DialogModel *model = [[DialogModel alloc]init];
        model.userId = [rs stringForColumn:@"userId"];
        model.friendId = [rs stringForColumn:@"friendId"];
        model.dialogId = [NSString stringWithFormat:@"%ld",(long)[rs doubleForColumn:@"dialogId"]];
        model.avatarIcon = [rs stringForColumn:@"avatarIcon"];
        model.content = [[rs stringForColumn:@"dialogContent"] emojizedString];
        model.from = [rs intForColumn:@"dialogType"];
        model.time = [rs doubleForColumn:@"dialogTime"];
        model.timeGroup = [rs stringForColumn:@"dialogGroup"];
        [array addObject:model];
        
    }
    [rs close];
    return array;
}

- (void)deleteDialogByDialogId:(NSString *)dialogId UserId:(NSString *)userId friendId:(NSString *)friendId {
    [self openDataBase];
    NSString *sql_string = [NSString stringWithFormat:@"delete from Table_dialogV2 where dialogId = %ld and userId = '%@' and friendId = '%@'",(long)[dialogId doubleValue],userId,friendId];
    NSLog(@"sql_string = %@",sql_string);
    [self.dialogDatabase executeUpdate:sql_string];
    [self.dialogDatabase close];
}

- (void)deleteDialogsByUserId:(NSString *)userId friendId:(NSString *)friendId {
    [self openDataBase];
    NSString *sql_string = [NSString stringWithFormat:@"delete from Table_dialogV2 where userId = '%@' and friendId = '%@'",userId,friendId];
    NSLog(@"sql_string = %@",sql_string);
    [self.dialogDatabase executeUpdate:sql_string];
    [self.dialogDatabase close];
    
}

- (void)deleteAllDialog {
    [self openDataBase];
    NSString *sql_string = [NSString stringWithFormat:@"delete from Table_dialogV2 where userId = '%@'",[[Utility sharedUtility] getUserId]];
    [self.dialogDatabase executeUpdate:sql_string];
    [self.dialogDatabase close];
}

- (void)dealloc {
    
}

@end
