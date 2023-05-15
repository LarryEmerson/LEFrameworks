//
//  LELoadingAnimationView.m
//  ticket
//
//  Created by Larry Emerson on 14-2-22.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//

#import "LELoadingAnimationView.h" 



@implementation LELoadingAnimationView{
    UIImageView *curView;
}
#define LoadingAnimationTime    0.2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self leAdditionalInits];
    }
    return self;
}
-(void) leAdditionalInits{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"LEFrameworks" ofType:@"bundle"]];
    UIImage *img=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"sr_refresh"]];
    [self setFrame:CGRectMake(0,0, img.size.width, img.size.height)];
    self.leViewWidth=img.size.width;
    self.leViewHeight=img.size.height;
    curView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width,img.size.height)];
    [curView setImage:img];
    [self addSubview:curView];
    [self setHidden:YES];
}
+ (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView{
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
    [self setHidden:NO];
    curView=[LELoadingAnimationView rotate360DegreeWithImageView:curView];
}

-(void) leStopAnimation{
    [curView.layer removeAllAnimations];
    [self setHidden:YES];
}

/** // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
