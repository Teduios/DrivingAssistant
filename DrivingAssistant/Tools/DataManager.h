//
//  DataManager.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeHeader.h"

@interface DataManager : NSObject

//本地数据处理
//返回所有天气条件数组(TRWeatherCondition)
+ (NSArray *)getAllWeatherConditons;

//设置用户所在城市名字
+ (void)setUserCityName:(NSString *)cityName;

//返回用户所在城市名字
+ (NSString *)getUserCityName;

//网络数据处理
//返回解析好的HomeHeader模型对象
+ (HomeHeader *)returnHomeHeaderData:(id)responseObject;

//返回所有每天天气数组(TRDaily)
+ (NSArray *)returnAllDailyData:(id)respondObject;

//返回所有中国城市数组(TRChinaCity)
+ (NSArray *)getAllChinaCities;

//给定城市名字，返回城市ID
+ (NSString *)getCityIDByName:(NSString *)cityName;

@end
