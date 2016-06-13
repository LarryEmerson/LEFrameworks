//
//  LEBaseCellWithIconTextAndText.m
//  spark-client-ios
//
//  Created by Larry Emerson on 15/2/4.
//  Copyright (c) 2015年 Syan. All rights reserved.
//

#import "LEBaseCellWithIconTextAndText.h" 


@implementation LEBaseCellWithIconTextAndText{
    UIImageView *curIcon;
    UILabel *labelLeft;
}
-(void)initUI{
    self.hasBottomSplit=YES;
    self.hasArrow=YES;
    //
    [self setBackgroundColor:ColorWhite];
    int space=DefaultCellHeight-DefaultCellIconRect;
    space/=2;
    // 
    curIcon=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(self.CellLeftSpace, 0) CGSize:[LEUIFramework getSizeWithValue:DefaultCellIconRect]] Image:nil];
    labelLeft=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorOutsideRightCenter RelativeView:curIcon Offset:CGPointMake(self.CellLeftSpace, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:nil FontSize:CellFontSizeTitle Font:nil Width:0 Height:0 Color:ColorBlack Line:1 Alignment:NSTextAlignmentLeft]];
    self.labelRight=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideRightCenter Offset:CGPointMake(-self.CellLeftSpace*2, 0) CGSize:CGSizeMake(self.globalVar.ScreenWidth*2/3-self.CellLeftSpace*3, DefaultCellHeight-CellLeftSpaceAs*2)] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:nil FontSize:15 Font:nil Width:0 Height:0 Color:ColorTextGray Line:0 Alignment:NSTextAlignmentRight]];
    self.labelRight.leAutoLayoutSettings.leLabelMaxWidth=self.globalVar.ScreenWidth*2/3-self.CellLeftSpace*3;
    [self initUIWithData];
}
-(void) initUIWithData{}
-(void) setIcon:(NSString *) icon LeftText:(NSString *) left RightText:(NSString *) right{
    if(icon){
        [curIcon setImage:[LEUIFramework getMiddleStrechedImage:[UIImage imageNamed:icon]]];
    }
    if(left){
        [labelLeft leSetText: left];
    }
    if(right){ 
        [self.labelRight leSetText:right];
    }
}

@end
