//
//  JKNetManager.m
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "JKNetManager.h"
#import "ExamModel.h"

@implementation JKNetManager


+(void)getQuestionBankWithSubject:(NSInteger)subject model:(NSString *)model testType:(NSString *)testType completionHandler:(void (^)(ExamModel *, NSError *))completionHandler{
    NSDictionary *parameter = @{@"subject":@(subject),
                                       @"model":model,
                                       @"testType":testType,
                                       @"key":kJKAPPKEY};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:kJKBASE_URL parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completionHandler([ExamModel parseJSON:responseObject],nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"获取失败");
    }];
}

+ (void)sendGetRequest:(NSString *)urlStr withParams:(NSDictionary *)params withSuccess:(successBlock)success withFailure:(failureBlock)failure {
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //通过successBlock把服务器返回的responseObject返回调用控制器
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ////通过failureBlock把服务器返回的error返回调用控制器
        failure(error);
    }];
    
}


@end
