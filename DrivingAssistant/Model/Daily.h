//
//  Daily.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Daily : NSObject
//日期
@property (nonatomic, copy) NSString *dataWeekStr;
//最低/最高温度
@property (nonatomic, copy) NSString *lowHighTempStr;
//天气描述
@property (nonatomic, copy) NSString *weatherDesc;
//天气url
@property (nonatomic, copy) NSString *weatherIconUrl;
@end
