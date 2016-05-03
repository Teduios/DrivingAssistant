//
//  WeatherCondition.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherCondition : NSObject

//对照allConditions.plist
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *txt;
@property (nonatomic, copy) NSString *txt_en;

@end
