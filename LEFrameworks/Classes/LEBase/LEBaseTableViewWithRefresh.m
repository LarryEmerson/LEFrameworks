//
//  LEBaseTableViewWithRefresh.m
//  Pods
//
//  Created by emerson larry on 16/7/11.
//
//

#import "LEBaseTableViewWithRefresh.h"
#import "LERefresh.h"

//#import "MJRefresh.h"
//@implementation LEBaseTableViewWithMJRefresh
//-(void) leExtraInits{
//    [super leExtraInits];
//    self.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        LESuppressPerformSelectorLeakWarning(
//                                           [self performSelector:NSSelectorFromString(@"onDelegateRefreshData")];
//                                           );
//    }];
//    self.mj_header.automaticallyChangeAlpha=YES;
//    self.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        LESuppressPerformSelectorLeakWarning(
//                                           [self performSelector:NSSelectorFromString(@"onDelegateLoadMore")];
//                                           );
//    }];
//}
//-(void) leOnAutoRefresh{
//    [self.mj_header beginRefreshing];
//}
//-(void) leSetTopRefresh:(BOOL) enable{
//    [self.mj_header setUserInteractionEnabled:enable];
//    [self.mj_header setHidden:!enable];
//}
//-(void) leSetBottomRefresh:(BOOL) enable{
//    [self.mj_footer setUserInteractionEnabled:enable];
//    [self.mj_footer setHidden:!enable];
//}
//-(void) leOnStopTopRefresh {
//    [self onStopRefreshLogic];
//}
//-(void) leOnStopBottomRefresh {
//    [self onStopRefreshLogic];
//}
//-(void) onStopRefreshLogic{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 结束刷新
//        [self.mj_header endRefreshing];
//        [self.mj_footer endRefreshing];
//        [self reloadData];
//    });
//}
//@end

@implementation LEBaseTableViewWithRefresh{
    LERefreshHeader *refreshHeader;
    LERefreshFooter *refreshFooter;
}

-(void) leExtraInits{
    [super leExtraInits];
    
    refreshHeader=[[LERefreshHeader alloc] initWithTarget:self];
    typeof(self) __weak weakSelf = self;
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
-(void) leOnAutoRefresh{
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
    [self onStopRefreshLogic];
}
-(void) leOnStopBottomRefresh {
    [self onStopRefreshLogic];
}
-(void) onStopRefreshLogic{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [refreshHeader onEndRefresh];
        [refreshFooter onEndRefresh];
    });
}

@end
