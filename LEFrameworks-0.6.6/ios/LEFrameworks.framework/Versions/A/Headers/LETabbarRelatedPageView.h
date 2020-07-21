//
//  LETabbarRelatedPageView.h
//  ygj-app-ios
//
//  Created by emerson larry on 15/12/31.
//  Copyright © 2015年 LarryEmerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"

@interface LETabbarRelatedPageView : UIView
-(void) leSetRootView:(UIView *) view;
-(UIView *) leRootView;
-(void) leEaseInView;
-(void) leEaseOutView;
-(void) leEaseInViewLogic;
-(void) leEaseOutViewLogic;
-(void) leNotifyPageSelected;
@end
