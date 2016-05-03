//
//  ExamModel.m
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "ExamModel.h"

@implementation ExamModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"questions": @"result"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"questions" : [ExamQuestionModel class]};
}
@end
@implementation ExamQuestionModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID": @"id",
             @"imageUrl": @"url"};
}
@end


