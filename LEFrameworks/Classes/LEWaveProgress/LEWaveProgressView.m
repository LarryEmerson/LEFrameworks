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
#define LEWaveMinHeight 0.15

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
    
    int targetProgressTextValue;
    int curProgressTextValue;
    
    NSTimer *curTextTimer;
    
    float count;
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
    UIImage *imgWave=[UIImage imageNamed:@"lewave"];
    
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
    curProgressText=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:textContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:50 Font:nil Width:curSize Height:0 Color:ColorWhite Line:1 Alignment:NSTextAlignmentCenter]];
    [curProgressText setFont:[UIFont fontWithName:LayoutFontNameArialRoundedMTBold size:50]];
    
    [self setBackgroundColor:[UIColor colorWithRed:0.1961 green:0.2196 blue:0.2706 alpha:1.0]];
    [movingViewContainer setAlpha:0.8];
    [movingWave setAlpha:0.8];
    
    curProgressTextValue=100;
    
    [self setPercentage:0.88];
    
    [textContainer setBackgroundColor:[UIColor colorWithRed:1.0 green:0.0895 blue:0.084 alpha:0.170129654255319]];
    
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(testEffect) userInfo:nil repeats:YES];
}

-(void) testEffect{
    count=count-0.2;
    if(count<0){
        count=1;
    }
    [self setPercentageText:count];
}

-(void) setPercentage:(float) percentage{
    float height=bottomHeight*(1-percentage);
    float dur1=0.5*percentage+fabs(-topHeight+movingViewContainer.frame.origin.y)/curSize;
    float dur2=0.5*percentage+fabs(topHeight+movingViewContainer.frame.origin.y)/curSize;
    [UIView animateWithDuration: dur1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void){
        [movingViewContainer setFrame:CGRectMake(0, -topHeight, curSize, curSize*2)];
    } completion:^(BOOL done){
        [UIView animateWithDuration: dur2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void){
            [movingViewContainer setFrame:CGRectMake(0, height, curSize, curSize*2)];
        } completion:^(BOOL done){
        }];
    }];
    [self setPercentageText:percentage];
}
-(void) setPercentageText:(float)percentage{
    targetProgressTextValue=(int)(percentage*100);
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
        curTextTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(percentageTextLogic) userInfo:nil repeats:YES];
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
