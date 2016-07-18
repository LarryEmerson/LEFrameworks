//
//  AppMessageDelegate.h
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/13.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LEAppMessageDelegate <NSObject>
-(void) leOnShowAppMessageWith:(NSString *) message;
@end

