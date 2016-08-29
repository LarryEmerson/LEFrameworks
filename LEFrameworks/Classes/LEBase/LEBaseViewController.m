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
@property (nonatomic, readwrite) UIView *leViewContainer;
@property (nonatomic, readwrite) UIView *leViewBelowCustomizedNavigation;
@property (nonatomic, readwrite) LEBaseViewController *leCurrentViewController;
@end
@implementation LEBaseView{
    UIView *curSuperView; 
}
-(id) initWithViewController:(LEBaseViewController *) vc{
    curSuperView=vc.view;
    self.leCurrentViewController=vc;
    self=[super initWithFrame:curSuperView.bounds];
    [self setBackgroundColor:LEColorWhite];
    [curSuperView addSubview:self];
    self.leCurrentFrameWidth=self.bounds.size.width;
    self.leCurrentFrameHight=self.bounds.size.height-(self.leCurrentViewController.extendedLayoutIncludesOpaqueBars?0:(LEStatusBarHeight+LENavigationBarHeight));
    self.leViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.leCurrentFrameWidth,self.leCurrentFrameHight)]];
    [self.leViewContainer setBackgroundColor:[LEUIFramework sharedInstance].leColorViewContainer];
    //
    if(self.leCurrentFrameHight==LESCREEN_HEIGHT){
        self.leViewBelowCustomizedNavigation=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, LEStatusBarHeight+LENavigationBarHeight) CGSize:CGSizeMake(LESCREEN_WIDTH, LESCREEN_HEIGHT-LEStatusBarHeight-LENavigationBarHeight)]];
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
        LEBaseView *view= [(LEBaseView *) obj initWithViewController:self];
        [view setUserInteractionEnabled:YES];
    }
}
@end


@implementation LEBaseNavigation{
    id<LENavigationDelegate> curDelegate;
    UIViewController *curViewController;
    UIImageView *background;
    UIView *bottomSplit;
}

-(id) initWithDelegate:(id<LENavigationDelegate>) delegate ViewController:(UIViewController *) viewController SuperView:(UIView *) superview Offset:(int) offset BackgroundImage:(UIImage *) bg TitleColor:(UIColor *) color LeftItemImage:(UIImage *) left{
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:superview Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, offset) CGSize:CGSizeMake(LESCREEN_WIDTH, LENavigationBarHeight)]];
    curViewController=viewController;
    curDelegate=delegate;
    background=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(LESCREEN_WIDTH, offset+LENavigationBarHeight)] Image:bg];
    self.leTitleViewContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LENavigationBarHeight, 0) CGSize:CGSizeMake(LESCREEN_WIDTH-LENavigationBarHeight, LENavigationBarHeight)]];
    leNavigationTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:0 Font:LEBoldFont(LENavigationBarFontSize) Width:LESCREEN_WIDTH-LENavigationBarHeight-LELayoutSideSpace*2 Height:LENavigationBarFontSize Color:color Line:1 Alignment:NSTextAlignmentCenter]];
    UIView *viewLeft=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeMake(LENavigationBarHeight, LENavigationBarHeight)]];
    leBackButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc]initWithSuperView:viewLeft Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeMake(LENavigationBarHeight, LENavigationBarHeight)] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:nil FontSize:0 Font:nil Image:left BackgroundImage:nil Color:nil SelectedColor:nil MaxWidth:0 SEL:@selector(onLeft) Target:self]]; 
    [leBackButton setHidden:!left];
    [self leEnableBottomSplit:YES Color:LEColorSplit];
    return self;
}
-(void) leSetLeftButton:(UIImage *) img{
    [leBackButton setImage:img forState:UIControlStateNormal];
    [leBackButton setHidden:!img];
}
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
    [leNavigationTitle leSetText:title];
    CGFloat gap=leNavigationTitle.frame.origin.x-LELayoutSideSpace-LENavigationBarHeight;
    if(gap<0){
        [UIView animateWithDuration:0.1 animations:^{
            [leNavigationTitle leSetOffset:CGPointMake(-gap, 0)];
        }];
    }
}
-(void) leSetRightNavigationItemWith:(NSString *) title Image:(UIImage *) image{
    [self leSetRightNavigationItemWith:title Image:image Color:LEColorTextBlack];
}
-(void) leSetRightNavigationItemWith:(NSString *) title Image:(UIImage *) image Color:(UIColor *) color{
    [self lazyInitRightButton];
    [leRightButton leSetText:title];
    //    [leRightButton setTitle:title forState:UIControlStateNormal];
    [leRightButton setTitleColor:color forState:UIControlStateNormal];
    [leRightButton setImage:image forState:UIControlStateNormal];
    if((title==nil||title.length==0)&&image==nil){
        [leRightButton setHidden:YES];
    }else{
        [leRightButton setHidden:NO];
    }
    int width=LESCREEN_WIDTH-LENavigationBarHeight-(leRightButton.isHidden?0:leRightButton.bounds.size.width);
    [self.leTitleViewContainer leSetSize:CGSizeMake(width, LENavigationBarHeight)];
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leNavigationNotifyTitleViewContainerWidth:)]){
        [curDelegate leNavigationNotifyTitleViewContainerWidth:width];
    }
    [leNavigationTitle.leAutoLayoutLabelSettings setLeWidth:width-LELayoutSideSpace*2];
    [UIView animateWithDuration:0.1 animations:^{
        [leNavigationTitle leSetOffset:CGPointZero];
        [self leSetNavigationTitle:leNavigationTitle.text];
    }];
}
-(void)lazyInitRightButton{
    if(leRightButton==nil){
        leRightButton=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideRightCenter Offset:CGPointMake(-LELayoutSideSpace, 0) CGSize:CGSizeMake(LENavigationBarHeight, LENavigationBarHeight)] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:@"" FontSize:LELayoutFontSize14 Font:nil Image:nil BackgroundImage:nil Color:LEColorTextBlack SelectedColor:LEColorGray MaxWidth:0 SEL:@selector(onRight) Target:self]];
    }
}

-(void) leSetNavigationOffset:(int) offset{
    [background leSetSize:CGSizeMake(LESCREEN_WIDTH, offset+LENavigationBarHeight)];
    [self leSetOffset:CGPointMake(0, offset)];
}
-(void) onLeft{
    if(curDelegate&&[curDelegate respondsToSelector:@selector(leNavigationLeftButtonTapped)]){
        [curDelegate leNavigationLeftButtonTapped];
    }else{
        [curViewController.navigationController popViewControllerAnimated:YES];
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
