//
//  LEBarChart.m
//  campuslife
//
//  Created by emerson larry on 16/6/25.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEBarChart.h"
#import <QuartzCore/QuartzCore.h>
@interface LEBarChartSettings()
@property (nonatomic, readwrite) int minBarHeight;
@property (nonatomic, readwrite) int barWidth;
@property (nonatomic, readwrite) int barSpace;
@property (nonatomic, readwrite) BOOL showTag;
@property (nonatomic, readwrite) BOOL showValue;
@property (nonatomic, readwrite) BOOL barRoundRect;
@property (nonatomic, readwrite) UIColor *barColor;
@property (nonatomic, readwrite) UIColor *barColorSelected;
@property (nonatomic, readwrite) UIColor *tagColor;
@property (nonatomic, readwrite) UIColor *tagColorSelected;
@property (nonatomic, readwrite) UIColor *valueColor;
@property (nonatomic, readwrite) int tagFontsize;
@property (nonatomic, readwrite) int valueFontsize;
@end
@implementation LEBarChartSettings
-(void) leSetMinBarHeight:(int) minBarHeight{
    self.minBarHeight=minBarHeight;
}
-(void) leSetBarWidth:(int) barWidth{
    self.barWidth=barWidth;
}
-(void) leSetBarSpace:(int) barSpace{
    self.barSpace=barSpace;
}
-(void) leSetShowTag:(BOOL) showTag{
    self.showTag=showTag;
}
-(void) leSetShowValue:(BOOL) showValue{
    self.showValue=showValue;
}
-(void) leSetBarRoundRect:(BOOL) barRoundRect{
    self.barRoundRect=barRoundRect;
}
-(void) leSetBarColor:(UIColor *) barColor{
    self.barColor=barColor;
}
-(void) leSetBarColorSelected:(UIColor *) barColorSelected{
    self.barColorSelected=barColorSelected;
}
-(void) leSetTagColor:(UIColor *) tagColor{
    self.tagColor=tagColor;
}
-(void) leSetTagColorSelected:(UIColor *) tagColorSelected{
    self.tagColorSelected=tagColorSelected;
}
-(void) leSetValueColor:(UIColor *) valueColor{
    self.valueColor=valueColor;
}
-(void) leSetTagFontsize:(int) tagFontsize{
    self.tagFontsize=tagFontsize;
}
-(void) leSetValueFontsize:(int) valueFontsize{
    self.valueFontsize=valueFontsize;
}
-(id) init{
    self=[super init];
    [self setMinBarHeight:50];
    [self setBarWidth:14];
    [self setBarSpace:30];
    [self setShowTag:YES];
    [self setShowValue:YES];
    [self setBarRoundRect:YES];
    [self setBarColor:[UIColor colorWithRed:0.9216 green:0.2471 blue:0.2784 alpha:1.0]];
    [self setBarColorSelected:[UIColor colorWithRed:0.7048 green:0.0286 blue:0.1548 alpha:1.0]];
    [self setTagColor:[UIColor colorWithRed:0.6863 green:0.7137 blue:0.7529 alpha:1.0]];
    [self setTagColorSelected:[UIColor colorWithRed:0.2853 green:0.2985 blue:0.3212 alpha:1.0]];
    [self setValueColor:[UIColor colorWithRed:0.9216 green:0.2471 blue:0.2784 alpha:1.0]];
    [self setTagFontsize:10];
    [self setValueFontsize:11];
    return self;
}

@end

