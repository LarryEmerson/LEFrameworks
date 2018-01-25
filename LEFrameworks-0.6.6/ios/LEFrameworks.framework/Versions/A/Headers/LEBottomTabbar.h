//
//  LEBottomTabbar.h
//  ticket
//
//  Created by Larry Emerson on 15/4/3.
//  Copyright (c) 2015年 360cbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"


@protocol LEBottomTabbarDelegate <NSObject>
-(void) leTabbarDidTappedWith:(int) index;
-(BOOL) leWillShowPageWithIndex:(int) index;
@end

@interface LEBottomTabbar : UIImageView
-(id) initTabbarWithFrame:(CGRect) frame Delegate:(id<LEBottomTabbarDelegate>) delegate NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *) pages;
-(id) initTabbarWithFrame:(CGRect) frame Delegate:(id<LEBottomTabbarDelegate>) delegate NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *) pages NormalColor:(UIColor *) normalColor HighlightedColor:(UIColor *) highlightedColor;
@property id<LEBottomTabbarDelegate> leDelegate;
-(void) leDidChoosedPageWith:(int) index;
-(NSArray *) getTabbars;
@end
