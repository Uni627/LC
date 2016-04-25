//
//  ButtonModel.h
//  TimeFaceV3
//
//  Created by zguanyu on 11/25/15.
//  Copyright © 2015 timeface. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonModel : TFModel

/**
 *  标题
 */
@property (nonatomic, strong) NSString       *title;
/**
 *  状态
 */
@property (nonatomic, strong) NSString       *status;
/**
 *  按钮图片
 */
@property (nonatomic, strong) NSString       *iconUrl;
/**
 *  错误码
 */
@property (nonatomic, assign) NSInteger      errorCode;
/**
 *  信息
 */
@property (nonatomic, strong) NSString       *info;

@end
