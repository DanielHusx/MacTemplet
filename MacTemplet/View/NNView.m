//
//  NNView.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNView.h"

@implementation NNView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.wantsLayer = true;
        
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsLayer = true;

    }
    return self;
}


- (BOOL)isFlipped{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark- set get

-(void)setBackgroundColor:(NSColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    self.layer.backgroundColor = backgroundColor.CGColor;
}

@end
