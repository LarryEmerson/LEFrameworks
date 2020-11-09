//
//  LEBaseTableViewSectionWithIcon.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/6.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewSectionWithIcon.h" 

@implementation LEBaseTableViewSectionWithIcon

-(id) initWithSectionText:(NSString *) title{
    self=[super initWithFrame:CGRectMake(0, 0, LESCREEN_WIDTH, LEDefaultSectionHeight)];
    [self setBackgroundColor:LEColorTableViewGray];
    //
    self.leIcon=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LELayoutSideSpace, 0) CGSize:CGSizeZero] Image:nil];
    self.leTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideRightCenter RelativeView:self.leIcon Offset:CGPointMake(10, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:title FontSize:10 Font:nil Width:0 Height:0 Color:LEColorBlack Line:1 Alignment:NSTextAlignmentLeft]];
    [LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(LESCREEN_WIDTH, 0.5)] Image:[LEColorSplit leImageStrechedFromSizeOne]];
    return self;
}

@end
