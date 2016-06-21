//
//  LEScanQRCode.m
//  LEFrameworks
//
//  Created by Larry Emerson on 15/8/27.
//  Copyright (c) 2015年 LarryEmerson. All rights reserved.
//

#import "LEScanQRCode.h"
//#import "ZBarSDK.h" 
#import <AVFoundation/AVFoundation.h>

@interface LEScanQRCode()<AVCaptureMetadataOutputObjectsDelegate/*,ZBarReaderViewDelegate*/>
@end

@implementation LEScanQRCode{
    
    //
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
    
    
    //    ZBarReaderView *curZBarReader;
    //    ZBarImageScanner *curZBarScanner;
    float DefaultScanRect;
    //
    UIView *curResultView;
    UILabel *curHelper;
    BOOL hasBack;
}
-(id) initWithSuperView:(UIView *)view Delegate:(id<LEScanQRCodeDelegate>)delegate{
    return [self initWithSuperView:view Delegate:delegate HasBackButton:NO];
}
-(id) initWithSuperView:(UIView *)view Delegate:(id<LEScanQRCodeDelegate>)delegate HasBackButton:(BOOL) back{
    hasBack=back;
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:@"1" forKey:KeyOfNavigationInFullScreenMode];
    if(back){
        [dic setObject:IMG_ArrowLeft forKey:KeyOfNavigationBackButton];
    }
    self=[super initWithSuperView:view NavigationDataModel:dic EffectType:back?EffectTypeFromRight:EffectTypeNone];
    [self setScanQRCodeDelegate:delegate];
    return self;
}
-(void) setCustomizeResultWithView:(UIView *) view{
    if(curResultView){
        [curResultView removeFromSuperview];
    }
    curResultView=view;
    [self.viewContainer addSubview:curResultView];
    [curResultView setHidden:YES];
}
-(void) easeOutViewLogic{ 
    //    if(self.globalVar.IsStatusBarNotCovered){
    [session stopRunning];
    device=nil;
    input=nil;
    output=nil;
    [preview removeFromSuperlayer];
    session=nil;
    //    }else{
    //        [curZBarReader setReaderDelegate:nil];
    //    }
}
-(void) showOrHideResultView:(BOOL) show{
    if(curResultView){
        [curResultView setHidden:NO];
    }
}
//IOS7+
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
        if(hasBack){
            if(self.scanQRCodeDelegate){
                [self.scanQRCodeDelegate onScannedQRCodeWithResult:stringValue];
            }
            if(!curResultView){
                [self easeOutView];
            }
        }else{
            [self easeOutView];
            if(self.scanQRCodeDelegate){
                [self.scanQRCodeDelegate onScannedQRCodeWithResult:stringValue];
            }
        }
    }else{
        
    }
}
////IOS6-
//- (void) readerView: (ZBarReaderView*) readerView didReadSymbols: (ZBarSymbolSet*) symbols fromImage: (UIImage*) image{
//    ZBarSymbol * symbol = nil;
//    for (symbol in symbols) {
//        break;
//    }
//    NSString * result;
//    if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding]) {
//        result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding] encoding:NSUTF8StringEncoding];
//    } else {
//        result = symbol.data;
//    }
//    [readerView stop];
//    [self switchScanLine:NO];
//    if(result&&(NSNull *)result!=[NSNull null]){
//        if(self.scanQRCodeDelegate){
//            [self.scanQRCodeDelegate onScannedQRCodeWithResult:result];
//        }
//        if(curResultView){
//            [curResultView setHidden:NO];
//        }else{
//            [self easeOutView];
//        }
//    } 
//}
//- (void) readerView: (ZBarReaderView*) readerView
//   didStopWithError: (NSError*) error{
//    [curZBarReader flushCache];
//}

