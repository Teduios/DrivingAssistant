//
//  ExamModel.h
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ExamQuestionModel;
@interface ExamModel : NSObject
@property (nonatomic, assign) NSInteger error_code;

@property (nonatomic, strong) NSArray<ExamQuestionModel *> *questions;

@property (nonatomic, copy) NSString *reason;

@end
@interface ExamQuestionModel : NSObject

@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *item4;

@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *item1;

@property (nonatomic, strong) NSString *question;

@property (nonatomic, copy) NSString *item3;

@property (nonatomic, copy) NSString *explains;

@property (nonatomic, copy) NSString *item2;
@end

