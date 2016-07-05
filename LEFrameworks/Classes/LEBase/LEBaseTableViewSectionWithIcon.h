//
//  LEBaseTableViewSectionWithIcon.h
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/6.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h" 
@interface LEBaseTableViewSectionWithIcon : UIView
@property (nonatomic) UIImageView *curIcon;
-(id) initWithSectionText:(NSString *) title;
@end
