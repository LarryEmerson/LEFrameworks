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
@property (nonatomic) int minBarHeight;
@property (nonatomic) int barWidth;
@property (nonatomic) int barSpace;
@property (nonatomic) BOOL showTag;
@property (nonatomic) BOOL showValue;
@property (nonatomic) BOOL barRoundRect;
@property (nonatomic) UIColor *barColor;
@property (nonatomic) UIColor *barColorSelected;
@property (nonatomic) UIColor *tagColor;
@property (nonatomic) UIColor *tagColorSelected;
@property (nonatomic) UIColor *valueColor;
@property (nonatomic) int tagFontsize;
@property (nonatomic) int valueFontsize;
@end
@protocol LEBarChartDelegate <NSObject>
-(void) onBarSelectedWithIndex:(int) index;
@end
@interface LEBarChart : UIView
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings BarChartSettings:(LEBarChartSettings *) barSettings Delegate:(id<LEBarChartDelegate>) delegate;
-(void) onSetValues:(NSArray *) array Tags:(NSArray *) tags;
@end
