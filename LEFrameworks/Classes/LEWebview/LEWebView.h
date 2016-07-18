//
//  LEWebView.h
//  ticket
//
//  Created by Larry Emerson on 14-8-27.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//
#import "LEBaseViewController.h"

@interface LEWebView : LEBaseViewController
-(id) initWithURLString:(NSString *) urlString;
- (void)leLoadWebPageWithString:(NSString*)urlString;
- (void)leSetTitle:(NSString *) title;
@end
