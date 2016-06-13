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
-(void) onLEWaveProgressChangedWith:(float) percentage;
@end
@interface LEWaveProgressView : UIView
@property (nonatomic) id<LEWaveProgressViewDelegate> delegate;
@property (nonatomic) UILabel *curProgress;
-(void) setPercentage:(float) percentage;
@end
