//
//  LocationManager.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

+(void)getUserLocation:(void(^)(double lat, double lon))locationBlock;
+(void)getUserCityName:(void(^)(NSString * cityName))cityBlock;

@end
