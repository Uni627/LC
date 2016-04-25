//
//  Utility.m
//  TimeFaceV3
//
//  Created by zguanyu on 10/21/15.
//  Copyright © 2015 timeface. All rights reserved.
//

#import "Utility.h"
#import "TFSubStringUtility.h"
#import "ZipArchive.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utility

+(instancetype)sharedUtility {
    static Utility* utility = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (!utility) {
            utility = [[self alloc] init];
        }
    });
    return utility;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark - NSString

- (NSString*)getUserId {
    if (self.stringUtility) {
        TFSubStringUtility *subString = (TFSubStringUtility*)self.stringUtility;
        return [subString getUserId];
    }
    return @"";
}

#pragma mark -
/**
 *  获取地址
 *
 *  @param location
 *
 *  @return
 */
-(NSString *) getRegionName:(NSString *)location {
    if (self.stringUtility) {
        TFSubStringUtility *subString = (TFSubStringUtility *)self.stringUtility;
        return [subString getRegionName:location];
    }
    return nil;
}


/**
 *  获取地区名称
 *
 *  @param cityId
 *
 *  @return
 */
-(NSString *) getCityName:(NSInteger)cityId {
    if (self.stringUtility) {
        TFSubStringUtility *subString = (TFSubStringUtility *)self.stringUtility;
        return [subString getCityName:cityId];
    }
    return nil;
}
/**
 *  根据Pid获取地区
 *
 *  @param pid
 *
 *  @return
 */
- (NSMutableArray *)getCitysWithPid:(NSInteger)pid {
    if (self.stringUtility) {
        TFSubStringUtility *subString = (TFSubStringUtility *)self.stringUtility;
        return [subString getCitysWithPid:pid];
        
    }
    return nil;
    
}
/**
 *  判定个人中心我的时光属于自己还是他人
 *
 *  @param memberId
 *
 *  @return
 */
-(MemberType)checkMemberType:(NSString *)memberId {
    MemberType memberType = MemberTypeOthers;
    NSString *userId = [self getUserId];
    if ([userId isEqualToString:memberId]) {
        memberType = MemberTypeMyself;
    }
    return memberType;
}

/**
 *  使用颜色生成1*1图片
 *
 *  @param color
 *
 *  @return
 */
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  使用颜色生成指定尺寸图片
 *
 *  @param color
 *  @param width
 *  @param height
 *
 *  @return
 */
- (UIImage *)createImageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height {
    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  使用颜色值、透明度生成图片
 *
 *  @param color 颜色值
 *  @param alpha 透明度
 *
 *  @return 图片对象
 */
- (UIImage *)createImageWithColor:(UIColor *)color alpha:(CGFloat)alpha {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextSetAlpha(context, alpha);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (NSString*)getFileMD5WithPath:(NSString*)path {
    if (self.stringUtility) {
        TFSubStringUtility *subString = (TFSubStringUtility*)self.stringUtility;
        return [subString getFileMD5WithPath:path];
    }
    return nil;
}

- (NSString *)getMimeType:(NSString *)fileType {
    if (self.stringUtility) {
        TFSubStringUtility *subString = (TFSubStringUtility*)self.stringUtility;
        return [subString getMimeType:fileType];
    }
    return nil;
    
}

/**
 *  ARGB转为颜色值
 *
 *  @param argb
 *
 *  @return
 */
-(UIColor *)getColorFromHexARGB:(NSString *)hexColor {
    //剔除#
    hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@""];
    unsigned int alpha = 1, red = 0, green = 0, blue = 0;
    NSRange range;
    range.length = 2;
    
    if (hexColor.length == 6) {
        [[TFStyle globalStyleSheet] getColorByHex:hexColor];
    } else if (hexColor.length == 8) {
        range.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&alpha];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
        range.location = 6;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    }
    
    return [UIColor colorWithRed:(float)(red/255.0f)
                           green:(float)(green/255.0f)
                            blue:(float)(blue/255.0f)
                           alpha:(float)(alpha/255.0f)];
    
    
}
- (NSString*)getLastDialogId:(NSString *)userId friendId:(NSString *)friendId {
    DialogDatabaseManager *manager = [[DialogDatabaseManager alloc]init];
    NSString *dialogId = @"0";
    if ([manager isTableDataExist]) {
        DialogModel *model  = [manager getLastDialogInfoByUserId:userId friendId:friendId];
        if (model) {
            dialogId = model.dialogId;
        }
    }
    return dialogId;
}

