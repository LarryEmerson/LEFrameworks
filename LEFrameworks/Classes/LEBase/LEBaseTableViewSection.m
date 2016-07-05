//
//  LEBaseTableViewSection.m
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/5.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewSection.h" 
 
@implementation LEBaseTableViewSection

-(id) initWithSectionText:(NSString *) text{
    return [self initWithSectionText:text Height:DefaultSectionHeight];
}
-(id) initWithSectionText:(NSString *) text Height:(int) heiht{
    return [self initWithSectionText:text Height:heiht Split:YES];
}
-(id) initWithSectionText:(NSString *)text  Height:(int)heiht Split:(BOOL)split{
    return [self initWithSectionText:text Color:ColorTableViewGray Height:heiht Split:split];
}
-(id) initWithSectionText:(NSString *)text Color:(UIColor *)color  Height:(int)heiht Split:(BOOL)split{
    self=[super initWithFrame:CGRectMake(0, 0, [LEUIFramework sharedInstance].ScreenWidth, heiht)];
    [self setBackgroundColor:color];
    self.curSplit=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsMake(heiht-1, 0, 0, 0)] Image:[ColorSplit imageStrechedFromSizeOne]];
    [self.curSplit setHidden:!split];
    self.labelTitle=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:text FontSize:LayoutFontSize10 Font:nil Width:0 Height:0 Color:ColorTextGray Line:1 Alignment:NSTextAlignmentLeft]];
    return self;
}
@end
