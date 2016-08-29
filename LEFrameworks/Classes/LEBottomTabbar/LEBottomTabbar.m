//
//  LEBottomTabbar.m
//  ticket
//
//  Created by Larry Emerson on 15/4/3.
//  Copyright (c) 2015年 360cbs. All rights reserved.
//

#import "LEBottomTabbar.h"
#import "LETabbarRelatedPageView.h"

@interface LEButton : UIButton
@end
@implementation LEButton
-(void)layoutSubviews {
    [super layoutSubviews];
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height ;
    newFrame.size.width = self.frame.size.width;
    //
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end

@implementation LEBottomTabbar{
    LEUIFramework *globalVar;
    
    NSArray *arrayNormalIcons;
    NSArray *arrayHighlightedIcons;
    NSArray *arrayTitles;
    NSArray *arrayPages;
    //
    NSMutableArray *arrayButtons;
    UIColor *curNormalColor;
    UIColor *curHighlightedColor;
    int lastIndex;
}
-(id) initTabbarWithFrame:(CGRect) frame Delegate:(id<LEBottomTabbarDelegate>) delegate  NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *)pages{
    return [self initTabbarWithFrame:frame Delegate:delegate NormalIcons:icons HighlightedIcons:iconsSelected Titles:titles Pages:pages NormalColor:LEColorGray HighlightedColor:LEColorBlue];
}
-(NSArray *) getTabbars{
    return arrayButtons;
}
-(id) initTabbarWithFrame:(CGRect) frame Delegate:(id<LEBottomTabbarDelegate>) delegate  NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *)pages NormalColor:(UIColor *) normalColor HighlightedColor:(UIColor *) highlightedColor{
    globalVar=[LEUIFramework sharedInstance];
    arrayNormalIcons=icons;
    arrayHighlightedIcons=iconsSelected;
    arrayTitles=titles;
    arrayPages=pages;
    arrayButtons=[[NSMutableArray alloc] init];
    curNormalColor=normalColor;
    curHighlightedColor=highlightedColor;
    self.leDelegate=delegate;
    self=[super initWithFrame:frame];
    if(self){
        [self setUserInteractionEnabled:YES];
        [self leExtraInits];
    }
    return self;
}

-(void) leExtraInits{
    [self leAddTopSplitWithColor:LEColorSplit Offset:CGPointZero Width:LESCREEN_WIDTH];
    [self setBackgroundColor:LEColorWhite];
    int buttonWidth=(int)LESCREEN_WIDTH/arrayNormalIcons.count;
    for (int i=0; i<arrayNormalIcons.count; i++) {
        LEButton *btn=[[LEButton alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointMake(i*buttonWidth, 0) CGSize:CGSizeMake(buttonWidth, LEBottomTabbarHeight)]];
        [btn setTitle:arrayTitles?[arrayTitles objectAtIndex:i]:nil forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:LELayoutFontSize10]];
        [btn setImage:[LEUIFramework leGetUIImage:[arrayNormalIcons objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setTitleColor:curHighlightedColor forState:UIControlStateNormal];
        [btn setTitleColor:curNormalColor forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(onClickForButton:) forControlEvents:UIControlEventTouchUpInside];
        [arrayButtons addObject:btn];
    }
    lastIndex=-1;
    [self onClickForButton:[arrayButtons objectAtIndex:0]];
}
-(void) leDidChoosedPageWith:(int) index{
    if(index<arrayButtons.count){
        UIButton *btn=[arrayButtons objectAtIndex:index];
        [self onClickForButton:btn];
    }
}
-(void) onClickForButton:(UIButton *) btn{
    int index=(int)[arrayButtons indexOfObject:btn];
    if(index==lastIndex){
        return;
    }
    BOOL okToGo=YES;
    if(self.leDelegate&&[self.leDelegate respondsToSelector:@selector(leWillShowPageWithIndex:)]){
        okToGo=[self.leDelegate leWillShowPageWithIndex:index];
    }
    if(!okToGo){
        return;
    }
    lastIndex=index;
    for (int i=0; i<arrayButtons.count; i++) {
        [[arrayButtons objectAtIndex:i] setImage:[LEUIFramework leGetUIImage:[(i==index?arrayHighlightedIcons:arrayNormalIcons) objectAtIndex:i]] forState:UIControlStateNormal];
        if(arrayTitles){
            [[arrayButtons objectAtIndex:i] setTitleColor:i==index?curHighlightedColor:curNormalColor forState:UIControlStateNormal];
        }
        id obj=[arrayPages objectAtIndex:i];
        if([obj isKindOfClass:[LETabbarRelatedPageView class]]){
            LESuppressPerformSelectorLeakWarning(
                                                 [obj performSelector:NSSelectorFromString(i==index?@"leEaseInView":@"leEaseOutView")];
                                                 );
        }
    }
    if(self.leDelegate&&[self.leDelegate respondsToSelector:@selector(leTabbarDidTappedWith:)]){
        [self.leDelegate leTabbarDidTappedWith:index];
    }
}
@end
