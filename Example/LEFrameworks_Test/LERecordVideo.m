//
//  LERecordVideo.m
//  LEFrameworks
//
//  Created by emerson larry on 2017/2/7.
//  Copyright © 2017年 LarryEmerson. All rights reserved.
//

#import "LERecordVideo.h"
#import <AVFoundation/AVFoundation.h>

#define ColorGreen [UIColor colorWithRed:0.133 green:0.735 blue:0.139 alpha:1.000]
@interface LERecordVideoPage:LEBaseView<AVCaptureVideoDataOutputSampleBufferDelegate,LENavigationDelegate>
@end
@implementation LERecordVideoPage{
    __weak id<LERecordVideoDelegate> curDelegate;
    AVCaptureDevice * device;
    AVCaptureDeviceInput * input;
    AVCaptureVideoDataOutput * output;
    AVCaptureSession * session;
    AVCaptureVideoPreviewLayer * preview;
    
    NSTimer *curTimer;
    UIImageView *curRecordView;
    UIView *bottomView;
    NSMutableArray *samples;
    UIButton *recordButton;
}
-(id) initWithViewController:(LEBaseViewController *)vc Delegate:(id<LERecordVideoDelegate>)delegate{
    self=[super initWithViewController:vc];
    curDelegate=delegate;
    return self;
}
-(void) leNavigationLeftButtonTapped{
    [self leRelease];
    [self.leCurrentViewController lePopSelfAnimated];
}
-(void) dealloc{
    [self leRelease];
}
-(void) leRelease{
    [session stopRunning];
    device=nil;
    input=nil;
    output=nil;
    [preview removeFromSuperlayer];
    session=nil;
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    NSLog(@"didOutputSampleBuffer");
    UIImage *img=[self imageFromSampleBuffer:sampleBuffer];
    if(img)
    [samples addObject:img];
}
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // 锁定pixel buffer的基地址
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // 得到pixel buffer的基地址
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // 得到pixel buffer的行字节数
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // 得到pixel buffer的宽和高
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // 创建一个依赖于设备的RGB颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // 根据这个位图context中的像素数据创建一个Quartz image对象
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // 解锁pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // 释放context和颜色空间
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // 用Quartz image创建一个UIImage对象image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // 释放Quartz image对象
    CGImageRelease(quartzImage);
    
    return (image);
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSLog(@"didOutputMetadataObjects");
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
    [session stopRunning];
    device=nil;
    input=nil;
    output=nil;
    session=nil;
}
-(void) leAdditionalInits {
    samples=[NSMutableArray new];
    self.leViewContainer.backgroundColor=LEColorBlack;
    LEBaseNavigation *navi=[[LEBaseNavigation alloc] initWithSuperViewAsDelegate:self Title:nil];
    [navi leSetLeftNavigationItemWith:@"取消" Image:nil Color:ColorGreen];
    [navi leSetBackground:[LEColorBlack leImageStrechedFromSizeOne]];
    curRecordView=[UIImageView new].leSuperView(self.leViewBelowCustomizedNavigation).leAnchor(LEAnchorInsideTopCenter).leSize(CGSizeMake(LESCREEN_WIDTH, LESCREEN_WIDTH)).leBackground(LEColorTest).leAutoLayout;
    bottomView=[UIView new].leSuperView(self.leViewBelowCustomizedNavigation).leAnchor(LEAnchorInsideBottomCenter).leSize(CGSizeMake(LESCREEN_WIDTH, self.leFrameHightForCustomizedView-LESCREEN_WIDTH)).leAutoLayout;
    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    if(input){
        output = [[AVCaptureVideoDataOutput alloc] init];
        [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
        session = [[AVCaptureSession alloc]init];
        [session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [preview setFrame:curRecordView.bounds];
        [curRecordView.layer insertSublayer: preview atIndex:0];
        [session startRunning];
    }
}

//-(void) leShowScanView{
//    [session stopRunning];
//    device=nil;
//    input=nil;
//    output=nil;
//    [preview removeFromSuperlayer];
//    preview=nil;
//    session=nil;
//    device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
//    if(input){
//        output = [[AVCaptureMetadataOutput alloc]init];
//        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//        session = [[AVCaptureSession alloc]init];
//        [session setSessionPreset:AVCaptureSessionPresetHigh];
//        if ([session canAddInput:input]) {
//            [session addInput:input];
//        }
//        if ([session canAddOutput:output]) {
//            [session addOutput:output];
//        }
//        output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
//        preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
//        preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        preview.frame =curRecordView.bounds;
//        [curRecordView.layer insertSublayer: preview atIndex:0];
//        [session startRunning];
//    }
//}


@end
@implementation LERecordVideo{
    LERecordVideoPage *page;
    BOOL isBarHidden;
    UIStatusBarStyle barStyle;
}
-(id) initWithDelegate:(id<LERecordVideoDelegate>) delegate{
    self=[super init];
    page=[[LERecordVideoPage alloc] initWithViewController:self Delegate:delegate];
    return self;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
-(void) viewDidLoad{
    [super viewDidLoad];
    isBarHidden=self.navigationController.navigationBarHidden;
    barStyle=[UIApplication sharedApplication].statusBarStyle;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view addSubview:page];
}
-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:isBarHidden animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:barStyle animated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void) leAdditionalInits{}
@end
