//
//  LERefresh.m
//  Pods
//
//  Created by emerson larry on 16/7/11.
//
//

#import "LERefresh.h"


@implementation LERefresh
-(void) setIsEnabled:(BOOL)isEnabled{
    _isEnabled=isEnabled;
    [self.refreshContainer setUserInteractionEnabled:isEnabled];
    [self.refreshContainer setHidden:!isEnabled];
}
-(void) setCurScrollView:(UIScrollView *)curScrollView{
    _curScrollView=curScrollView;
    [_curScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
-(void) dealloc{
    [self.curScrollView removeObserver:self forKeyPath:@"contentOffset"];
}
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([@"contentOffset" isEqualToString:keyPath]){
        [self onScrolling];
    }
}
-(void) onScrolling{
    
}
-(void) onBeginRefresh{
    
}
-(void) onEndRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            self.curScrollView.contentInset=UIEdgeInsetsZero;
        }];
        self.curRefreshState=LERefreshBegin;
        [self.curIndicator stopAnimating];
    });
}
-(instancetype) initWithTarget:(UIScrollView *) scrollview{
    self=[super init];
    self.curScrollView=scrollview;
    self.curIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.curRefreshState=LERefreshBegin;
    [self initRefreshView];
    return self;
}
-(void) initRefreshView{
    
}
-(void) setCurRefreshState:(LERefreshState)curRefreshState{
    _curRefreshState=curRefreshState;
    [self onResetRefreshString];
}
-(void) onResetRefreshString{
    switch (self.curRefreshState) {
        case LERefreshBegin:
            [self.curIndicator setHidden:YES];
            [self.curRefreshLabel leSetOffset:CGPointZero];
            [self.curRefreshLabel leSetText:self.beginRefreshString];
            break;
        case LERefreshRelease:
            [self.curIndicator setHidden:YES];
            [self.curRefreshLabel leSetOffset:CGPointZero];
            [self.curRefreshLabel leSetText:self.refreshReleaseString];
            break;
        case LERefreshLoading:
            [self.curIndicator setHidden:NO];
            [self.curRefreshLabel leSetOffset:CGPointMake(LayoutSideSpace/2+self.curIndicator.bounds.size.width/2, 0)];
            [self.curRefreshLabel leSetText:self.loadingString];
            [self.curIndicator startAnimating];
            break;
        default:
            break;
    }
    [self.curIndicator leExecAutoLayout];
}
@end


