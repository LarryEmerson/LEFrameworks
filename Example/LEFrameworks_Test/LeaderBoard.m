//
//  LeaderBoard.m
//  guguxinge
//
//  Created by emerson larry on 2018/5/11.
//  Copyright © 2018年 LarryEmerson. All rights reserved.
//

#import "LeaderBoard.h"

@interface LeaderBoard ()<LENavigationDelegate>

@end
#define LeftBlock 200
#define ChartMargins UIEdgeInsetsMake(60,60,80,20)
@implementation LeaderBoard{
    BOOL isInited;
    LEBaseView *baseView;
    LEBaseNavigation *navi;
    UIView *container;
    UIView *viewAniDis;
    //
    UILabel *labelTitle;
    UILabel *labelZHH;
    UILabel *labelName;
    UILabel *labelNO;
//    UICountingLabel *labelDis;
//    UICountingLabel *labelSpeed;
    //
    LECurveProgressView *curveProgress;
    //
//    LineChart *line;
    UIButton *lineType;
    int lineTypeValue;
    NSMutableArray *curDS;
    
}

-(void) leAdditionalInits{}
-(void) inits{
    if(isInited)return;
    isInited=YES;
    self.view.backgroundColor=LEColorRed;
    UIView *baseView2=[[UIView alloc] initWithFrame:CGRectMake(0, 0,   LESCREEN_MIN_LENGTH,LESCREEN_MAX_LENGTH)];
    [self.view addSubview:baseView2]; baseView2.backgroundColor=LEColorBlue; 
    [baseView2 setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    [baseView2 setFrame:CGRectMake(0, 0,  LESCREEN_MIN_LENGTH,LESCREEN_MAX_LENGTH)];
    UIView *naviView=[UIView new].leSuperView(baseView2).leAnchor(LEAnchorInsideTopLeft).leSize(CGSizeMake(LESCREEN_MAX_LENGTH, 44)).leBackground(LEColorMask2).leAutoLayout;
    navi=[[LEBaseNavigation alloc] initWithDelegate:self ViewController:self SuperView:naviView Offset:0 BackgroundImage:[LEUIFramework sharedInstance].leImageNavigationBar TitleColor:[LEUIFramework sharedInstance].leColorNavigationContent LeftItemImage:[LEUIFramework sharedInstance].leImageNavigationBack];
    [navi leSetNavigationTitle:@"飞行数据分析"];
    [navi leSetOffset:CGPointZero];
    [navi leSetLeftNavigationItemWith:@"返回" Image:[LEUIFramework sharedInstance].leImageNavigationBack Color:LEColorBlack];
    BOOL found=YES;//[[AppConfigs sharedInstance] isOkToShare];
//    if(found)
        [navi leSetRightNavigationItemWith:@"分享" Image:[UIImage imageNamed:@"share"] Color:LEColorBlack];
//    UIInterfaceOrientation orin=[self getSpecificOrientation];
    container=[UIView new].leSuperView(baseView2).leAnchor(LEAnchorInsideTopLeft).leSize(CGSizeMake(LESCREEN_MAX_LENGTH-(LEIS_IPHONE_X?44:0), LESCREEN_MIN_LENGTH-LENavigationBarHeight)).leOffset(CGPointMake(44, LENavigationBarHeight)).leAutoLayout;
    [container leAddTopSplitWithColor:LEColorSplit Offset:CGPointZero Width:container.bounds.size.width];
    [self initUI];
}
-(void) initUI{
    UIView *viewLeft=[UIView new].leSuperView(container).leAnchor(LEAnchorInsideTopLeft).leSize(CGSizeMake(LeftBlock, container.bounds.size.height)).leAutoLayout;
    UIView *viewRight=[UIView new].leSuperView(container).leAnchor(LEAnchorInsideTopRight).leSize(CGSizeMake(container.bounds.size.width-LeftBlock, container.bounds.size.height)).leAutoLayout;
    float space=LELayoutSideSpace;
    float vSpace = space;
    int fontSize=14;
    labelTitle=[UILabel new].leSuperView(viewLeft).leAnchor(LEAnchorInsideTopLeft).leOffset(CGPointMake(space, vSpace)).leWidth(LeftBlock-space*2).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leLine(2).leAutoLayout;
    UILabel *zhh=[UILabel new].leSuperView(viewLeft).leRelativeView(labelTitle).leAnchor(LEAnchorOutsideBottomLeft).leOffset(CGPointMake(0, vSpace/2)).leColor(LEColorTextGray).leFont(LEFont(fontSize)).leText(@"足环号：").leAutoLayout;
    labelZHH=[UILabel new].leSuperView(viewLeft).leRelativeView(zhh).leAnchor(LEAnchorOutsideRightCenter).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leWidth(LeftBlock-space*2-zhh.bounds.size.width).leLine(1).leAutoLayout;
    UILabel *name=[UILabel new].leSuperView(viewLeft).leRelativeView(zhh).leAnchor(LEAnchorOutsideBottomLeft).leOffset(CGPointMake(0, vSpace/2)).leColor(LEColorTextGray).leFont(LEFont(fontSize)).leText(@"鸽主：").leAutoLayout;
    labelName=[UILabel new].leSuperView(viewLeft).leRelativeView(name).leAnchor(LEAnchorOutsideRightCenter).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leWidth(LeftBlock-space*2-zhh.bounds.size.width).leLine(1).leAutoLayout;
    UILabel *no=[UILabel new].leSuperView(viewLeft).leRelativeView(name).leAnchor(LEAnchorOutsideBottomLeft).leOffset(CGPointMake(0, vSpace/2)).leColor(LEColorTextGray).leFont(LEFont(fontSize)).leText(@"参赛编号：").leAutoLayout;
    labelNO=[UILabel new].leSuperView(viewLeft).leRelativeView(no).leAnchor(LEAnchorOutsideRightCenter).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leWidth(LeftBlock-space*2-zhh.bounds.size.width).leLine(1).leAutoLayout;
    
    
//    labelSpeed=[UICountingLabel new].leSuperView(viewLeft).leAnchor(LEAnchorInsideBottomCenter).leOffset(CGPointMake(0, -vSpace)).leFont(LEFont(16)).leAlignment(NSTextAlignmentCenter).leColor(LEColorBlue).leLine(1).leSize(CGSizeMake(LeftBlock, 18)).leText(@"0000.0000").leAutoLayout;
//    UIView *viewSpeed=[UIView new].leSuperView(viewLeft).leRelativeView(labelSpeed).leAnchor(LEAnchorOutsideTopCenter).leAutoLayout;
//    UIImage *imgSpeed=[UIImage imageNamed:@"LB_speed"];
//    UIImageView *imgSpeedV=[UIImageView new].leSuperView(viewSpeed).leAnchor(LEAnchorInsideLeftCenter).leImage(imgSpeed).leAutoLayout;
//    UILabel *labelSpeedText=[UILabel new].leSuperView(viewSpeed).leRelativeView(imgSpeedV).leAnchor(LEAnchorOutsideRightCenter).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leText(@"平均分速").leAutoLayout;
//    [viewSpeed leSetSize:CGSizeMake(labelSpeedText.frame.origin.x+labelSpeedText.frame.size.width, 30)];
//
//    viewAniDis=[UIView new].leSuperView(viewLeft).leRelativeView(viewSpeed).leAnchor(LEAnchorOutsideTopCenter).leSize(CGSizeMake(LeftBlock, viewSpeed.frame.origin.y-no.frame.origin.y-no.frame.size.height)).leAutoLayout;
//    int curveSize=MIN(viewAniDis.bounds.size.height-vSpace, LeftBlock-space*2);
//    curveProgress=[[LECurveProgressView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewAniDis Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeMake(curveSize, curveSize)] MinAngle:-90 MaxAngle:-90+360 Color:LEColorBlue  ShadowColor:LEColorGrayLight LineWidth:4 ShadowLineWidth:3 Progrss:0];
//    [curveProgress leStrokeChart];
//    labelDis=[UICountingLabel new].leSuperView(curveProgress).leAnchor(LEAnchorInsideCenter).leOffset(CGPointMake(0, -10)).leAlignment(NSTextAlignmentCenter).leFont(LEBoldFont((int)((curveSize-5*LESCREEN_SCALE_INT)/3.5))).leSize(CGSizeMake(curveSize, 30)).leColor(LEColorTextBlack).leText(@"0000").leAutoLayout;
//    [UILabel new].leSuperView(curveProgress).leAnchor(LEAnchorInsideCenter).leOffset(CGPointMake(0,curveProgress.bounds.size.height/5)).leFont(LEFont((int)((curveSize-5*LESCREEN_SCALE_INT)/8))).leColor(LEColorTextBlack).leText(@"总飞行公里数").leAutoLayout;
//    //
//    line=[LineChart new].leSuperView(viewRight).leEdgeInsects(UIEdgeInsetsZero).leAutoLayout;
//    line.block = ^(id data) {
//        LELogObject(data)
//    };
//    UIView *topContainer=[UIView new].leSuperView(viewRight).leAnchor(LEAnchorInsideTopLeft).leSize(CGSizeMake(viewRight.bounds.size.width, ChartMargins.top)).leAutoLayout;
//    [UILabel new].leSuperView(topContainer).leAnchor(LEAnchorInsideLeftCenter).leOffset(CGPointMake(ChartMargins.left, 0)).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leText(@"分速统计").leAutoLayout;
//    lineType=[UIButton new].leSuperView(topContainer).leAnchor(LEAnchorInsideRightCenter).leOffset(CGPointMake(-ChartMargins.right, 0)).leTapEvent(@selector(onLineType),self).leColor(LEColorTextBlack).leBackgroundImage([[UIImage imageNamed:@"btn_white_grayoutline_N"] leMiddleStrechedImage]).leFont(LEFont(fontSize)).leText(@"显示全部分速").leAutoLayout;
//    UILabel *label1=[UILabel new].leSuperView(topContainer).leRelativeView(lineType).leAnchor(LEAnchorOutsideLeftCenter).leOffset(CGPointMake(-14, -10)).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leText(@"冠军分速").leAutoLayout;
//    UILabel *label2=[UILabel new].leSuperView(topContainer).leRelativeView(lineType).leAnchor(LEAnchorOutsideLeftCenter).leOffset(CGPointMake(-14, +10)).leFont(LEFont(fontSize)).leColor(LEColorTextBlack).leText(@"我的分速").leAutoLayout;
//    [UIView new].leSuperView(topContainer).leRelativeView(label1).leAnchor(LEAnchorOutsideLeftCenter).leOffset(CGPointMake(-10, 0)).leSize(CGSizeMake(30, 3)).leBackground(LEColorRed).leAutoLayout;
//    [UIView new].leSuperView(topContainer).leRelativeView(label2).leAnchor(LEAnchorOutsideLeftCenter).leOffset(CGPointMake(-10, 0)).leSize(CGSizeMake(30, 3)).leBackground(LEColorBlue).leAutoLayout;
//    //
//    labelDis.formatBlock = ^NSString* (CGFloat value) {
//        return [NSString stringWithFormat: @"%d", (int)value];
//    };
//    labelSpeed.formatBlock = ^NSString* (CGFloat value) {
//        return [NSString stringWithFormat: @"%.4f", value];
//    };
//    //
//    [labelTitle leSetText:@"2018年浙江黄金海岸春棚(首届)竞赛"];
//    [labelZHH leSetText:@"09-0208891"];
//    [labelName leSetText:@"某某工棚-120"];
//    [labelNO leSetText:@"120345"];
////    [labelSpeed leSetText:@"1120.12340"];
//    [labelSpeed countFrom:0 to:1120.1234];
////    [labelDis leSetText:@"8960"];
//    [labelDis countFrom:0 to:896];
//    [NSTimer scheduledTimerWithTimeInterval:60/180 target:self selector:@selector(onCheckCurveProgressView) userInfo:nil repeats:YES];
}
//-(void) onLineType{
//    if(curDS.count>0){
//        lineTypeValue++;
//        lineTypeValue=lineTypeValue%3;
//        lineType=lineType.leColor(lineTypeValue==0?LEColorTextBlack:(lineTypeValue==1?LEColorBlue:LEColorRed)).leBackgroundImage([[UIImage imageNamed:lineTypeValue==0?@"btn_white_grayoutline_N":(lineTypeValue==1?@"btn_white_blueoutline_N":@"btn_white_redoutline_N")] leMiddleStrechedImage]).leText(lineTypeValue==0?@"显示全部分速":(lineTypeValue==1?@"只看我的分速":@"只看冠军分速")).leAutoLayout;
//        line.chartSettings.tooltipSettings[0].textColor=(lineTypeValue==0||lineTypeValue==1)?LEColorBlue:LEColorClear;
//        line.chartSettings.tooltipSettings[1].textColor=(lineTypeValue==0||lineTypeValue==2)?LEColorRed:LEColorClear;
//        [line leConfigChart];
//        [line leSetDataSource:curDS Min:0 Max:rand()%2==(rand()%100)?0:100];
//    }
//}
//-(void) leNavigationRightButtonTapped{
//    TooltipSettings *toolMine=[TooltipSettings new];
//    toolMine.bgColor=LEColorClear;
//    toolMine.textColor=LEColorBlue;
//    toolMine.fontSize=14;
//    toolMine.offset=14;
//    toolMine.size=CGSizeZero;
//    toolMine.margins=UIEdgeInsetsZero;
//    toolMine.radius=0;
//    TooltipSettings *toolTop=[TooltipSettings new];
//    toolTop.bgColor=LEColorClear;
//    toolTop.textColor=LEColorRed;
//    toolTop.fontSize=14;
//    toolTop.offset=14;
//    toolTop.size=CGSizeZero;
//    toolTop.margins=UIEdgeInsetsZero;
//    toolTop.radius=0;
//    line.chartSettings.tooltipSettings=@[toolMine, toolTop].mutableCopy;
//    ChartLineSettings *lineMine = [ChartLineSettings new];
//    lineMine.lineWidth=2;
//    lineMine.lineColor=LEColorBlue;
//    lineMine.dotOutlineWidth=2;
//    lineMine.dotOutlineColor=LEColorBlue;
//    lineMine.dotRadius=3;
//    lineMine.dotColor=LEColorWhite;
//    ChartLineSettings *lineTop = [ChartLineSettings new];
//    lineTop.lineWidth=2;
//    lineTop.lineColor=LEColorRed;
//    lineTop.dotOutlineWidth=2;
//    lineTop.dotOutlineColor=LEColorRed;
//    lineTop.dotRadius=3;
//    lineTop.dotColor=LEColorWhite;
//    line.chartSettings.lineSettings=@[lineMine,lineTop].mutableCopy;
//    line.chartSettings.scrollviewMargins=ChartMargins;
//    line.chartSettings.rows=8;
//    line.chartSettings.gridWidth=100;
//    line.chartSettings.gridBGColor=LEColorWhite;
//    line.chartSettings.gridColorX=LEColorGrayLight;
//    line.chartSettings.gridColorY=LEColorClear;
//    line.chartSettings.gridLineWidth=1;
//    line.chartSettings.tickLineColorX=LEColorGray;
//    line.chartSettings.tickLineTextColorX=LEColorTextBlack;
//    line.chartSettings.tickLineOffsetX=0;
//    line.chartSettings.tickLineFontsizeX=14;
//    line.chartSettings.tickLineWidthX=1;
//    line.chartSettings.tickLineColorY=LEColorGray;
//    line.chartSettings.tickLineTextColorY=LEColorTextBlack;
//    line.chartSettings.tickLineOffsetY=10;
//    line.chartSettings.tickLineFontsizeY=14;
//    line.chartSettings.tickLineWidthY=1;
//    line.chartSettings.yAxisPrecision=0;
//    [line leConfigChart];
//    NSMutableArray *muta=[NSMutableArray new];
//    NSMutableArray *muta1=[NSMutableArray new];
//    NSMutableArray *muta2=[NSMutableArray new];
//    NSMutableArray *muta3=[NSMutableArray new];
//    for (NSInteger i=0; i<4+rand()%20; i++) {
//        [muta3 addObject:
//                        @{
//                          @"label":[NSString stringWithFormat:@"%ld公里\n（%d名）",(i+1)*10,20+rand()%500],@"value":[NSString stringWithFormat:@"%f", (rand()%4000/3.0)]
//                          }];
//        [muta1 addObject:@{
//                           @"label":[NSString stringWithFormat:@"%ld公里\n（%d名）",(i+1)*10,20+rand()%500],@"value":[NSString stringWithFormat:@"%f", (rand()%4000/3.0)]
//                           }];
//        [muta2 addObject:@{
//                           @"label":[NSString stringWithFormat:@"%ld公里\n（%d名）",(i+1)*10,20+rand()%500],@"value":[NSString stringWithFormat:@"%f", (rand()%4000/3.0)]
//                           }];
//    }
//    [muta addObject:muta1];
//    [muta addObject:muta2];
//    curDS=muta;
//    [line leSetDataSource:muta Min:0 Max:rand()%2==(rand()%100)?0:100 Animation:YES];
//}
//-(void) onCheckCurveProgressView{
//    [curveProgress leGrowChartByAmount:1];
//}
//-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
//    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
//    float offset = !LEIS_IPHONE_X?0:(toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft?0:44);
//    LELog(@"oren %d offset %f",toInterfaceOrientation, offset)
//    [container leSetOffset:CGPointMake(offset, LENavigationBarHeight)];
//}
//- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation)toInterfaceOrientation {
//    return NO;
//}
//-(BOOL)shouldAutorotate{
//    return NO;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscape;
//}
//-(void)forceOrientationLandscape{
//    //这种方法，只能旋转屏幕不能达到强制横屏的效果
//    UIInterfaceOrientation val = [self getSpecificOrientation];
//    LELogInteger(val)
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//    //加上代理类里的方法，旋转屏幕可以达到强制横屏的效果
//    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    appdelegate.navi.isForceLandscape=YES;
//    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
//    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
//    NSNumber *orientationTarget = [NSNumber numberWithInt:val];
//    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//    [container leSetOffset:CGPointMake(!LEIS_IPHONE_X?0:(val==UIInterfaceOrientationLandscapeLeft?0:LEStatusBarHeight), LENavigationBarHeight)];
//}
//-(void)forceOrientationPortrait{
//    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    appdelegate.navi.isForceLandscape=NO;
//    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
//    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
//    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
//}
//-(void)viewDidDisappear:(BOOL)animated{
////    [self forceOrientationPortrait];
////    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
////        SEL selector = NSSelectorFromString(@"setOrientation:");
////        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
////        [invocation setSelector:selector];
////        [invocation setTarget:[UIDevice currentDevice]];
////        int val = UIInterfaceOrientationPortrait;
////        [invocation setArgument:&val atIndex:2];
////        [invocation invoke];
////    }
//}
//-(void) viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//}
-(void)viewDidAppear:(BOOL)animated{
//    [self forceOrientationLandscape]; //设置横屏
    [self inits];
}
//- (UIInterfaceOrientation )getSpecificOrientation  {
//    UIInterfaceOrientation orien=[[UIApplication sharedApplication] statusBarOrientation];
//    UIDeviceOrientation device=[[UIDevice currentDevice] orientation];
//    if(device==UIDeviceOrientationLandscapeLeft){
//        orien=UIInterfaceOrientationLandscapeRight;
//    }else if(device==UIDeviceOrientationLandscapeRight){
//        orien=UIInterfaceOrientationLandscapeLeft;
//    }
//    if(orien!=UIInterfaceOrientationLandscapeLeft&&orien!=UIInterfaceOrientationLandscapeRight){
//        orien = UIInterfaceOrientationLandscapeRight;
//    }
//    return orien;
//}
@end
