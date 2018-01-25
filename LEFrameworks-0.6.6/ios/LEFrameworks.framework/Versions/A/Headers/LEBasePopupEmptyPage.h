//
//  LEBasePopupEmptyPage.h
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"

#define PopupTitleFontSize 15
#define PopupSubtitleFontSize 14

@protocol LEBasePopupEmptyPageDelegate <NSObject>
-(void) leOnPopupTappedWithResult:(NSString *) result;
@end

@interface LEBasePopupEmptyPage : UIView

@property (nonatomic) NSString *leResult;
//
-(id) initWithDelegate:(id) delegate;
-(id) initWithDelegate:(id) delegate EaseInOrOutWithDelayWhenInited:(BOOL) isEaseIn;
-(void) leEaseIn;
-(void) leEaseOut;

@end
