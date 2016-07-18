//
//  LEBasePopupEmptyPage.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBasePopupEmptyPage.h"

@interface LEBasePopupEmptyPage () 
@property (nonatomic) id<LEBasePopupEmptyPageDelegate> delegate;
@end
@implementation LEBasePopupEmptyPage 

-(id) initWithDelegate:(id) delegate{
    self.leResult=@"";
    self.delegate = delegate; 
    self=[super initWithFrame:CGRectMake(0, 0, LESCREEN_WIDTH, LESCREEN_HEIGHT)];
    [self setBackgroundColor:LEColorMask8];
    [self leExtraInits];
    return self;
}
-(id) initWithDelegate:(id) delegate EaseInOrOutWithDelayWhenInited:(BOOL) isEaseIn{
    self=[self initWithDelegate:delegate];
    if(isEaseIn){
        [self leEaseIn];
    }else{
        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(leEaseOut) userInfo:nil repeats:NO];
    }
    return self;
}
-(void) leEaseIn{
    [self setAlpha:0];
    [UIView animateWithDuration:0.3 animations:^(void){
        [self setAlpha:1];
    } completion:^(BOOL isDone){
        
    }];
}

-(void) leEaseOut{
    [UIView animateWithDuration:0.3 animations:^(void){
        [self setAlpha:0];
    } completion:^(BOOL isDone){
        if(self.delegate && [self.delegate respondsToSelector:@selector(leOnPopupTappedWithResult:)]){
            [self.delegate leOnPopupTappedWithResult:self.leResult];
        }
        [self removeFromSuperview];
    }];
}
@end
