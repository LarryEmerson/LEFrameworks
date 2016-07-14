//
//  LEBaseViewController.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseViewController.h"

@implementation LEBaseView{
    UIView *curSuperView;
    
}
-(id) initWithViewController:(LEBaseViewController *) vc{
    curSuperView=vc.view;
    self.curViewController=vc;
    self=[super initWithFrame:curSuperView.bounds];
    [self setBackgroundColor:LEColorWhite];
    [curSuperView addSubview:self];
    self.curFrameWidth=self.bounds.size.width;
    self.curFrameHight=self.bounds.size.height-(self.curViewController.extendedLayoutIncludesOpaqueBars?0:(LEStatusBarHeight+LENavigationBarHeight));
    self.viewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.curFrameWidth,self.curFrameHight)]];
    [self.viewContainer setBackgroundColor:[LEUIFramework sharedInstance].leColorViewContainer];
    //
    self.recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
    [self.recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.viewContainer addGestureRecognizer:self.recognizerRight];
    //
    [self setExtraViewInits];
    return self;
}
-(void) onSetRightSwipGesture:(BOOL) gesture{
    [self.recognizerRight setEnabled:gesture];
}
-(void)setExtraViewInits{
    
}
-(UIView *)superViewContainer{
    return curSuperView;
}
- (void)swipGesture:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self swipGestureLogic];
    }
}
-(void) swipGestureLogic{
    [self.curViewController.navigationController popViewControllerAnimated:YES];
}
@end
@implementation LEBaseViewController
-(id) initWithDelegate:(id<LEBaseViewControllerPageJumpDelagte>) delegate{
    self.jumpDelegate=delegate;
    return [super init];
}
-(void) viewDidLoad{
    [self setExtendedLayoutIncludesOpaqueBars:NO];
    [self setEdgesForExtendedLayout:UIRectEdgeLeft&UIRectEdgeRight&UIRectEdgeBottom];
    [super viewDidLoad];
}
@end

