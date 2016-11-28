//
//  LEBaseViewController.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseViewController.h"
@interface LEBaseView()
@property (nonatomic, readwrite) UISwipeGestureRecognizer *recognizerRight;
@property (nonatomic, readwrite) int leCurrentFrameWidth;
@property (nonatomic, readwrite) int leCurrentFrameHight;
@property (nonatomic, readwrite) int leFrameHightForCustomizedView;
@property (nonatomic, readwrite) UIView *leViewContainer;
@property (nonatomic, readwrite) UIView *leViewBelowCustomizedNavigation;
@property (nonatomic, readwrite) LEBaseViewController *leCurrentViewController;
@end
@implementation LEBaseView{
    UIView *curSuperView; 
}
-(void) leReleaseView{
    [self.recognizerRight removeTarget:self action:@selector(swipGesture:)];
    self.recognizerRight=nil;
    self.leCurrentViewController=nil;
    [self.leViewBelowCustomizedNavigation removeFromSuperview];
    [self.leViewContainer removeFromSuperview];
    self.leViewContainer=nil;
    self.leViewBelowCustomizedNavigation=nil;
    [self removeFromSuperview];
} 
-(id) initWithViewController:(LEBaseViewController *) vc{
    curSuperView=vc.view;
    self.leCurrentViewController=vc;
    self=[super initWithFrame:curSuperView.bounds];
    [self setBackgroundColor:LEColorWhite];
    [curSuperView addSubview:self];
    self.leCurrentFrameWidth=self.bounds.size.width;
    self.leCurrentFrameHight=self.bounds.size.height-(self.leCurrentViewController.extendedLayoutIncludesOpaqueBars?0:(LEStatusBarHeight+LENavigationBarHeight));
    self.leFrameHightForCustomizedView=self.leCurrentFrameHight;
    self.leViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.leCurrentFrameWidth,self.leCurrentFrameHight)]];
    [self.leViewContainer setBackgroundColor:[LEUIFramework sharedInstance].leColorViewContainer];
    //
    if(self.leCurrentFrameHight==LESCREEN_HEIGHT){
        self.leViewBelowCustomizedNavigation=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, LEStatusBarHeight+LENavigationBarHeight) CGSize:CGSizeMake(LESCREEN_WIDTH, LESCREEN_HEIGHT-LEStatusBarHeight-LENavigationBarHeight)]];
        self.leFrameHightForCustomizedView=self.leViewBelowCustomizedNavigation.bounds.size.height;
    }
    self.recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
    [self.recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.leViewContainer addGestureRecognizer:self.recognizerRight];
    //
    [self leExtraInits];
    return self;
}
-(void) leOnSetRightSwipGesture:(BOOL) gesture{
    [self.recognizerRight setEnabled:gesture];
} 
-(UIView *)leSuperViewContainer{
    return curSuperView;
}
- (void)swipGesture:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self leSwipGestureLogic];
    }
}
-(void) leSwipGestureLogic{
    [self.leCurrentViewController.navigationController popViewControllerAnimated:YES];
} 
@end
@interface LEBaseViewController ()
@property (nonatomic, readwrite) id<LEViewControllerPopDelegate> lePopDelegate;
@end
@implementation LEBaseViewController
-(id) initWithDelegate:(id<LEViewControllerPopDelegate>) delegate{
    self.lePopDelegate=delegate;
    return [super init];
}
-(void) viewDidLoad{
    [self setExtendedLayoutIncludesOpaqueBars:YES];
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [super viewDidLoad];
    [self leExtraInits];
}
-(void) leExtraInits{
    NSString *class=NSStringFromClass(self.class);
    class=[class stringByAppendingString:@"Page"];
    NSObject *obj=[NSClassFromString(class) alloc];
    if(obj&&([obj isKindOfClass:[LEBaseView class]]||[obj isMemberOfClass:[LEBaseView class]])){
        [[(LEBaseView *) obj initWithViewController:self] setUserInteractionEnabled:YES];
    }
}
@end

