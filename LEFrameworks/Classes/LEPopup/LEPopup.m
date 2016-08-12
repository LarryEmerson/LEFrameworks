//
//  LEPopup.m
//  YuSen
//
//  Created by emerson larry on 16/4/18.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEPopup.h"


@implementation LEPopupSettings
-(id) init{
    self=[super init];
    [self initExtra];
    return self;
}
-(void) initExtra{}
@end

@implementation LEPopup{
    LEPopupSettings *curSettings;
    UIImageView *curBackground;
    UIView *curContentContainer;
    UILabel *curTitle;
    UIImageView *curSplit;
    UILabel *curSubtitle;
    //
    int W;
    int H;
    int ContentW;
    int ContentHExtra;
    //
    UIView *curBottomBar;
    UIView *curLeftBar;
    UIView *curRightBar;
    UIButton *curLeftButton;
    UIButton *curRightButton;
    UIButton *curCenterButton;
    //
    int btnHeight;
}
+(LEPopup *) leShowLEPopupWithSettings:(LEPopupSettings *) settings{
    LEPopup *popup= [[LEPopup alloc] initWithSettings:settings];
    [popup leEaseIn];
    return popup;
}
+(LEPopup *) leShowQuestionPopupWithSubtitle:(NSString *)leSubtitle Delegate:(id<LEPopupDelegate>) delegate{
    return [LEPopup leShowQuestionPopupWithTitle:nil Subtitle:leSubtitle Alignment:NSTextAlignmentCenter Delegate:delegate];
}
+(LEPopup *) leShowQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)leSubtitle Alignment:(NSTextAlignment) leTextAlignment Delegate:(id<LEPopupDelegate>) delegate{
    return [LEPopup leShowQuestionPopupWithTitle:title Subtitle:leSubtitle Alignment:leTextAlignment LeftButtonText:@"取消" RightButtonText:@"确定" Delegate:delegate];
}
+(LEPopup *) leShowQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)leSubtitle Alignment:(NSTextAlignment) leTextAlignment LeftButtonText:(NSString *)leftText RightButtonText:(NSString *)rightText Delegate:(id<LEPopupDelegate>) delegate {
    return [LEPopup leShowQuestionPopupWithTitle:title Subtitle:leSubtitle Alignment:leTextAlignment LeftButtonImage:[LEPopupCancleImage leMiddleStrechedImage] RightButtonImage:[LEPopupOKImage leMiddleStrechedImage] LeftButtonText:leftText RightButtonText:rightText Delegate:delegate];
}
+(LEPopup *) leShowQuestionPopupWithTitle:(NSString *)title Subtitle:(NSString *)leSubtitle Alignment:(NSTextAlignment) leTextAlignment LeftButtonImage:(UIImage *)leftImg RightButtonImage:(UIImage *)rightImg LeftButtonText:(NSString *)leftText RightButtonText:(NSString *)rightText Delegate:(id<LEPopupDelegate>) delegate{
    LEPopupSettings *settings=[[LEPopupSettings alloc] init];
    [settings setLeDelegate:delegate];
    [settings setLeTitle:title];
    
    [settings setLeHasTopSplit:title!=nil];
    [settings setLeSubtitle:leSubtitle];
    [settings setLeTextAlignment:leTextAlignment];
    [settings setLeLeftButtonSetting:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:leftText FontSize:LELayoutFontSize13 Font:nil Image:nil BackgroundImage:leftImg Color:LEColorWhite SelectedColor:LEColorGray MaxWidth:0 SEL:nil Target:nil HorizontalSpace:30]];
    [settings setLeRightButtonSetting:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:rightText FontSize:LELayoutFontSize13 Font:nil Image:nil BackgroundImage:rightImg Color:LEColorWhite SelectedColor:LEColorGray MaxWidth:0 SEL:nil Target:nil HorizontalSpace:30]];
    LEPopup *popup=[[LEPopup alloc] initWithSettings:settings];
    [popup leEaseIn];
    return popup;
}
+(LEPopup *) leShowTipPopupWithTitle:(NSString *)title Subtitle:(NSString *)leSubtitle Alignment:(NSTextAlignment) leTextAlignment{
    return [LEPopup leShowTipPopupWithTitle:title Subtitle:leSubtitle Alignment:leTextAlignment ButtonImage:[LEPopupOKImage leMiddleStrechedImage] ButtonText:@"确定"];
}
+(LEPopup *) leShowTipPopupWithTitle:(NSString *)title Subtitle:(NSString *)leSubtitle Alignment:(NSTextAlignment) leTextAlignment ButtonImage:(UIImage *)img ButtonText:(NSString *) text{
    LEPopupSettings *settings=[[LEPopupSettings alloc] init];
    [settings setLeTitle:title];
    [settings setLeHasTopSplit:title!=nil];
    [settings setLeSubtitle:leSubtitle];
    [settings setLeTextAlignment:leTextAlignment];
    [settings setLeCenterButtonSetting:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:text FontSize:LELayoutFontSize13 Font:nil Image:nil BackgroundImage:img Color:LEColorWhite SelectedColor:LEColorGray MaxWidth:0 SEL:nil Target:nil HorizontalSpace:30]];
    LEPopup *popup=[[LEPopup alloc] initWithSettings:settings];
    [popup leEaseIn];
    return popup;
}
-(id) initWithSettings:(LEPopupSettings *) settings{
    curSettings=settings;
    self=[super initWithFrame:LESCREEN_BOUNDS];
    [self setBackgroundColor:LEColorMask5];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self initExtra];
    [self leExtraInits];
    return self;
}
-(void) initExtra{
    W=self.bounds.size.width;
    H=self.bounds.size.height;
    if(curSettings.leSideEdge==0){
        curSettings.leSideEdge=LENavigationBarHeight;
    }
    if(curSettings.leMaxHeight==0){
        curSettings.leMaxHeight=H;
    }
    if(UIEdgeInsetsEqualToEdgeInsets(curSettings.leContentInsects, UIEdgeInsetsZero)){
        curSettings.leContentInsects=UIEdgeInsetsMake(LELayoutContentTopSpace, LELayoutSideSpace, LELayoutContentBottomSpace, LELayoutSideSpace);
    }
    if(!curSettings.leTitleFont){
        curSettings.leTitleFont=[UIFont boldSystemFontOfSize:LELayoutFontSize14];
    }
    if(!curSettings.leTitleColor){
        curSettings.leTitleColor=LEColorTextBlack;
    }
    if(!curSettings.leSubtitleFont){
        curSettings.leSubtitleFont=[UIFont systemFontOfSize:LELayoutFontSize12];
    }
    if(!curSettings.leSubTitleColor){
        curSettings.leSubTitleColor=LEColorTextBlack;
    }
    if(!curSettings.leColorSplit){
        curSettings.leColorSplit=LEColorSplit;
    }
    //  
} 
-(void) leExtraInits{
    [self setAlpha:0]; 
    [self leAddTapEventWithSEL:@selector(onBackgroundTapped) Target:self];
    curBackground=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeMake(W-curSettings.leSideEdge*2, curSettings.leMaxHeight)] Image:curSettings.leBckgroundImage?[[UIImage imageNamed:curSettings.leBckgroundImage] leMiddleStrechedImage]:(LEPopupBGImage?LEPopupBGImage:[LEColorWhite leImageStrechedFromSizeOne])];
    [curBackground setUserInteractionEnabled:YES];
    [curBackground leAddTapEventWithSEL:nil];
    curContentContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBackground EdgeInsects:curSettings.leContentInsects]];
    ContentW=curContentContainer.bounds.size.width;
    ContentHExtra=curSettings.leContentInsects.top+curSettings.leContentInsects.bottom;
    curTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(ContentW, ContentHExtra)] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:curSettings.leTitle FontSize:0 Font:curSettings.leTitleFont Width:ContentW Height:0 Color:curSettings.leTitleColor Line:0 Alignment:NSTextAlignmentCenter]];
    curSplit=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:curTitle Offset:CGPointMake(0, LELayoutSideSpace) CGSize:CGSizeMake(ContentW, 1)] Image:[curSettings.leColorSplit leImageStrechedFromSizeOne]];
    [curSplit setHidden:!curSettings.leHasTopSplit];
    curSubtitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:curSplit Offset:CGPointMake(0, curSettings.leHasTopSplit?LELayoutSideSpace:0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:curSettings.leSubtitle FontSize:0 Font:curSettings.leSubtitleFont Width:ContentW Height:0 Color:curSettings.leSubTitleColor Line:0 Alignment:curSettings.leTextAlignment]];
    [curSubtitle leSetLineSpace:curSettings.leSubtitleLineSpace];
    btnHeight=LENavigationBarHeight;
    if(curSettings.leLeftButtonSetting.leBackgroundImage){
        btnHeight=MAX(LENavigationBarHeight, curSettings.leLeftButtonSetting.leBackgroundImage.size.height);
    }
    if(curSettings.leLeftButtonSetting.leBackgroundImage){
        btnHeight=MAX(LENavigationBarHeight, curSettings.leLeftButtonSetting.leBackgroundImage.size.height);
    }
    if(curSettings.leCenterButtonSetting.leBackgroundImage){
        btnHeight=MAX(LENavigationBarHeight, curSettings.leCenterButtonSetting.leBackgroundImage.size.height);
    }
    curBottomBar=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curContentContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:curSubtitle Offset:CGPointMake(0, LELayoutSideSpace) CGSize:CGSizeMake(ContentW, btnHeight)]];
    curLeftBar=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(ContentW/2.0, btnHeight)]];
    curRightBar=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar Anchor:LEAnchorInsideRightCenter Offset:CGPointZero CGSize:CGSizeMake(ContentW/2.0, btnHeight)]];
    [self initLeftButton];
    [self initRightButton];
    [self initCenterButton];
    [self leOnUpdatePopupLayout];
}
//
-(void) leOnResetPopupContent{
    [curTitle leSetText:curSettings.leTitle];
    [curSplit setHidden:!curSettings.leHasTopSplit];
    [curSubtitle leSetText:curSettings.leSubtitle];
    [curSubtitle leSetLineSpace:curSettings.leSubtitleLineSpace];
    [curSubtitle leSetOffset:CGPointMake(0, curSettings.leHasTopSplit?LELayoutSideSpace:0)];
    [self initLeftButton];
    [self initRightButton];
    [self initCenterButton];
    [self leOnUpdatePopupLayout];
}
-(void) leOnUpdatePopupLayout{
    BOOL hasButton=(curSettings.leLeftButtonSetting&&curSettings.leRightButtonSetting)||curSettings.leCenterButtonSetting;
    [curBottomBar setHidden:!hasButton];
    [curContentContainer leSetSize:CGSizeMake(curBackground.bounds.size.width, curBottomBar.frame.origin.y+(hasButton?btnHeight:0))];
    [curBackground leSetSize:CGSizeMake(curBackground.bounds.size.width, curBottomBar.frame.origin.y+(hasButton?btnHeight:0)+curSettings.leContentInsects.top+curSettings.leContentInsects.bottom)];
}
//
-(void) initLeftButton{
    if(curSettings.leLeftButtonSetting){
        if(curLeftButton){
            [curLeftButton removeTarget:self action:@selector(onLeft) forControlEvents:UIControlEventTouchUpInside];
            [curLeftButton removeFromSuperview];
        }
        if(UIEdgeInsetsEqualToEdgeInsets(curSettings.leLeftButtonEdge, UIEdgeInsetsZero)){
            curLeftButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curLeftBar Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:curSettings.leLeftButtonSetting];
        }else{
            curLeftButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curLeftBar EdgeInsects:curSettings.leLeftButtonEdge] ButtonSettings:curSettings.leLeftButtonSetting];
        }
        [curLeftButton addTarget:self action:@selector(onLeft) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void) initRightButton{
    if(curSettings.leRightButtonSetting){
        if(curRightButton){
            [curRightButton removeTarget:self action:@selector(onRight) forControlEvents:UIControlEventTouchUpInside];
            [curRightButton removeFromSuperview];
        }
        if(UIEdgeInsetsEqualToEdgeInsets(curSettings.leRightButtonEdge, UIEdgeInsetsZero)){
            curRightButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curRightBar Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:curSettings.leRightButtonSetting];
        }else{
            curRightButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curRightBar EdgeInsects:curSettings.leRightButtonEdge] ButtonSettings:curSettings.leRightButtonSetting];
        }
        [curRightButton addTarget:self action:@selector(onRight) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void) initCenterButton{
    if(curSettings.leCenterButtonSetting){
        if(curCenterButton){
            [curCenterButton removeTarget:self action:@selector(onCenter) forControlEvents:UIControlEventTouchUpInside];
            [curCenterButton removeFromSuperview];
        }
        if(UIEdgeInsetsEqualToEdgeInsets(curSettings.leCenterButtonEdge, UIEdgeInsetsZero)){
            curCenterButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:curSettings.leCenterButtonSetting];
        }else{
            curCenterButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curBottomBar EdgeInsects:curSettings.leCenterButtonEdge] ButtonSettings:curSettings.leCenterButtonSetting];
        }
        [curCenterButton addTarget:self action:@selector(onCenter) forControlEvents:UIControlEventTouchUpInside];
    }
}
//
-(void) onLeft{
    [self leEaseOut:@selector(onLeftLogic)];
}
-(void) onLeftLogic{
    if(curSettings.leDelegate&&[curSettings.leDelegate respondsToSelector:@selector(leOnPopupLeftButtonClicked)]){
        [curSettings.leDelegate performSelector:@selector(leOnPopupLeftButtonClicked)];
    }
}
-(void) onRight{
    [self leEaseOut:@selector(onRightLogic)];
}
-(void) onRightLogic{
    if(curSettings.leDelegate&&[curSettings.leDelegate respondsToSelector:@selector(leOnPopupRightButtonClicked)]){
        [curSettings.leDelegate performSelector:@selector(leOnPopupRightButtonClicked)];
    }
}
-(void) onCenter{
    [self leEaseOut:@selector(onCenterLogic)];
}
-(void) onCenterLogic{
    if(curSettings.leDelegate&&[curSettings.leDelegate respondsToSelector:@selector(leOnPopupCenterButtonClicked)]){
        [curSettings.leDelegate performSelector:@selector(leOnPopupCenterButtonClicked)];
    }
}
-(void) onBackgroundTapped{
    [self leEaseOut:nil];
}
-(void) leEaseIn{
    [UIView animateWithDuration:0.4 animations:^(void){
        [self setAlpha:1];
    }];
}
-(void) leEaseOut:(SEL) sel{
    [UIView animateWithDuration:0.4 animations:^(void){
        [self setAlpha:0];
    } completion:^(BOOL done){
        if(sel){
            LESuppressPerformSelectorLeakWarning(
                                                 [self performSelector:sel];
                                                 );
        }
        [self removeFromSuperview];
    }];
}
@end
