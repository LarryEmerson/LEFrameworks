//
//  LEBaseTableViewDisplayCell.m
//  Pods
//
//  Created by emerson larry on 16/9/12.
//
//

#import "LEBaseTableViewDisplayCell.h"

@implementation LEBaseTableViewDisplayCell{
    float leSelfHeight;
}
-(id) initWithDelegate:(id<LETableViewCellSelectionDelegate>)delegate EnableGesture:(NSNumber *)gesture{
    self=[super initWithFrame:CGRectMake(0, 0, LESCREEN_WIDTH, 0)];
    self.leSelectionDelegate=delegate;
    leSelfHeight=LEDefaultCellHeight;
    [self leExtraInits];
    if(![gesture boolValue]){
        self.leSelfTapEvent=[UIButton new].leSuperView(self).leEdgeInsects(UIEdgeInsetsZero).leAutoLayout.leType;
        [self.leSelfTapEvent leSetForTapEventWithSel:@selector(onSelfTapEvent) Target:self];
    }
    return self;
}
-(void) onSelfTapEvent{
    //    LELogObject(self.leIndexPath)
    [self leOnCellSelectedWithIndex:0];
}
-(void) leSetData:(id)data {
    self.leData=data;
}
-(void) leSetCellHeight:(CGFloat) height{
    leSelfHeight=height;
    [self leSetFrame:CGRectMake(0, 0, LESCREEN_WIDTH, height)];
    [self.leSelfTapEvent leSetSize:CGSizeMake(LESCREEN_WIDTH, [self leGetHeight])];
}
-(void) leSetIndex:(NSIndexPath *)index{
    self.leIndexPath=index;
    [self leOnIndexSet];
}
-(void) leOnIndexSet{}
-(void) leOnCellSelectedWithInfo:(NSDictionary *) info{
    if(self.leSelectionDelegate&&self.leIndexPath){
        [self.leSelectionDelegate leOnTableViewCellSelectedWithInfo:@{LEKeyOfIndexPath:self.leIndexPath,LEKeyOfClickStatus:info}];
    }
}
-(void) leOnCellSelectedWithIndex:(int) index{
    if(self.leSelectionDelegate&&self.leIndexPath){
        [self.leSelectionDelegate leOnTableViewCellSelectedWithInfo:@{LEKeyOfIndexPath:self.leIndexPath,LEKeyOfClickStatus:[NSNumber numberWithInt:index]}];
    }
}
-(CGFloat) leGetHeight{
    return leSelfHeight;
}
@end
