//
//  LEBasePopupEmptyPage.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBasePopupEmptyPage.h"

@implementation LEBasePopupEmptyPage 

-(id) initWithDelegate:(id) delegate{
    self.result=@"";
    self.delegate = delegate;
    self.globalVar=[LEUIFramework sharedInstance]; 
    self=[super initWithFrame:CGRectMake(0, 0, LESCREEN_WIDTH, LESCREEN_HEIGHT)];
    [self setBackgroundColor:LEColorMask8];
    [self initUI];
    if(self.needsEaseIn){
        [self easeIn];
    }
    if(self.needsEaseOut){
        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(easeOut) userInfo:nil repeats:NO];
    }
    return self;
}


-(void) initUI{
    
}

-(void) easeIn{
    [self setAlpha:0];
    [UIView animateWithDuration:0.3 animations:^(void){
        [self setAlpha:1];
    } completion:^(BOOL isDone){

    }];
}

-(void) easeOut{
    [UIView animateWithDuration:0.3 animations:^(void){
        [self setAlpha:0];
    } completion:^(BOOL isDone){
        if(self.delegate && [self.delegate respondsToSelector:@selector(onDoneEaseOut:)]){
            [self.delegate onDoneEaseOut:self.result];
        }
        [self removeFromSuperview];
    }];
}
@end
