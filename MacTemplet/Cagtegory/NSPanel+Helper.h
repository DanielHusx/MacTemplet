//
//  NSPanel+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPanel (Helper)

+(__kindof NSOpenPanel *)openPanelChooseFileTypes:(NSArray *)fileTypes;

+(__kindof NSOpenPanel *)openPanelChooseDirs:(BOOL)isMultipleSelection;

+(void)openPanelFileTypes:(NSArray *)fileTypes;

@end

NS_ASSUME_NONNULL_END
