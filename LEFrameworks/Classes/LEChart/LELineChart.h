//
//  LELineChart.h
//  campuslife
//
//  Created by emerson larry on 16/6/30.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"

@protocol LELineChartDelegate <NSObject>
-(void) leOnLineChartSelection:(NSUInteger) index;
@end
@interface LELineChart : UIView
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings LineWidth:(int) width RulerLineWidth:(int) rulerw Color:(UIColor *) color RulerColor:(UIColor *) rulerColor Padding:(float) padding VerticalPadding:(float) verticalPadding Target:(id<LELineChartDelegate>) target;
-(void) leOnSetValues:(NSArray *) array Min:(float) min Max:(float) max;
@end
