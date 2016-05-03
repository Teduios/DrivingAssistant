//
//  JKNetManager.h
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExamModel.h"

/**
 *  定义请求成功的block
 */
typedef void(^successBlock)(id responseObject);
/**
 *  定义请求失败的block
 */
typedef void(^failureBlock)(NSError *error);

@interface JKNetManager : NSObject

+(void)getQuestionBankWithSubject:(NSInteger)subject model:(NSString*)model testType:(NSString*)testType completionHandler:(void(^)(ExamModel *model,NSError *error))completionHandler;

/**
 *  发送get请求
 *
 *  @param url     网络请求的URL
 *  @param params  传一个字典
 *  @param success 请求成功的block
 *  @param failure 请求失败的block
 */
+ (void)sendGetRequest:(NSString *)urlStr withParams:(NSDictionary *)params withSuccess:(successBlock) success withFailure:(failureBlock)failure;


@end