-(NSString *) localWebImage:(NSString *)content path:(NSString *)path {
    NSString *urlPattern = @"<img[^>]+?src=[\"']?([^>'\"]+)[\"']?";
    NSError *error = [NSError new];
    NSString *newcontent = content;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlPattern options:NSRegularExpressionCaseInsensitive error:&error ];
    
    //match 这块内容非常强大
    NSUInteger counts =[regex numberOfMatchesInString:content options:NSMatchingReportProgress range:NSMakeRange(0, [content length])];//匹配到的次数
    if(counts > 0){
        NSArray* matches = [regex matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, [content length])];
        
        for (NSTextCheckingResult *match in matches) {
            NSInteger count = [match numberOfRanges];//匹配项
            for(NSInteger index = 0;index < count;index++){
                NSRange halfRange = [match rangeAtIndex:index];
                if (index == 1) {
                    NSString *imageUrl = [content substringWithRange:halfRange];
                    NSArray *array = [imageUrl componentsSeparatedByString:@"/"];
                    NSString *imageUrlName = [array lastObject];
                    NSArray *arrayMame = [imageUrlName componentsSeparatedByString:@"@"];
                    imageUrlName = [arrayMame firstObject];
                    
                    NSString *localimage = [NSString stringWithFormat:@"images/%@",imageUrlName];
                    newcontent = [newcontent stringByReplacingOccurrencesOfString:imageUrl withString:localimage];
                    //                    if ([imageUrl containsString:@"http://"]) {
                    //                         NSString *localimage = [NSString stringWithFormat:@"images/%@.jpg",[[Utility sharedUtility] getMD5StringFromNSString:imageUrl]];
                    //
                    //                        newcontent = [newcontent stringByReplacingOccurrencesOfString:imageUrl withString:localimage];
                    //                    }
                }
            }
        }
    }
    return newcontent;
}

- (NSString *)realFilePathForURL:(NSURL *)URL {
    NSAssert(URL,@"URL is nil");
    NSError *error = nil;
    NSString *hashedURLString = [self getMD5StringFromNSString:[URL absoluteString]];
    NSString *homeDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    homeDirectory = [homeDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@/",[self getUserId],hashedURLString]];
    BOOL isDirectoryCreated = [[NSFileManager defaultManager] createDirectoryAtPath:homeDirectory
                                                        withIntermediateDirectories:YES
                                                                         attributes:nil
                                                                              error:&error];
    if (!isDirectoryCreated) {
        NSException *exception = [NSException exceptionWithName:NSInternalInconsistencyException
                                                         reason:@"Failed to crate cache directory"
                                                       userInfo:@{ NSUnderlyingErrorKey : error }];
        @throw exception;
    }
    return homeDirectory;
    
}

- (void)unZipFile:(NSString *)zipFile
       targetPath:(NSString *)targetPath
        completed:(void (^)(bool result,NSError *error))completedBlock {
    
    NSAssert(completedBlock,@"completedBlock is nil");
    [[NSFileManager defaultManager] removeItemAtPath:targetPath error:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        ZipArchive* zip = [[ZipArchive alloc] init];
        BOOL result = [zip UnzipOpenFile:zipFile];
        NSError *error = nil;
        if (result) {
            result = [zip UnzipFileTo:targetPath overWrite:YES];
            [zip CloseZipFile2];
            if (result) {
                //删除原始文件
                [[NSFileManager defaultManager] removeItemAtPath:zipFile error:&error];
                if (error) {
                    NSLog(@"delete file error:%@",[error debugDescription]);
                }
                //移动文件
                NSArray *contentArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:targetPath error:&error];
                
                for (NSString *path in contentArray) {
                    BOOL isDirectory;
                    NSString *currentPath = [NSString stringWithFormat:@"%@/%@/",targetPath,path];
                    if ([[NSFileManager defaultManager] fileExistsAtPath:currentPath
                                                             isDirectory:&isDirectory]) {
                        for (NSString *entry in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:currentPath
                                                                                                    error:&error]) {
                            NSLog(@"entry:%@",entry);
                            //是目录,移动当前目录所有文件到上层
                            [[NSFileManager defaultManager] moveItemAtPath:[currentPath stringByAppendingPathComponent:entry]
                                                                    toPath:[targetPath stringByAppendingPathComponent:entry]
                                                                     error:&error];
                        }
                        if (!error) {
                            //删除当前目录内容
                            [[NSFileManager defaultManager] removeItemAtPath:currentPath error:&error];
                        }
                    }
                }
            }
        }
        
        completedBlock(result ,error);
        
    });
}
/**
 *  屏幕截图
 *
 *  @param orgView
 *  @param getDeviceId
 *
 *  @return
 */
