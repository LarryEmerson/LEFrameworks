//
//  LELoadingAnimationView.h
//  ticket
//
//  Created by Larry Emerson on 14-2-22.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LELoadingAnimationView : UIView

@property   (nonatomic) int leViewWidth;
@property   (nonatomic) int leViewHeight;
-(void) leStartAnimation;
-(void) leStopAnimation;
@end
