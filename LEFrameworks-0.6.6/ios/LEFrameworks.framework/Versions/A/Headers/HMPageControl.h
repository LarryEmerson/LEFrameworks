//
//  wiPageControl.h
//  wiIos
//
//  Created by qq on 12-2-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPageControl : UIPageControl
{
    UIImage *imagePageStateHighlighted;
    UIImage *imagePageStateNormal;
}

@property (nonatomic, strong) UIImage *imagePageStateNormal;
@property (nonatomic, strong) UIImage *imagePageStateHighlighted;

- (id)initWithFrame:(CGRect)frame;

@end
