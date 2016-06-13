//
//  LETabbarRelatedPageView.h
//  ygj-app-ios
//
//  Created by emerson larry on 15/12/31.
//  Copyright © 2015年 LarryEmerson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LETabbarRelatedPageView : UIView
@property (nonatomic) UIView *rootView;
-(void) initUI;
-(void) easeInView;
-(void) easeOutView;
-(void) easeInViewLogic;
-(void) easeOutViewLogic;
-(void) notifyPageSelected;
@end
