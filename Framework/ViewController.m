//
//  ViewController.m
//  Framework
//
//  Created by zero on 15/7/27.
//  Copyright (c) 2015年 zero. All rights reserved.
//

#import "ViewController.h"
#import "LMServiceClient.h"
#import "CommonCrypto/CommonDigest.h"
#import "ItemModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 50)];
    [btn setTitle:@"xxx" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(didRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didRequest{
//    [[LMServiceClient shareInstance]PostType:@"353" Parameters:@{} ShowHud:YES RespondInteractions:NO Success:^(id result) {
//        
//    } Failed:^(NSError *error) {
//        
//    }];
    [[LMServiceClient shareInstance]PostWithoutHudType:@"353" Parameters:@{} Success:^(id result) {
        NSArray* array = [result objectForKey:@"jkxjlbinfos"];
        NSArray* results = [ItemModel initWithArray:array];
        ItemModel* model = results[0];
        NSLog(@"%@,%@,%@",model.itemValue,model.itemKey.stringValue,model.info);
    } Failed:^(NSError *error) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *pwdToMD5 = [self toMD5String:@"123456"];
    
    NSDictionary *params = @{@"userAccount": @"13122895251",
                             @"pwd"        : pwdToMD5,
                             };
    [[LMServiceClient shareInstance]PostType:@"6" Parameters:params ShowHud:YES RespondInteractions:NO Success:^(id result) {
        
    } Failed:^(NSError *error) {
        
    }];

}

- (NSString*) toMD5String:(NSString*)string
{
    const char* str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    
    NSMutableString * ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++)
    {
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
