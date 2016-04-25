//
//  TFSubStringUtility.h
//  TimeFaceV3
//
//  Created by zguanyu on 10/21/15.
//  Copyright © 2015 timeface. All rights reserved.
//

#import "TFStringUtility.h"

@interface TFSubStringUtility : TFStringUtility


/**
 *  获取当前用户Id
 *
 *  @return
 */
- (NSString*)getUserId;

/**
 *  获取地址
 *
 *  @param location
 *
 *  @return
 */
-(NSString *) getRegionName:(NSString *)location;

/**
 *  获取地区名称
 *
 *  @param cityId
 *
 *  @return
 */
-(NSString *) getCityName:(NSInteger)cityId;
/**
 *  根据Pid获取地区
 *
 *  @param pid
 *
 *  @return
 */
-(NSMutableArray *) getCitysWithPid:(NSInteger)pid ;


/**
 *  获取文件md5
 *
 *  @param path
 *
 *  @return
 */
- (NSString*)getFileMD5WithPath:(NSString*)path;

/**
 *  获取mimetype
 *
 *  @param fileType
 *
 *  @return
 */
- (NSString *)getMimeType:(NSString *)fileType;
@end
