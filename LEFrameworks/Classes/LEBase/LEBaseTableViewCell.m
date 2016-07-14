//
//  LEBaseTableViewCell.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewCell.h" 

@implementation LEBaseTableViewCell{
    BOOL hasGesture;
}
- (id)initWithSettings:(LETableViewCellSettings *) settings {
    self.selectionDelegate=settings.selectionDelegate;
    hasGesture=settings.gesture;
    self = [super initWithStyle:settings.style reuseIdentifier:settings.reuseIdentifier]; 
    if (self) {
        self.globalVar=[LEUIFramework sharedInstance];
        self.CellLeftSpace=LENavigationBarHeight/2;
        self.CellRightSpace=LESCREEN_WIDTH-LENavigationBarHeight/2;
        [self setFrame:CGRectMake(0, 0, LESCREEN_WIDTH, LEDefaultCellHeight)];
        [self setBackgroundColor:LEColorWhite];
        self.hasBottomSplit=YES;
        if(hasGesture){
            self.tapEffect=[[UIButton alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
            [self.tapEffect setBackgroundImage:[LEColorMask2 leImageStrechedFromSizeOne] forState:UIControlStateHighlighted];
            [self.tapEffect addTarget:self action:@selector(onButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        } 
        [self initUI];
        [self initCellStyle];
        if(self.tapEffect){
            [self addSubview:self.tapEffect];
        }
        [self initTopClickUIS];
    }
    return self;
}

-(void) initUI{
    self.curTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(self.CellLeftSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LENavigationBarFontSize Font:nil Width:self.CellRightSpace-self.CellLeftSpace Height:self.bounds.size.height Color:LEColorBlack Line:0 Alignment:NSTextAlignmentLeft]];
}
-(void) initTopClickUIS{}
-(void) setHasBottomSplit:(BOOL)hasBottomSplit{
    _hasBottomSplit=hasBottomSplit;
    if(hasBottomSplit){
        if(self.curBottomSplit){
            [self.curBottomSplit setHidden:NO];
        }else{
            self.curBottomSplit=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(self.bounds.size.width-self.bottomSplitSpace*2, 0.5 )] Image:[LEColorSplit leImageStrechedFromSizeOne]];
        }
        [self addSubview:self.curBottomSplit];
    }else{
        if(self.curBottomSplit){
            [self.curBottomSplit setHidden:YES];
        }
    }
}
-(void) setBottomSplit:(BOOL) hasSplit Width:(int) width{
    [self setHasBottomSplit:hasSplit];
    [self.curBottomSplit leSetSize:CGSizeMake(width, 0.5)];
}
-(void) setBottomSplit:(BOOL) hasSplit Width:(int) width Offset:(CGPoint) offset{
    [self setHasBottomSplit:hasSplit];
    [self.curBottomSplit leSetSize:CGSizeMake(width, 0.5)];
    [self.curBottomSplit leSetOffset:offset];
}
-(void) setEnableArrow:(BOOL)hasArrow{
    self.hasArrow=hasArrow;
    if(self.hasArrow){
        [self.curArrow leSetImage:LEIMG_Cell_RightArrow WithSize:LEIMG_Cell_RightArrow.size];
    }else{
        [self.curArrow leSetImage:nil WithSize:CGSizeZero];
    }
}
-(void) initCellStyle{
    if(self.hasTopSplit){
        [LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.bounds.size.width, 0.5)] Image:[LEColorSplit leImageStrechedFromSizeOne]];
    }
    if(self.hasArrow){
        self.curArrow=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideRightCenter Offset:CGPointMake(-LELayoutSideSpace20, 0) CGSize:CGSizeZero] Image:LEIMG_Cell_RightArrow];
    }
}
-(void) setCellHeight:(int) height{
    [self setCellHeight:height TapWidth:self.bounds.size.width];
}
-(void) setCellHeight:(int) height TapWidth:(int) width {
    [self leSetSize:CGSizeMake(self.bounds.size.width, height)];
    
}
-(void) onButtonTaped{
    if([self.globalVar canItBeTapped]){
        [self onCellSelectedWithIndex:KeyOfCellClickDefaultStatus];
    }
} 
-(void) onCellSelectedWithIndex:(int) index{
    if(self.selectionDelegate){
        if(!self.curIndexPath){
            LELogObject(@"点击事件无效。继承LEBaseTableViewCell后，重写SetData方法中需要设置indexPath：self.curIndexPath=path;")
            return;
        }
        [self.selectionDelegate onTableViewCellSelectedWithInfo:@{KeyOfCellIndexPath:self.curIndexPath,KeyOfCellClickStatus:[NSNumber numberWithInt:index]}];
    }
}
-(void) setData:(id) data IndexPath:(NSIndexPath *) path{
    self.curIndexPath=path; 
}
@end
