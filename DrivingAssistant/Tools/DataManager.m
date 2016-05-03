//
//  DataManager.m
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "DataManager.h"
#import "WeatherCondition.h"
#import "Daily.h"
#import "ChinaCity.h"

@implementation DataManager


static DataManager *_dataManager = nil;
+ (DataManager *)sharedDataManager {
    if (!_dataManager) {
        _dataManager = [[DataManager alloc] init];
    }
    return _dataManager;
}


static NSArray *_weatherConditionArray = nil;
+ (NSArray *)getAllWeatherConditons {
    if (!_weatherConditionArray) {
        _weatherConditionArray = [self getPlistData:@"allConditons.plist" withClass:[WeatherCondition class]];
    }
    return _weatherConditionArray;
}


+ (NSArray *)getPlistData:(NSString *)plistName withClass:(Class)modelClass {
    //从plistName中读取数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    //array[Dic, Dic....]
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    
    //循环转换:Dictionary -> modelClass
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        //创建modelClass对象
        id modelInstance = [[modelClass alloc] init];
        [modelInstance setValuesForKeysWithDictionary:dic];
        [mutableArray addObject:modelInstance];
    }
    return [mutableArray copy];
}

//给定天气描述，返回该天气条件下的图片url
+ (NSString *)getIconURLStr:(NSString *)weatherDesc {
    //获取所有天气的条件数组
    NSArray *conditionArray = [self getAllWeatherConditons];
    
    for (WeatherCondition *condition in conditionArray) {
        if ([condition.txt isEqualToString:weatherDesc]) {
            return condition.icon;
        }
    }
    
    return nil;
}

static NSString *_userCityName= nil;
//设置用户所在城市名字
+ (void)setUserCityName:(NSString *)cityName {
    _userCityName = cityName;
}

//返回用户所在城市名字
+ (NSString *)getUserCityName {
    return _userCityName;
}

#pragma mark - 处理服务器返回数据方法
+ (HomeHeader *)returnHomeHeaderData:(id)responseObject {
    
    NSDictionary *weatherDic = responseObject[@"HeWeather data service 3.0"][0];
    
    HomeHeader *homeHeaderModel = [HomeHeader new];
    homeHeaderModel.currentTemp = [NSString stringWithFormat:@"%@˚C", weatherDic[@"now"][@"tmp"]];
    homeHeaderModel.weatherDesc = weatherDic[@"now"][@"cond"][@"txt"];
    homeHeaderModel.weatherIconUrl = [self getIconURLStr:homeHeaderModel.weatherDesc];
    homeHeaderModel.cityName = weatherDic[@"basic"][@"city"];
    homeHeaderModel.windDirection = weatherDic[@"now"][@"wind"][@"dir"];
    homeHeaderModel.windLevel = weatherDic[@"now"][@"wind"][@"sc"];
    
    return homeHeaderModel;
    
}


+ (NSString *)getWeekStrWithDateStr:(NSString *)dateStr {
    
    NSDateFormatter *weekFormatter = [[NSDateFormatter alloc] init] ;
    [weekFormatter setDateFormat:@"EEEE"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSString *weekStr = [weekFormatter stringFromDate:date];
    
    return weekStr;
}

//返回所有每天天气数组(TRDaily)
+ (NSArray *)returnAllDailyData:(id)respondObject {
    
    NSArray *dailyArray = respondObject[@"HeWeather data service 3.0"][0][@"daily_forecast"];
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in dailyArray) {
        Daily *daily = [Daily new];
        NSString *weekStr = [self getWeekStrWithDateStr:dic[@"date"]];
        daily.dataWeekStr = weekStr;
        daily.lowHighTempStr = [NSString stringWithFormat:@"%@˚ / %@˚", dic[@"tmp"][@"min"], dic[@"tmp"][@"max"]];
        daily.weatherDesc = dic[@"cond"][@"txt_d"];
        daily.weatherIconUrl = [self getIconURLStr:daily.weatherDesc];
        
        [mutableArray addObject:daily];
    }
    return [mutableArray copy];
}

static NSArray *_chinaCityArray = nil;
+ (NSArray *)getAllChinaCities {
    if (!_chinaCityArray) {
        _chinaCityArray = [self getPlistData:@"chinaCity.plist" withClass:[ChinaCity class]];
    }
    return _chinaCityArray;
}

+ (NSString *)getCityIDByName:(NSString *)cityName {
    //获取所有城市数组
    NSArray *chinaArray = [self getAllChinaCities];
    
    for (ChinaCity *chinaCity in chinaArray) {
        if ([chinaCity.city isEqualToString:cityName]) {
            return chinaCity.id;
        }
    }
    return nil;
}

@end
