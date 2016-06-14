//
//  LEWebView.m
//  ticket
//
//  Created by Larry Emerson on 14-8-27.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//

#import "LEWebView.h" 
@implementation LEWebView{
    UIWebView *webView;
    UIImageView *bottomView;
    //
    NSURL *curURL;
    //    int count;
    //
    UIImageView *viewRefresh;
    NSTimer *curTimer;
    //
    NSMutableArray *curButtons;
}

#define Space 6

-(void) onShare{
    
}

-(void) setExtraViewInits{
    //    UIImage *imgIconRefresh=[UIImage imageNamed:@"web_icon_refresh"];
    //    UIImage *imgIconBack=[UIImage imageNamed:@"web_icon_backward_on"];
    //    UIImage *imgIconBackDisabled=[UIImage imageNamed:@"browser_icon_back_disabled"];
    //    UIImage *imgIconForward=[UIImage imageNamed:@"web_icon_forward_on"];
    //    UIImage *imgIconForwardDisabled=[UIImage imageNamed:@"browser_icon_forward_disabled"];
    //    UIImage *imgIconShare=[UIImage imageNamed:@"web_icon_share"];
    //    UIImage *imgBottom=[UIImage imageNamed:@"browser_bottombg"];
    
    UIImage *imgIconRefresh=[[LEUIFramework instance] getImageFromLEFrameworksWithName:@"web_icon_refresh"];
    UIImage *imgIconBack   =[[LEUIFramework instance] getImageFromLEFrameworksWithName:@"web_icon_backward_on"];
    //    UIImage *imgIconBackDisabled   =[[LEUIFramework instance] getImageFromLEFrameworksWithName:@"browser_icon_back_disabled"];
    UIImage *imgIconForward=[[LEUIFramework instance] getImageFromLEFrameworksWithName:@"web_icon_forward_on"];
    //    UIImage *imgIconForwardDisabled=[[LEUIFramework instance] getImageFromLEFrameworksWithName:@"browser_icon_forward_disabled"];
    UIImage *imgIconShare=[[LEUIFramework instance] getImageFromLEFrameworksWithName:@"web_icon_share"];
    UIImage *imgBottom=[[LEUIFramework instance] getImageFromLEFrameworksWithName:@"browser_bottombg"];
    
    int bottomHeight=50;
    //
    bottomView=[[UIImageView alloc] initWithFrame:CGRectMake(0, self.viewContainer.bounds.size.height-bottomHeight, self.globalVar.ScreenWidth, bottomHeight)];
    [bottomView setUserInteractionEnabled:YES];
    [bottomView setImage:[imgBottom stretchableImageWithLeftCapWidth:imgBottom.size.width/2 topCapHeight:imgBottom.size.height/2]];
    [self.viewContainer addSubview:bottomView];
    //
    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.globalVar.ScreenWidth, self.viewContainer.bounds.size.height-bottomHeight)];
    //    [webView setDelegate:self];
    [self.viewContainer addSubview:webView];
    //
    int buttonWidth=self.curFrameWidth/4;
    curButtons=[[NSMutableArray alloc] init];
    NSArray *array=[[NSArray alloc] initWithObjects:imgIconBack,imgIconForward,imgIconRefresh,imgIconShare, nil];
    //    NSArray *arrayDisabled=[[NSArray alloc] initWithObjects:imgIconBackDisabled,imgIconForwardDisabled, nil];
    //
    for (int i=0; i<array.count; i++) {
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*i, 0, buttonWidth, bottomHeight)];
        [bottomView addSubview:button];
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[array objectAtIndex:i] forState:UIControlStateNormal];
        //        if(i<arrayDisabled.count){
        //            [button setImage:[arrayDisabled objectAtIndex:i] forState:UIControlStateDisabled];
        //        }
        [curButtons addObject:button];
    }
    //
    viewRefresh=[[UIImageView alloc] initWithFrame:CGRectMake(buttonWidth*2.5-imgIconRefresh.size.width/2, bottomHeight/2-imgIconRefresh.size.height/2, imgIconRefresh.size.width, imgIconRefresh.size.height)];
    [bottomView addSubview:viewRefresh];
    [viewRefresh setImage:imgIconRefresh];
    //
    [self.viewContainer setBackgroundColor:ColorTest];
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

-(void) startAnimation{
    [[curButtons objectAtIndex:2] setHidden:YES];
    [viewRefresh setHidden:NO];
    viewRefresh=[self rotate360DegreeWithImageView:viewRefresh];
    [curTimer invalidate];
    curTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stopAnimation) userInfo:nil repeats:NO];
}

-(void) stopAnimation{
    [viewRefresh.layer removeAllAnimations];
    [viewRefresh setHidden:YES];
    [[curButtons objectAtIndex:2] setHidden:NO];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    count++;
    //    [[curButtons objectAtIndex:0] setEnabled:count>1];
    //    if(count<=1) {
    //        [self.title setFrame:CGRectMake(NavigationBarHeight, self.globalVar.IsStatusBarNotCovered?StatusBarHeight:0,self.globalVar.ScreenWidth-NavigationBarHeight*2, NavigationBarHeight)];
    //    }else{
    //        [self.title setFrame:CGRectMake(NavigationBarHeight*2+6, (self.globalVar.IsStatusBarNotCovered?StatusBarHeight:0), self.globalVar.ScreenWidth-NavigationBarHeight*3-6, NavigationBarHeight)];
    //    }
    return YES;
}

-(void) onWebClose{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
        [self setFrame:CGRectMake(self.globalVar.ScreenWidth, 0, self.frame.size.width, self.frame.size.height)];
    } completion:^(BOOL isFinished){
        [self easeOutViewLogic];
    }];
}

-(void) onWebRefresh{
    //    count-=1;
    [webView reload];
}

- (void)loadWebPageWithString:(NSString*)urlString
{
    if(urlString&&(NSNull *)urlString!=[NSNull null]){
        curURL=[NSURL URLWithString:urlString];
        NSURLRequest *request =[NSURLRequest requestWithURL:curURL];
        [webView loadRequest:request];
    }else{
        
    }
}

-(void) easeOutViewLogic{
    if(self.delegate){
        [self.delegate onCloseWebView];
    }
    [self removeFromSuperview];
}

//-(void) easeOutView{
//    if([webView canGoBack]){
//        count-=2;
//        [webView goBack];
//    }else{
//        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^(void){
//            [self setFrame:CGRectMake(self.globalVar.ScreenWidth, 0, self.frame.size.width, self.frame.size.height)];
//        } completion:^(BOOL isFinished){
//            [self easeOutViewLogic];
//        }];
//    }
//}

-(void) webViewDidStartLoad:(UIWebView *)webView{
    [self startAnimation];
}

-(void) webViewDidFinishLoad:(UIWebView *)webView{
    [self stopAnimation];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self stopAnimation];
    //    NSLog(@"web didFailLoadWithError %@",error);
    if ([error code] != NSURLErrorCancelled) {
        //show error alert, etc.
        [self addLocalNotification:error.localizedDescription];
    }
}

@end
