//
//  LEBaseEmptyView.h
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h" 
 

typedef NS_ENUM(NSInteger, EffectType) {
    EffectTypeWithAlpha = 0,
    EffectTypeFromRight = 1,
    EffectTypeNone      = 2,
};
#define DefaultNavigationClassName @"LENavigationView"
#define KeyOfNavigationBackButton @"KeyOfNavigationBackButton"
#define KeyOfNavigationTitle @"KeyOfNavigationTitle"
#define KeyOfNavigationRightButton @"KeyOfNavigationRightButton"
#define KeyOfNavigationBackground @"KeyOfNavigationBackground"
#define KeyOfNavigationInFullScreenMode @"KeyOfNavigationInFullScreenMode"
#define IsFullScreenMode NO
@interface LEBaseNavigationView : UIImageView
@property (nonatomic) NSDictionary *navigationDataModel;
@property (nonatomic) UIView    *curViewLeft;
@property (nonatomic) UIView    *curViewMiddle;
@property (nonatomic) UIView    *curViewRight;
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) autoLayoutSettings ViewDataModel:(NSDictionary *) dataModel;
-(void) onSetupView;
-(void) onUpdateViewWithDataModel:(NSDictionary *) dataModel;
@end

@interface LENavigationView : LEBaseNavigationView
@property (nonatomic) UIButton  *curButtonBack;
@property (nonatomic) UILabel   *curLabelTitle;
@property (nonatomic) UIButton  *curButtonRight;
@end

@interface LEBaseEmptyView : UIView
@property (nonatomic) LEBaseNavigationView *curNavigationView;
@property (nonatomic) NSString *curNavigationClassName;
@property (nonatomic) EffectType curEffectType; 
@property (nonatomic) UIView *viewContainer;

@property (nonatomic) LEUIFramework *globalVar;
@property (nonatomic) int curFrameWidth;
@property (nonatomic) int curFrameHight;
 
-(id) initWithSuperView:(UIView *)view;
-(id) initWithSuperView:(UIView *)view NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType;
-(id) initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *) navigationClass NavigationDataModel:(NSDictionary *) dataModel EffectType:(EffectType) effectType; 
-(void) setExtraViewInits;

-(void) easeInView;
-(void) easeOutView;
-(void) dismissView;

-(UIView *) superViewContainer;
-(void) setSuperViewContainer:(UIView *) view;
//
-(void) easeInViewLogic;
-(void) easeOutViewLogic;
-(void) eventCallFromChild;
//
-(void) onClickedForLeftButton;
-(void) onClickedForRightButton;
-(void) onNavigationBarClickedWithCode:(NSString *) code;
-(void) setStatusBarStyle:(UIStatusBarStyle) style;
@end
@protocol LEViewControllerPageJumpDelagte <NSObject>
-(void) onEaseOutPageWithPageName:(NSString *) order AndData:(id) data;
@end
@interface LEViewController : UIViewController
@property (nonatomic) id<LEViewControllerPageJumpDelagte> jumpDelegate;
@property (nonatomic) UIViewController *superViewController;
-(id) initWithDelegate:(id<LEViewControllerPageJumpDelagte>) delegate;
@end
@interface LEEmptyViewUnderSystemNavigation : UIView
@property (nonatomic) UISwipeGestureRecognizer *recognizerRight;
@property (nonatomic) int curFrameWidth;
@property (nonatomic) int curFrameHight;
@property (nonatomic) UIView *viewContainer;
@property (nonatomic) LEViewController *curViewController;
-(UIView *) superViewContainer;
-(id) initWithViewController:(LEViewController *) vc;
-(void)setExtraViewInits;
-(void) swipGestureLogic;
@end
