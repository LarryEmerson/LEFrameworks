//
//  LEPopup.h
//  YuSen
//
//  Created by emerson larry on 16/4/18.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LEUIFramework.h"
#define LEPopupCancleImage  [[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"LE_common_btn_gray"]
#define LEPopupOKImage      [[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"LE_common_btn_blue"]
#define LEPopupBGImage      [[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"LE_popup_bg"]


@protocol LEPopupDelegate<NSObject>
@optional
-(void) onPopupLeftButtonClicked;
-(void) onPopupRightButtonClicked;
-(void) onPopupCenterButtonClicked;

@end

@interface LEPopupSettings:NSObject
@property (nonatomic) id<LEPopupDelegate> curDelegate;
@property (nonatomic) NSString *backgroundImage;
@property (nonatomic) int sideEdge;
@property (nonatomic) int maxHeight;
@property (nonatomic) UIEdgeInsets contentInsects;
//
@property (nonatomic) NSString *title;
@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIColor *titleColor;
//
@property (nonatomic) BOOL hasTopSplit;
@property (nonatomic) UIColor *colorSplit;
//
@property (nonatomic) NSString *subtitle;
@property (nonatomic) UIFont *subtitleFont;
@property (nonatomic) UIColor *subtitleColor;
@property (nonatomic) NSTextAlignment textAlignment;
//
@property (nonatomic) LEAutoLayoutUIButtonSettings *leftButtonSetting;
@property (nonatomic) LEAutoLayoutUIButtonSettings *rightButtonSetting;
@property (nonatomic) LEAutoLayoutUIButtonSettings *centerButtonSetting;
@property (nonatomic) UIEdgeInsets leftButtonEdge;
@property (nonatomic) UIEdgeInsets rightButtonEdge;
@property (nonatomic) UIEdgeInsets centerButtonEdge;
@end

@interface LEPopup : UIView
-(id) initWithSettings:(LEPopupSettings *) settings;
-(void) onUpdatePopupLayout;
-(void) onResetPopupContent;
-(void) easeIn;
+(LEPopup *) showLEPopupWithSettings:(LEPopupSettings *) settings;
+(LEPopup *) showQuestionPopupWithSubtitle:(NSString *)subtitle Delegate:(id<LEPopupDelegate>) delegate;
+(LEPopup *) showQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment Delegate:(id<LEPopupDelegate>) delegate;
+(LEPopup *) showQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment LeftButtonText:(NSString *)leftText RightButtonText:(NSString *)rightText Delegate:(id<LEPopupDelegate>) delegate;
+(LEPopup *) showQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment LeftButtonImage:(UIImage *)leftImg RightButtonImage:(UIImage *)rightImg LeftButtonText:(NSString *)leftText RightButtonText:(NSString *)rightText Delegate:(id<LEPopupDelegate>) delegate;
+(LEPopup *) showTipPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment;
+(LEPopup *) showTipPopupWithTitle:(NSString *)title Subtitle:(NSString *)subtitle Alignment:(NSTextAlignment) textAlignment ButtonImage:(UIImage *)img ButtonText:(NSString *) text;

@end
