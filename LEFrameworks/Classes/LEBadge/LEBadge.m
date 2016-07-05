//
//  LEBadge.m
//  Letou
//
//  Created by emerson larry on 16/3/23.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEBadge.h"

@implementation LEBadge{
    UIImageView *curBadge;
    UILabel *curCount;
    int curEdge;
    int minWidth;
}

-(id) initWithAutoLayoutSettings:(LEAutoLayoutSettings *)settings BadgeImage:(UIImage *) badge BadgeNumber:(NSString *) num Fontsize:(int) fontsize TextColor:(UIColor *) color Edge:(int) edge{
    if(!badge)return nil;
    minWidth=badge.size.width;
    self=[super initWithAutoLayoutSettings:settings];
    [self leSetSize:badge.size];
    [self setImage:[badge middleStrechedImage]];
    curCount=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:num FontSize:fontsize Font:nil Width:0 Height:0 Color:color Line:1 Alignment:NSTextAlignmentCenter]];
    [self setBadgeNumber:num];
    return self;
}
-(void) setBadgeNumber:(NSString *) num{
    [curCount leSetText:num];
    CGSize size=curCount.bounds.size;
    int w=size.width+curEdge*2;
    [self leSetSize:CGSizeMake(w<minWidth?minWidth:w, self.bounds.size.height)];
    if([num isEqualToString:@"0"]){
        [self setHidden:YES];
    }else{
        [self setHidden:NO];
    }
}
@end