@interface LEBaseNavigation ()
@property (nonatomic, weak) UIViewController *curViewController;
@end
@implementation LEBaseNavigation{
    id<LENavigationDelegate> curDelegate;
    UIImageView *background;
    UIView *bottomSplit;
}
-(id) initWithSuperViewAsDelegate:(LEBaseView *)superview Title:(NSString *) title{
    return [self initWithDelegate:(id)superview SuperView:superview Title:title];
}
-(id) initWithDelegate:(id<LENavigationDelegate>)delegate SuperView:(LEBaseView *)superview Title:(NSString *) title{
    self= [self initWithDelegate:delegate ViewController:superview.leCurrentViewController SuperView:superview Offset:LEStatusBarHeight BackgroundImage:[LEUIFramework sharedInstance].leImageNavigationBar TitleColor:[LEUIFramework sharedInstance].leColorNavigationContent LeftItemImage:[LEUIFramework sharedInstance].leImageNavigationBack];
    [self leSetNavigationTitle:title];
    return self;
}
-(id) initWithDelegate:(id<LENavigationDelegate>) delegate ViewController:(UIViewController *) viewController SuperView:(UIView *) superview Offset:(int) offset BackgroundImage:(UIImage *) bg TitleColor:(UIColor *) color LeftItemImage:(UIImage *) left{
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:superview Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, offset) CGSize:CGSizeMake(LESCREEN_WIDTH, LENavigationBarHeight)]];
    self.curViewController=viewController;
    curDelegate=delegate;
    background=[UIImageView new].leSuperView(self).leAnchor(LEAnchorInsideBottomCenter).leSize(CGSizeMake(LESCREEN_WIDTH, LENavigationBarHeight+offset)).leBackground([LEUIFramework sharedInstance].leColorNavigationBar).leAutoLayout.leType;
    [background setImage:bg];
    //
    leBackButton=[UIButton new].leSuperView(self).leAnchor(LEAnchorInsideLeftCenter).leAutoLayout.leType;
    [leBackButton.leGap(LELayoutSideSpace).leFont(LEFont([LEUIFramework sharedInstance].leNavigationButtonFontsize)).leNormalColor(LEColorBlack).leHighlightedColor(LEColorGray).leTapEvent(@selector(onLeft),self)  leButtonLayout];
    [leBackButton setClipsToBounds:YES];
    leRightButton=[UIButton new].leSuperView(self).leAnchor(LEAnchorInsideRightCenter).leAutoLayout.leType;
    [leRightButton.leGap(LELayoutSideSpace).leFont(LEFont([LEUIFramework sharedInstance].leNavigationButtonFontsize)).leNormalColor(LEColorBlack).leHighlightedColor(LEColorGray).leTapEvent(@selector(onRight),self) leButtonLayout];
    [leRightButton setClipsToBounds:YES]; 
    //
    self.leTitleViewContainer=[UIView new].leSuperView(self).leRelativeView(leBackButton).leAnchor(LEAnchorOutsideRightCenter).leSize(CGSizeMake(LESCREEN_WIDTH-LENavigationBarHeight*2, LENavigationBarHeight)).leAutoLayout;
    leNavigationTitle=[UILabel new].leSuperView(self).leAnchor(LEAnchorInsideCenter).leAutoLayout.leType;
    [leNavigationTitle.leFont(LEBoldFont(LENavigationBarFontSize)).leLine(1).leColor(color).leAlignment(NSTextAlignmentCenter) leLabelLayout];
    //
    [self leSetLeftNavigationItemWith:nil Image:left Color:nil];
    [self leEnableBottomSplit:YES Color:LEColorSplit];
    return self;
}
-(void) onCheckTitleView{
    [self onCheckTitleViewWith:leNavigationTitle.text];
}
-(void) onCheckTitleViewWith:(NSString *) title{
    [UIView animateWithDuration:0.2 animations:^{
        [leNavigationTitle leSetText:title];
        float width=LESCREEN_WIDTH-leBackButton.bounds.size.width-leRightButton.bounds.size.width;
        [self.leTitleViewContainer leSetSize:CGSizeMake(width, LENavigationBarHeight)];
        if(curDelegate&&[curDelegate respondsToSelector:@selector(leNavigationNotifyTitleViewContainerWidth:)]){
            [curDelegate leNavigationNotifyTitleViewContainerWidth:width];
        }
        [leNavigationTitle leSetOffset:CGPointZero];
        [leNavigationTitle.leWidth(width-LELayoutSideSpace*2).leText(leNavigationTitle.text) leLabelLayout];
        float x1=self.leTitleViewContainer.frame.origin.x;
        float x2=leNavigationTitle.frame.origin.x;
        float w1=self.leTitleViewContainer.frame.size.width;
        float w2=leNavigationTitle.frame.size.width;
        [leNavigationTitle leSetOffset:CGPointMake((MAX(0, (x1-x2+LELayoutSideSpace))+MIN(0, (x1-x2+w1-w2-LELayoutSideSpace)))/1, 0)];
    }];
    //    LELog(@"%f %f %f %f",leBackButton.bounds.size.width,leRightButton.bounds.size.width,width,leNavigationTitle.leAutoLayoutSettings.leOffset.x)
}
//-(void) leSetLeftButton:(UIImage *) img{
//    [leBackButton setImage:img forState:UIControlStateNormal];
//    [leBackButton leSetSize:LESquareSize(LENavigationBarHeight)];
//    [self onCheckTitleView];
//}
-(void) leEnableBottomSplit:(BOOL) enable Color:(UIColor *) color{
    if(enable&&bottomSplit==nil){
        bottomSplit=[self leAddBottomSplitWithColor:color Offset:CGPointZero Width:LESCREEN_WIDTH];
    }
    [bottomSplit setHidden:!enable];
}
-(void) leSetBackground:(UIImage *) image{
    [background setImage:image];
}
-(void) leSetNavigationTitle:(NSString *) title{
    [self onCheckTitleViewWith:title];
}
-(void) leSetLeftNavigationItemWith:(NSString *)title Image:(UIImage *)image Color:(UIColor *) color{
    [leBackButton.leText(title) leButtonLayout];
    if(color){
        [leBackButton.leNormalColor(color) leButtonLayout];
    }
    if(image){
        [leBackButton.leImage(image) leButtonLayout];
    }else{
        [leBackButton.leImage(nil) leButtonLayout];
    }
    [self onCheckTitleView];
}
-(void) leSetRightNavigationItemWith:(NSString *) title Image:(UIImage *) image{
    [self leSetRightNavigationItemWith:title Image:image Color:LEColorTextBlack];
}
-(void) leSetRightNavigationItemWith:(NSString *) title Image:(UIImage *) image Color:(UIColor *) color{
    [leRightButton.leText(title) leButtonLayout];
    if(color){
        [leRightButton.leNormalColor(color) leButtonLayout];
    }
    if(image){
        [leRightButton.leImage(image) leButtonLayout];
    }else{
        [leRightButton.leImage(nil) leButtonLayout];
    }
    [self onCheckTitleView];
}

