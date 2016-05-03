//
//  LocationManager.m
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager()<CLLocationManagerDelegate>
//和定位相关属性
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, copy) void (^saveLocation)(double lat, double lon);

//和地理/反地理编码相关属性
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLLocation *userLocation;

@end

@implementation LocationManager

//懒加载的方式初始化
//单例: 一个类的唯一一个实例对象
+ (id)sharedLoationManager {
    static LocationManager *locationManager = nil;
    if (!locationManager) {
        locationManager = [[LocationManager alloc] init];
    }
    return locationManager;
}

//重写init方法初始化manager对象/征求用户同意
- (instancetype)init {
    if (self = [super init]) {
        self.manager = [CLLocationManager new];
        self.manager.delegate = self;
        
        //初始化地理编码
        self.geocoder = [CLGeocoder new];
        
        //判断iOS版本
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            //Info.plist添加key
            [self.manager requestWhenInUseAuthorization];
        }
    }
    return self;
}


+ (void)getUserLocation:(void (^)(double, double))locationBlock {
    LocationManager *locationManager = [LocationManager sharedLoationManager];
    [locationManager getUserLocations:locationBlock];
}

- (void)getUserLocations:(void (^)(double, double))locationBlock {
    //用户没有同意/没有开启定位功能
    if (![CLLocationManager locationServicesEnabled]) {
        //告诉用户消息无法定位
        return;
    }
    //!!!将saveLocationBlock赋值给locationBlock
    //copy函数指针/函数体
    _saveLocation = [locationBlock copy];
    
    //设定精度(调用频率)
    self.manager.distanceFilter = 500;
    //同意/开启 -> 开始定位
    [self.manager startUpdatingLocation];
    
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //防止调用多次
    //经纬度
    CLLocation *location = [locations lastObject];
    
    //block传参数(调用block)
    _saveLocation(location.coordinate.latitude, location.coordinate.longitude);
    
}

+ (void)getUserCityName:(void (^)(NSString *))cityBlock {
    LocationManager *locationManager = [LocationManager sharedLoationManager];
    [locationManager getUserCityName:cityBlock];
    
}

- (void)getUserCityName:(void (^)(NSString *))cityBlock {
    //先定位用户的位置
    [LocationManager getUserLocation:^(double lat, double lon) {
        self.userLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lon];
        [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获取最后一个地标对象
            CLPlacemark *placemark = [placemarks lastObject];
//            NSLog(@"详细信息:%@", placemark.addressDictionary);
            NSString *cityName = placemark.addressDictionary[@"City"];
            //北京市 --> 北京(前提:模拟器语言中文的)
            cityName = [cityName substringToIndex:cityName.length - 1];
            cityBlock(cityName);
        }];
        
    }];
}
@end
