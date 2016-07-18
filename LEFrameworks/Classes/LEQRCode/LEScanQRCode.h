//
//  LEScanQRCode.h
//  LEFrameworks
//
//  Created by Larry Emerson on 15/8/27.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import "LEBaseViewController.h"


@protocol LEScanQRCodeDelegate <NSObject>
-(void) leOnScannedQRCodeWithResult:(NSString *) code;
@end

@interface LEScanQRCodeViewPage : LEBaseView 

-(void) leSetCustomizeResultWithView:(UIView *) view;
-(void) leShowScanView;
-(void) leShowOrHideResultView:(BOOL) show;
-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LEScanQRCodeDelegate>)delegate;
@end

@interface LEScanQRCodeViewController : LEBaseViewController
-(id) initWithDelegate:(id<LEScanQRCodeDelegate>) delegate;
-(void) leReScanAfterSeconds:(NSTimeInterval) seconds;
@end