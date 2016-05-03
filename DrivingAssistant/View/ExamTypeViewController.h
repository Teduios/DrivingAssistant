//
//  ExamTypeViewController.h
//  DrivingAssistant
//
//  Created by ji on 16/4/20.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "AlertViewController.h"

@interface ExamTypeViewController : AlertViewController

/** 传入代码块和字符串 */
@property (nonatomic,copy)void (^chooseExamTypeHandler)(NSString *examType,NSString *subject,NSString *chooseNumber);

@end
