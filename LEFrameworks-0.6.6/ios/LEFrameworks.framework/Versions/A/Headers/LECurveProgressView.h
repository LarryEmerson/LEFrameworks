#import <UIKit/UIKit.h>
#import "LEUIFramework.h"
// degrees 角度, 度数 radians 弧度  将角度 angle 转为弧度的 define
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface LECurveProgressView : UIView
-(void) leStrokeChart;
-(void) leGrowChartByAmount:(float)growAmount;
-(void) leUpdateChartByCurrent:(float) to ;
-(void) leSetCircleLineCapAsButt;
-(void) leSetCircleLineCapAsSquare;
-(void) leSetCircleLineCapAsRound;
-(void) leSetColor:(UIColor *) color ShadowColor:(UIColor *) shadowColor;
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings MinAngle:(float) min MaxAngle:(float) max Color:(UIColor *) color  ShadowColor:(UIColor *) shadowColor LineWidth:(float) lineW ShadowLineWidth:(float) shadowLineWidth Progrss:(float) progress;
@end
