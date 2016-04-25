//
//  RegionModel.h
//  TimeFaceV2
//
//  Created by 吴寿 on 14/12/4.
//  Copyright (c) 2014年 TimeFace. All rights reserved.
//

#import "TFModel.h"

@interface RegionModel : TFModel

@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, assign) NSInteger locationPid;
@property (nonatomic, assign) BOOL hasChild;

@end
