#import <UIKit/UIKit.h>
#import "LEUIFramework.h"
// degrees 角度, 度数 radians 弧度  将角度 angle 转为弧度的 define
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface LECurveProgressView : UIView
- (void)strokeChart;
- (void)growChartByAmount:(float)growAmount;
- (void)updateChartByCurrent:(float) to ;
-(void) setCircleLineCapAsButt;
-(void) setCircleLineCapAsSquare;
-(void) setCircleLineCapAsRound;
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings MinAngle:(float) min MaxAngle:(float) max Color:(UIColor *) color  ShadowColor:(UIColor *) shadowColor LineWidth:(float) lineW ShadowLineWidth:(float) shadowLineWidth Progrss:(float) progress;
-(void) setColor:(UIColor *) color ShadowColor:(UIColor *) shadowColor;
@end
