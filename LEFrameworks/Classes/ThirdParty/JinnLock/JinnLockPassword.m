/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockPassword.m
 ** Description: 密码管理操作
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#import "JinnLockPassword.h"
#import "JinnLockConfig.h"

@implementation JinnLockPassword

+ (BOOL)isEncrypted
{
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:JINN_LOCK_PASSWORD];
    
    if (password == nil)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+ (BOOL)setNewPassword:(NSString *)password
{
    if (password == nil || [password isEqualToString:@""] || [password isEqualToString:@"(null)"])
    {
        return NO;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:JINN_LOCK_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

+ (NSString *)oldPassword
{
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:JINN_LOCK_PASSWORD];
    
    if (password != nil && ![password isEqualToString:@""] && ![password isEqualToString:@"(null)"])
    {
        return password;
    }
    
    return nil;
}

+ (void)removePassword
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:JINN_LOCK_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com