-(void) setExtraViewInits {
    //
    DefaultScanRect=self.globalVar.ScreenWidth*2.0/3;
    scanSpaceH=NavigationBarHeight*1.5;
    //
    scanSpaceW=(self.globalVar.ScreenWidth-DefaultScanRect)/2;
    // 
    UIImage *imgScanPickBG=[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"main_scan_pick_bg"];
    UIImageView *viewScanRect=[[UIImageView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, scanSpaceH) CGSize:CGSizeMake(DefaultScanRect, DefaultScanRect)]];
    [self.viewContainer addSubview:viewScanRect];
    [viewScanRect setBackgroundColor:[UIColor clearColor]];
    [viewScanRect setImage:imgScanPickBG];
     
    UIImage *imgScanLine=[[LEUIFramework sharedInstance] getImageFromLEFrameworksWithName:@"scan_line"];
    scanLine=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DefaultScanRect, imgScanLine.size.height)];
    [scanLine setImage:imgScanLine];
    [viewScanRect addSubview:scanLine];
    
    UIView *viewTop=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.globalVar.ScreenWidth, scanSpaceH)]];
    UIView *viewLeft=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorOutsideBottomLeft RelativeView:viewTop Offset:CGPointZero CGSize:CGSizeMake(scanSpaceW, DefaultScanRect)]];
    UIView *viewRight=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorOutsideBottomRight RelativeView:viewTop Offset:CGPointZero CGSize:CGSizeMake( scanSpaceW, DefaultScanRect)]];
    UIView *viewBottom=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.viewContainer Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(self.globalVar.ScreenWidth, self.viewContainer.bounds.size.height-scanSpaceH-DefaultScanRect)]];
    [viewTop setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [viewLeft setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [viewRight setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    [viewBottom setBackgroundColor:[UIColor colorWithWhite:0.000 alpha:0.500]];
    
    NSString *tip2=@"将扫码框对准二维码，即可自动完成扫描";
    curHelper=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:viewBottom Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, NavigationBarHeight) CGSize:CGSizeMake(self.globalVar.ScreenWidth, scanSpaceH*2/3)] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:tip2 FontSize:12 Font:nil Width:self.globalVar.ScreenWidth-NavigationBarHeight Height:0 Color:ColorWhite Line:0 Alignment:NSTextAlignmentCenter]];
    //    float topRate=scanSpaceH/self.viewContainer.bounds.size.height;
    //    if(self.globalVar.IsStatusBarNotCovered){
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
        //            preview.frame =self.viewContainer.bounds;
        [preview setFrame:viewScanRect.frame];
        [self.viewContainer.layer insertSublayer: preview atIndex:0];
        [session startRunning];
    }
    //    }else{
    //        curZBarScanner=[[ZBarImageScanner alloc] init];
    //        curZBarReader=[[ZBarReaderView alloc] initWithImageScanner:curZBarScanner];
    //        [curZBarReader setReaderDelegate:self];
    //        [curZBarReader setTorchMode:0];
    //        [curZBarReader setFrame:self.viewContainer.bounds];
    //        [curZBarScanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    //        [self.viewContainer addSubview:curZBarReader];
    //        [curZBarReader setScanCrop:CGRectMake(topRate, 1.0/6, DefaultScanRect*1.0/self.viewContainer.bounds.size.height, 2.0/3)];
    //        //[y,x,h,w]
    //        [curZBarReader start];
    //        [curZBarReader setEnableCache:YES];
    //        [curZBarReader setBackgroundColor:ColorBlack];
    //        [curZBarReader setTrackingColor:[UIColor clearColor]];
    //        [curZBarReader setTracksSymbols:NO];
    //        [curZBarReader setAllowsPinchZoom:NO];
    //        [curZBarReader willRotateToInterfaceOrientation: UIInterfaceOrientationPortrait duration: [[UIApplication sharedApplication] statusBarOrientationAnimationDuration]];
    //    }
    [self switchScanLine:YES];
    //
    //    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:NO];
}

//-(void) test{
//    NSString *result=@"official://bHRjeWRz";
//    result=@"group://Mjc=";
//    result=@"user://Mjc=";
//    if(self.scanQRCodeDelegate){
//        [self.scanQRCodeDelegate onScannedQRCodeWithResult:result];
//    }
//    if(!curResultView){
//        [self easeOutView];
//    }
//}

-(void) setCurScanHelperString:(NSString *)curScanHelperString{
    [curHelper leSetText:curScanHelperString];
}
-(void) switchScanLine:(BOOL) isON{
    if(isON){
        if(curTimer){
            [curTimer invalidate];
        }
        curTimer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onScanLineLogic) userInfo:nil repeats:YES];
        //        if(self.globalVar.IsStatusBarNotCovered){
        [session startRunning];
        //        }else{
        //            [curZBarReader start];
        //        }
    }else{
        [curTimer invalidate];
        //        if(self.globalVar.IsStatusBarNotCovered){
        [session stopRunning];
        //        }else{
        //            [curZBarReader stop];
        //        }
    }
}
//scan line
-(void) onScanLineLogic {
    curLineOffset+=(isLineUp?-2:2);
    if(curLineOffset<10){
        isLineUp=NO;
    }else if(curLineOffset>DefaultScanRect-15){
        isLineUp=YES;
    }
    [scanLine setFrame:CGRectMake(0, curLineOffset, DefaultScanRect, scanLine.bounds.size.height)];
}

//
-(void) showScanView{
    [self switchScanLine:YES];
    //    if(self.globalVar.IsStatusBarNotCovered){
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
        // Preview
        preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        preview.frame =self.viewContainer.bounds;
        [self.viewContainer.layer insertSublayer: preview atIndex:0];
        [session startRunning];
    }
    //    }else{
    //        [curZBarReader start];
    //        [curZBarReader flushCache];
    //    }
}

@end

@interface LEScanQRCodeViewPage : LEEmptyViewUnderSystemNavigation
@end
@implementation LEScanQRCodeViewPage{
    LEScanQRCode *scanner;
}
-(id) initWithViewController:(LEViewController *)vc Delegate:(id<LEScanQRCodeDelegate>) delegate{
    self=[super initWithViewController:vc];
    scanner=[[LEScanQRCode alloc] initWithSuperView:self Delegate:delegate HasBackButton:NO];
    return self;
}
-(void) showScanView{
    [scanner showScanView];
}
-(void) easeOut{
    [scanner easeOutView];
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
-(void) reScanAfterSeconds:(NSTimeInterval) seconds{
    [page performSelector:@selector(showScanView) withObject:nil afterDelay:seconds];
}
-(void) viewDidLoad{
    [super viewDidLoad];
    isBarHidden=self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view addSubview:page];
    [self.navigationItem setTitle:@"扫一扫"];
    [self setLeftBarButtonAsBackWith:IMG_ArrowLeft];
    
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [page showScanView];
}
-(void) viewWillDisappear:(BOOL)animated{
    [page easeOut];
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:isBarHidden animated:YES];
}
@end