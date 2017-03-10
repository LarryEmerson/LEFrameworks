//
//  LERecordVideo.h
//  LEFrameworks
//
//  Created by emerson larry on 2017/2/7.
//  Copyright © 2017年 LarryEmerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <LEFrameworks/LEFrameworks.h>

@protocol LERecordVideoDelegate <NSObject>

-(void) onDoneRecordWith:(NSURL *) url;
-(void) onCancleRecord;
@end

@interface LERecordVideo : LEBaseViewController
-(id) initWithDelegate:(id<LERecordVideoDelegate>) delegate;
@end
