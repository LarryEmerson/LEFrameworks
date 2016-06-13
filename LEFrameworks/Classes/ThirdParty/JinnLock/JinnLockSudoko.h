/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockSudoko.h
 ** Description: 解锁九宫格视图
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#import <UIKit/UIKit.h>

@protocol JinnLockSudokoDelegate;

@interface JinnLockSudoko : UIView

@property (nonatomic, weak) id<JinnLockSudokoDelegate> delegate;

- (instancetype)init;
- (void)showErrorPassword:(NSString *)errorPassword;
- (void)reset;

@end

@protocol JinnLockSudokoDelegate <NSObject>

- (void)sudoko:(JinnLockSudoko *)sudoko passwordDidCreate:(NSString *)password;

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com