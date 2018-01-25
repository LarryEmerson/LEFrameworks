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
//    if(self.leCurrentFrameHight==LESCREEN_HEIGHT){
    self.leViewBelowCustomizedNavigation=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, (LEIS_IPHONE_X?LEStatusBarHeight:20)+LENavigationBarHeight) CGSize:CGSizeMake(LESCREEN_WIDTH, LESCREEN_HEIGHT-LEStatusBarHeight-LENavigationBarHeight)]];
        self.leFrameHightForCustomizedView=self.leViewBelowCustomizedNavigation.bounds.size.height;
//    }
    self.recognizerRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGesture:)];
    [self.recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.leViewContainer addGestureRecognizer:self.recognizerRight];
    //
    [self leAdditionalInits];
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

@implementation UIViewController (StatusBarChange)
-(void) leRelayout{
    NSArray *array=self.view.subviews;
    for (NSInteger i=0; i<array.count; i++) {
        UIView *v=[array objectAtIndex:i];
        if([v isKindOfClass:[LEBaseView class]]){
            LEBaseView *base=(LEBaseView *)v; 
            base.leCurrentFrameHight=base.bounds.size.height-(base.leCurrentViewController.extendedLayoutIncludesOpaqueBars?0:(LEStatusBarHeight+LENavigationBarHeight));
            [base.leViewContainer leSetSize:CGSizeMake(base.leCurrentFrameWidth,base.leCurrentFrameHight)];
            [base.leViewBelowCustomizedNavigation leSetSize:CGSizeMake(LESCREEN_WIDTH, LESCREEN_HEIGHT-LEStatusBarHeight-LENavigationBarHeight)];
            base.leFrameHightForCustomizedView=base.leViewBelowCustomizedNavigation.bounds.size.height;
            [base leRelayout];
            NSMutableArray *searchClass=[[NSMutableArray alloc] initWithArray:base.leViewContainer.subviews];
            [searchClass addObjectsFromArray:base.leViewBelowCustomizedNavigation.subviews];
            for (NSInteger i=0; i<searchClass.count; i++) {
                UIView *v=[searchClass objectAtIndex:i];
//                LELogObject(NSStringFromClass([v class]))
                if([v isKindOfClass:NSClassFromString(@"LEBaseNavigation")]||[v isKindOfClass:NSClassFromString(@"LEBaseTableView")]){
                    LESuppressPerformSelectorLeakWarning(
                                                         [v performSelector:NSSelectorFromString(@"leRelayout")];
                                                         );
                }
            }
            break;
        }
    }
}
-(void) addStatusBarChangeNotification{
//    LELogFunc
    [[ NSNotificationCenter defaultCenter ] addObserver : self selector : @selector (leRelayout) name : UIApplicationDidChangeStatusBarFrameNotification object : nil ];
}
-(void) removeStatusBarChangeNotification{
//    LELogFunc
    [[ NSNotificationCenter defaultCenter ] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
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
    [self leAdditionalInits];
}
-(void) leAdditionalInits{
    NSString *class=NSStringFromClass(self.class);
    class=[class stringByAppendingString:@"Page"];
    NSObject *obj=[NSClassFromString(class) alloc];
    if(obj&&([obj isKindOfClass:[LEBaseView class]]||[obj isMemberOfClass:[LEBaseView class]])){
        [[(LEBaseView *) obj initWithViewController:self] setUserInteractionEnabled:YES];
    }
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addStatusBarChangeNotification];
    [self leRelayout];
//    NSArray *searchClass=self.view.subviews;
//    for (NSInteger i=0; i<searchClass.count; i++) {
//        UIView *v=[searchClass objectAtIndex:i];
//        if([v isKindOfClass:[LEBaseView class]]){
//            [v leRelayout];
//        }
//    }
}
-(void) viewWillDisappear:(BOOL)animated{
    [self removeStatusBarChangeNotification];
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
    self= [self initWithDelegate:delegate ViewController:superview.leCurrentViewController SuperView:superview Offset:LEIS_IPHONE_X?LEStatusBarHeight:20 BackgroundImage:[LEUIFramework sharedInstance].leImageNavigationBar TitleColor:[LEUIFramework sharedInstance].leColorNavigationContent LeftItemImage:[LEUIFramework sharedInstance].leImageNavigationBack];
    [self leSetNavigationTitle:title];
    return self;
}
-(void) leRelayout{
    [super leRelayout];
    if(!LEIS_IPHONE_X){
        [self leSetOffset:CGPointMake(0, 20)];
    }
}
-(id) initWithDelegate:(id<LENavigationDelegate>) delegate ViewController:(UIViewController *) viewController SuperView:(UIView *) superview Offset:(int) offset BackgroundImage:(UIImage *) bg TitleColor:(UIColor *) color LeftItemImage:(UIImage *) left{
    offset=LEStatusBarHeight;
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:superview Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, offset) CGSize:CGSizeMake(LESCREEN_WIDTH, LENavigationBarHeight)]];
    self.curViewController=viewController;
    curDelegate=delegate;
    background=[UIImageView new].leSuperView(self).leAnchor(LEAnchorInsideBottomCenter).leSize(CGSizeMake(LESCREEN_WIDTH, LENavigationBarHeight+(LEIS_IPHONE_X?LEStatusBarHeight:20))).leBackground([LEUIFramework sharedInstance].leColorNavigationBar).leAutoLayout.leType;
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
    if([LEUIFramework sharedInstance].leCanItBeTapped){
        if(curDelegate&&[curDelegate respondsToSelector:@selector(leNavigationRightButtonTapped)]){
            [curDelegate leNavigationRightButtonTapped];
        }
    }
}
@end
