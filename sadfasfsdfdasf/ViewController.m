//
//  ViewController.m
//  sadfasfsdfdasf
//
//  Created by jiangzhenfeng on 16/3/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, copy) NSMutableString * resultStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",NSHomeDirectory());
#pragma mark 代码移动到指定目录
    NSString *documentsDirectory= [NSHomeDirectory() stringByAppendingPathComponent:@"jiang"];
    NSString * retFileName = [NSString stringWithFormat:@"%@/ret.txt",NSHomeDirectory()];
    NSArray * arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil];
    for(NSString * path in arr) {
        NSString *subPath = [NSString stringWithFormat:@"%@/%@",documentsDirectory,path];
        [self checkWithPath:subPath];
    }
    [self.resultStr writeToFile:retFileName atomically:NO encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",NSHomeDirectory());
}

- (NSMutableString *)resultStr {
    if (_resultStr == nil) {
        _resultStr = [NSMutableString string];
    }
    return _resultStr;
}

- (NSString *)checkWithPath:(NSString *)pathInfo {
    NSArray * arr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:pathInfo error:nil];
    for(NSString * path in arr) {
        NSString *subPath = [NSString stringWithFormat:@"%@/%@",pathInfo,path];
        NSLog(@"%@",subPath);
        if ([self isDirWithPath:subPath] == YES && ![subPath hasSuffix:@".xcassets"]) {
            [self checkWithPath:subPath];
        }
#pragma mark 根据需要设置指定文件
        else if ([subPath hasSuffix:@".m"] || [subPath hasSuffix:@".h"]){
//        else if ([subPath hasSuffix:@".java"] || [subPath hasSuffix:@".xml"]){
            NSString * tmpStr = [NSString stringWithContentsOfFile:subPath encoding:NSUTF8StringEncoding error:nil];
            [self.resultStr appendString:tmpStr];
        }
    }
    return nil;
}

- (BOOL)isDirWithPath:(NSString *)path {
    BOOL isDir = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    return isDir;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
