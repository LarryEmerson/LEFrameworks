//
//  LEWaveProgressView.m
//  SXWaveAnimate
//
//  Created by emerson larry on 15/12/21.
//  Copyright © 2015年 Sankuai. All rights reserved.
//

#import "LEWaveProgressView.h"
#import <QuartzCore/QuartzCore.h>


#define LEWaveDuration 2
#define LEWaveMinHeight 0.05

@implementation LEWaveProgressView{
    int curSize;
    int topHeight;
    float bottomHeight;
    
    int startPoz;
    int endPoz;
    
    int waveWidth;
    
    UIImageView *movingWave;
    UIView *movingViewContainer;
    //
    UIView *textContainer;
    UILabel *curProgressText;
    float lastPercentage;
    int targetProgressTextValue;
    float targetProgressDuration;
    int curProgressTextValue;
    
    NSTimer *curTextTimer;
    
}

-(id) initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initUI];
    return self;
}
-(void) initUI{
    curSize=self.bounds.size.width;
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:curSize/2];
    UIImage *imgWave=[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"LE_lewave"];
    
    waveWidth=imgWave.size.width;
    
    movingWave =[[UIImageView alloc] initWithImage:[imgWave stretchableImageWithLeftCapWidth:0 topCapHeight:imgWave.size.height/2]];
    
    topHeight    = curSize*LEWaveMinHeight;
    bottomHeight = curSize*(1-LEWaveMinHeight);
    
    startPoz     =  -waveWidth*2.5/5.0;
    endPoz       =  -waveWidth*1.5/5.0;
    
    movingViewContainer=[[UIView alloc] initWithFrame:CGRectMake(0, curSize, curSize, curSize*2)];
    [self addSubview:movingViewContainer];
    //
    [movingViewContainer addSubview:movingWave];
    [movingWave setFrame:CGRectMake(startPoz, 0, waveWidth, curSize*2)];
    [self moveWaveWith:movingWave];
    
    textContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, 40) CGSize:CGSizeMake(curSize, curSize-40*2)]];
    curProgressText=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:textContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:0 Font:[UIFont boldSystemFontOfSize:50] Width:curSize Height:0 Color:ColorWhite Line:1 Alignment:NSTextAlignmentCenter]];
    [curProgressText setFont:[UIFont fontWithName:LayoutFontNameArialRoundedMTBold size:50]];
    
    [self setBackgroundColor:[UIColor colorWithRed:0.1961 green:0.2196 blue:0.2706 alpha:1.0]];
    [movingViewContainer setAlpha:0.8];
    [movingWave setAlpha:0.8];
    lastPercentage=0;
    curProgressTextValue=0;
}


-(void) setPercentage:(float) percentage{
    float height=bottomHeight*(1-percentage);
    float dur1=0.2+0.4*fabsf(percentage-lastPercentage)+fabs(-topHeight+movingViewContainer.frame.origin.y)/curSize;
    float dur2=0.2+0.4*fabsf(percentage-lastPercentage)+fabs(-topHeight-height)/curSize;
    [UIView animateWithDuration: dur1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void){
        [movingViewContainer setFrame:CGRectMake(0, -topHeight, curSize, curSize*2)];
    } completion:^(BOOL done){
        [UIView animateWithDuration: dur2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void){
            [movingViewContainer setFrame:CGRectMake(0, height, curSize, curSize*2)];
        } completion:^(BOOL done){
        }];
    }];
    targetProgressTextValue=(int)(percentage*100);
    targetProgressDuration=(dur1+dur2)/abs(curProgressTextValue-targetProgressTextValue);
    lastPercentage=percentage;
    [curTextTimer invalidate];
    [self percentageTextLogic];
}
-(void) percentageTextLogic{
    [curProgressText leSetText:[NSString stringWithFormat:curProgressTextValue<10?@"0%d":@"%d",curProgressTextValue]];
    if(curProgressTextValue!=targetProgressTextValue){
        if(curProgressTextValue<targetProgressTextValue){
            curProgressTextValue++;
        }else{
            curProgressTextValue--;
        }
        curTextTimer=[NSTimer scheduledTimerWithTimeInterval:targetProgressDuration target:self selector:@selector(percentageTextLogic) userInfo:nil repeats:NO];
    }else{
        [curTextTimer invalidate];
    }
}
-(void) moveWaveWith:(UIImageView *) wave{
    [UIView animateWithDuration:LEWaveDuration*(endPoz-wave.frame.origin.x)/(endPoz-startPoz) delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void){
        [wave setFrame:CGRectMake(endPoz, 0, waveWidth, curSize*2)];
    } completion:^(BOOL done){
        [wave setFrame:CGRectMake(startPoz-LEWaveDuration*2, 0, waveWidth, curSize*2)];
        [self moveWaveWith:wave];
    }];
}
@end
