//
//  DJRefresh.h
//
//  Copyright (c) 2014 YDJ ( https://github.com/ydj/DJRefresh )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "DJRefreshBottomView.h"

@implementation DJRefreshBottomView{
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

- (void)setup{
    self.backgroundColor=[UIColor colorWithRed:237.0/255.0 green:237.0/255.0 blue:237.0/255.0 alpha:237.0/255.0];
    int screenWidth=self.bounds.size.width;
    int H=46;
    UIView *container=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter  Offset:CGPointZero CGSize:CGSizeMake(screenWidth, H)]]; 
    
    _activityIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.hidesWhenStopped=YES;
    int H2=_activityIndicatorView.bounds.size.height;
    
    UIView *aniView=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:container Anchor:LEAnchorInsideCenter Offset:CGPointMake(-H2*2, 0) CGSize:CGSizeMake(H2,H2)]];
    [aniView addSubview:_activityIndicatorView];
    
    _promptLabel=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:container Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:13 Font:nil Width:0 Height:0 Color:ColorBlack Line:1 Alignment:NSTextAlignmentLeft]];
    _promptLabel.backgroundColor=[UIColor clearColor];
    //
    [self reset];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
///重新布局
- (void)reset{
    [super reset];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_activityIndicatorView isAnimating]) {
            [_activityIndicatorView stopAnimating];
        }
//        _promptLabel.text=kDJRefreshBottomTypeDefine;
        [_promptLabel leSetText:kDJRefreshTopTypeDefine];
        [_promptLabel leSetOffset:CGPointZero];
    });
}
///松开可刷新
- (void)canEngageRefresh{
    [super canEngageRefresh];
//    _promptLabel.text=kDJRefreshBottomTypeCanRefresh;
    [_promptLabel leSetText:kDJRefreshTopTypeCanRefresh];
}
- (void)didDisengageRefresh{
    [self reset];
}
///开始刷新
- (void)startRefreshing{
    [super startRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
//        _promptLabel.text=kDJRefreshBottomTypeRefreshing;
        [_promptLabel leSetText:kDJRefreshTopTypeRefreshing];
        [self.activityIndicatorView startAnimating];
        [_promptLabel leSetOffset:CGPointMake(10, 0)];
    });
} 
@end
