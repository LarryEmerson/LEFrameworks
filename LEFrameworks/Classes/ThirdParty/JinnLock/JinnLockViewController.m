/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockViewController.m
 ** Description: 解锁密码控制器
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#import "JinnLockViewController.h"
#import "JinnLockConfig.h"

typedef NS_ENUM(NSInteger, JinnLockStep)
{
    JinnLockStepNone = 0,
    JinnLockStepCreateNew,
    JinnLockStepCreateAgain,
    JinnLockStepCreateNotMatch,
    JinnLockStepCreateReNew,
    JinnLockStepModifyOld,
    JinnLockStepModifyOldError,
    JinnLockStepModifyReOld,
    JinnLockStepModifyNew,
    JinnLockStepModifyAgain,
    JinnLockStepModifyNotMatch,
    JinnLockStepModifyReNew,
    JinnLockStepVerifyOld,
    JinnLockStepVerifyOldError,
    JinnLockStepVerifyReOld,
    JinnLockStepRemoveOld,
    JinnLockStepRemoveOldError,
    JinnLockStepRemoveReOld
};

@interface JinnLockViewController () <JinnLockSudokoDelegate>

@property (nonatomic, strong) JinnLockIndicator *indicator;
@property (nonatomic, strong) JinnLockSudoko *sudoko;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIButton *resetButton;

@property (nonatomic, assign) JinnLockStep step;
@property (nonatomic, strong) NSString *passwordTemp;

@end

@implementation JinnLockViewController

- (instancetype)initWithType:(JinnLockType)type
                  appearMode:(JinnLockAppearMode)appearMode
{
    self = [super init];
    
    if (self)
    {
        self.type = type;
        self.appearMode = appearMode;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setup];
    [self initGui];
    
    switch (self.type)
    {
        case JinnLockTypeCreate:
        {
            [self updateGuiForStep:JinnLockStepCreateNew];
        }
            break;
        case JinnLockTypeModify:
        {
            [self updateGuiForStep:JinnLockStepModifyOld];
        }
            break;
        case JinnLockTypeVerify:
        {
            [self updateGuiForStep:JinnLockStepVerifyOld];
        }
            break;
        case JinnLockTypeRemove:
        {
            [self updateGuiForStep:JinnLockStepRemoveOld];
        }
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self viewsAutoLayout];
}

- (void)setup
{
    self.view.backgroundColor = JINN_LOCK_COLOR_BACKGROUND;
    
    _step = JinnLockStepNone;
}

- (void)initGui
{
    _noticeLabel = [[UILabel alloc] init];
    _noticeLabel.textAlignment = NSTextAlignmentCenter;
    _noticeLabel.font = [UIFont boldSystemFontOfSize:18];
    
    _indicator = [[JinnLockIndicator alloc] init];
    
    _sudoko = [[JinnLockSudoko alloc] init];
    _sudoko.delegate = self;
    
    _resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _resetButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_resetButton setTitleColor:JINN_LOCK_COLOR_RESET forState:UIControlStateNormal];
    [_resetButton setTitle:JINN_LOCK_RESET_TEXT forState:UIControlStateNormal];
    [_resetButton addTarget:self action:@selector(resetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_noticeLabel];
    [self.view addSubview:_indicator];
    [self.view addSubview:_sudoko];
    [self.view addSubview:_resetButton]; 
}

#pragma mark - AutoLayout

- (void)viewsAutoLayout
{
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    _noticeLabel.frame = CGRectMake(0, 0, width, (height - JINN_LOCK_SUDOKO_SIDE_LENGTH) / 2);
    _indicator.frame = CGRectMake((width - JINN_LOCK_INDICATOR_SIDE_LENGTH)/2,
                                  (height - JINN_LOCK_SUDOKO_SIDE_LENGTH)/2 - JINN_LOCK_INDICATOR_SIDE_LENGTH,
                                  JINN_LOCK_INDICATOR_SIDE_LENGTH,
                                  JINN_LOCK_INDICATOR_SIDE_LENGTH);
    _sudoko.frame = CGRectMake((width - JINN_LOCK_SUDOKO_SIDE_LENGTH)/2,
                               (height - JINN_LOCK_SUDOKO_SIDE_LENGTH)/2,
                               JINN_LOCK_SUDOKO_SIDE_LENGTH,
                               JINN_LOCK_SUDOKO_SIDE_LENGTH);
    _resetButton.frame = CGRectMake(0, height - 80, width, 80);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self viewsAutoLayout];
}

#pragma mark - Private

