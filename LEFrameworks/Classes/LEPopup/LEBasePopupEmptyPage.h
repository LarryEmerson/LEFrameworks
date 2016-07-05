//
//  LEBasePopupEmptyPage.h
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"

#define PopupTitleFontSize 15
#define PopupSubtitleFontSize 14

@protocol LEBasePopupEmptyPageDelegate <NSObject>
-(void) onDoneEaseOut:(NSString *) result;
@end

@interface LEBasePopupEmptyPage : UIView
@property (nonatomic) LEUIFramework *globalVar;
//
@property (nonatomic) BOOL needsEaseIn;
@property (nonatomic) BOOL needsEaseOut;
@property (nonatomic) id<LEBasePopupEmptyPageDelegate> delegate;
@property (nonatomic) NSString *result;
//
-(id) initWithDelegate:(id) delegate; 
-(void) initUI;
-(void) easeIn;
-(void) easeOut;

@end
