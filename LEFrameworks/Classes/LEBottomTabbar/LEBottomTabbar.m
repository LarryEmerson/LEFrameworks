//
//  LEBottomTabbar.m
//  ticket
//
//  Created by Larry Emerson on 15/4/3.
//  Copyright (c) 2015年 360cbs. All rights reserved.
//

#import "LEBottomTabbar.h" 
#import "LETabbarRelatedPageView.h"  

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
-(id) initTabbarWithFrame:(CGRect) frame Delegate:(id<LEBottomTabbarDelegate>) delegate  NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *)pages NormalColor:(UIColor *) normalColor HighlightedColor:(UIColor *) highlightedColor{
    globalVar=[LEUIFramework sharedInstance];
    arrayNormalIcons=icons;
    arrayHighlightedIcons=iconsSelected;
    arrayTitles=titles;
    arrayPages=pages;
    arrayButtons=[[NSMutableArray alloc] init];
    curNormalColor=normalColor;
    curHighlightedColor=highlightedColor;
    self.delegate=delegate;
    self=[super initWithFrame:frame];
    if(self){
        [self setUserInteractionEnabled:YES];
        [self initUI];
    }
    return self;
}

-(void) initUI{
    [self leAddTopSplitWithColor:LEColorSplit Offset:CGPointZero Width:LESCREEN_WIDTH];
    [self setBackgroundColor:LEColorWhite]; 
    int buttonWidth=(int)LESCREEN_WIDTH/arrayNormalIcons.count;
    for (int i=0; i<arrayNormalIcons.count; i++) {
        UIButton *btn=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopLeft Offset:CGPointMake(i*buttonWidth, 0) CGSize:CGSizeMake(buttonWidth, LEBottomTabbarHeight)] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:arrayTitles?[arrayTitles objectAtIndex:i]:nil FontSize:LELayoutFontSize10 Font:nil Image:[LEUIFramework leGetUIImage:[arrayNormalIcons objectAtIndex:i]] BackgroundImage:nil Color:curHighlightedColor SelectedColor:curNormalColor MaxWidth:buttonWidth SEL:@selector(onClickForButton:) Target:self]];
        if(arrayTitles){
            [self leVerticallyLayoutButton:btn];
        }
        [arrayButtons addObject:btn];
    }
    lastIndex=-1;
    [self onClickForButton:[arrayButtons objectAtIndex:0]];
}
-(void) leVerticallyLayoutButton:(UIButton *) btn{
    UIButton *button=btn;
    button.imageView.backgroundColor=[UIColor clearColor];
    [button.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    button.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height/2+titleSize.height , -imageSize.width, 0, 0);
    titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height-titleSize.height/2, 0, 0, -titleSize.width);
    [button.titleLabel setBackgroundColor:[UIColor clearColor]];
}
-(void) onChoosedPage:(int) index{
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
    if(self.delegate&&[self.delegate respondsToSelector:@selector(isOkToShowPageWithIndex:)]){
        okToGo=[self.delegate isOkToShowPageWithIndex:index];
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
                                               [obj performSelector:NSSelectorFromString(i==index?@"easeInView":@"easeOutView")];
                                               );
        }
    }
    if(self.delegate&&[self.delegate respondsToSelector:@selector(onTabbarTapped:)]){
        [self.delegate onTabbarTapped:index];
    }
}

@end
