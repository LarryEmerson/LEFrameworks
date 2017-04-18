//
//  LETabbarRelatedPageView.m
//  ygj-app-ios
//
//  Created by emerson larry on 15/12/31.
//  Copyright © 2015年 LarryEmerson. All rights reserved.
//

#import "LETabbarRelatedPageView.h"

@implementation LETabbarRelatedPageView{
    UIView *rootView;
}

-(id) initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self setAlpha:0];
    return self;
}
-(void) leSetRootView:(UIView *)view{
    rootView=view;
}
-(UIView *) leRootView{
    return rootView;
}
-(void) leEaseInView{
//    [self.layer removeAllAnimations];
    [self setHidden:NO];
    [self setAlpha:0];
    [UIView animateWithDuration:.2 animations:^(void){
        [self setAlpha:1];
    }completion:^(BOOL isDone){
        [self leEaseInViewLogic];
        [self setHidden:NO];
        [self setAlpha:1];
    }];
}
-(void) leEaseOutView{
//    [self.layer removeAllAnimations];
    [self setHidden:NO];
    [self leEaseOutViewLogic];
    [UIView animateWithDuration:.2 animations:^(void){
        [self setAlpha:0];
    } completion:^(BOOL isDone){
        [self setHidden:YES];
        [self setAlpha:0];
    }];
}
-(void) leEaseInViewLogic{
    
}
-(void) leEaseOutViewLogic{
    
}
-(void) leNotifyPageSelected{
}
@end
