//
//  TFSubStringUtility.m
//  TimeFaceV3
//
//  Created by zguanyu on 10/21/15.
//  Copyright © 2015 timeface. All rights reserved.
//

#import "TFSubStringUtility.h"
#import "RegionModel.h"
#import "TFCoreUtility.h"
#import "TFSubDataHelper.h"
#import "UserModel.h"
#import <CommonCrypto/CommonDigest.h>




#define FileHashDefaultChunkSizeForReadingData 1024*8

@implementation TFSubStringUtility



/**
 *  获取当前用户Id
 *
 *  @return
 */
- (NSString*)getUserId {
    UserModel *user = [[TFSubDataHelper shared] getCurrentUserModel];
    if (!user) {
        return @"";
    }
    return user.userId;
}

/**
 *  获取地址
 *
 *  @param location
 *
 *  @return
 */
-(NSString *) getRegionName:(NSString *)location {
    NSMutableString *region = [[NSMutableString alloc] initWithString:@""];
    NSString *current = @"";
    NSArray *array = [location componentsSeparatedByString:@","];
    for (NSString *cityId in array) {
        NSString *cityName = [self getCityName:[cityId integerValue]];
        if (cityName.length) {
            if (![current isEqualToString:cityName]) {
                current = cityName;
                [region appendFormat:@",%@",cityName];
            }
        }
    }
    
    return (region.length?[region substringFromIndex:1]:@"");
}


/**
 *  获取地区名称
 *
 *  @param cityId
 *
 *  @return
 */
-(NSString *) getCityName:(NSInteger)cityId {
    if (!cityId) {
        return nil;
    }
    NSArray *results = [[TFSubDataHelper shared] getRegion];
    NSString *cid = [NSString stringWithFormat:@"%ld",(long)cityId];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.locationId = %@", cid];
    NSArray *as = [results filteredArrayUsingPredicate: predicate];
    if (as.count) {
        NSError *error = nil;
        RegionModel *model = [[RegionModel alloc] initWithDictionary:[as objectAtIndex:0] error:&error];
        model.hasChild = [self checkRegionChild:model.locationId citys:results];
        return model.locationName;
    }
    return nil;
}

-(BOOL)checkRegionChild:(NSInteger)pid citys:(NSArray *)citys {
    NSString *cid = [NSString stringWithFormat:@"%ld",(long)pid];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.locationPid = %@", cid];
    NSArray *as = [citys filteredArrayUsingPredicate: predicate];
    if (as.count) {
        return YES;
    }
    return NO;
}

/**
 *  根据Pid获取地区
 *
 *  @param pid
 *
 *  @return
 */
-(NSMutableArray *) getCitysWithPid:(NSInteger)pid {
    NSMutableArray *citys = [NSMutableArray array];
    
    NSArray *results = [[TFSubDataHelper shared] getRegion];
    NSString *cid = [NSString stringWithFormat:@"%ld",(long)pid];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.locationPid = %@", cid];
    NSArray *as = [results filteredArrayUsingPredicate: predicate];
    
    for (NSDictionary *dic in as) {
        NSError *error = nil;
        RegionModel *model = [[RegionModel alloc] initWithDictionary:dic error:&error];
        model.hasChild = [self checkRegionChild:model.locationId citys:results];
        [citys addObject:model];
    }
    return citys;
}

- (NSString*)getFileMD5WithPath:(NSString*)path {
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path,
                                                                   FileHashDefaultChunkSizeForReadingData);
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

- (NSString *)getMimeType:(NSString *)fileType {
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                            (__bridge CFStringRef)fileType, NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    
    NSString *mimeType = (__bridge NSString *)MIMEType;
    CFRelease(MIMEType);
    return mimeType;
}

@end
