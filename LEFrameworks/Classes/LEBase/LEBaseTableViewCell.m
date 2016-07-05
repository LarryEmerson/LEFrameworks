//
//  LEBaseTableViewCell.m
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewCell.h" 

@implementation LEBaseTableViewCell{
    BOOL hasGesture;
    UIImage *imgSplit;
    UIImage *imgMask;
}
- (id)initWithSettings:(LETableViewCellSettings *) settings {
    UIColor *colorSplit=[UIColor colorWithWhite:0.0 alpha:0.08];
    UIColor *colorMask=[UIColor colorWithWhite:0.500 alpha:0.250];
    imgSplit=[colorSplit imageWithSize:CGSizeMake(1, 0.25)];
    imgMask=[colorMask imageWithSize:CGSizeMake(1,1)];
    self.selectionDelegate=settings.selectionDelegate;
    hasGesture=settings.gesture;
    self = [super initWithStyle:settings.style reuseIdentifier:settings.reuseIdentifier]; 
    if (self) {
        self.globalVar=[LEUIFramework sharedInstance];
        self.CellLeftSpace=NavigationBarHeight/2;
        self.CellRightSpace=self.globalVar.ScreenWidth-NavigationBarHeight/2;
        [self setFrame:CGRectMake(0, 0, self.globalVar.ScreenWidth, DefaultCellHeight)];
        [self setBackgroundColor:ColorWhite];
        self.hasBottomSplit=YES;
        if(hasGesture){
            self.tapEffect=[[UIButton alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
            [self.tapEffect setBackgroundImage:[LEUIFramework getMiddleStrechedImage:imgMask] forState:UIControlStateHighlighted];
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
    self.curTitle=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(self.CellLeftSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:NavigationBarFontSize Font:nil Width:self.CellRightSpace-self.CellLeftSpace Height:self.bounds.size.height Color:ColorBlack Line:0 Alignment:NSTextAlignmentLeft]];
}
-(void) initTopClickUIS{}
-(void) setHasBottomSplit:(BOOL)hasBottomSplit{
    _hasBottomSplit=hasBottomSplit;
    if(hasBottomSplit){
        if(self.curBottomSplit){
            [self.curBottomSplit setHidden:NO];
        }else{
            self.curBottomSplit=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(self.bounds.size.width-self.bottomSplitSpace*2, 0.5 )] Image:[ColorSplit imageStrechedFromSizeOne]];
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
        [self.curArrow leSetImage:IMG_Cell_RightArrow WithSize:IMG_Cell_RightArrow.size];
    }else{
        [self.curArrow leSetImage:nil WithSize:CGSizeZero];
    }
}
-(void) initCellStyle{
    if(self.hasTopSplit){
        [LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.bounds.size.width, 0.5)] Image:[imgSplit middleStrechedImage]];
    }
    if(self.hasArrow){
        self.curArrow=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideRightCenter Offset:CGPointMake(-LayoutSideSpace20, 0) CGSize:CGSizeZero] Image:IMG_Cell_RightArrow];
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
            NSLogObject(@"点击事件无效。继承LEBaseTableViewCell后，重写SetData方法中需要设置indexPath：self.curIndexPath=path;")
            return;
        }
        [self.selectionDelegate onTableViewCellSelectedWithInfo:@{KeyOfCellIndexPath:self.curIndexPath,KeyOfCellClickStatus:[NSNumber numberWithInt:index]}];
    }
}
-(void) setData:(id) data IndexPath:(NSIndexPath *) path{
    self.curIndexPath=path; 
}
@end
