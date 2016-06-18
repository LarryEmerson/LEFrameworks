//
//  WPHotspotLabel.h
//  WPAttributedMarkupDemo
//
//  Created by Nigel Grange on 20/10/2014.
//  Copyright (c) 2014 Nigel Grange. All rights reserved.
//

#import "WPTappableLabel.h"
#import "LEUIFramework.h"
#import "NSString+WPAttributedMarkup.h"
@interface WPHotspotLabel : WPTappableLabel
+(WPHotspotLabel *) getUILabelWithSettings:(LEAutoLayoutSettings *) settings StyleBook:(NSDictionary *) stylebook AttributedString:(NSString *) attributedString AttributesForCalculateSize:(NSDictionary *) calculateSize  Alignment:(NSTextAlignment) alignment NumberOfLines:(int) lines;
-(void) leSetAttributedString:(NSString *) string;
-(void) leSetAttributedString:(NSString *) string StyleBook:(NSDictionary *) stylebook AttributesForCalculateSize:(NSDictionary *) calculateSize;
@end
