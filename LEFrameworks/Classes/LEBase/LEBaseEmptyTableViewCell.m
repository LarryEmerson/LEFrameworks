//
//  LEBaseEmptyTableViewCell.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/8/28.
//  Copyright (c) 2015年 360cbs. All rights reserved.
//

#import "LEBaseEmptyTableViewCell.h"

@implementation LEBaseEmptyTableViewCell
- (id)initWithSettings:(NSDictionary *) settings {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LEBaseEmptyTableViewCell"];
    if (self) {
        [self setFrame:CGRectMake(0, 0, LESCREEN_WIDTH, LEDefaultCellHeight)];
        [self setBackgroundColor:LEColorClear];
        self.leCurSettings=settings;
        [self leAdditionalInits];
        [self setAlpha:0];
        [self leEaseInView];
    }
    return self;
}
-(void) leEaseInView{
    [UIView animateWithDuration:0.4 delay:0.08 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
        [self setAlpha:1];
    } completion:^(BOOL isDone){}];
}
-(void) leCommendsFromTableView:(NSString *) commends{}
@end