-(UIImage *)getImageFromView:(UIView *)orgView  scale:(CGFloat)scale{
    UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, scale);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  从NSData获取md5
 *
 *  @param data <#data description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)getMD5StringFromNSData:(NSData *)data {
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([data bytes], (CC_LONG)[data length], digest);
    NSMutableString *result = [NSMutableString string];
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat: @"%02x", (int)(digest[i])];
    }
    return [result copy];
}

/**
 *  bookType转换成podType,不能识别极速成书产生的时光书，因为其bookType也为0
 */
- (NSInteger)bookTypeToPodType:(NSInteger)bookType {
    NSInteger podType = 0;
    switch (bookType) {
        case 0: {
            //时光书
            podType = 2;
            break;
        }
        case 1: {
            //微信书
            podType = 3;
            break;
        }
        case 2: {
            //圈时光书
            podType = 4;
            break;
        }
        case 4: {
            //QQ书
            podType = 6;
            break;
        }
        case 5: {
            //博客书
            podType = 7;
            break;
        }
        default:
            break;
    }
    return podType;
}

- (NSInteger)getCurrentWeekIndexWithData:(NSTimeInterval)date {
    NSInteger weekIndex = 1;
    NSString *str = [self stringFromTimeInterval:date format:@"yyyy-MM-dd HH:mm:ss"];
    NSArray *subArray = [str componentsSeparatedByString:@" "];
    NSString *lastStr = [subArray firstObject];
    NSArray *tempArray = [lastStr componentsSeparatedByString:@"-"];
    NSInteger currentMoth = [tempArray[1] integerValue];
    NSInteger currentDay = [tempArray[2] integerValue];
    
    NSInteger totalDayCount = [self getTotalDayWithMonth:currentMoth day:currentDay];
    
    if ([[tempArray firstObject] integerValue] == 2016) {
        if (currentMoth == 1 && currentDay <= 3) {
            weekIndex = 1;
        } else {
            NSInteger index = (totalDayCount - 3) % 7;
            if (index == 0) {
                weekIndex = ((totalDayCount - 3) / 7) + 1;
            } else {
                weekIndex = ((totalDayCount - 3) / 7) + 2;
            }
        }
    }
    return weekIndex;
}

- (NSInteger)getTotalDayWithMonth:(NSInteger)month day:(NSInteger)day {
    NSInteger totalCount = 0;
    NSArray *array = @[@31,@29,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
    for (int i = 0; i < month - 1; i++) {
        totalCount += [array[i] integerValue];
    }
    totalCount += day;
    return totalCount;
}

@end
