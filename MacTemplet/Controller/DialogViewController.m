//
//  DialogViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "DialogViewController.h"

#import <CocoaExpand-Swift.h>


@interface DialogViewController ()

@property (nonatomic, strong) NSButton *btn;
@property (nonatomic, strong) NSButton *btnCancell;
@property (nonatomic, strong) NSDatePicker *datePicker;

@end

@implementation DialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.lightGreen.CGColor;
    
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btnCancell];
}

- (void)viewDidLayout{
    [super viewDidLayout];

    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(30);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.bottom.equalTo(self.view).offset(-30);
        make.size.equalTo(CGSizeMake(80, 50));
    }];
    
    [self.btnCancell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-30);
        make.size.equalTo(CGSizeMake(80, 50));
    }];
}

#pragma mark -funtions



#pragma mark -lazy

-(NSDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = ({
            NSDatePicker *view = [[NSDatePicker alloc] init];
            view.datePickerStyle = NSDatePickerStyleClockAndCalendar;
//            view.datePickerStyle = NSDatePickerStyleTextFieldAndStepper;
            
            view.layer.backgroundColor = NSColor.whiteColor.CGColor;
            
            // 设置日期选择控件的类型为“时钟和日历”。其他类型有如，NSTextField文本框
            view.dateValue = NSDate.date;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSDatePicker *sender = (NSDatePicker *)control;
                NSString *dateStr = [NSDateFormatter stringFromDate:sender.dateValue fmt:kFormatDate];
                DDLog(@"%@", dateStr);
                
            }];
            
            view;
        });
    }
    return _datePicker;
}

#pragma mark -lazy

- (NSButton *)btn{
    if (!_btn) {
        _btn = ({
            NSButton * view = [[NSButton alloc]init];
            view.title = @"确定";
            view.bezelStyle = NSBezelStyleRounded;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSButton *sender = (NSButton *)control;
                DDLog(@"%@", sender.title);

//                [NSApp.mainWindow endSheet:self.view.window returnCode:NSModalResponseOK];
                [NSApp.mainWindow beginSheet:self.datePicker.window completionHandler:^(NSModalResponse returnCode) {
                    DDLog(@"%@", @(returnCode));
                }];
            }];
            view;
        });
    }
    return _btn;
}

- (NSButton *)btnCancell{
    if (!_btnCancell) {
        _btnCancell = ({
            NSButton * view = [[NSButton alloc]init];
            view.title = @"取消";
            view.bezelStyle = NSBezelStyleRounded;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSButton *sender = (NSButton *)control;
                DDLog(@"%@", sender.title);
                
                [NSApp.mainWindow endSheet:self.view.window returnCode:NSModalResponseCancel];
            }];
            view;
        });
    }
    return _btnCancell;
}

@end
