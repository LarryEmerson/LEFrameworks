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
//-(void) initTableView{
//    [super initTableView];
//    self.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        SuppressPerformSelectorLeakWarning(
//                                           [self performSelector:NSSelectorFromString(@"onDelegateRefreshData")];
//                                           );
//    }];
//    self.mj_header.automaticallyChangeAlpha=YES;
//    self.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        SuppressPerformSelectorLeakWarning(
//                                           [self performSelector:NSSelectorFromString(@"onDelegateLoadMore")];
//                                           );
//    }];
//}
//-(void) onAutoRefresh{
//    [self.mj_header beginRefreshing];
//}
//-(void) setTopRefresh:(BOOL) enable{
//    [self.mj_header setUserInteractionEnabled:enable];
//    [self.mj_header setHidden:!enable];
//}
//-(void) setBottomRefresh:(BOOL) enable{
//    [self.mj_footer setUserInteractionEnabled:enable];
//    [self.mj_footer setHidden:!enable];
//}
//-(void) onStopTopRefresh {
//    [self onStopRefreshLogic];
//}
//-(void) onStopBottomRefresh {
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

-(void) initTableView{
    [super initTableView];
    
    refreshHeader=[[LERefreshHeader alloc] initWithTarget:self];
    typeof(self) __weak weakSelf = self;
    refreshHeader.refreshBlock=^(){
        SuppressPerformSelectorLeakWarning(
                                           [weakSelf performSelector:NSSelectorFromString(@"onDelegateRefreshData")];
                                           );
    };
    refreshFooter=[[LERefreshFooter alloc] initWithTarget:self];
    refreshFooter.refreshBlock=^(){
        SuppressPerformSelectorLeakWarning(
                                           [weakSelf performSelector:NSSelectorFromString(@"onDelegateLoadMore")];
                                           );
    };
}
-(void) onAutoRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [refreshHeader onBeginRefresh];
    });
}
-(void) setTopRefresh:(BOOL) enable{
    refreshHeader.isEnabled=enable;
}
-(void) setBottomRefresh:(BOOL) enable{
    refreshFooter.isEnabled=enable;
}
-(void) onStopTopRefresh {
    NSLogFunc;
    [self onStopRefreshLogic];
}
-(void) onStopBottomRefresh {
    NSLogFunc;
    [self onStopRefreshLogic];
}
-(void) onStopRefreshLogic{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [refreshHeader onEndRefresh];
        [refreshFooter onEndRefresh];
        [self reloadData];
    });
}

@end
