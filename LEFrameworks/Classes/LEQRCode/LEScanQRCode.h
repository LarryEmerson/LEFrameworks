//
//  LEScanQRCode.h
//  LEFrameworks
//
//  Created by Larry Emerson on 15/8/27.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import "LEBaseViewController.h"


@protocol LEScanQRCodeDelegate <NSObject>
-(void) onScannedQRCodeWithResult:(NSString *) code;
@end

@interface LEScanQRCodeViewPage : LEBaseView 
@property (nonatomic) NSString *curScanHelperString;
-(void) setCustomizeResultWithView:(UIView *) view;
-(void) showScanView;
-(void) showOrHideResultView:(BOOL) show;
-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LEScanQRCodeDelegate>)delegate;
@end

@interface LEScanQRCodeViewController : LEBaseViewController
-(id) initWithDelegate:(id<LEScanQRCodeDelegate>) delegate;
-(void) reScanAfterSeconds:(NSTimeInterval) seconds;
@end