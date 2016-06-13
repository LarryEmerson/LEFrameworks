/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockConfig.h
 ** Description: 配置文件
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#ifndef JinnLockConfig_h
#define JinnLockConfig_h

// 指示器大小
#define JINN_LOCK_INDICATOR_SIDE_LENGTH 30.0f

// 九宫格大小
#define JINN_LOCK_SUDOKO_SIDE_LENGTH [UIScreen mainScreen].bounds.size.width*21/22

// 圆圈边框粗细(指示器和九宫格的一样粗细)
#define JINN_LOCK_CIRCLE_WIDTH 2.8

// 指示器轨迹粗细
#define JINN_LOCK_INDICATOR_TRACK_WIDTH 2

// 九宫格轨迹粗细
#define JINN_LOCK_SUDOKO_TRACK_WIDTH 7

// 圆圈选中效果中心点和圆圈比例
#define JINN_LOCK_CIRCLE_CENTER_RATIO 0.22f

// 背景颜色
#define JINN_LOCK_COLOR_BACKGROUND [UIColor colorWithRed:0.13 green:0.1294 blue:0.1307 alpha:1.0]

// 正常主题颜色
#define JINN_LOCK_COLOR_NORMAL [UIColor colorWithRed:0.868 green:0.8638 blue:0.8722 alpha:1.0]

// 错误提示颜色
#define JINN_LOCK_COLOR_ERROR [UIColor colorWithRed:0.8551 green:0.2329 blue:0.1953 alpha:0.700835129310345]

// 重设按钮颜色
#define JINN_LOCK_COLOR_RESET [UIColor grayColor]

// 指示器标签基数(不建议更改)
#define JINN_LOCK_INDICATOR_LEVEL_BASE 1000

// 九宫格标签基数(不建议更改)
#define JINN_LOCK_SUDOKO_LEVEL_BASE 2000

// 密码键(不建议更改)
#define JINN_LOCK_PASSWORD @"JinnLockPassword"

// 提示文本
#define JINN_LOCK_RESET_TEXT     @"重新设置"
#define JINN_LOCK_NEW_TEXT       @"请设置新密码"
#define JINN_LOCK_AGAIN_TEXT     @"请再次确认新密码"
#define JINN_LOCK_NOT_MATCH_TEXT @"两次密码不匹配"
#define JINN_LOCK_RE_NEW_TEXT    @"请重新设置新密码"
#define JINN_LOCK_OLD_TEXT       @"请输入旧密码"
#define JINN_LOCK_OLD_ERROR_TEXT @"密码不正确"
#define JINN_LOCK_RE_OLD_TEXT    @"请重新输入旧密码"

#endif// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com