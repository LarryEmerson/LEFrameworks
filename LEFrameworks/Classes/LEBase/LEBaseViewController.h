//
//  LEBaseViewController.h
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h" 
#import "LEUIFrameworkExtra.h"
@protocol LEViewControllerPopDelegate <NSObject>
-(void) leOnViewControllerPopedWithPageName:(NSString *) order AndData:(id) data;
@end
/**
 * 如果LEBaseViewController的子类（XXX）对应的view为LEBaseView的子类，并且LEBaseView的子类类名定义为“XXXPage"，则”XXXPage“类会被主动创建。如果需要重新定义子类的init方法，则需要复写XXX的方法：-(void) leExtraInits{}，这样可以避免XXX自动创建“XXXPage”。
 */
@interface LEBaseViewController : UIViewController 
@property (nonatomic, readonly) id<LEViewControllerPopDelegate> lePopDelegate;
-(id) initWithDelegate:(id<LEViewControllerPopDelegate>) delegate; 
@end
@interface LEBaseView : UIView
@property (nonatomic, readonly) int leCurrentFrameWidth;
@property (nonatomic, readonly) int leCurrentFrameHight;
@property (nonatomic, readonly) int leFrameHightForCustomizedView;
@property (nonatomic, readonly) UIView *leViewContainer;
@property (nonatomic, readonly) UIView *leViewBelowCustomizedNavigation;
@property (nonatomic, readonly) UISwipeGestureRecognizer *leRecognizerRight;
@property (nonatomic, weak, readonly) LEBaseViewController *leCurrentViewController;
-(UIView *) leSuperViewContainer;
-(id) initWithViewController:(LEBaseViewController *) vc;
-(void) leSwipGestureLogic;
-(void) leOnSetRightSwipGesture:(BOOL) gesture; 
@end

@protocol LENavigationDelegate <NSObject>
@optional
-(void) leNavigationRightButtonTapped;
-(void) leNavigationNotifyTitleViewContainerWidth:(int) width;
-(void) leNavigationLeftButtonTapped;
@end
@interface LEBaseNavigation : UIView{
    UILabel *leNavigationTitle;
    UIButton *leBackButton;
    UIButton *leRightButton;
    
}
@property (nonatomic) UIView *leTitleViewContainer;
-(id) initWithSuperViewAsDelegate:(LEBaseView *)superview Title:(NSString *) title;
-(id) initWithDelegate:(id<LENavigationDelegate>)delegate SuperView:(LEBaseView *)superview Title:(NSString *) title;
-(id) initWithDelegate:(id<LENavigationDelegate>) delegate ViewController:(UIViewController *) viewController SuperView:(UIView *) superview Offset:(int) offset BackgroundImage:(UIImage *) background TitleColor:(UIColor *) color LeftItemImage:(UIImage *) left;
-(void) leSetNavigationTitle:(NSString *) title;
//-(void) leSetLeftButton:(UIImage *) img;
-(void) leEnableBottomSplit:(BOOL) enable Color:(UIColor *) color;
-(void) leSetBackground:(UIImage *) image;
-(void) leSetLeftNavigationItemWith:(NSString *)title Image:(UIImage *)image Color:(UIColor *) color;
-(void) leSetRightNavigationItemWith:(NSString *) title Image:(UIImage *) image;
-(void) leSetRightNavigationItemWith:(NSString *) title Image:(UIImage *) image Color:(UIColor *) color;
-(void) leSetNavigationOffset:(int) offset;
@end

//typedef NS_ENUM(NSInteger, EffectType) {
//    EffectTypeWithAlpha = 0,
//    EffectTypeFromRight = 1,
//    EffectTypeNone      = 2,
//};
//#define DefaultNavigationClassName @"LENavigationView"
//#define KeyOfNavigationBackButton @"KeyOfNavigationBackButton"
//#define KeyOfNavigationTitle @"KeyOfNavigationTitle"
//#define KeyOfNavigationRightButton @"KeyOfNavigationRightButton"
//#define KeyOfNavigationBackground @"KeyOfNavigationBackground"
//#define KeyOfNavigationInFullScreenMode @"KeyOfNavigationInFullScreenMode"
//#define IsFullScreenMode NO
//@interface LEBaseNavigationView : UIImageView
//@property (nonatomic) NSDictionary *navigationDataModel;
//@property (nonatomic) UIView    *curViewLeft;
//@property (nonatomic) UIView    *curViewMiddle;
//@property (nonatomic) UIView    *curViewRight;
//-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *) autoLayoutSettings ViewDataModel:(NSDictionary *) dataModel;
//-(void) onSetupView;
//-(void) onUpdateViewWithDataModel:(NSDictionary *) dataModel;
//@end
//
//@interface LENavigationView : LEBaseNavigationView
//@property (nonatomic) UIButton  *curButtonBack;
//@property (nonatomic) UILabel   *curLabelTitle;
//@property (nonatomic) UIButton  *curButtonRight;
//@end
//
//@interface LEBaseViewController : UIView
//@property (nonatomic) LEBaseNavigationView *curNavigationView;
//@property (nonatomic) NSString *curNavigationClassName;
//@property (nonatomic) EffectType curEffectType; 
//@property (nonatomic) UIView *leViewContainer;
//
//@property (nonatomic) LEUIFramework *globalVar;
//@property (nonatomic) int leCurrentFrameWidth;
//@property (nonatomic) int leCurrentFrameHight;
//
//-(id) initWithSuperView:(UIView *)view;
//-(id) initWithSuperView:(UIView *)view NavigationDataModel:(NSDictionary *)dataModel EffectType:(EffectType)effectType;
//-(id) initWithSuperView:(UIView *)view NavigationViewClassName:(NSString *) navigationClass NavigationDataModel:(NSDictionary *) dataModel EffectType:(EffectType) effectType; 
//-(void) setExtraViewInits;
//
//-(void) leEaseInView;
//-(void) leEaseOutView;
//-(void) dismissView;
//
//-(UIView *) leSuperViewContainer;
//-(void) setSuperViewContainer:(UIView *) view;
////
//-(void) leEaseInViewLogic;
//-(void) leEaseOutViewLogic;
//-(void) eventCallFromChild;
////
//-(void) onClickedForLeftButton;
//-(void) onClickedForRightButton;
//-(void) onNavigationBarClickedWithCode:(NSString *) code;
//-(void) setStatusBarStyle:(UIStatusBarStyle) style;
//@end

