//
//  LELocalNotification.h
//  ticket
//
//  Created by Larry Emerson on 14-2-20.
//  Copyright (c) 2014年 360CBS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUIFramework.h"  
@interface LELocalNotification : UIView

-(void) setText:(NSString *) text WithEnterTime:(float) time AndPauseTime:(float) pauseTime ;
-(void) setText:(NSString *) text WithEnterTime:(float) time AndPauseTime:(float) pauseTime ReleaseWhenFinished:(BOOL) isRealse;
@end
