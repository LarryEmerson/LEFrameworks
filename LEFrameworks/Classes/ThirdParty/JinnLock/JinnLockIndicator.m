/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockIndicator.m
 ** Description: 解锁密码小指示器
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#import "JinnLockIndicator.h"
#import "JinnLockConfig.h"
#import "JinnLockCircle.h"

@interface JinnLockIndicator ()

@property (nonatomic, strong) NSMutableArray *circleArray;
@property (nonatomic, strong) NSMutableArray *selectedCircleArray;
@property (nonatomic, assign) CGFloat circleMargin;

@end

@implementation JinnLockIndicator

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self initCircles];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    _circleArray = [NSMutableArray array];
    _selectedCircleArray = [NSMutableArray array];
    _circleMargin = JINN_LOCK_INDICATOR_SIDE_LENGTH / 15;
}

- (void)initCircles
{
    for (int i = 0; i < 9; i++)
    {
        float x = _circleMargin * (4.5 * (i % 3) + 1.5);
        float y = _circleMargin * (4.5 * (i / 3) + 1.5);
        
        JinnLockCircle *circle = [[JinnLockCircle alloc] initWithDiameter:_circleMargin * 3];
        circle.tag = JINN_LOCK_INDICATOR_LEVEL_BASE + i;
        [circle setFrame:CGRectMake(x, y, _circleMargin * 3, _circleMargin * 3)];
        [_circleArray addObject:circle];
        [self addSubview:circle];
    }
}

#pragma mark - Public

- (void)showPassword:(NSString *)password
{
    [self reset];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:password.length];
    for (int i = 0; i < password.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [password substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [_circleArray[number.intValue] updateCircleState:JinnLockCircleStateFill];
        [_selectedCircleArray addObject:_circleArray[number.intValue]];
    }
    
    [self setNeedsDisplay];
}

- (void)reset
{
    for (JinnLockCircle *circle in _circleArray)
    {
        [circle updateCircleState:JinnLockCircleStateNormal];
    }

    [_selectedCircleArray removeAllObjects];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    if (_selectedCircleArray.count == 0)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JINN_LOCK_INDICATOR_TRACK_WIDTH);
    [JINN_LOCK_COLOR_NORMAL set];
    
    CGPoint addLines[9];
    int count = 0;
    for (JinnLockCircle *circle in _selectedCircleArray)
    {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com