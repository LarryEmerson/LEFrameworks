//
//  LEWaveProgressView.h
//  SXWaveAnimate
//
//  Created by emerson larry on 15/12/21.
//  Copyright © 2015年 Sankuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"
@protocol LEWaveProgressViewDelegate <NSObject>
-(void) leOnWaveProgressPercentageChanged:(float) percentage;
@end

@interface LEWaveProgressView : UIView
-(void) leSetDelegate:(id<LEWaveProgressViewDelegate>) delegate;

-(void) leSetPercentage:(float) percentage;
@end
