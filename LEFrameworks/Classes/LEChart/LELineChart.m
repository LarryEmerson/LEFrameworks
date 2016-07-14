//
//  LELineChart.m
//  campuslife
//
//  Created by emerson larry on 16/6/30.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LELineChart.h"


@implementation LELineChart{
    id<LELineChartDelegate> curTarget;
    int curLineWidth;
    UIColor *curLineColor;
    UIColor *curRulerColor;
    NSArray *curData;
    float lineGap;
    CGPoint originPoint;
    float lineH;
    float totalHeight;
    UILabel *noDataLabel;
    UIImageView *lineVertical;
    UIImageView *lineHorizontal;
    float curPadding;
    NSInteger lastIndex;
    float curMinY;
    float curRulerWidth;
    float curVerticalPadding;
}
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings LineWidth:(int) width RulerLineWidth:(int) rulerw Color:(UIColor *) color RulerColor:(UIColor *) rulerColor Padding:(float) padding VerticalPadding:(float) verticalPadding Target:(id<LELineChartDelegate>) target{
    self=[super initWithAutoLayoutSettings:settings];
    curLineWidth=width;
    curRulerWidth=rulerw;
    curLineColor=color;
    curRulerColor=rulerColor;
    curVerticalPadding=verticalPadding;
    curTarget=target;
    totalHeight=settings.leSize.height-curVerticalPadding*2;
    noDataLabel=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"暂无数据" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:curLineColor Line:1 Alignment:NSTextAlignmentCenter]];
    curPadding=padding;
    lineVertical=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(curRulerWidth, settings.leSize.height)] Image:[curRulerColor leImageStrechedFromSizeOne]];
    lineHorizontal=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(settings.leSize.width, curRulerWidth)] Image:[curRulerColor leImageStrechedFromSizeOne]];
    [lineVertical setHidden:YES];
    [lineHorizontal setHidden:YES];
    [noDataLabel setHidden:YES];
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if(curData&&curData.count>0){
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetLineWidth(context, curLineWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextMoveToPoint(context, originPoint.x,originPoint.y);
        CGPoint sPoints[curData.count] ;
        for (int i=0; i<curData.count; i++) {
            float y=[[curData objectAtIndex:i] floatValue];
            float asp=(lineH==0?0:((y-curMinY)/lineH));
            y=totalHeight*asp;
            sPoints[i]=CGPointMake(curPadding+i*lineGap, totalHeight-y+curVerticalPadding);
        }
        CGContextAddLines(context, sPoints, curData.count);
        const CGFloat *components = CGColorGetComponents(curLineColor.CGColor);
        CGContextSetRGBStrokeColor(context, components[0], components[1], components[2], components[3]);
        CGContextStrokePath(context);
    }
}
-(void) onSetData:(NSArray *) array Min:(float) min Max:(float) max{
    [noDataLabel setHidden:array.count>0];
    curData=array;
    lineGap=0;
    if(curData.count>0){
        lineGap=(self.bounds.size.width-curPadding*2)*1.0/curData.count;
        originPoint=CGPointMake(curPadding, [[array objectAtIndex:0] floatValue]);
    }
    lineH=max-min;
    curMinY=min;
    lastIndex=curData.count-1;
    //    [lineVertical setFrame:CGRectMake(curPadding+lineGap*curData.count-curLineWidth/2, 0, curLineWidth, self.bounds.size.height)];
    [lineVertical setHidden:min==max];
    [lineHorizontal setHidden:min==max];
    [lineVertical leSetOffset:CGPointMake(curPadding+lastIndex*lineGap-curRulerWidth/2, 0)];
    float y=[[curData objectAtIndex:lastIndex] floatValue];
    float asp=(lineH==0?0:((y-curMinY)/lineH));
    y=totalHeight*asp;
    [lineHorizontal leSetOffset:CGPointMake(0, totalHeight-y+curVerticalPadding-curRulerWidth/2)];
    [self setNeedsDisplay];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self showIndicatorForTouch:[touches anyObject]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self showIndicatorForTouch:[touches anyObject]];
}
- (void)showIndicatorForTouch:(UITouch *)touch {
    CGPoint pos = [touch locationInView:self];
    pos.x=MAX(pos.x, curPadding);
    pos.x=MIN(pos.x, self.bounds.size.width-curPadding);
    //    [lineVertical setFrame:CGRectMake(pos.x-curLineWidth/2, 0, curLineWidth, self.bounds.size.height)];
    [lineVertical leSetOffset:CGPointMake(pos.x-curRulerWidth/2, 0)];
    BOOL reset=NO;
    for (NSInteger i=0; i<curData.count; i++) {
        if(round(pos.x)==round(curPadding+lineGap*i)){
            if(lastIndex!=i)reset=YES;
            lastIndex=i;
            break;
        }else{
            float p=i*lineGap+curPadding;
            if(pos.x>p&&pos.x<(p+lineGap/2)){
                if(lastIndex!=i)reset=YES;
                lastIndex=i;
                break;
            }else if(pos.x>(p+lineGap/2)&&pos.x<(p+lineGap)){
                NSInteger  last=i+1;
                last=MIN(curData.count-1, last);
                if(last!=i)reset=YES;
                lastIndex=last;
                break;
            }
        }
    }
    if(reset){
        float y=[[curData objectAtIndex:lastIndex] floatValue];
        float asp=(lineH==0?0:((y-curMinY)/lineH));
        y=totalHeight*asp;
        [UIView animateWithDuration:0.1 animations:^{
            //            [lineHorizontal setFrame:CGRectMake(0, totalHeight-y+curPadding-curLineWidth/2, self.bounds.size.width, curLineWidth)];
            [lineHorizontal leSetOffset:CGPointMake(0, totalHeight-y+curVerticalPadding-curRulerWidth/2)];
        }completion:^(BOOL done){
            if(curTarget&&[curTarget respondsToSelector:@selector(onLineChartSelection:)]){
                [curTarget onLineChartSelection:lastIndex];
            }
        }];
    }
}
@end