//@implementation LEBaseNavigationView{
//}
//-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) autoLayoutSettings ViewDataModel:(NSDictionary *) dataModel{
//    self.navigationDataModel=dataModel;
//    self=[super initWithAutoLayoutSettings:autoLayoutSettings];
//    self.curViewLeft=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leAutoLayoutSettings.leSuperView Anchor:LEAnchorInsideTopLeft Offset:CGPointMake(0, LEStatusBarHeight) CGSize:CGSizeMake(LENavigationBarHeight, LENavigationBarHeight)]];
//    self.curViewMiddle=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leAutoLayoutSettings.leSuperView Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, LEStatusBarHeight) CGSize:CGSizeMake(self.leAutoLayoutSettings.leSuperView.bounds.size.width-LENavigationBarHeight*2-LELayoutSideSpace*2, LENavigationBarHeight)]];
//    [self.curViewMiddle setUserInteractionEnabled:NO];
//    self.curViewRight=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leAutoLayoutSettings.leSuperView Anchor:LEAnchorInsideTopRight Offset:CGPointMake(0, LEStatusBarHeight) CGSize:CGSizeMake(LENavigationBarHeight, LENavigationBarHeight)]];
//    [self onSetupView];
//    [self onUpdateViewWithDataModel:dataModel];
//    return self;
//}
//-(void) onSetupView{}
//-(void) onUpdateViewWithDataModel:(NSDictionary *) dataModel{
//    if(dataModel){
//        BOOL fullScreen=NO;
//        if([dataModel objectForKey:KeyOfNavigationInFullScreenMode]){
//            fullScreen=[[dataModel objectForKey:KeyOfNavigationInFullScreenMode] boolValue];
//        }else{
//            fullScreen=IsFullScreenMode;
//        } 
//        [self setUserInteractionEnabled:!fullScreen];
//        [self setBackgroundColor:fullScreen?LEColorClear:[LEUIFramework sharedInstance].leColorNavigationBar];
//        UIImage *background=[dataModel objectForKey:KeyOfNavigationBackground];
//        if(background){
//            [self setImage:[background leMiddleStrechedImage]];
//        }
//    }
//}
//@end
//@implementation LENavigationView
//-(void) onSetupView{
//    [self setBackgroundColor:[LEUIFramework sharedInstance].leColorNavigationBar];
//    self.curButtonBack=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.curViewLeft  Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:self.curViewLeft.bounds.size] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:nil FontSize:0 Font:nil Image:nil BackgroundImage:nil Color:nil SelectedColor:nil MaxWidth:0 SEL:@selector(onButtonClicked:) Target:self]];
//    self.curButtonRight=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.curViewRight Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:self.curViewRight.bounds.size] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:nil FontSize:0 Font:nil Image:nil BackgroundImage:nil Color:nil SelectedColor:nil MaxWidth:0 SEL:@selector(onButtonClicked:) Target:self]];
//    self.curLabelTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.curViewMiddle Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:nil FontSize:0 Font:[UIFont boldSystemFontOfSize:NavigationBarFontSize] Width:LESCREEN_WIDTH-LELayoutSideSpace*4-LENavigationBarHeight*2 Height:0 Color:[LEUIFramework sharedInstance].leColorNavigationContent Line:1 Alignment:NSTextAlignmentCenter]];
//}
//-(void) onUpdateViewWithDataModel:(NSDictionary *) dataModel{
//    [super onUpdateViewWithDataModel:dataModel];
//    self.navigationDataModel=dataModel;
//    UIImage *back=nil;
//    NSString *title=nil;
//    UIImage *right=nil;
//    if(dataModel){
//        back=[dataModel objectForKey:KeyOfNavigationBackButton];
//        title=[dataModel objectForKey:KeyOfNavigationTitle];
//        right=[dataModel objectForKey:KeyOfNavigationRightButton];
//        if(back){
//            [self.curButtonBack setImage:back forState:UIControlStateNormal];
//        }
//        if(title){
//            [self.curLabelTitle leSetText:title];
//        }
//        if(right){
//            [self.curButtonRight setImage:right forState:UIControlStateNormal];
//        }
//    }
//    [self.curViewMiddle setHidden:!title];
//    [self.curViewLeft setHidden:(back==nil)];
//    [self.curViewRight setHidden:(right==nil)];
//}
//-(void) onButtonClicked:(UIButton *) button{
//    NSString *code=@"";
//    if([button isEqual:self.curButtonBack]){
//        code=KeyOfNavigationBackButton;
//    }else if([button isEqual:self.curButtonRight]){
//        code=KeyOfNavigationRightButton;
//    }
//    if([self.superview respondsToSelector:NSSelectorFromString(@"onNavigationBarClickedWithCode:")]){
//        LESuppressPerformSelectorLeakWarning(
//                                           [self.superview performSelector:NSSelectorFromString(@"onNavigationBarClickedWithCode:") withObject:code];
//                                           );
//    }
//}
//@end
//@implementation LEBaseViewController{
//    UIView *curSuperViewContainer;
//    UISwipeGestureRecognizer *recognizerRight;
//    UIStatusBarStyle targetStatusStyle;
//    UIStatusBarStyle lastStatusStyle;
//}
//@synthesize viewContainer=_viewContainer;
//@synthesize globalVar=_globalVar;
//@synthesize curFrameHight=_curFrameHight;
//@synthesize curFrameWidth=_curFrameWidth;
//-(void) onNavigationBarClickedWithCode:(NSString *) code{
//    //    LELogObject(code);
//    if([code isEqualToString:KeyOfNavigationBackButton]){
//        [self onClickedForLeftButton];
//    }else if([code isEqualToString:KeyOfNavigationRightButton]){
//        [self onClickedForRightButton];
//    }
//}
//-(void) onClickedForLeftButton{
//    [self easeOutView];
//}
//-(void) onClickedForRightButton{
//    
//}
//-(void) setStatusBarStyle:(UIStatusBarStyle) style{
//    [[UIApplication sharedApplication] setStatusBarStyle:style animated:YES];
//} 
//-(UIView *) superViewContainer{
//    return curSuperViewContainer;
//}
//-(void) setSuperViewContainer:(UIView *) view{
//    curSuperViewContainer=view;
//}
//-(id) initWithSuperView:(UIView *)view{
//    return [self initWithSuperView:view NavigationViewClassName:nil NavigationDataModel:nil  EffectType:EffectTypeWithAlpha];
//}
//-(id) initWithSuperView:(UIView *)view NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType{
//    return [self initWithSuperView:view NavigationViewClassName:@"LENavigationView" NavigationDataModel:dataModel EffectType:effectType];
//}
//-(id) initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *) navigationClass NavigationDataModel:(NSDictionary *) dataModel EffectType:(EffectType) effectType{
//    curSuperViewContainer=view;
//    self.curNavigationClassName=navigationClass;
//    lastStatusStyle=[[UIApplication sharedApplication] statusBarStyle];
//    self.globalVar = [LEUIFramework sharedInstance];
//    self.curFrameWidth=LESCREEN_WIDTH;
//    self.curFrameHight=LESCREEN_HEIGHT;
//    self.curFrameHight=view.frame.size.height;
//    self = [super initWithFrame:CGRectMake(0, 0, self.curFrameWidth,self.curFrameHight)];
//    BOOL fullScreen=NO;
//    if([dataModel objectForKey:KeyOfNavigationInFullScreenMode]){
//        fullScreen=[[dataModel objectForKey:KeyOfNavigationInFullScreenMode] boolValue];
//    }else{
//        fullScreen=IsFullScreenMode;
//    }
//    //
//    self.curEffectType=effectType;
//    if(effectType==EffectTypeFromRight){
//        [self leSetFrame:CGRectMake(self.curFrameWidth, 0, self.curFrameWidth, self.curFrameHight)];
//    }
//    recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
//    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self addGestureRecognizer:recognizerRight];
//    //
//    [view addSubview:self];
//    [self setBackgroundColor:LEColorWhite];
//    //Container
//    self.viewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, fullScreen?0:(LENavigationBarHeight+LEStatusBarHeight)) CGSize:CGSizeMake(self.curFrameWidth, self.curFrameHight-(fullScreen?0:(LENavigationBarHeight+LEStatusBarHeight)))]];
//    [self.viewContainer setBackgroundColor:[LEUIFramework sharedInstance].leColorViewContainer];
//    //
//    if(navigationClass&&navigationClass.length>0){
//        LESuppressPerformSelectorLeakWarning(
//                                           self.curNavigationView=[[NSClassFromString(navigationClass) alloc] performSelector:NSSelectorFromString(@"initWithAutoLayoutSettings:ViewDataModel:") withObject:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.curFrameWidth, LENavigationBarHeight+LEStatusBarHeight)] withObject:dataModel];
//                                           );
//    }
//    [self setExtraViewInits];
//    return self;
//}
//-(void) setExtraViewInits{
//}
//-(void) easeInView{
//    if(self.curEffectType==EffectTypeWithAlpha){
//        [self setAlpha:0];
//        [UIView animateWithDuration:0.2f animations:^(void){
//            [self setAlpha:1];
//        }completion:^(BOOL isDone){
//            [self easeInViewLogic];
//        }];
//    }else if(self.curEffectType==EffectTypeFromRight){
//        [self leSetFrame:CGRectMake(self.curFrameWidth, 0, self.curFrameWidth, self.curFrameHight)];
//        [UIView animateWithDuration:0.2 animations:^(void){
//            [self leSetFrame:CGRectMake(0, 0, self.curFrameWidth, self.curFrameHight)];
//        } completion:^(BOOL isDone){
//            [self easeInViewLogic];
//        }];
//    }
//}
//-(void) easeOutView{
//    [self setStatusBarStyle:lastStatusStyle];
//    if(self.curEffectType==EffectTypeWithAlpha){
//        [UIView animateWithDuration:0.2f animations:^(void){
//            [self setAlpha:0];
//        } completion:^(BOOL isDone){
//            [self dismissView];
//        }];
//    }else if(self.curEffectType==EffectTypeFromRight){
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
//            [self leSetFrame:CGRectMake(self.curFrameWidth, 0, self.curFrameWidth, self.curFrameHight)];
//        } completion:^(BOOL isFinished){
//            [self easeOutViewLogic];
//        }];
//    }else{
//        [self easeOutViewLogic];
//    }
//}
//-(void) easeInViewLogic{
//}
//-(void) easeOutViewLogic{
//    [self dismissView];
//}
//-(void) eventCallFromChild{
//}
//-(void) dismissView{
//    [self removeFromSuperview];
//}
//- (void)swipGesture:(UISwipeGestureRecognizer *)recognizer {
//    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
//        [self easeOutView];
//    }
//}
//@end
//