@interface LEBarChartItem:UIView
@end
@implementation LEBarChartItem{
    LEBarChartSettings *curBarChartSetting;
    UILabel *labelValue;
    UIImageView *curBar;
    UILabel *labelTag;
    int W;
    int H;
    int barH;
    BOOL isChecked;
    id curTarget;
    int curIndex;
}
-(id) initWithSettings:(LEBarChartSettings *) settings Height:(int) height{
    curBarChartSetting=settings;
    self=[super initWithFrame:CGRectMake(0, 0, settings.barWidth+settings.barSpace, height)];
    [self leExtraInits];
    return self;
}
-(void) leExtraInits{
    W=self.bounds.size.width;
    H=self.bounds.size.height;
    UIView *viewTag=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(W, LELayoutSideSpace*2+curBarChartSetting.tagFontsize)]];
    labelTag=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewTag Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:curBarChartSetting.tagFontsize Font:nil Width:W Height:LELayoutSideSpace*2+curBarChartSetting.tagFontsize Color:curBarChartSetting.tagColor Line:0 Alignment:NSTextAlignmentCenter]];
    [labelTag setHidden:!curBarChartSetting.showTag];
    //
    barH=H-LELayoutSideSpace*4-curBarChartSetting.valueFontsize-curBarChartSetting.tagFontsize;
    UIView *viewBar=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideTopCenter RelativeView:viewTag Offset:CGPointZero CGSize:CGSizeMake(W, H-viewTag.bounds.size.height)]];
    curBar=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewBar Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(curBarChartSetting.barWidth, curBarChartSetting.minBarHeight)] Image:[curBarChartSetting.barColor leImageStrechedFromSizeOne]];
    [curBar setUserInteractionEnabled:YES];
    //
    if(curBarChartSetting.barRoundRect){
        [curBar.layer setMasksToBounds:YES];
        [curBar.layer setCornerRadius:curBarChartSetting.barWidth/2];
    }
    //
    labelValue=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewBar Anchor:LEAnchorOutsideTopCenter RelativeView:curBar Offset:CGPointMake(0, -LELayoutSideSpace) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:curBarChartSetting.valueFontsize Font:nil Width:W Height:LELayoutSideSpace*2+curBarChartSetting.valueFontsize Color:curBarChartSetting.valueColor Line:0 Alignment:NSTextAlignmentCenter]];
    [labelValue setHidden:!curBarChartSetting.showValue];
    [curBar leAddTapEventWithSEL:@selector(onClick) Target:self];
    
}
-(void) onSetWith:(int) index Tag:(NSString *) tag Value:(float) value MinValue:(float) min MaxValue:(float) max Target:(id) target{
    curTarget=target;
    curIndex=index;
    [self setFrame:CGRectMake(W*index, 0, W, H)];
    [labelTag leSetText:tag];
    float extra=(max-min)==0?0:((barH-curBarChartSetting.minBarHeight)*(value-min)/(max-min));
    [curBar leSetSize:CGSizeMake(curBarChartSetting.barWidth, curBarChartSetting.minBarHeight+extra)];
    [labelValue leSetText:[NSString stringWithFormat:@"%.1f",value]];
}
-(void) onClick{
    if(curTarget&&[curTarget respondsToSelector:NSSelectorFromString(@"onCheckedWithIndex:")]){
        LESuppressPerformSelectorLeakWarning(
                                             [curTarget performSelector:NSSelectorFromString(@"onCheckedWithIndex:") withObject:[NSNumber numberWithInt:curIndex]];
                                             );
    }
}
-(void) onCheck:(BOOL) check{
    isChecked=check;
    [labelTag setTextColor:check?curBarChartSetting.tagColorSelected:curBarChartSetting.tagColor];
    [curBar setImage:isChecked?[curBarChartSetting.barColorSelected leImageStrechedFromSizeOne]:[curBarChartSetting.barColor leImageStrechedFromSizeOne]];
}
@end

@implementation LEBarChart{
    UIScrollView *curScrollView;
    NSMutableArray *curItems;
    LEBarChartSettings *curBarChartSettings;
    id<LEBarChartDelegate> curDelegate;
    
    UILabel *noDataLabel;
}
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings BarChartSettings:(LEBarChartSettings *) barSettings Delegate:(id<LEBarChartDelegate>) delegate{
    self=[super initWithAutoLayoutSettings:settings];
    curDelegate=delegate;
    curBarChartSettings=barSettings;
    [self leExtraInits];
    return self;
}
-(void) leExtraInits{
    curItems=[[NSMutableArray alloc] init];
    curScrollView=[[UIScrollView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:self.bounds.size]];
    noDataLabel=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curScrollView Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"暂无数据" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorTextGray Line:1 Alignment:NSTextAlignmentCenter]];
    [noDataLabel setHidden:YES];
}
-(void) onCheckedWithIndex:(NSNumber *) index{
    for (int i=0; i<curItems.count; i++) {
        LEBarChartItem *item=[curItems objectAtIndex:i];
        [item onCheck:[index intValue]==i];
    }
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leOnBarSelectedWithIndex:)]){
        [curDelegate leOnBarSelectedWithIndex:[index intValue]];
    }
}
-(void) leOnSetValues:(NSArray *) array Tags:(NSArray *) tags{
    [noDataLabel setHidden:array&&array.count>0];
    float max=-10000000;
    float min= 10000000;
    float cur=0;
    for (int i=0; i<array.count; i++) {
        if(i<array.count){
            cur=[[array objectAtIndex:i] floatValue];
        }
        max=MAX(max, cur);
        min=MIN(min, cur);
        LEBarChartItem *item=nil;
        if(i<curItems.count){
            item=[curItems objectAtIndex:i];
            [item setHidden:NO];
        }else{
            item=[[LEBarChartItem alloc] initWithSettings:curBarChartSettings Height:self.bounds.size.height];
            [curScrollView addSubview:item];
            [curItems addObject:item];
        }
        [item onCheck:NO];
    }
    for (int i=0; i<MAX(curItems.count, array.count); i++) {
        LEBarChartItem *item=[curItems objectAtIndex:i];
        float cur=0;
        if(i<array.count){
            cur=[[array objectAtIndex:i] floatValue];
        }
        NSString *tag=nil;
        if(tags&&i<tags.count){
            tag=[tags objectAtIndex:i];
        }
        [item onSetWith:i Tag:tag Value:cur MinValue:min MaxValue:max Target:self];
        [item setHidden:i>=array.count];
    }
    NSInteger W=array.count*(curBarChartSettings.barWidth+curBarChartSettings.barSpace);
    //    W=MIN(W, self.bounds.size.width);
    [curScrollView setContentSize:CGSizeMake(W, curScrollView.bounds.size.height)];
    [curScrollView leSetSize:CGSizeMake(MIN(W, self.bounds.size.width), curScrollView.bounds.size.height)];
}
@end
