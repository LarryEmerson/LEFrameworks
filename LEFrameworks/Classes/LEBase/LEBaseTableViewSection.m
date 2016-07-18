//
//  LEBaseTableViewSection.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/5.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewSection.h" 

@implementation LEBaseTableViewSection

-(id) initWithSectionText:(NSString *) text{
    return [self initWithSectionText:text Height:LEDefaultSectionHeight];
}
-(id) initWithSectionText:(NSString *) text Height:(int) heiht{
    return [self initWithSectionText:text Height:heiht Split:YES];
}
-(id) initWithSectionText:(NSString *)text  Height:(int)heiht Split:(BOOL)split{
    return [self initWithSectionText:text Color:LEColorTableViewGray Height:heiht Split:split];
}
-(id) initWithSectionText:(NSString *)text Color:(UIColor *)color  Height:(int)heiht Split:(BOOL)split{
    self=[super initWithFrame:CGRectMake(0, 0, LESCREEN_WIDTH, heiht)];
    [self setBackgroundColor:color];
    self.leSplit=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsMake(heiht-1, 0, 0, 0)] Image:[LEColorSplit leImageStrechedFromSizeOne]];
    [self.leSplit setHidden:!split];
    self.labelTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LELayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:text FontSize:LELayoutFontSize10 Font:nil Width:0 Height:0 Color:LEColorTextGray Line:1 Alignment:NSTextAlignmentLeft]];
    return self;
}
@end
