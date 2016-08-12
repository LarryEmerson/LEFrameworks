//
//  LEScanQRCode.m
//  LEFrameworks
//
//  Created by Larry Emerson on 15/8/27.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import "LEScanQRCode.h"
#import <AVFoundation/AVFoundation.h>
@interface LEScanQRCodeViewPage()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic) NSString *curScanHelperString;
@end
@implementation LEScanQRCodeViewPage{
    id<LEScanQRCodeDelegate> scanQRCodeDelegate;
    UIImageView *scanLine;
    int curLineOffset;
    BOOL isLineUp;
    
    AVCaptureDevice * device;
    AVCaptureDeviceInput * input;
    AVCaptureMetadataOutput * output;
    AVCaptureSession * session;
    AVCaptureVideoPreviewLayer * preview;
    NSTimer *curTimer;
    
    float scanSpaceW;
    float scanSpaceH;
    
    float DefaultScanRect;
    //
    UIView *curResultView;
    UILabel *curHelper;
}
-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LEScanQRCodeDelegate>)delegate{
    self=[super initWithViewController:vc];
    scanQRCodeDelegate=delegate;
    return self;
}
-(void) leSetCustomizeResultWithView:(UIView *) view{
    if(curResultView){
        [curResultView removeFromSuperview];
    }
    curResultView=view;
    [self.leViewContainer addSubview:curResultView];
    [curResultView setHidden:YES];
}
-(void) dealloc{
    [session stopRunning];
    device=nil;
    input=nil;
    output=nil;
    [preview removeFromSuperlayer];
    session=nil;
}
-(void) leShowOrHideResultView:(BOOL) show{
    if(curResultView){
        [curResultView setHidden:NO];
    }
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    if (metadataObjects && [metadataObjects count] >0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        if([[metadataObject type] isEqualToString:AVMetadataObjectTypeQRCode]
           ||[[metadataObject type] isEqualToString:AVMetadataObjectTypeEAN13Code]
           ||[[metadataObject type] isEqualToString:AVMetadataObjectTypeEAN8Code]
           ||[[metadataObject type] isEqualToString:AVMetadataObjectTypeCode128Code]
           ){
            stringValue = metadataObject.stringValue;
        }
    }
    [self switchScanLine:NO];
    [session stopRunning];
    device=nil;
    input=nil;
    output=nil;
    session=nil;
    if(stringValue){
        if(scanQRCodeDelegate){
            [scanQRCodeDelegate leOnScannedQRCodeWithResult:stringValue];
        }
        if(!curResultView){
            [self.leCurrentViewController.navigationController popViewControllerAnimated:YES];
        }
    }else{
        
    }
}
-(void) leExtraInits {
    //
    DefaultScanRect=self.leCurrentFrameWidth*2.0/3;
    scanSpaceH=LENavigationBarHeight*1.5;
    //
    scanSpaceW=(self.leCurrentFrameWidth-DefaultScanRect)/2;
    // 
    UIImage *imgScanPickBG=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_qrcode_scan_bg"];
    UIImageView *viewScanRect=[[UIImageView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, scanSpaceH) CGSize:CGSizeMake(DefaultScanRect, DefaultScanRect)]];
    [self.leViewContainer addSubview:viewScanRect];
    [viewScanRect setBackgroundColor:[UIColor clearColor]];
    [viewScanRect setImage:imgScanPickBG];
    
    UIImage *imgScanLine=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_qrcode_scan_line"];
    scanLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DefaultScanRect, imgScanLine.size.height)];
    [scanLine setImage:imgScanLine];
    [viewScanRect addSubview:scanLine];
    
    UIView *viewTop=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.leCurrentFrameWidth, scanSpaceH)]];
    UIView *viewLeft=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorOutsideBottomLeft RelativeView:viewTop Offset:CGPointZero CGSize:CGSizeMake(scanSpaceW, DefaultScanRect)]];
    UIView *viewRight=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorOutsideBottomRight RelativeView:viewTop Offset:CGPointZero CGSize:CGSizeMake( scanSpaceW, DefaultScanRect)]];
    UIView *viewBottom=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leViewContainer Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(self.leCurrentFrameWidth, self.leViewContainer.bounds.size.height-scanSpaceH-DefaultScanRect)]];
    [viewTop setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [viewLeft setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [viewRight setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [viewBottom setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    
    NSString *tip2=@"将扫码框对准二维码，即可自动完成扫描";
    curHelper=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewBottom Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, LENavigationBarHeight) CGSize:CGSizeMake(self.leCurrentFrameWidth, scanSpaceH*2/3)] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:tip2 FontSize:12 Font:nil Width:self.leCurrentFrameWidth-LENavigationBarHeight Height:0 Color:LEColorWhite Line:0 Alignment:NSTextAlignmentCenter]];
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if(input){
        output = [[AVCaptureMetadataOutput alloc]init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        session = [[AVCaptureSession alloc]init];
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        //            preview.frame =self.leViewContainer.bounds;
        [preview setFrame:viewScanRect.frame];
        [self.leViewContainer.layer insertSublayer: preview atIndex:0];
        [session startRunning];
    }
    [self switchScanLine:YES];
}

-(void) setCurScanHelperString:(NSString *)curScanHelperString{
    [curHelper leSetText:curScanHelperString];
}
-(void) switchScanLine:(BOOL) isON{
    if(isON){
        if(curTimer){
            [curTimer invalidate];
        }
        curTimer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onScanLineLogic) userInfo:nil repeats:YES];
        [session startRunning];
    }else{
        [curTimer invalidate];
        [session stopRunning];
    }
}
-(void) onScanLineLogic {
    curLineOffset+=(isLineUp?-2:2);
    if(curLineOffset<10){
        isLineUp=NO;
    }else if(curLineOffset>DefaultScanRect-15){
        isLineUp=YES;
    }
    [scanLine setFrame:CGRectMake(0, curLineOffset, DefaultScanRect, scanLine.bounds.size.height)];
}
-(void) leShowScanView{
    [self switchScanLine:YES];
    [session stopRunning];
    device=nil;
    input=nil;
    output=nil;
    [preview removeFromSuperlayer];
    preview=nil;
    session=nil;
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if(input){
        output = [[AVCaptureMetadataOutput alloc]init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        session = [[AVCaptureSession alloc]init];
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        preview.frame =self.leViewContainer.bounds;
        [self.leViewContainer.layer insertSublayer: preview atIndex:0];
        [session startRunning];
    }
}

@end

@interface LEScanQRCodeViewController()
@end
@implementation LEScanQRCodeViewController{
    LEScanQRCodeViewPage *page;
    BOOL isBarHidden;
}
-(id) initWithDelegate:(id<LEScanQRCodeDelegate>) delegate{
    self=[super init];
    page=[[LEScanQRCodeViewPage alloc] initWithViewController:self Delegate:delegate];
    return self;
}
-(void) leReScanAfterSeconds:(NSTimeInterval) seconds{
    [page performSelector:@selector(leShowScanView) withObject:nil afterDelay:seconds];
}
-(void) viewDidLoad{
    [super viewDidLoad];
    isBarHidden=self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view addSubview:page];
    [self.navigationItem setTitle:@"扫一扫"];
    [self leSetLeftBarButtonAsBackWith:LEIMG_ArrowLeft];
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [page leShowScanView];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:isBarHidden animated:YES];
}
-(void) leExtraInits{}
@end