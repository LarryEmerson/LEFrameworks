/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockViewController.h
 ** Description: 解锁密码控制器
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#import <UIKit/UIKit.h>
#import "JinnLockSudoko.h"
#import "JinnLockIndicator.h"
#import "JinnLockPassword.h"

typedef NS_ENUM(NSInteger, JinnLockType)
{
    JinnLockTypeCreate = 0,
    JinnLockTypeModify,
    JinnLockTypeVerify,
    JinnLockTypeRemove
};

typedef NS_ENUM(NSInteger, JinnLockAppearMode)
{
    JinnLockAppearModePush = 0,
    JinnLockAppearModePresent
};

@protocol JinnLockViewControllerDelegate;

@interface JinnLockViewController : UIViewController

@property (nonatomic, weak) id<JinnLockViewControllerDelegate> delegate;
@property (nonatomic, assign) JinnLockType type;
@property (nonatomic, assign) JinnLockAppearMode appearMode;

- (instancetype)initWithType:(JinnLockType)type appearMode:(JinnLockAppearMode)appearMode;

@end

@protocol JinnLockViewControllerDelegate <NSObject>

@optional
- (void)passwordDidCreate:(NSString *)newPassword;
- (void)passwordDidModify:(NSString *)newPassword;
- (void)passwordDidVerify:(NSString *)oldPassword;
- (void)passwordDidRemove;

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com