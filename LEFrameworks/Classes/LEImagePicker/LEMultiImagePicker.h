//
//  LEMultiImagePicker.h
//  LEUIFrameworkDemo
//
//  Created by emerson larry on 16/6/1.
//  Copyright © 2016年 Larry Emerson. All rights reserved.
//

#import "LEBaseViewController.h"
@protocol LEMultiImagePickerDelegate<NSObject>
-(void) leOnMultiImagePickedWith:(NSArray *) images;
@end

@interface LEMultiImagePicker : LEBaseViewController
-(id) initWithImagePickerDelegate:(id<LEMultiImagePickerDelegate>) delegate;
@end
