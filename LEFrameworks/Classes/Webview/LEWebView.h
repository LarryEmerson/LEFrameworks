//
//  LEWebView.h
//  ticket
//
//  Created by Larry Emerson on 14-8-27.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//
#import "LEBaseEmptyView.h"
@protocol LEWebViewDelegate<NSObject>
-(void) onCloseWebView;
@end

@interface LEWebView : LEBaseEmptyView<UIWebViewDelegate>
@property (nonatomic) id<LEWebViewDelegate> delegate; 
//-(id) initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *)navigationClass NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType;
- (void)loadWebPageWithString:(NSString*)urlString;
@end
