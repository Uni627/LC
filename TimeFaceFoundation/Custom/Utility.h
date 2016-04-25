//
//  Utility.h
//  TimeFaceV3
//
//  Created by zguanyu on 10/21/15.
//  Copyright © 2015 timeface. All rights reserved.
//

#import "TFCoreUtility.h"
#import "DialogDatabaseManager.h"
#import "DialogModel.h"
#import "AppMacro.h"
@interface Utility : TFCoreUtility

#pragma mark - NSString
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
- (NSMutableArray *)getCitysWithPid:(NSInteger)pid;

-(MemberType)checkMemberType:(NSString *)memberId;

/**
 *  使用颜色生成1*1图片
 *
 *  @param color
 *
 *  @return
 */
- (UIImage *)createImageWithColor:(UIColor *)color;

/**
 *  使用颜色生成指定尺寸图片
 *
 *  @param color
 *  @param width
 *  @param height
 *
 *  @return
 */
- (UIImage *)createImageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

/**
 *  使用颜色值、透明度生成图片
 *
 *  @param color 颜色值
 *  @param alpha 透明度
 *
 *  @return 图片对象
 */
- (UIImage *)createImageWithColor:(UIColor *)color alpha:(CGFloat)alpha;

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

/**
 *  ARGB转为颜色值
 *
 *  @param argb
 *
 *  @return
 */
-(UIColor *)getColorFromHexARGB:(NSString *)hexColor;


/**
 *  获得本地最新得一条对话Id
 *
 *  @param userId
 *  @param friendId
 *
 *  @return
 */
- (NSString*)getLastDialogId:(NSString *)userId friendId:(NSString *)friendId;

-(NSString *) localWebImage:(NSString *)content path:(NSString *)path;

- (NSString *)realFilePathForURL:(NSURL *)URL;

- (void)unZipFile:(NSString *)zipFile
       targetPath:(NSString *)targetPath
        completed:(void (^)(bool result,NSError *error))completedBlock;
/**
 *  屏幕截图
 *
 *  @param orgView
 *  @param getDeviceId
 *
 *  @return
 */
-(UIImage *)getImageFromView:(UIView *)orgView  scale:(CGFloat)scale;

/**
 *  从NSData获取md5
 *
 *  @param data <#data description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)getMD5StringFromNSData:(NSData *)data;

/**
 *  bookType转换成podType
 */
- (NSInteger)bookTypeToPodType:(NSInteger)bookType;

- (NSInteger)getCurrentWeekIndexWithData:(NSTimeInterval)date;

@end
