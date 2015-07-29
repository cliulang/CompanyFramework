//
//  LMServiceClient.m
//  Framework
//
//  Created by zero on 15/7/27.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "LMServiceClient.h"


#define IP  @"http://220.173.139.116"
#define BASE_URL @"/PalmHospital/PHJsonService"
static NSString * const LMAPIBaseURLString = @"";

@implementation LMServiceClient

+ (id)shareInstance{
    static LMServiceClient* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[LMServiceClient alloc]initWithBaseURL:[NSURL URLWithString:IP]];
        client.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
        client.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        client.requestSerializer.timeoutInterval = 15;
        [client.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:{
                    
                    break;
                }
                case AFNetworkReachabilityStatusUnknown:{
                    
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    
                    break;
                }
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    
                    break;
                }
                default:
                    break;
            }
        }];
    });
    return client;
}

- (void)PostWithoutHudType:(NSString*)type Parameters:(id)parameters Success:(void (^)(id result))success Failed:(void(^)(NSError *error))failed{
    [self PostType:type Parameters:parameters ShowHud:NO RespondInteractions:NO Success:^(id result) {
        success(result);
    } Failed:^(NSError *error) {
        failed(error);
    }];
}

- (void)dismissHud{
    [SVProgressHUD dismiss];
}

- (void)PostType:(NSString*)type Parameters:(id)parameters ShowHud:(BOOL)show RespondInteractions:(BOOL)respond Success:(void (^)(id result))success Failed:(void(^)(NSError *error))failed{
    if(self.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
        [SVProgressHUD showErrorWithStatus:@"网络连接错误..." maskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD dismissWithTime:2];
        return;
    }
    if(show){
        if(respond){
            [SVProgressHUD showWithStatus:@"加载中......" maskType:SVProgressHUDMaskTypeNone];
        }else{
            [SVProgressHUD showWithStatus:@"加载中......" maskType:SVProgressHUDMaskTypeBlack];
        }
    }
    [self POST:BASE_URL parameters:@{@"gson":[parameters JSONString],@"type":type} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if(show){
            [SVProgressHUD dismiss];
        }
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(show){
            [SVProgressHUD dismiss];
        }
        failed(error);
    }];
}


@end
