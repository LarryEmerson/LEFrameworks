//
//  LEBaseTableViewSectionWithIcon.m
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/6.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewSectionWithIcon.h" 

@implementation LEBaseTableViewSectionWithIcon

-(id) initWithSectionText:(NSString *) title{
    self=[super initWithFrame:CGRectMake(0, 0, [LEUIFramework instance].ScreenWidth, DefaultSectionHeight)];
    [self setBackgroundColor:ColorTableViewGray];
    //
    self.curIcon=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(12, 0) CGSize:CGSizeZero] Image:@"main_section_icon" Streched:YES];
    [LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideRightCenter RelativeView:self.curIcon Offset:CGPointMake(10, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:title FontSize:10 Font:nil Width:0 Height:0 Color:ColorBlack Line:1 Alignment:NSTextAlignmentLeft]];
    [LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsMake(DefaultSectionHeight-1, 0, 0, 0)] Image:@"CellSplit" Streched:YES];
    return self;
}

@end
