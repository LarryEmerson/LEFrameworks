//
//  LEBaseCollectionViewWithRefresh.m
//  Pods
//
//  Created by emerson larry on 16/7/25.
//
//

#import "LEBaseCollectionViewWithRefresh.h"

@implementation LEBaseCollectionViewWithRefresh{
    LERefreshHeader *refreshHeader;
    LERefreshFooter *refreshFooter;
}

-(void) leExtraInits{
    typeof(self) __weak weakSelf = self;
    refreshHeader=[[LERefreshHeader alloc] initWithTarget:self];
    refreshHeader.refreshBlock=^(){
        LESuppressPerformSelectorLeakWarning(
                                             [weakSelf performSelector:NSSelectorFromString(@"onDelegateRefreshData")];
                                             );
    };
    refreshFooter=[[LERefreshFooter alloc] initWithTarget:self];
    
    refreshFooter.refreshBlock=^(){
        LESuppressPerformSelectorLeakWarning(
                                             [weakSelf performSelector:NSSelectorFromString(@"onDelegateLoadMore")];
                                             );
    };
}
-(void) leOnSetContentInsects:(UIEdgeInsets) insects{
    [refreshFooter onSetCollectionViewContentInsects:insects];
}
-(void) leOnAutoRefresh{
    //    LELogFunc
    dispatch_async(dispatch_get_main_queue(), ^{
        [refreshHeader onBeginRefresh];
    });
}
-(void) leSetTopRefresh:(BOOL) enable{
    refreshHeader.isEnabled=enable;
}
-(void) leSetBottomRefresh:(BOOL) enable{
    refreshFooter.isEnabled=enable;
}
-(void) leOnStopTopRefresh {
    //    LELogFunc
    [self onStopRefreshLogic];
}
-(void) leOnStopBottomRefresh {
    //    LELogFunc;
    [self onStopRefreshLogic];
}
-(void) onStopRefreshLogic{
    //    LELogFunc
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [refreshHeader onEndRefresh];
        [refreshFooter onEndRefresh];
        [self reloadData];
    });
}

@end
