//
//  NSView+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Helper)

- (void)getViewLayer;

+(__kindof NSButton *)createBtnRect:(CGRect)rect;

+(__kindof NSImageView *)createImgViewRect:(CGRect)rect image:(id)image;

+(__kindof NSTextField *)createTextFieldRect:(CGRect)rect placeholder:(NSString *)placeholder;

+(__kindof NSTextView *)createTextViewRect:(CGRect)rect;

+(__kindof NSScrollView *)createScrollViewRect:(CGRect)rect;

+(__kindof NSTableView *)createTableViewRect:(CGRect)rect;

+(__kindof NSTabView *)createTabViewRect:(CGRect)rect;


@end

NS_ASSUME_NONNULL_END
