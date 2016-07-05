//
//  LEBaseEmptyTableViewCell.m
//  four23
//
//  Created by Larry Emerson on 15/8/28.
//  Copyright (c) 2015年 360cbs. All rights reserved.
//

#import "LEBaseEmptyTableViewCell.h"

@implementation LEBaseEmptyTableViewCell
- (id)initWithSettings:(NSDictionary *) settings {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LEBaseEmptyTableViewCell"];
    if (self) {
        self.globalVar=[LEUIFramework sharedInstance];
        [self setFrame:CGRectMake(0, 0, self.globalVar.ScreenWidth, DefaultCellHeight)];
        [self setBackgroundColor:ColorClear];
        self.curSettings=settings;
        [self initUI];
        [self setAlpha:0];
        [self easeInView];
    }
    return self;
}
-(void) initUI{
    [LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:[self.curSettings objectForKey:KeyOfCellTitle] FontSize:12 Font:nil Width:0 Height:0 Color:ColorTextGray Line:1 Alignment:NSTextAlignmentCenter]];
}
-(void) easeInView{
    [UIView animateWithDuration:0.4 delay:0.08 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
        [self setAlpha:1];
    } completion:^(BOOL isDone){}];
}
-(void) commendsFromTableView:(NSString *) commends{}
@end
