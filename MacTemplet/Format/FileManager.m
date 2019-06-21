//
//  FileManager.m
//  ESJsonFormatForMac
//
//  Created by zx on 17/6/13.
//  Copyright © 2017年 ZX. All rights reserved.
//

#import "FileManager.h"
#import "ESJsonFormat.h"
#import "NSFileManager+Helper.h"

@implementation FileManager

+ (FileManager *)sharedInstance{
    static FileManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)handleBaseData:(NSString *)folderPath
             hFileName:(NSString *)hFileName
             mFileName:(NSString *)mFileName
              hContent:(NSString *)hContent
              mContent:(NSString *)mContent{
    NSString *modelStr = [NSString stringWithFormat:@"//\n//Created by ESJsonFormatForMac on %@.\n//\n\n",[self getDateStr]];
    NSMutableString *hImportStr = nil;
    NSString *mImportStr = nil;
    NSString *newHContent = nil;
    NSString *newMContent = nil;
     if (![NSUserDefaults.standardUserDefaults boolForKey:@"isSwift"]) {
         
         hImportStr = [NSMutableString stringWithString:@"#import <Foundation/Foundation.h>\n\n"];
         NSString *superClassString = [NSUserDefaults.standardUserDefaults valueForKey:@"SuperClass"];
         if (superClassString&&superClassString.length > 0) {
             [hImportStr appendString:[NSString stringWithFormat:@"#import \"%@.h\" \n\n",superClassString]];
         }
         
         mImportStr = [NSString stringWithFormat:@"#import \"%@\"\n",hFileName];
         newHContent = [NSString stringWithFormat:@"%@%@%@",modelStr,hImportStr,hContent];
         newMContent = [NSString stringWithFormat:@"%@%@%@",modelStr,mImportStr,mContent];
     }else{
         
         hImportStr = [NSMutableString stringWithString:@"import UIKit\n\n"];
         NSString *superClassString = [NSUserDefaults.standardUserDefaults valueForKey:@"SuperClass"];
         if (superClassString&&superClassString.length>0) {
             [hImportStr appendString:[NSString stringWithFormat:@"import %@ \n\n",superClassString]];
         }
         newHContent = [NSString stringWithFormat:@"%@%@%@",modelStr,hImportStr,hContent];
     }
    
    [self createFileWithFolderPath:folderPath hFileName:hFileName mFileName:mFileName hContent:newHContent mContent:newMContent];
    
}


- (void)createFileWithFolderPath:(NSString *)folderPath
                       hFileName:(NSString *)hFileName
                       mFileName:(NSString *)mFileName
                       hContent :(NSString *)hContent
                       mContent :(NSString *)mContent{
    if (![NSUserDefaults.standardUserDefaults boolForKey:@"isSwift"]) {
        //创建.h文件
        BOOL isSuccessH = [NSFileManager createFileWithFolderPath:folderPath name:hFileName content:hContent];
        //创建.m文件
        BOOL isSuccessM = [NSFileManager createFileWithFolderPath:folderPath name:mFileName content:mContent];
        DDLog(@"_%@_%@",@(isSuccessH), @(isSuccessM));
    }else{
        //创建.swift文件
        BOOL isSuccess = [NSFileManager createFileWithFolderPath:folderPath name:hFileName content:hContent];
        DDLog(@"_%@",@(isSuccess));
    }
}

- (NSString *)getDateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy/MM/dd";
    return [formatter stringFromDate:NSDate.date];
}
@end