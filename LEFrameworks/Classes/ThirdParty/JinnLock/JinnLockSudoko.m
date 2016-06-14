/*******************************************************************************
 ** Copyright © 2016年 Jinnchang. All rights reserved.
 ** Giuhub: https://github.com/jinnchang
 **
 ** FileName: JinnLockSudoko.m
 ** Description: 解锁九宫格视图
 **
 ** History
 ** ----------------------------------------------------------------------------
 ** Author: Jinnchang
 ** Date: 2016-01-26
 ** Description: 创建文件
 ******************************************************************************/

#import "JinnLockSudoko.h"
#import "JinnLockConfig.h"
#import "JinnLockCircle.h"

@interface JinnLockSudoko ()

@property (nonatomic, strong) NSMutableArray *circleArray;
@property (nonatomic, strong) NSMutableArray *selectedCircleArray;
@property (nonatomic, assign) CGFloat circleMargin;
@property (nonatomic, assign) CGPoint currentPoint;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign, getter = isErrorPassword) BOOL errorPassword;
@property (nonatomic, assign, getter = isDrawing) BOOL drawing;

@end

@implementation JinnLockSudoko

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
    _circleMargin = JINN_LOCK_SUDOKO_SIDE_LENGTH / 15;
}

#pragma mark - Public

- (void)initCircles
{
    for (int i = 0; i < 9; i++)
    {
        float x = _circleMargin * (4.5 * (i % 3) + 1.5);
        float y = _circleMargin * (4.5 * (i / 3) + 1.5);
        
        JinnLockCircle *circle = [[JinnLockCircle alloc] initWithDiameter:_circleMargin * 3];
        circle.tag = JINN_LOCK_SUDOKO_LEVEL_BASE + i;
        [circle setFrame:CGRectMake(x, y, _circleMargin * 3, _circleMargin * 3)];
        [_circleArray addObject:circle];
        [self addSubview:circle];
    }
}

- (void)showErrorPassword:(NSString *)errorPassword
{
    _errorPassword = YES;
    
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:errorPassword.length];
    
    for (int i = 0; i < errorPassword.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [errorPassword substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [_circleArray[number.intValue] updateCircleState:JinnLockCircleStateError];
        [_selectedCircleArray addObject:_circleArray[number.intValue]];
    }
    
    [self setNeedsDisplay];
    
    if (!_timer)
    {
        [_timer invalidate];
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(reset)
                                            userInfo:nil
                                             repeats:NO];
}

- (void)reset
{
    if (!_drawing)
    {
        _errorPassword = NO;
        
        for (JinnLockCircle *circle in _circleArray)
        {
            [circle updateCircleState:JinnLockCircleStateNormal];
        }
        
        [_selectedCircleArray removeAllObjects];
        [self setNeedsDisplay];
    }
}

#pragma mark - Private

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _drawing = NO;
    
    if (_errorPassword)
    {
        [self reset];
    }
    
    [self updateTrack:[[touches anyObject] locationInView:self]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _drawing = YES;
    
    [self updateTrack:[[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrack];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endTrack];
}

- (void)updateTrack:(CGPoint)point
{
    self.currentPoint = point;
    
    for (JinnLockCircle *circle in _circleArray)
    {
        CGFloat xABS = fabs(point.x - circle.center.x);
        CGFloat yABS = fabs(point.y - circle.center.y);
        
        CGFloat radius = _circleMargin * 3 / 2;
        
        if (xABS <= radius && yABS <= radius)
        {
            if (circle.state == JinnLockCircleStateNormal)
            {
                [circle updateCircleState:JinnLockCircleStateSelected];
                
                [_selectedCircleArray addObject:circle];
            }
            
            break;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)endTrack
{
    _drawing = NO;
    
    NSString *password = @"";
    for (int i = 0; i < _selectedCircleArray.count; i++)
    {
        JinnLockCircle *circle = _selectedCircleArray[i];
        password = [password stringByAppendingFormat:@"%d", (int)(circle.tag - JINN_LOCK_SUDOKO_LEVEL_BASE)];
    }
    
    [self reset];
    
    if ([_delegate respondsToSelector:@selector(sudoko:passwordDidCreate:)])
    {
        [_delegate sudoko:self passwordDidCreate:password];
    }
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    if (_selectedCircleArray.count == 0)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, JINN_LOCK_SUDOKO_TRACK_WIDTH);
    _errorPassword ? [JINN_LOCK_COLOR_ERROR set] : [JINN_LOCK_COLOR_NORMAL set];
    
    CGPoint addLines[9];
    int count = 0;
    for (JinnLockCircle *circle in _selectedCircleArray)
    {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
    
    if (!_errorPassword)
    {
        UIButton* lastButton = _selectedCircleArray.lastObject;
        CGContextMoveToPoint(context, lastButton.center.x, lastButton.center.y);
        CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);
        CGContextStrokePath(context);
    }
}

@end// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com