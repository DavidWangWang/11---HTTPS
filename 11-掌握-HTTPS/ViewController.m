//
//  ViewController.m
//  11-掌握-HTTPS
//
//  Created by xiaomage on 15/7/15.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionTaskDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:@"https://www.apple.com/"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    [task resume];
}

#pragma mark - <NSURLSessionTaskDelegate>
/**
 * challenge ： 挑战、质询
 * completionHandler : 通过调用这个block，来告诉URLSession要不要接收这个证书
 只要实现了这个方法的话，对于https协议的话，都会先进入这个方法问一下是否要安装安全证书，只有说安装了安全证书，服务器
 才会去返回数据给我们
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    // 如果不是服务器信任类型的证书，直接返回 NSURLAuthenticationMethodServerTrust 服务器信任类型
    if (![challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) return;
    
    // void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *)
    // NSURLSessionAuthChallengeDisposition ： 如何处理这个安全证书
    // NSURLCredential ：安全证书
    
    // 根据服务器的信任信息创建证书对象  .protectionSpace受保护空间
//    NSURLCredential *crdential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];

    // 利用这个block说明使用这个证书
//    if (completionHandler) {
//        completionHandler(NSURLSessionAuthChallengeUseCredential, crdential);
//    }
    
    !completionHandler ? : completionHandler(NSURLSessionAuthChallengeUseCredential, challenge.proposedCredential);
}

@end
