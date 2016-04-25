//
//  AdModel.h
//  TimeFaceV3
//
//  Created by zguanyu on 11/3/15.
//  Copyright © 2015 timeface. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdModel : TFModel

/**
 *  广告id
 */
@property (nonatomic, strong) NSString     *adId;
/**
 *  广告图片高度（原图）
 */
@property (nonatomic, assign) CGFloat      adImgHeight;
/**
 *  图片地址
 */
@property (nonatomic, strong) NSString     * adImgUrl;
/**
 *  广告图片宽度（原图）
 */
@property (nonatomic, assign) CGFloat      adImgWidth;
/**
 *  广告执行的uri 调用网页web:http:**********
 *  调用时光 time:timeId
 *  调用话题 topic:topicId
 *  调用时光书 book:bookId
 *  调用POD预览 pod:podId
 *  调用个人中心user:userId
 *  调用扫一扫 scan:
 */
@property (nonatomic, strong) NSString     * adUri;
/**
 *  停留时间
 */
@property (nonatomic, assign) NSInteger     showTime;

@property (nonatomic, assign) NSInteger    point;


@end
