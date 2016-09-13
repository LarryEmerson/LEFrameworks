//
//  LEBaseTableViewCell.m
//  https://github.com/LarryEmerson/LEFrameworks
//
//  Created by Larry Emerson on 15/2/2.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseTableViewCell.h" 

@interface LEBaseTableViewCell ()
//@property (nonatomic, weak, readwrite) id<LETableViewCellSelectionDelegate> leSelectionDelegate;
@property (nonatomic, readwrite) BOOL leHasTopSplit;
@property (nonatomic, readwrite) BOOL leHasBottomSplit;
@property (nonatomic, readwrite) BOOL leHasArrow; 
@property (nonatomic, readwrite) UIImageView *leCurArrow;
@property (nonatomic, readwrite) UIImageView *curBottomSplit;
@end

@implementation LEBaseTableViewCell{
    BOOL hasGesture;
}
- (id)initWithSettings:(LETableViewCellSettings *) settings {
    self.leSelectionDelegate=settings.leSelectionDelegate;
    hasGesture=settings.leGesture;
    self = [super initWithStyle:settings.leStyle reuseIdentifier:settings.leReuseIdentifier];
    if (self) {
        [self setFrame:CGRectMake(0, 0, LESCREEN_WIDTH, LEDefaultCellHeight)];
        [self setBackgroundColor:LEColorWhite];
        self.leHasBottomSplit=YES;
        if(hasGesture){
            self.leTapEffect=[[UIButton alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero]];
            [self.leTapEffect setBackgroundImage:[LEColorMask2 leImageStrechedFromSizeOne] forState:UIControlStateHighlighted];
            [self.leTapEffect addTarget:self action:@selector(onButtonTaped) forControlEvents:UIControlEventTouchUpInside];
        } 
        [self leExtraInits];
        [self initCellStyle];
        if(self.leTapEffect){
            [self addSubview:self.leTapEffect];
        }
        [self leExtraInitsForTopViews];
    }
    return self;
}

-(void) leExtraInits{
    self.leTitle=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LELayoutSideSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LENavigationBarFontSize Font:nil Width:LESCREEN_WIDTH-LELayoutSideSpace*2 Height:self.bounds.size.height Color:LEColorBlack Line:0 Alignment:NSTextAlignmentLeft]];
}
-(void) leExtraInitsForTopViews{}
-(void) setHasBottomSplit:(BOOL)leHasBottomSplit{
    _leHasBottomSplit=leHasBottomSplit;
    if(leHasBottomSplit){
        if(self.curBottomSplit){
            [self.curBottomSplit setHidden:NO];
        }else{
            self.curBottomSplit=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter Offset:CGPointZero CGSize:CGSizeMake(self.bounds.size.width, 0.5 )] Image:[LEColorSplit leImageStrechedFromSizeOne]];
        }
        [self addSubview:self.curBottomSplit];
    }else{
        if(self.curBottomSplit){
            [self.curBottomSplit setHidden:YES];
        }
    }
}
-(void) leSetBottomSplit:(BOOL) hasSplit{
    [self setHasBottomSplit:hasSplit];
}
-(void) leSetBottomSplit:(BOOL) hasSplit Width:(int) width{
    [self setHasBottomSplit:hasSplit];
    [self.curBottomSplit leSetSize:CGSizeMake(width, 0.5)];
}
-(void) leSetBottomSplit:(BOOL) hasSplit Width:(int) width Offset:(CGPoint) offset{
    [self setHasBottomSplit:hasSplit];
    [self.curBottomSplit leSetSize:CGSizeMake(width, 0.5)];
    [self.curBottomSplit leSetOffset:offset];
}
-(void) leSetEnableArrow:(BOOL)leHasArrow{
    self.leHasArrow=leHasArrow;
    if(self.leHasArrow){
        [self.leCurArrow leSetImage:LEIMG_Cell_RightArrow WithSize:LEIMG_Cell_RightArrow.size];
    }else{
        [self.leCurArrow leSetImage:nil WithSize:CGSizeZero];
    }
}
-(void) initCellStyle{
    if(self.leHasTopSplit){
        [LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.bounds.size.width, 0.5)] Image:[LEColorSplit leImageStrechedFromSizeOne]];
    }
    if(self.leHasArrow){
        self.leCurArrow=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideRightCenter Offset:CGPointMake(-LELayoutSideSpace20, 0) CGSize:CGSizeZero] Image:LEIMG_Cell_RightArrow];
    }
}
-(void) leSetCellHeight:(int) height{
    [self leSetCellHeight:height TapWidth:self.bounds.size.width];
}
-(void) leSetCellHeight:(int) height TapWidth:(int) width {
    [self leSetSize:CGSizeMake(self.bounds.size.width, height)];
    
}
-(void) onButtonTaped{
    if([LEUIFramework sharedInstance].leCanItBeTapped){
        [self leOnCellSelectedWithIndex:LEKeyOfClickStatusAsDefault];
    }
}
-(void) leOnCellSelectedWithInfo:(NSDictionary *) info{
    if(self.leSelectionDelegate){
        if(!self.leIndexPath){
            LELogObject(@"点击事件无效。继承LEBaseTableViewCell后，重写SetData方法中需要设置indexPath：self.leIndexPath=path;")
            return;
        }
        [self.leSelectionDelegate leOnTableViewCellSelectedWithInfo:@{LEKeyOfIndexPath:self.leIndexPath,LEKeyOfClickStatus:info}];
    }
}
-(void) leOnCellSelectedWithIndex:(int) index{
    if(self.leSelectionDelegate){
        if(!self.leIndexPath){
            LELogObject(@"点击事件无效。继承LEBaseTableViewCell后，重写SetData方法中需要设置indexPath：self.leIndexPath=path;")
            return;
        }
        [self.leSelectionDelegate leOnTableViewCellSelectedWithInfo:@{LEKeyOfIndexPath:self.leIndexPath,LEKeyOfClickStatus:[NSNumber numberWithInt:index]}];
    }
}
-(void) leSetData:(id) data IndexPath:(NSIndexPath *) path{
    self.leIndexPath=path; 
}
@end
