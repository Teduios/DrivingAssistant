//
//  ChinaCity.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChinaCity : NSObject

//对照chinaCity.plist
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cnty;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *prov;

@end
