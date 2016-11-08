//
//  LELocalNotification.m
//  ticket
//
//  Created by Larry Emerson on 14-2-20.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//

#import "LELocalNotification.h"

#define MessageEnterTime    0.3
#define MessagePauseTime    1.2
@implementation LELocalNotification{
    NSTimer *extraCheck;
    CATransition *transition; 
    UILabel *labelNoti;
}
-(id) init{
    self=[super init];
    [self leExtraInits];
    return self;
}
+(void) showText:(NSString *) text WithEnterTime:(float) time AndPauseTime:(float) pauseTime ReleaseWhenFinished:(BOOL) isRealse{
    LELocalNotification *noti=[[LELocalNotification alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:[UIApplication sharedApplication].keyWindow Anchor:LEAnchorInsideBottomCenter Offset:CGPointMake(0, -LEStatusBarHeight) CGSize:CGSizeMake(LESCREEN_WIDTH-LENavigationBarHeight, LENavigationBarHeight)]];
    [noti leSetText:text WithEnterTime:time AndPauseTime:pauseTime ReleaseWhenFinished:isRealse];
}
-(void) leExtraInits{
    [self setUserInteractionEnabled:NO];
    [self leSetRoundCornerWithRadius:6];
    [self setBackgroundColor:LEColorGrayDark];
    labelNoti=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:nil FontSize:14 Font:nil Width:self.bounds.size.width-LELayoutSideSpace*2 Height:0 Color:LEColorWhite Line:0 Alignment:NSTextAlignmentCenter]];
    // effect
    transition = [CATransition animation];
    [transition setDuration:MessageEnterTime];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transition setType:kCATransitionFade];
//    [transition setDelegate: self];
    [self setAlpha:0];
}
-(void) leSetText:(NSString *) text WithEnterTime:(float) time AndPauseTime:(float) pauseTime {
    [self.layer removeAllAnimations];
    [self leSetText:text WithEnterTime:time AndPauseTime:pauseTime ReleaseWhenFinished:NO];
}
-(void) leReleaseView{
    [extraCheck invalidate];
    extraCheck=nil;
    [transition setDelegate:nil];
    transition=nil;
    [self removeFromSuperview];
}
-(void) onCheck{
    [self leReleaseView];
}
-(void) leSetText:(NSString *) text WithEnterTime:(float) time AndPauseTime:(float) pauseTime ReleaseWhenFinished:(BOOL) isRelease{
    if(!text){
        [self leReleaseView];
        return;
    }
    [extraCheck invalidate];
    extraCheck=[NSTimer scheduledTimerWithTimeInterval:time+pauseTime+0.1 target:self selector:@selector(onCheck) userInfo:nil repeats:NO];
    [self setAlpha:0];
    [labelNoti leSetText:text];
    [labelNoti leSetLineSpace:4];
    [self leSetSize:CGSizeMake(self.bounds.size.width, labelNoti.bounds.size.height+LELayoutSideSpace*2)];
    [UIView  animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^(void){
        [self leSetOffset:CGPointMake(0, -LENavigationBarHeight-LEStatusBarHeight)];
        [self setAlpha:1];
    } completion:^(BOOL isFinished){
        if(isFinished){
            [UIView animateWithDuration:time delay:pauseTime options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                [self setAlpha:0];
            } completion:^(BOOL done){
                if(isRelease){
                    [extraCheck invalidate];
                    [self leReleaseView];
                }
            }];
        }
    }];
}
@end
