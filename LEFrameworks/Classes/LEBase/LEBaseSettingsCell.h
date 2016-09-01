//
//  LEBaseSettingsCell.h
//  guguxinge
//
//  Created by emerson larry on 16/7/29.
//  Copyright © 2016年 LarryEmerson. All rights reserved.
//

#import "LEFrameworks.h"
#import "LEImageFrameworks.h"
/*
 *@brief L:left, R:right, M:middle, F:fullscreen, icon:图标, title:标题（黑）, Textfield:输入文本（灰）, Arrow:箭头， SectionSolid:实心间隔（灰）, Subtitle:副标题（灰）
 */
typedef enum {
    L_Icon_Title_R_Arrow=0,
    L_Title_R_Subtitle,
    L_Title_R_Icon_Arrow,
    L_Title_R_Arrow,
    M_Submit,
    F_SectionSolid,
    L_Title_R_Switch,
    L_Title_R_Subtitle_Arrow
}LESettingsCellType;

#define LEKeyOfSettingsCellFunction @"function"
#define LEKeyOfSettingsCellType @"itemtype"
#define LEKeyOfSettingsCellTitle @"title"
#define LEKeyOfSettingsCellImage @"image"
#define LEKeyOfSettingsCellSubmit @"submit"
#define LEKeyOfSettingsCellSwitch @"switch"
#define LEKeyOfSettingsCellSubtitle @"subtitle"
#define LEKeyOfSettingsCellColor @"color"
#define LEKeyOfSettingsCellHeight @"height"
#define LEKeyOfSettingsCellImageCorner @"corner"
#define LEKeyOfSettingsCellLinespace @"linespace"

#define LEKeyOfSettingsCellTitleFontsize LELayoutFontSize16
#define LEKeyOfSettingsCellSubTitleFontsize LELayoutFontSize13
#define LEKeyOfSettingsCellSubTitleColor LEColorTextGray
#define LEKeyOfSettingsCellSideSpace LELayoutSideSpace
@class LEBaseSettingsItem;
@interface LEBaseSettingsCell : LEBaseCollectionViewCell
-(void) leSetCellType:(LESettingsCellType) type ;
-(LEBaseSettingsItem *) getItemWithType:(LESettingsCellType) type NS_REQUIRES_SUPER;
@end

@interface LEBaseSettingsItem : UIView
@property (nonatomic) LESettingsCellType itemType;
@property (nonatomic) LEBaseSettingsCell *settingsCell;
@property (nonatomic) id curDelegate;
-(id) initWithType:(LESettingsCellType) type SettingsCell:(LEBaseSettingsCell*) cell;
-(void) leSetData:(id)data;
@end
