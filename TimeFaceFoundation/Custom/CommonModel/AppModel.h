//
//  AppModel.h
//  TimeFace
//
//  Created by boxwu on 15/1/30.
//  Copyright (c) 2015年 TimeFace. All rights reserved.
//

#import "TFModel.h"

@interface AppModel : TFModel

@property (nonatomic, strong) NSString           *version;
@property (nonatomic, strong) NSString           *trackViewUrl;
@property (nonatomic, strong) NSString           *releaseNotes;

@end
