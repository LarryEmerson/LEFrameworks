//
//  LEWebView.h
//  ticket
//
//  Created by Larry Emerson on 14-8-27.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//
#import "LEBaseEmptyView.h"

@interface LEWebView : LEViewController
- (void)loadWebPageWithString:(NSString*)urlString;
- (void)setTitle:(NSString *) title;
@end