@implementation LERefreshHeader{
    float topRefreshHeight;
}
-(void) initRefreshView{
    self.beginRefreshString=LERefreshStringPullDown;
    self.loadingString=LERefreshStringLoading;
    self.refreshReleaseString=LERefreshStringRelease;
    topRefreshHeight=NavigationBarHeight;
    self.refreshContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.curScrollView Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, -topRefreshHeight) CGSize:CGSizeMake([LEUIFramework sharedInstance].ScreenWidth, topRefreshHeight)]];
    [self.refreshContainer addSubview:self.curIndicator];
    self.curRefreshLabel=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.refreshContainer Anchor:LEAnchorInsideCenter Offset:CGPointMake(self.curIndicator.bounds.size.width/2+LayoutSideSpace/2, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:self.beginRefreshString FontSize:LayoutFontSize12 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
    [self.curIndicator setLeAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.refreshContainer Anchor:LEAnchorOutsideLeftCenter RelativeView:self.curRefreshLabel Offset:CGPointMake(-LayoutSideSpace, 0) CGSize:self.curIndicator.bounds.size]];
    [self setIsEnabled:YES];
}
-(void) onScrolling{
    [super onScrolling];
    if(self.isEnabled){
        float offsetY=self.curScrollView.contentOffset.y;
        if(offsetY<=0){
            if(self.curScrollView.dragging){
                if(self.curRefreshState!=LERefreshLoading){
                    if(offsetY<-topRefreshHeight){
                        if(self.curRefreshState!=LERefreshRelease){
                            self.curRefreshState=LERefreshRelease;
                        }
                    }else{
                        if(self.curRefreshState!=LERefreshLoading){
                            self.curRefreshState=LERefreshBegin;
                        }
                    }
                }
            }else{
                if(offsetY<-topRefreshHeight){
                    if(self.curRefreshState==LERefreshRelease){
                        [self onBeginRefresh];
                    }
                } 
            }
        }
    }
}
-(void) onBeginRefresh{
    if(self.curRefreshState!=LERefreshLoading){
        self.curRefreshState=LERefreshLoading;
        [UIView animateWithDuration:0.3 animations:^{
            float offsetY=self.curScrollView.contentOffset.y;
            if(offsetY<-topRefreshHeight){
                self.curScrollView.contentOffset=CGPointMake(0, offsetY-topRefreshHeight);
            }
            self.curScrollView.contentInset=UIEdgeInsetsMake(topRefreshHeight, 0, 0, 0);
        }];
        self.refreshBlock();
    }
}
@end
@implementation LERefreshFooter{
    float topRefreshHeight;
}
-(void) initRefreshView{
    self.beginRefreshString=LERefreshStringPullUp;
    self.loadingString=LERefreshStringLoading;
    self.refreshReleaseString=LERefreshStringRelease;
    topRefreshHeight=NavigationBarHeight;
    self.refreshContainer=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.curScrollView Anchor:LEAnchorInsideBottomCenter Offset:CGPointMake(0, topRefreshHeight) CGSize:CGSizeMake([LEUIFramework sharedInstance].ScreenWidth, topRefreshHeight)]];
    [self.refreshContainer addSubview:self.curIndicator];
    self.curRefreshLabel=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.refreshContainer Anchor:LEAnchorInsideCenter Offset:CGPointMake(self.curIndicator.bounds.size.width/2+LayoutSideSpace/2, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:self.beginRefreshString FontSize:LayoutFontSize12 Font:nil Width:0 Height:0 Color:ColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
    [self.curIndicator setLeAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.refreshContainer Anchor:LEAnchorOutsideLeftCenter RelativeView:self.curRefreshLabel Offset:CGPointMake(-LayoutSideSpace, 0) CGSize:self.curIndicator.bounds.size]];
    [self setIsEnabled:YES];
}
-(void) onScrolling{
    [super onScrolling];
    if(self.isEnabled){
        float offsetY=self.curScrollView.contentOffset.y;
        CGSize size=self.curScrollView.contentSize;
        size.height=MAX(size.height, self.curScrollView.bounds.size.height);
        [self.curScrollView setContentSize:size];
        float gap=self.curScrollView.contentSize.height-self.curScrollView.bounds.size.height;
        float maxOffset=MAX(topRefreshHeight, topRefreshHeight+gap);
        [self.refreshContainer leSetOffset:CGPointMake(0, maxOffset)];
        if(offsetY>=0){
            if(self.curScrollView.dragging){
                if(self.curRefreshState!=LERefreshLoading){
                    if(offsetY>maxOffset){
                        if(self.curRefreshState!=LERefreshRelease){
                            self.curRefreshState=LERefreshRelease;
                        }
                    }else{
                        if(self.curRefreshState!=LERefreshLoading){
                            self.curRefreshState=LERefreshBegin;
                        }
                    }
                }
            }else{
                if(offsetY>maxOffset){
                    if(self.curRefreshState==LERefreshRelease){
                        [self onBeginRefresh];
                    }
                }
            }
        }
    }
}
-(void) onBeginRefresh{
    if(self.curRefreshState!=LERefreshLoading){
        self.curRefreshState=LERefreshLoading;
        [UIView animateWithDuration:0.3 animations:^{
            self.curScrollView.contentInset=UIEdgeInsetsMake(0, 0, topRefreshHeight, 0);
        }];
        self.refreshBlock();
    }
}
@end