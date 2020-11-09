//
//  LEWebView.m
//  ticket
//
//  Created by Larry Emerson on 14-8-27.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//

#import "LEWebView.h" 
@interface LEWebViewPage : LEBaseView<UIWebViewDelegate>
- (void)leLoadWebPageWithString:(NSString*)urlString;
@end
@implementation LEWebViewPage{
    UIWebView *webView;
    UIImageView *bottomView;
    NSURL *curURL;
    UIImageView *viewRefresh;
    NSTimer *curTimer;
    NSMutableArray *curButtons;
    LEBaseNavigation *navi;
}
-(void) onShare{
    
}
-(void) setNavigationTitle:(NSString *) title{
    [navi leSetNavigationTitle:title];
}
-(void) leAdditionalInits{
    navi=[[LEBaseNavigation alloc] initWithDelegate:nil SuperView:self Title:nil];
    curButtons=[[NSMutableArray alloc] init];
    UIImage *imgIconRefresh=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_web_icon_refresh"];
    UIImage *imgIconBack   =[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_web_icon_backward_on"];
    UIImage *imgIconBackDisabled   =[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_web_icon_backward_off"];
    UIImage *imgIconForward=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_web_icon_forward_on"];
    UIImage *imgIconForwardDisabled=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_web_icon_forward_off"];
    UIImage *imgBottom=[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"LE_browser_bottombg"];
    int bottomHeight=50;
    //
    bottomView=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.leFrameHightForCustomizedView-bottomHeight, self.leCurrentFrameWidth, bottomHeight)];
    [bottomView setUserInteractionEnabled:YES];
    [bottomView setImage:[imgBottom stretchableImageWithLeftCapWidth:imgBottom.size.width/2 topCapHeight:imgBottom.size.height/2]];
    [self.leViewBelowCustomizedNavigation addSubview:bottomView];
    //
    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.leCurrentFrameWidth, self.leFrameHightForCustomizedView-bottomHeight)];
    [webView setDelegate:self];
    [self.leViewBelowCustomizedNavigation addSubview:webView];
    //
    NSArray *array=[[NSArray alloc] initWithObjects:imgIconBack,imgIconForward,imgIconRefresh /*,imgIconShare*/ , nil];
    float buttonWidth=self.leCurrentFrameWidth*1.0/array.count;
    NSArray *arrayDisabled=[[NSArray alloc] initWithObjects:imgIconBackDisabled,imgIconForwardDisabled, nil];
    //
    for (int i=0; i<array.count; i++) {
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*i, 0, buttonWidth, bottomHeight)];
        [bottomView addSubview:button];
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[array objectAtIndex:i] forState:UIControlStateNormal];
        if(i<arrayDisabled.count){
            [button setImage:[arrayDisabled objectAtIndex:i] forState:UIControlStateHighlighted];
        }
        [curButtons addObject:button];
    }
    //
    viewRefresh=[[UIImageView alloc] initWithFrame:CGRectMake(buttonWidth*2.5-imgIconRefresh.size.width/2, bottomHeight/2-imgIconRefresh.size.height/2, imgIconRefresh.size.width, imgIconRefresh.size.height)];
    [bottomView addSubview:viewRefresh];
    [viewRefresh setImage:imgIconRefresh];
}
-(void) onClick:(UIButton *) button{
    int index=(int)[curButtons indexOfObject:button];
    switch (index) {
        case 0:
            [webView goBack];
            break;
        case 1:
            [webView goForward];
            break;
        case 2:
            [webView reload];
            break;
        case 3:
            [self onShare];
            break;
        default:
            break;
    }
}

- (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.2f;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    animation.removedOnCompletion = YES;
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageRrect.size, NO, [UIScreen mainScreen].scale);
    [imageView.image drawInRect:imageRrect];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [imageView.layer addAnimation:animation forKey:nil ];
    return imageView;
}

-(void) leStartAnimation{
    if(curButtons.count>2){
        [[curButtons objectAtIndex:2] setHidden:YES];
    }
    [viewRefresh setHidden:NO];
    viewRefresh=[self rotate360DegreeWithImageView:viewRefresh];
    [curTimer invalidate];
    curTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(leStopAnimation) userInfo:nil repeats:NO];   
}

-(void) leStopAnimation{
    [viewRefresh.layer removeAllAnimations];
    [viewRefresh setHidden:YES];
    if(curButtons.count>2){
        [[curButtons objectAtIndex:2] setHidden:NO];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    count++;
    //    [[curButtons objectAtIndex:0] setEnabled:count>1];
    //    if(count<=1) {
    //        [self.title setFrame:CGRectMake(LENavigationBarHeight, self.globalVar.IsStatusBarNotCovered?LEStatusBarHeight:0,LESCREEN_WIDTH-LENavigationBarHeight*2, LENavigationBarHeight)];
    //    }else{
    //        [self.title setFrame:CGRectMake(LENavigationBarHeight*2+6, (self.globalVar.IsStatusBarNotCovered?LEStatusBarHeight:0), LESCREEN_WIDTH-LENavigationBarHeight*3-6, LENavigationBarHeight)];
    //    }
    return YES;
}


-(void) onWebRefresh{
    [webView reload];
}
- (void)leLoadWebPageWithString:(NSString*)urlString{
    if(urlString&&(NSNull *)urlString!=[NSNull null]){
        curURL=[NSURL URLWithString:urlString];
        NSURLRequest *request =[NSURLRequest requestWithURL:curURL];
        [webView loadRequest:request];
    }else{
        
    }
}
-(void) webViewDidStartLoad:(UIWebView *)webView{
    [self leStartAnimation];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self leStopAnimation];
}
-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self leStopAnimation];
    //    NSLog(@"web didFailLoadWithError %@",error);
    if ([error code] != NSURLErrorCancelled) {
        //show error alert, etc.
        [self leAddLocalNotification:error.localizedDescription];
    }
}
-(id) initWithViewController:(LEBaseViewController *)vc URLString:(NSString *) url{
    self=[super initWithViewController:vc];
    [self leLoadWebPageWithString:url];
    return self;
}
@end


@implementation LEWebView{
    LEWebViewPage *page;
}
- (void)leLoadWebPageWithString:(NSString*)urlString{
    [page leLoadWebPageWithString:urlString];
}
- (void)leSetTitle:(NSString *) title{
    [page setNavigationTitle:title];
}
-(id) init{
    self=[super init];
    page=[[LEWebViewPage alloc] initWithViewController:self URLString:nil];
    return self;
}
-(id) initWithURLString:(NSString *) urlString{
    self=[super init];
    page=[[LEWebViewPage alloc] initWithViewController:self URLString:urlString];
    return self;
} 
-(void) leAdditionalInits{}
@end
