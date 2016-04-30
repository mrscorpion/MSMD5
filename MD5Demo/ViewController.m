//
//  ViewController.m
//  MD5Demo
//
//  Created by mr.scorpion on 16/4/18.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h> // 加密

@interface ViewController ()
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *datenow = [NSDate date];
    // 时间转时间戳的方法
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    // 格式 md5(md5(xxx)+时间戳)
    NSString *str = [self md5:@"xxx"]; // 这里"xxx"填写服务端约定字符串
    NSString *str2 = [str stringByAppendingString:timeSp];
    NSString *appKey = [self md5:str2];
    
    // MD5加密有16位大小写和32位大小写，是用哪个？
    NSString *result = [NSString stringWithFormat:@"http://api.enjoy-plus.com/Post/index?appkey=%@&timestamp=%@", appKey, timeSp];
    NSLog(@"result:%@",result); //时间戳的值
}

#pragma mark - MD5 Encryption
- (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result];
    }
    return ret;
}
//// md5 16位加密 （大写）
//- (NSString *)md5:(NSString *)str {
//    const char *cStr = [str UTF8String];
//    unsigned char result[16];
//    CC_MD5(cStr, strlen(cStr), result );
//    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
//}
// md5 16位加密 （大写）
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
// md5 32位 加密 （小写）
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"xxxxxxxxxxxxxxxx",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15],
            result[16], result[17],result[18], result[19],
            result[20], result[21],result[22], result[23],
            result[24], result[25],result[26], result[27],
            result[28], result[29],result[30], result[31]
            ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
