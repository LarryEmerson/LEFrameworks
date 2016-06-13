//
//  LEScanQRCode.h
//  LEFrameworks
//
//  Created by Larry Emerson on 15/8/27.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import "LEBaseEmptyView.h"
 

@protocol LEScanQRCodeDelegate <NSObject>
-(void) onScannedQRCodeWithResult:(NSString *) code;
@end

@interface LEScanQRCode : LEBaseEmptyView
@property (nonatomic) id<LEScanQRCodeDelegate> scanQRCodeDelegate;
@property (nonatomic) NSString *curScanHelperString;
-(void) setCustomizeResultWithView:(UIView *) view;
-(void) showScanView;
-(void) showOrHideResultView:(BOOL) show;
-(id) initWithSuperView:(UIView *)view Delegate:(id<LEScanQRCodeDelegate>) delegate;
@end

@interface LEScanQRCodeViewController : LEViewController
-(id) initWithDelegate:(id<LEScanQRCodeDelegate>) delegate;
-(void) reScanAfterSeconds:(NSTimeInterval) seconds;
@end