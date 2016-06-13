//
//  LEBadge.h
//  Letou
//
//  Created by emerson larry on 16/3/23.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h" 

@interface LEBadge : UIImageView
-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings BadgeImage:(UIImage *) badge BadgeNumber:(NSString *) num Fontsize:(int) fontsize TextColor:(UIColor *) color Edge:(int) edge;
-(void) setBadgeNumber:(NSString *) num;
@end
