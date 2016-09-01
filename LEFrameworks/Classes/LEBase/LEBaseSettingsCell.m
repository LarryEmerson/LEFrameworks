//
//  LEBaseSettingsCell.m
//  guguxinge
//
//  Created by emerson larry on 16/7/29.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEBaseSettingsCell.h"
@protocol LEBaseSettingsCellTapDelegate <NSObject>
-(void) onTapEvent;
-(void) onTapEventWith:(id) event;
@end

@implementation LEBaseSettingsItem
-(id) initWithType:(LESettingsCellType) type SettingsCell:(LEBaseSettingsCell*) cell{
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:cell EdgeInsects:UIEdgeInsetsZero]];
    self.itemType=type;
    self.settingsCell=cell;
    self.curDelegate=cell;
    [self leExtraInits];
    [self leAddBottomSplitWithColor:LEColorSplit Offset:CGPointZero Width:LESCREEN_WIDTH];
    return self;
}
-(void) leSetData:(id)data {}
-(void) dealloc{
    self.curDelegate=nil;
}
-(void) onTapped{
    if(self.curDelegate&&[self.curDelegate respondsToSelector:@selector(onTapEvent)]){
        [self.curDelegate onTapEvent];
    }
}
@end
@interface Item_L_Title_R_Arrow : LEBaseSettingsItem
@end
@implementation Item_L_Title_R_Arrow{
    UILabel *label;
}
-(void)leExtraInits{
    label=[UILabel new].leSuperView(self).leAnchor(LEAnchorInsideLeftCenter).leOffset(CGPointMake(LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    UIImageView *arrow=[UIImageView new].leSuperView(self).leAnchor(LEAnchorInsideRightCenter).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    [label.leWidth(LESCREEN_WIDTH-LEKeyOfSettingsCellSideSpace*3-arrow.bounds.size.width).leFont(LEFont(LEKeyOfSettingsCellTitleFontsize)).leLine(1) leLabelLayout];
}
-(void) leSetData:(id) data{
    [label leSetText:[data objectForKey:LEKeyOfSettingsCellTitle]];
}
@end
@interface Item_L_Title_R_Switch : LEBaseSettingsItem
@end
@implementation Item_L_Title_R_Switch{
    UISwitch *curSwitch;
    UILabel *label;
}
-(void)leExtraInits{
    label=[UILabel new].leSuperView(self).leAnchor(LEAnchorInsideLeftCenter).leOffset(CGPointMake(LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    curSwitch=[UISwitch new];
    [curSwitch.leSuperView(self).leAnchor(LEAnchorInsideRightCenter).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, 0)).leSize(curSwitch.bounds.size) leExecAutoLayout];
    [label.leWidth(LESCREEN_WIDTH-LEKeyOfSettingsCellSideSpace*3-curSwitch.bounds.size.width).leFont(LEFont(LEKeyOfSettingsCellTitleFontsize)).leLine(1) leLabelLayout];
    [curSwitch addTarget:self action:@selector(onTapped) forControlEvents:UIControlEventTouchUpInside];
}
-(void) leSetData:(id) data{
    [label leSetText:[data objectForKey:LEKeyOfSettingsCellTitle]];
    [curSwitch setOn:[[data objectForKey:LEKeyOfSettingsCellSwitch] boolValue]];
}
@end
//
@interface Item_L_Title_R_Subtitle : LEBaseSettingsItem
@end
@implementation Item_L_Title_R_Subtitle{
    UILabel *label;
    UILabel *labelSub;
}
-(void)leExtraInits{
    label=[UILabel new].leSuperView(self).leAnchor(LEAnchorInsideTopLeft).leOffset(CGPointMake(LEKeyOfSettingsCellSideSpace, LEKeyOfSettingsCellSideSpace)).leAutoLayout.leType;
    [label.leFont(LEFont(LEKeyOfSettingsCellTitleFontsize)).leLine(1) leLabelLayout];
    labelSub=[UILabel new].leSuperView(self).leAnchor(LEAnchorInsideTopRight).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, LEKeyOfSettingsCellSideSpace)).leAutoLayout.leType;
    [labelSub.leFont(LEFont(LEKeyOfSettingsCellSubTitleFontsize)).leColor(LEKeyOfSettingsCellSubTitleColor).leAlignment(NSTextAlignmentRight).leLine(0) leLabelLayout];
}
-(void) leSetData:(id) data{
    [label leSetText:[data objectForKey:LEKeyOfSettingsCellTitle]];
    [labelSub.leWidth(LESCREEN_WIDTH-LEKeyOfSettingsCellSideSpace*3-label.text.length*LEKeyOfSettingsCellTitleFontsize).leText([data objectForKey:LEKeyOfSettingsCellSubtitle]) leLabelLayout];
    if([data objectForKey:LEKeyOfSettingsCellLinespace]){
        [labelSub leSetLineSpace:[[data objectForKey:LEKeyOfSettingsCellLinespace] intValue]];
    }
    [self leSetSize:CGSizeMake(self.bounds.size.width, MAX(LEKeyOfSettingsCellSideSpace*2+labelSub.bounds.size.height, LEDefaultCellHeight))];
}
@end
@interface Item_L_Title_R_Subtitle_Arrow : LEBaseSettingsItem
@end
@implementation Item_L_Title_R_Subtitle_Arrow{
    UILabel *label;
    UILabel *subtitle;
    UIImageView *arrow;
}
-(void) leExtraInits{
    label=[UILabel new].leSuperView(self).leAnchor(LEAnchorInsideLeftCenter).leOffset(CGPointMake(LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    [label.leFont(LEFont(LEKeyOfSettingsCellTitleFontsize)).leLine(1) leLabelLayout];
    arrow= [UIImageView new].leSuperView(self).leAnchor(LEAnchorInsideRightCenter).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    [arrow leSetImage:[UIImage imageNamed:@"common_arrow_gray"]];
    subtitle=[UILabel new].leSuperView(self).leRelativeView(arrow).leAnchor(LEAnchorOutsideLeftCenter).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    [subtitle.leFont(LEFont(LEKeyOfSettingsCellSubTitleFontsize)).leColor(LEKeyOfSettingsCellSubTitleColor).leLine(0).leAlignment(NSTextAlignmentRight) leLabelLayout];
}
-(void) leSetData:(id) data{
    [label leSetText:[data objectForKey:LEKeyOfSettingsCellTitle]];
    [subtitle.leWidth(LESCREEN_WIDTH-LEKeyOfSettingsCellSideSpace*4-label.text.length*LEKeyOfSettingsCellTitleFontsize).leText([data objectForKey:LEKeyOfSettingsCellSubtitle]) leLabelLayout];
    if([data objectForKey:LEKeyOfSettingsCellLinespace]){
        [subtitle leSetLineSpace:[[data objectForKey:LEKeyOfSettingsCellLinespace] intValue]];
    }
    [self leSetSize:CGSizeMake(self.bounds.size.width, MAX(LEKeyOfSettingsCellSideSpace*2+subtitle.bounds.size.height, LEDefaultCellHeight))];
}
@end
//
@interface Item_L_Icon_Title_R_Arrow : LEBaseSettingsItem
@end
@implementation Item_L_Icon_Title_R_Arrow{
    UIImageView *icon;
    UILabel *label;
}
-(void) leExtraInits{
    icon=[UIImageView new].leSuperView(self).leAnchor(LEAnchorInsideLeftCenter).leOffset(CGPointMake(LEKeyOfSettingsCellSideSpace, 0)).leSize(CGSizeMake(LELayoutAvatarSize, LELayoutAvatarSize)).leRoundCorner(LELayoutAvatarSize/2).leAutoLayout.leType;
    label=[UILabel new].leSuperView(self).leRelativeView(icon).leAnchor(LEAnchorOutsideRightCenter).leOffset(CGPointMake(LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    UIImageView *arrow= [UIImageView new].leSuperView(self).leAnchor(LEAnchorInsideRightCenter).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    [arrow leSetImage:[UIImage imageNamed:@"common_arrow_gray"]];
    [label.leFont(LEFont(LEKeyOfSettingsCellTitleFontsize)).leLine(1).leWidth(LESCREEN_WIDTH-LEKeyOfSettingsCellSideSpace*4-LELayoutAvatarSize-arrow.bounds.size.width) leLabelLayout];
}
-(void) leSetData:(id) data{
    [icon leSetImageWithUrlString:[data objectForKey:LEKeyOfSettingsCellImage]];
    [label leSetText:[data objectForKey:LEKeyOfSettingsCellTitle]];
}
@end
@interface Item_L_Title_R_Icon_Arrow : LEBaseSettingsItem
@end
@implementation Item_L_Title_R_Icon_Arrow{
    UIImageView *icon;
    UILabel *label;
}
-(void) leExtraInits{
    label=[UILabel new].leSuperView(self).leAnchor(LEAnchorInsideLeftCenter).leOffset(CGPointMake(LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    UIImageView *arrow= [UIImageView new].leSuperView(self).leAnchor(LEAnchorInsideRightCenter).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, 0)).leAutoLayout.leType;
    [arrow leSetImage:[UIImage imageNamed:@"common_arrow_gray"]];
    icon=[UIImageView new].leSuperView(self).leRelativeView(arrow).leAnchor(LEAnchorOutsideLeftCenter).leOffset(CGPointMake(-LEKeyOfSettingsCellSideSpace, 0)).leSize(CGSizeMake(LELayoutAvatarSize, LELayoutAvatarSize)).leRoundCorner(LELayoutAvatarSize/2).leAutoLayout.leType;
    [label.leFont(LEFont(LEKeyOfSettingsCellTitleFontsize)).leLine(1).leWidth(LESCREEN_WIDTH-LEKeyOfSettingsCellSideSpace*4-LELayoutAvatarSize-arrow.bounds.size.width) leLabelLayout];
}
-(void) leSetData:(id) data{
    [icon leSetCornerRadius:[[data objectForKey:LEKeyOfSettingsCellImageCorner] intValue]];
    [icon leSetImageForQiniuWithUrlString:[data objectForKey:LEKeyOfSettingsCellImage] Width:LELayoutAvatarSize Height:LELayoutAvatarSize];
    [label leSetText:[data objectForKey:LEKeyOfSettingsCellTitle]];
}

@end
@interface Item_M_Submit : LEBaseSettingsItem
@end
@implementation Item_M_Submit{
    UIButton *btn;
}
-(void) leExtraInits{
    [self setBackgroundColor:[LEUIFramework sharedInstance].leColorViewContainer];
    btn=[UIButton new].leSuperView(self).leEdgeInsects(UIEdgeInsetsMake(LEKeyOfSettingsCellSideSpace, LEKeyOfSettingsCellSideSpace, LEKeyOfSettingsCellSideSpace, LEKeyOfSettingsCellSideSpace)).leAutoLayout.leType;
    [btn.leFont(LEFont(LELayoutFontSize14)).leTapEvent(@selector(onTapped),self) leButtonLayout];
}
-(void) leSetData:(id) data{
    UIImage *img=[data objectForKey:LEKeyOfSettingsCellImage];
    if(img){
        [btn.leBackgroundImage([img leMiddleStrechedImage]) leButtonLayout];
    }
    [btn.leText([data objectForKey:LEKeyOfSettingsCellTitle]) leButtonLayout];
    UIColor *color=[data objectForKey:LEKeyOfSettingsCellColor];
    if(color){
        [btn.leNormalColor(color) leButtonLayout];
    }
} 
@end
@interface Item_F_SectionSolid : LEBaseSettingsItem
@end
@implementation Item_F_SectionSolid
-(void) leSetData:(id) data{
    [self setBackgroundColor:[data objectForKey:LEKeyOfSettingsCellColor]];
}
@end

@implementation LEBaseSettingsCell{
    
    LESettingsCellType curType;
    LEBaseSettingsItem *curItem;
}
-(void) leExtraInits{
    [self setBackgroundColor:LEColorWhite];
    self.selectedBackgroundView=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self EdgeInsects:UIEdgeInsetsZero] Image:[LEColorMask5 leImageStrechedFromSizeOne]];
}
-(void) leSetCellType:(LESettingsCellType) type{
    curType=type;
    if(curItem.itemType!=type){
        if(curItem){
            [curItem removeFromSuperview];
        }
        curItem=[self getItemWithType:type];
    }
}
-(LEBaseSettingsItem *) getItemWithType:(LESettingsCellType) type{
    LEBaseSettingsItem *item=nil;
    switch (type) {
        case L_Title_R_Arrow:
            item=[[Item_L_Title_R_Arrow alloc] initWithType:type SettingsCell:self];
            break;
        case L_Title_R_Switch:
            item=[[Item_L_Title_R_Switch alloc] initWithType:type SettingsCell:self];
            break;
        case L_Title_R_Subtitle:
            item=[[Item_L_Title_R_Subtitle alloc] initWithType:type SettingsCell:self];
            break;
        case L_Icon_Title_R_Arrow:
            item=[[Item_L_Icon_Title_R_Arrow alloc] initWithType:type SettingsCell:self];
            break;
        case L_Title_R_Icon_Arrow:
            item=[[Item_L_Title_R_Icon_Arrow alloc] initWithType:type SettingsCell:self];
            break;
        case L_Title_R_Subtitle_Arrow:
            item=[[Item_L_Title_R_Subtitle_Arrow alloc] initWithType:type SettingsCell:self];
            break;
        case M_Submit:
            item=[[Item_M_Submit alloc] initWithType:type SettingsCell:self];
            break;
        case F_SectionSolid:
            item=[[Item_F_SectionSolid alloc] initWithType:type SettingsCell:self];
            break;
        default:
            break;
    }
    return item;
}
-(void) onTapEvent{
    [self.leCollectionView leSelectCellAtIndex:self.leIndexPath];
}
-(void) leSetData:(id)data IndexPath:(NSIndexPath *)path{
    [super leSetData:data IndexPath:path];
    LESettingsCellType type=[[data objectForKey:LEKeyOfSettingsCellType] intValue];
    [self leSetCellType:type];
    [curItem leSetData:data];
}
@end
