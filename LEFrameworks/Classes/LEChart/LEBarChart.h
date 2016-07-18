//
//  LEBarChart.h
//  campuslife
//
//  Created by emerson larry on 16/6/25.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"

@interface LEBarChartSettings : NSObject
@property (nonatomic, readonly) int minBarHeight;
@property (nonatomic, readonly) int barWidth;
@property (nonatomic, readonly) int barSpace;
@property (nonatomic, readonly) BOOL showTag;
@property (nonatomic, readonly) BOOL showValue;
@property (nonatomic, readonly) BOOL barRoundRect;
@property (nonatomic, readonly) UIColor *barColor;
@property (nonatomic, readonly) UIColor *barColorSelected;
@property (nonatomic, readonly) UIColor *tagColor;
@property (nonatomic, readonly) UIColor *tagColorSelected;
@property (nonatomic, readonly) UIColor *valueColor;
@property (nonatomic, readonly) int tagFontsize;
@property (nonatomic, readonly) int valueFontsize;
-(void) leSetMinBarHeight:(int) minBarHeight;
-(void) leSetBarWidth:(int) barWidth;
-(void) leSetBarSpace:(int) barSpace;
-(void) leSetShowTag:(BOOL) showTag;
-(void) leSetShowValue:(BOOL) showValue;
-(void) leSetBarRoundRect:(BOOL) barRoundRect;
-(void) leSetBarColor:(UIColor *) barColor;
-(void) leSetBarColorSelected:(UIColor *) barColorSelected;
-(void) leSetTagColor:(UIColor *) tagColor;
-(void) leSetTagColorSelected:(UIColor *) tagColorSelected;
-(void) leSetValueColor:(UIColor *) valueColor;
-(void) leSetTagFontsize:(int) tagFontsize;
-(void) leSetValueFontsize:(int) valueFontsize;
@end
@protocol LEBarChartDelegate <NSObject>
-(void) leOnBarSelectedWithIndex:(int) index;
@end
@interface LEBarChart : UIView
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings BarChartSettings:(LEBarChartSettings *) barSettings Delegate:(id<LEBarChartDelegate>) delegate;
-(void) leOnSetValues:(NSArray *) array Tags:(NSArray *) tags;
@end
