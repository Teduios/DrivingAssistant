//
//  HomeHeader.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeHeader : NSObject

//当前温度
@property (nonatomic, copy) NSString *currentTemp;
//天气描述
@property (nonatomic, copy) NSString *weatherDesc;
//天气iconURL
@property (nonatomic, copy) NSString *weatherIconUrl;
//位置
@property (nonatomic, copy) NSString *cityName;
//风向
@property (nonatomic, copy) NSString *windDirection;
//风级别
@property (nonatomic, copy) NSString *windLevel;

@end