- (void)updateGuiForStep:(JinnLockStep)step
{
    _step = step;
    
    switch (step)
    {
        case JinnLockStepCreateNew:
        {
            _noticeLabel.text = JINN_LOCK_NEW_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateAgain:
        {
            _noticeLabel.text = JINN_LOCK_AGAIN_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = NO;
            _resetButton.hidden = NO;
        }
            break;
        case JinnLockStepCreateNotMatch:
        {
            _noticeLabel.text = JINN_LOCK_NOT_MATCH_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepCreateReNew:
        {
            _noticeLabel.text = JINN_LOCK_RE_NEW_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOld:
        {
            _noticeLabel.text = JINN_LOCK_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyOldError:
        {
            _noticeLabel.text = JINN_LOCK_OLD_ERROR_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReOld:
        {
            _noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyNew:
        {
            _noticeLabel.text = JINN_LOCK_NEW_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyAgain:
        {
            _noticeLabel.text = JINN_LOCK_AGAIN_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = NO;
            _resetButton.hidden = NO;
        }
            break;
        case JinnLockStepModifyNotMatch:
        {
            _noticeLabel.text = JINN_LOCK_NOT_MATCH_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepModifyReNew:
        {
            _noticeLabel.text = JINN_LOCK_RE_NEW_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyOld:
        {
            _noticeLabel.text = JINN_LOCK_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyOldError:
        {
            _noticeLabel.text = JINN_LOCK_OLD_ERROR_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepVerifyReOld:
        {
            _noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOld:
        {
            _noticeLabel.text = JINN_LOCK_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveOldError:
        {
            _noticeLabel.text = JINN_LOCK_OLD_ERROR_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_ERROR;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        case JinnLockStepRemoveReOld:
        {
            _noticeLabel.text = JINN_LOCK_RE_OLD_TEXT;
            _noticeLabel.textColor = JINN_LOCK_COLOR_NORMAL;
            
            _indicator.hidden = YES;
            _resetButton.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)shakeAnimationForView:(UIView *)view
{
    CALayer *viewLayer = view.layer;
    CGPoint position = viewLayer.position;
    CGPoint left = CGPointMake(position.x - 10, position.y);
    CGPoint right = CGPointMake(position.x + 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:left]];
    [animation setToValue:[NSValue valueWithCGPoint:right]];
    [animation setAutoreverses:YES];
    [animation setDuration:0.08];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

- (void)hide
{
    switch (self.appearMode)
    {
        case JinnLockAppearModePush:
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case JinnLockAppearModePresent:
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)resetButtonClick
{
    if (self.type == JinnLockTypeCreate)
    {
        [self updateGuiForStep:JinnLockStepCreateNew];
    }
    else if (self.type == JinnLockTypeModify)
    {
        [self updateGuiForStep:JinnLockStepModifyNew];
    }
}

#pragma mark - Delegate

- (void)sudoko:(JinnLockSudoko *)sudoko passwordDidCreate:(NSString *)password
{
    switch (_step)
    {
        case JinnLockStepCreateNew:
        case JinnLockStepCreateReNew:
        {
            _passwordTemp = password;
            [self updateGuiForStep:JinnLockStepCreateAgain];
        }
            break;
        case JinnLockStepCreateAgain:
        {
            if ([password isEqualToString:_passwordTemp])
            {
                [JinnLockPassword setNewPassword:password];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidCreate:)])
                {
                    [self.delegate passwordDidCreate:password];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepCreateNotMatch];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepCreateReNew];
                });
            }
        }
            break;
        case JinnLockStepModifyOld:
        case JinnLockStepModifyReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                [self updateGuiForStep:JinnLockStepModifyNew];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepModifyOldError];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepModifyReOld];
                });
            }
        }
            break;
        case JinnLockStepModifyNew:
        case JinnLockStepModifyReNew:
        {
            _passwordTemp = password;
            [self updateGuiForStep:JinnLockStepModifyAgain];
        }
            break;
        case JinnLockStepModifyAgain:
        {
            if ([password isEqualToString:_passwordTemp])
            {
                [JinnLockPassword setNewPassword:password];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidModify:)])
                {
                    [self.delegate passwordDidModify:password];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepModifyNotMatch];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepModifyReNew];
                });
            }
        }
            break;
        case JinnLockStepVerifyOld:
        case JinnLockStepVerifyReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                if ([self.delegate respondsToSelector:@selector(passwordDidVerify:)])
                {
                    [self.delegate passwordDidVerify:password];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepVerifyOldError];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepVerifyReOld];
                });
            }
        }
            break;
        case JinnLockStepRemoveOld:
        case JinnLockStepRemoveReOld:
        {
            if ([password isEqualToString:[JinnLockPassword oldPassword]])
            {
                [JinnLockPassword removePassword];
                
                if ([self.delegate respondsToSelector:@selector(passwordDidRemove)])
                {
                    [self.delegate passwordDidRemove];
                }
                
                [self hide];
            }
            else
            {
                [self updateGuiForStep:JinnLockStepRemoveOldError];
                [_sudoko showErrorPassword:password];
                [self shakeAnimationForView:_noticeLabel];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self updateGuiForStep:JinnLockStepRemoveReOld];
                });
            }
        }
            break;
        default:
            break;
    }
    
    [_indicator showPassword:password];
}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com