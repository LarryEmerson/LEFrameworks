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

#import "DJRefreshTopView.h"

@implementation DJRefreshTopView{
    UIView *container;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    //    self.backgroundColor=[UIColor colorWithWhite:0.929 alpha:0.28125];
    int screenWidth=self.bounds.size.width;
    int H=46;
    container=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideBottomCenter  Offset:CGPointZero CGSize:CGSizeMake(screenWidth, H)]];
    _activityIndicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.hidesWhenStopped=YES;
    int H2=_activityIndicatorView.bounds.size.height;
    
    UIView *aniView=[[UIView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:container Anchor:LEAnchorInsideCenter Offset:CGPointMake(-H2*1.8, 0) CGSize:CGSizeMake(H2,H2)]];
    [aniView addSubview:_activityIndicatorView];
    //
    _promptLabel=[LEUIFramework getUILabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:container Anchor:LEAnchorInsideCenter Offset:CGPointMake(NavigationBarHeight/3, 0) CGSize:CGSizeMake(screenWidth/2, container.bounds.size.height)] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:13 Font:nil Width:0 Height:0 Color:ColorBlack Line:1 Alignment:NSTextAlignmentLeft]];
    _promptLabel.backgroundColor=[UIColor clearColor];
    //
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"LEFrameworks" ofType:@"bundle"]];
    UIImage *img=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"dj_arrow_down"]];
    _imageView=[LEUIFramework getUIImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:aniView Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] Image:img];
    [self reset];
}
-(void) setOffset:(float) height{
    [container leSetOffset:CGPointMake(0, height-StatusBarHeight-NavigationBarHeight)];
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//}
///重新布局
- (void)reset {
    [super reset];
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.hidden=NO;
        [UIView animateWithDuration:0.25 animations:^{
            _imageView.transform=CGAffineTransformIdentity;
        }];
        if ([_activityIndicatorView isAnimating]) {
            [_activityIndicatorView stopAnimating];
        }
        //        _promptLabel.text=kDJRefreshTopTypeDefine;
        [_promptLabel leSetText:kDJRefreshTopTypeDefine];
    });
}

///松开可刷新
- (void)canEngageRefresh {
    [super canEngageRefresh];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        _promptLabel.text=kDJRefreshTopTypeCanRefresh;
        [_promptLabel leSetText:kDJRefreshTopTypeCanRefresh];
        [UIView animateWithDuration:0.25 animations:^{
            _imageView.transform=CGAffineTransformMakeRotation(M_PI);
        }];
    });
}

- (void)didDisengageRefresh {
    [self reset];
}

///开始刷新
- (void)startRefreshing {
    [super startRefreshing];
    dispatch_async(dispatch_get_main_queue(), ^{
        //        _promptLabel.text=kDJRefreshTopTypeRefreshing;
        [_promptLabel leSetText:kDJRefreshTopTypeRefreshing];
        _imageView.transform=CGAffineTransformIdentity;
        [_activityIndicatorView startAnimating];
        _imageView.hidden=YES;
    });
}
@end
