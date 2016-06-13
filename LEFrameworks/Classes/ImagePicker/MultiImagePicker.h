//
//  MultiImagePicker.h
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/1.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import "LEBaseEmptyView.h"
@protocol MultiImagePickerDelegate<NSObject>
-(void) onMultiImagePickedWith:(NSArray *) images;
@end

@interface MultiImagePicker : LEViewController
-(id) initWithImagePickerDelegate:(id<MultiImagePickerDelegate>) delegate;
@end
