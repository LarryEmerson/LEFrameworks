//
//  LESegmentView.h
//  NinaPagerView
//
//  Created by emerson larry on 16/4/23.
//  Copyright © 2016年 赵富阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"

@protocol LESegmentViewDelegate <NSObject>
@optional
-(void) leOnSegmentViewSelectedWithIndex:(NSInteger) index;
@end
@interface LESegmentView : UIView
-(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentHeight Indicator:(UIImage *) indicator SegmentSpace:(int) space;
-(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentHeight Indicator:(UIImage *) indicator SegmentSpace:(int) space Color:(UIColor *) normal HighlightedColor:(UIColor *) highlightedColor;
-(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentHeight Indicator:(UIImage *) indicator SegmentSpace:(int) space EqualWidth:(BOOL) equal;
-(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentHeight Indicator:(UIImage *) indicator SegmentSpace:(int) space EqualWidth:(BOOL) equal Color:(UIColor *) normal HighlightedColor:(UIColor *) highlightedColor;
-(void) leOnSetTitles:(NSArray *) titles;
-(void) leOnSetPages:(NSArray *) pages;
-(void) leSetIndicatorOffset:(float) offset;
-(void) leSetDelegate:(id<LESegmentViewDelegate>) delegate;
-(NSArray *) getTitleCache;
@end
