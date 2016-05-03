//
//  NSObject+Parse.m
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)
+ (id)parseJSON:(id)json{
    return [self modelWithJSON:json];
}
@end
