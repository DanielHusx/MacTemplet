//
//  ThirdViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "ThirdViewController.h"
#import "BNDialogWindowController.h"

@interface ThirdViewController ()



@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.greenColor.CGColor;

}

- (void)viewWillAppear{
    [super viewWillAppear];
    
    [self showDialogView];
}

#pragma mark -lazy

- (void)showDialogView{
    CGSize size = CGSizeMake(NSApp.mainWindow.minSize.width*0.5, NSApp.mainWindow.minSize.height*0.5);
    NSWindow * window = [NSWindow createWithCtrlName: @"DialogViewController" size:size];
//    window.contentViewController.currentWindow = window;
    [NSApp.mainWindow beginSheet:window completionHandler:^(NSModalResponse returnCode) {
        DDLog(@"returnCode_%@", @(returnCode));
    }];
    
}


@end
