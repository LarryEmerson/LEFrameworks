//
//  LESegmentView.m
//  NinaPagerView
//
//  Created by emerson larry on 16/4/23.
//  Copyright © 2016年 赵富阳. All rights reserved.
//

#import "LESegmentView.h"


@interface LESegmentView ()<UIScrollViewDelegate>
@end
@implementation LESegmentView{
    int pageWidth;
    int segmentSpace;
    UIScrollView *curSegmentContainer;
    UIScrollView *curPageContainer;
    NSMutableArray *curTitlesCache;
    NSMutableArray *curTitlesWidth;
    NSMutableArray *curTitlesWidthSum;
    int segmentHeight;
    NSInteger curSelectedIndex;
    float segmentSpeed;
    UIView *curIndicator;
    UIColor *normalColor;
    UIColor *highlightedColor;
}
-(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int)segmentH Indicator:(UIImage *) indicator SegmentSpace:(int) space{
    return [self initWithTitles:titles Pages:pages ViewContainer:container SegmentHeight:segmentH Indicator:indicator SegmentSpace:space Color:LEColorGray HighlightedColor:LEColorBlack];
}
-(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentH Indicator:(UIImage *) indicator SegmentSpace:(int) space Color:(UIColor *) normal HighlightedColor:(UIColor *) high{
    normalColor=normal;
    highlightedColor=high;
    segmentHeight=segmentH;
    segmentSpace=space;
    self=[super initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:container EdgeInsects:UIEdgeInsetsZero]];
    [self setBackgroundColor:LEColorWhite];
    pageWidth=self.bounds.size.width;
    curSegmentContainer=[[UIScrollView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(pageWidth, segmentHeight)]];
    curIndicator=[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curSegmentContainer Anchor:LEAnchorInsideBottomLeft Offset:CGPointZero CGSize:CGSizeZero] Image:indicator];
    [curIndicator leSetOffset:CGPointMake(0, segmentHeight-curIndicator.bounds.size.height+0.5)];
    curPageContainer=[[UIScrollView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:container Anchor:LEAnchorOutsideBottomCenter RelativeView:curSegmentContainer Offset:CGPointZero CGSize:CGSizeMake(pageWidth, self.bounds.size.height-segmentHeight)]];
    [curPageContainer setDelegate:self];
    [curPageContainer setScrollEnabled:YES];
    [curPageContainer setBounces:NO];
    [curPageContainer setPagingEnabled:YES];
    [curSegmentContainer setShowsHorizontalScrollIndicator:NO];
    [curPageContainer setShowsHorizontalScrollIndicator:NO];
    curTitlesCache=[[NSMutableArray alloc] init];
    curTitlesWidth=[[NSMutableArray alloc] init];
    curTitlesWidthSum=[[NSMutableArray alloc] init];
    [self onSetTitles:titles];
    [self onSetPages:pages];
    return self;
}
-(void) onSetTitles:(NSArray *) titles{
    [curTitlesWidth removeAllObjects];
    [curTitlesWidthSum removeAllObjects];
    UIButton *last=nil;
    for (int i=0; i<titles.count; i++) {
        UIButton *btn=nil;
        if(i<curTitlesCache.count){
            btn=[curTitlesCache objectAtIndex:i];
            [btn setHidden:NO];
            if(last){
                [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
                [btn setTitleColor:highlightedColor forState:UIControlStateNormal];
                [btn setTitleColor:normalColor forState:UIControlStateHighlighted];
                float sum=0;
                if(curTitlesWidthSum.count>0){
                    sum=[[curTitlesWidthSum objectAtIndex:i-1] floatValue];
                }
                [curTitlesWidthSum addObject:[NSNumber numberWithFloat:sum+btn.bounds.size.width/2+last.bounds.size.width/2]];
                [curTitlesWidth addObject:@(btn.bounds.size.width/2+last.bounds.size.width/2)];
            }else{
                [btn setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
                [btn setTitleColor:normalColor forState:UIControlStateNormal];
                [btn setTitleColor:highlightedColor forState:UIControlStateHighlighted];
                [curIndicator leSetOffset:CGPointMake(btn.bounds.size.width/2-curIndicator.bounds.size.width/2, 0)];
                [curTitlesWidthSum addObject:[NSNumber numberWithFloat:btn.bounds.size.width/2]];
            }
            last=btn;
        }else{
            if(last){
                btn=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curSegmentContainer Anchor:LEAnchorOutsideRightCenter RelativeView:last Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:[titles objectAtIndex:i] FontSize:15 Font:nil Image:nil BackgroundImage:nil Color:highlightedColor SelectedColor:normalColor MaxWidth:0 SEL:@selector(onTitleTapped:) Target:self HorizontalSpace:segmentSpace]];
                float sum=0;
                if(curTitlesWidthSum.count>0){
                    sum=[[curTitlesWidthSum objectAtIndex:i-1] floatValue];
                }
                [curTitlesWidthSum addObject:[NSNumber numberWithFloat:sum+btn.bounds.size.width/2+last.bounds.size.width/2]];
                [curTitlesWidth addObject:@(btn.bounds.size.width/2+last.bounds.size.width/2)];
            }else{
                btn=[LEUIFramework leGetButtonWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:curSegmentContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointZero CGSize:CGSizeZero] ButtonSettings:[[LEAutoLayoutUIButtonSettings alloc] initWithTitle:[titles objectAtIndex:i] FontSize:15 Font:nil Image:nil BackgroundImage:nil Color:normalColor SelectedColor:highlightedColor MaxWidth:0 SEL:@selector(onTitleTapped:) Target:self HorizontalSpace:segmentSpace]];
                [curIndicator leSetOffset:CGPointMake(btn.bounds.size.width/2-curIndicator.bounds.size.width/2, 0)];
                [curTitlesWidthSum addObject:[NSNumber numberWithFloat:btn.bounds.size.width/2]];
            }
            last=btn;
            [curTitlesCache addObject:btn];
        }
    }
    for (NSInteger i=titles.count; i<curTitlesCache.count; i++) {
        [[curTitlesCache objectAtIndex:i] setHidden:YES];
    }
    float finalWidth=last.frame.origin.x+last.frame.size.width;
    if(finalWidth<pageWidth&&titles.count>1){
        last=nil;
        UIButton *btn=nil;
        int size=pageWidth*1.0/titles.count;
        [curTitlesWidth removeAllObjects];
        [curTitlesWidthSum removeAllObjects];
        for (int i=0; i<curTitlesCache.count; i++) {
            [[curTitlesCache objectAtIndex:i] leSetSize:CGSizeMake(size, segmentHeight)];
            btn=[curTitlesCache objectAtIndex:i];
            if(last){
                float sum=0;
                if(curTitlesWidthSum.count>0){
                    sum=[[curTitlesWidthSum objectAtIndex:i-1] floatValue];
                }
                [curTitlesWidthSum addObject:[NSNumber numberWithFloat:sum+btn.bounds.size.width/2+last.bounds.size.width/2]];
                [curTitlesWidth addObject:@(btn.bounds.size.width/2+last.bounds.size.width/2)];
            }else{
                [curIndicator leSetOffset:CGPointMake(btn.bounds.size.width/2-curIndicator.bounds.size.width/2, 0)];
                [curTitlesWidthSum addObject:[NSNumber numberWithFloat:btn.bounds.size.width/2]];
            }
            last=btn;
        }
        finalWidth=pageWidth;
    }
    [curTitlesWidth addObject:@(0)];
    segmentSpeed=(finalWidth-pageWidth)*1.0/(pageWidth*(titles.count-1));
    [curSegmentContainer setContentSize:CGSizeMake(finalWidth, curSegmentContainer.bounds.size.height)];
} 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index=scrollView.contentOffset.x/pageWidth;
    float widthSum=[[curTitlesWidthSum objectAtIndex:index] floatValue];
    float width=[[curTitlesWidth objectAtIndex:index] floatValue];
    float indicatorOffset=widthSum+(scrollView.contentOffset.x/pageWidth-index)*width-curIndicator.bounds.size.width/2;
    [curIndicator leSetOffset:CGPointMake(indicatorOffset, curIndicator.leAutoLayoutSettings.leOffset.y)];
    //
    index=MIN(index, curSelectedIndex);
    BOOL checkLeft=index<curSelectedIndex;
    float sumW=[[curTitlesWidthSum objectAtIndex:curSelectedIndex] floatValue];
    float curHalfW=[[curTitlesCache objectAtIndex:curSelectedIndex] bounds].size.width/2;
    NSInteger finalIndex=curSelectedIndex;
    if(checkLeft&&curIndicator.frame.origin.x<sumW-curHalfW){
        finalIndex=finalIndex-1;
    }else if(!checkLeft&&curIndicator.frame.origin.x>sumW+curHalfW){
        finalIndex=finalIndex+1;
    }
    finalIndex=MIN(MAX(finalIndex, 0), curTitlesCache.count-1);
    float W=[[curTitlesCache objectAtIndex:curSelectedIndex] bounds].size.width;
    float mid=curIndicator.frame.origin.x+curIndicator.frame.size.width/2-curSegmentContainer.contentOffset.x;
    float segStartX=mid-W/2.0;
    float segEndX=mid+W/2.0-pageWidth;
    if(segStartX<=0){
        [curSegmentContainer setContentOffset:CGPointMake(curSegmentContainer.contentOffset.x+segStartX, 0)];
    }else if(segEndX>=0){
        [curSegmentContainer setContentOffset:CGPointMake(curSegmentContainer.contentOffset.x+segEndX, 0)];
    } 
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    curSelectedIndex = scrollView.contentOffset.x/pageWidth;
    [self onChangeTitleState];
    float segStartX=[[curTitlesCache objectAtIndex:curSelectedIndex] frame].origin.x;
    float segEndX=segStartX+[[curTitlesCache objectAtIndex:curSelectedIndex] bounds].size.width;
    float segOffset=curSegmentContainer.contentOffset.x;
    float leftSpace=segStartX-segOffset;
    float rightSpace=(segEndX-segOffset)-pageWidth;
    if(leftSpace<0){
        [curSegmentContainer setContentOffset:CGPointMake(curSegmentContainer.contentOffset.x+leftSpace, 0) animated:YES ];
    }else if(rightSpace>0){
        [curSegmentContainer setContentOffset:CGPointMake(curSegmentContainer.contentOffset.x+rightSpace, 0) animated:YES ];
    }
}
-(void) onTitleTapped:(UIButton *) button{
    curSelectedIndex=[curTitlesCache indexOfObject:button];
    [curPageContainer setContentOffset:CGPointMake(pageWidth*curSelectedIndex, 0)];
    [self onChangeTitleState];
}
-(void) onChangeTitleState{
    for (int i=0; i<curTitlesCache.count; i++) {
        UIButton *btn=[curTitlesCache objectAtIndex:i];
        [btn setTitleColor:i==curSelectedIndex?normalColor:highlightedColor forState:UIControlStateNormal];
    }
}
-(void) onSetPages:(NSArray *) pages{
    [curPageContainer setContentSize:CGSizeMake(pages.count*pageWidth, self.bounds.size.height-segmentHeight)];
    for (int i=0; i<pages.count; i++) {
        UIView *view=[pages objectAtIndex:i];
        [curPageContainer addSubview:view];
        [view setFrame:CGRectMake(pageWidth*i, 0, pageWidth, curPageContainer.bounds.size.height)];
    }
}
@end