-(void) leSetNavigationOffset:(int) offset{
    [background leSetSize:CGSizeMake(LESCREEN_WIDTH, offset+LENavigationBarHeight)];
    [self leSetOffset:CGPointMake(0, offset)];
}
-(void) onLeft{
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leNavigationLeftButtonTapped)]){
        [curDelegate leNavigationLeftButtonTapped];
    }else{
        [self.curViewController.navigationController popViewControllerAnimated:YES];
    }
}
-(void) onRight{
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leNavigationRightButtonTapped)]){
        [curDelegate leNavigationRightButtonTapped];
    }
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
//@synthesize leViewContainer=_leViewContainer;
//@synthesize globalVar=_globalVar;
//@synthesize leCurrentFrameHight=_leCurrentFrameHight;
//@synthesize leCurrentFrameWidth=_leCurrentFrameWidth;
//-(void) onNavigationBarClickedWithCode:(NSString *) code{
//    //    LELogObject(code);
//    if([code isEqualToString:KeyOfNavigationBackButton]){
//        [self onClickedForLeftButton];
//    }else if([code isEqualToString:KeyOfNavigationRightButton]){
//        [self onClickedForRightButton];
//    }
//}
//-(void) onClickedForLeftButton{
//    [self leEaseOutView];
//}
//-(void) onClickedForRightButton{
//    
//}
//-(void) setStatusBarStyle:(UIStatusBarStyle) style{
//    [[UIApplication sharedApplication] setStatusBarStyle:style animated:YES];
//} 
//-(UIView *) leSuperViewContainer{
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
//    self.leCurrentFrameWidth=LESCREEN_WIDTH;
//    self.leCurrentFrameHight=LESCREEN_HEIGHT;
//    self.leCurrentFrameHight=view.frame.size.height;
//    self = [super initWithFrame:CGRectMake(0, 0, self.leCurrentFrameWidth,self.leCurrentFrameHight)];
//    BOOL fullScreen=NO;
//    if([dataModel objectForKey:KeyOfNavigationInFullScreenMode]){
//        fullScreen=[[dataModel objectForKey:KeyOfNavigationInFullScreenMode] boolValue];
//    }else{
//        fullScreen=IsFullScreenMode;
//    }
//    //
//    self.curEffectType=effectType;
//    if(effectType==EffectTypeFromRight){
//        [self leSetFrame:CGRectMake(self.leCurrentFrameWidth, 0, self.leCurrentFrameWidth, self.leCurrentFrameHight)];
//    }
//    recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
//    [recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [self addGestureRecognizer:recognizerRight];
//    //
//    [view addSubview:self];
//    [self setBackgroundColor:LEColorWhite];
//    //Container
//    self.leViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, fullScreen?0:(LENavigationBarHeight+LEStatusBarHeight)) CGSize:CGSizeMake(self.leCurrentFrameWidth, self.leCurrentFrameHight-(fullScreen?0:(LENavigationBarHeight+LEStatusBarHeight)))]];
//    [self.leViewContainer setBackgroundColor:[LEUIFramework sharedInstance].leColorViewContainer];
//    //
//    if(navigationClass&&navigationClass.length>0){
//        LESuppressPerformSelectorLeakWarning(
//                                           self.curNavigationView=[[NSClassFromString(navigationClass) alloc] performSelector:NSSelectorFromString(@"initWithAutoLayoutSettings:ViewDataModel:") withObject:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.leCurrentFrameWidth, LENavigationBarHeight+LEStatusBarHeight)] withObject:dataModel];
//                                           );
//    }
//    [self setExtraViewInits];
//    return self;
//}
//-(void) setExtraViewInits{
//}
//-(void) leEaseInView{
//    if(self.curEffectType==EffectTypeWithAlpha){
//        [self setAlpha:0];
//        [UIView animateWithDuration:0.2f animations:^(void){
//            [self setAlpha:1];
//        }completion:^(BOOL isDone){
//            [self leEaseInViewLogic];
//        }];
//    }else if(self.curEffectType==EffectTypeFromRight){
//        [self leSetFrame:CGRectMake(self.leCurrentFrameWidth, 0, self.leCurrentFrameWidth, self.leCurrentFrameHight)];
//        [UIView animateWithDuration:0.2 animations:^(void){
//            [self leSetFrame:CGRectMake(0, 0, self.leCurrentFrameWidth, self.leCurrentFrameHight)];
//        } completion:^(BOOL isDone){
//            [self leEaseInViewLogic];
//        }];
//    }
//}
//-(void) leEaseOutView{
//    [self setStatusBarStyle:lastStatusStyle];
//    if(self.curEffectType==EffectTypeWithAlpha){
//        [UIView animateWithDuration:0.2f animations:^(void){
//            [self setAlpha:0];
//        } completion:^(BOOL isDone){
//            [self dismissView];
//        }];
//    }else if(self.curEffectType==EffectTypeFromRight){
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
//            [self leSetFrame:CGRectMake(self.leCurrentFrameWidth, 0, self.leCurrentFrameWidth, self.leCurrentFrameHight)];
//        } completion:^(BOOL isFinished){
//            [self leEaseOutViewLogic];
//        }];
//    }else{
//        [self leEaseOutViewLogic];
//    }
//}
//-(void) leEaseInViewLogic{
//}
//-(void) leEaseOutViewLogic{
//    [self dismissView];
//}
//-(void) eventCallFromChild{
//}
//-(void) dismissView{
//    [self removeFromSuperview];
//}
//- (void)swipGesture:(UISwipeGestureRecognizer *)recognizer {
//    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
//        [self leEaseOutView];
//    }
//}
//@end
//
