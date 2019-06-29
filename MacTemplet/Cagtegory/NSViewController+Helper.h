//
//  NSViewController+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSViewController * NSCtrlFromString(NSString *aControllerName);

    
@interface NSViewController (Helper)

@property (nonatomic, weak) NSWindow * currentWindow;

@end

NS_ASSUME_NONNULL_END
