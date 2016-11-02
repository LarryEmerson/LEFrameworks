//
//  wiEmojiInputView.m
//  wiIos
//
//  Created by qq on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmojiInputView.h"

// 人物
#define Emoji_People_key    @"People"
#define Emoji_People5_key    @"People_5"
// 物品
#define Emoji_Objects_key   @"Objects"
// 自然
#define Emoji_Nature_key    @"Nature"
// 地点
#define Emoji_Places_key    @"Places"
// 符号
#define Emoji_Symbols_key   @"Symbols"

@interface EmojiInputView ()
- (void)changeEmojiCategory:(UIButton *)btn;
- (void)drawInputView:(EMOJI_TYPE)emojiType;
- (void)loadScrollViewWithPage:(int)page;

@end


@implementation EmojiInputView
@synthesize delegate = _delegate;

@synthesize m_EmojiDic;
@synthesize m_EmojiCodeArray;
@synthesize m_EmojiViews;
@synthesize m_BtnArray;

- (void)dealloc
{
    //    [m_EmojiDic release];
    //    [m_EmojiViews release];
    //    [m_EmojiCodeArray release];
    //    [m_BtnArray release];
    //    
    //    [super dealloc];
}

- (NSDictionary *)makeEmojisDic
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"EmojisList"
                                                          ofType:@"plist"];
    self.m_EmojiDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    return m_EmojiDic;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"LEFrameworks" ofType:@"bundle"]];
        // Initialization code
        self.frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, 216);
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 162)];
        bgImageView.image = [[[UIImage alloc] initWithContentsOfFile:[bundle pathForResource:@"emoji_keybord_bg" ofType:@"png"]] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        [self addSubview:bgImageView];
        //[bgImageView release];
        
        UIView *bottomImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 162, UI_SCREEN_WIDTH, 54)];
        bottomImageView.userInteractionEnabled = YES;
        [self addSubview:bottomImageView];
        //[bottomImageView release];
        
        NSArray *imagesForSelect = @[
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_face_sicon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_bell_sicon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_flower_sicon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_car_sicon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_characters_sicon"]]
                                     ];
        
        NSArray *imagesForNormal = @[
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_face_icon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_bell_icon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_flower_icon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_car_icon"]],
                                     [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_characters_icon"]]
                                     ];
        
        self.m_BtnArray = [NSMutableArray arrayWithCapacity:0];
        
        CGFloat width = (UI_SCREEN_WIDTH-80)/5;
        UIImage *imgKeyboardBG=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_icon_bg"]] ;
        UIImage *imgKeyboardSBG=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_icon_sbg"]] ;
        UIImage *imgSwitch=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_switch_icon"]] ;
        UIImage *imgSwitchS=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_switch_sicon"]] ;
        UIImage *imgDelete=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_delete_icon"]] ;
        UIImage *imgDeleteS=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_keybord_delete_sicon"]] ;
        UIImage *imgDot=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_page_dot"]] ;
        UIImage *imgDots=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_page_dot_active"]] ;
        for (int i = 0 ; i < imagesForNormal.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(40+i*width, 0, width, 54);
            [btn addTarget:self action:@selector(changeEmojiCategory:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [btn setImage:[imagesForNormal objectAtIndex:i] forState:UIControlStateNormal];
            [btn setBackgroundImage:imgKeyboardBG forState:UIControlStateNormal];
            [btn setImage:[imagesForSelect objectAtIndex:i] forState:UIControlStateSelected];
            [btn setBackgroundImage:imgKeyboardSBG forState:UIControlStateSelected];
            [bottomImageView addSubview:btn];
            
            [m_BtnArray addObject:btn];
        }
        
        UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        lbtn.frame = CGRectMake(0, 0, 40, 54);
        [lbtn addTarget:self action:@selector(switchEmoji:) forControlEvents:UIControlEventTouchUpInside];
        [lbtn setImage:imgSwitch forState:UIControlStateNormal];
        [lbtn setImage:imgSwitchS forState:UIControlStateHighlighted];
        [bottomImageView addSubview:lbtn];
        
        UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rbtn.frame = CGRectMake(UI_SCREEN_WIDTH-40, 0, 40, 54);
        [rbtn addTarget:self action:@selector(deleteEmoji:) forControlEvents:UIControlEventTouchUpInside];
        [rbtn setImage:imgDelete forState:UIControlStateNormal];
        [rbtn setImage:imgDeleteS forState:UIControlStateHighlighted];
        [bottomImageView addSubview:rbtn];
        
        s_ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, EMOJI_VIEW_HEIGHT)];
        s_ScrollView.pagingEnabled = YES;
        s_ScrollView.delegate = self;
        s_ScrollView.showsHorizontalScrollIndicator = NO;
        s_ScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:s_ScrollView];
        //[s_ScrollView release];
        
        s_PageControl = [[HMPageControl alloc] init];
        
        if (IOS_VERSION >= 6.0)
        {
            s_PageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.67 green:0.67 blue:0.67 alpha:1.0];
            s_PageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
        }
        else
        {
            s_PageControl.imagePageStateNormal =imgDot;
            s_PageControl.imagePageStateHighlighted = imgDots;
        }
        
        s_PageControl.frame = CGRectMake(0, EMOJI_VIEW_HEIGHT, UI_SCREEN_WIDTH, 10);
        [s_PageControl addTarget:self action:@selector(clickpagecontrol:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:s_PageControl];
        //[s_PageControl release];
        
        s_CurrentCategory = -1;
        
        [self makeEmojisDic];
    }
    
    return self;
}

/** // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)deleteEmoji:(UIButton *)btn
{
    [_delegate deleteEmoji];
}

- (void)switchEmoji:(UIButton *)btn
{
    [_delegate switchEmojiInputView];
}

- (void)changeEmojiCategoryByIndex:(EMOJI_TYPE)emojiType
{
    UIButton *sbtn = [m_BtnArray objectAtIndex:emojiType];
    
    [self changeEmojiCategory:sbtn];
}

- (void)changeEmojiCategory:(UIButton *)btn
{
    if (s_CurrentCategory == btn.tag)
    {
        return;
    }
    
    for (int i = 0; i < m_BtnArray.count; i++)
    {
        UIButton *sbtn = [m_BtnArray objectAtIndex:i];
        sbtn.selected = NO;
    }
    
    btn.selected = YES;
    [self drawInputView:(EMOJI_TYPE)btn.tag];
}

- (void)drawInputView:(EMOJI_TYPE)emojiType
{
    NSArray *keyArray;
    
    s_CurrentCategory = emojiType;
    
    if (IOS_VERSION >= 6.0)
    {
        keyArray = @[Emoji_People_key, Emoji_Objects_key, Emoji_Nature_key, Emoji_Places_key, Emoji_Symbols_key];
    }
    else
    {
        keyArray = @[Emoji_People5_key, Emoji_Objects_key, Emoji_Nature_key, Emoji_Places_key, Emoji_Symbols_key];
    }
    
    self.m_EmojiCodeArray = [m_EmojiDic objectForKey:[keyArray objectAtIndex:emojiType]];
    
    NSInteger pageCount = m_EmojiCodeArray.count / EMOJI_ONEPAGE_COUNT;
    if (m_EmojiCodeArray.count % EMOJI_ONEPAGE_COUNT > 0)
    {
        pageCount++;
    }
    
    [m_EmojiViews removeAllObjects];
    
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < pageCount; i++)
    {
        [views addObject:[NSNull null]];
    }
    self.m_EmojiViews = views;
    //[views release];
    
    // 先初始化PageControl，否则scrollViewDidScroll后m_EmojiViews的index有可能溢出
    NSInteger currentPage = 0;
    s_PageControl.numberOfPages = pageCount;
    s_PageControl.currentPage = currentPage;
    
    if (s_ScrollView != nil)
    {
        //[s_ScrollView removeAllSubviews];
        while (s_ScrollView.subviews.count > 0)
        {
            UIView* child = s_ScrollView.subviews.lastObject;
            [child removeFromSuperview];
        }
    }
    
    s_ScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH * pageCount, EMOJI_VIEW_HEIGHT);
    
    [self loadScrollViewWithPage:(int)currentPage];
    s_ScrollView.contentOffset = CGPointMake(UI_SCREEN_WIDTH * currentPage, 0);
}


- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    
    if (page >= s_PageControl.numberOfPages)
        return;
    
    // replace the placeholder if necessary
    EmojiImagePageView *view = [m_EmojiViews objectAtIndex:page];
    if ((NSNull *)view == [NSNull null])
    {
        view = [[EmojiImagePageView alloc] initWithEmojiArray:m_EmojiCodeArray];
        view.delegate = self;
        [m_EmojiViews replaceObjectAtIndex:page withObject:view];
        //[view release];
    }
    
    // add the controller's view to the scroll view
    if (view.superview == nil)
    {
        CGRect frame = s_ScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        view.frame = frame;
        [s_ScrollView addSubview:view];
        [view drawPageAtIndex:page];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (s_PageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = s_ScrollView.frame.size.width;
    int page = floor((s_ScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    s_PageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    s_PageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    s_PageControlUsed = NO;
}

- (void)clickpagecontrol:(id)sender
{
    int page = (int)s_PageControl.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // update the scroll view to the appropriate page
    CGRect frame = s_ScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [s_ScrollView scrollRectToVisible:frame animated:YES];
    
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    s_PageControlUsed = YES;
}

- (void)selectedEmojiatIndex:(NSInteger)index
{
    [self.delegate setEmojiFromEmojiInputView:[m_EmojiCodeArray objectAtIndex:index]];
}

@end

/** // 使用举例
 
 EmojiInputView *emojiInputView = [[[EmojiInputView alloc] init] autorelease];
 [emojiInputView changeEmojiCategoryByIndex:EMOJI_CATEGORY_MOOD];
 emojiInputView.delegate = self;
 m_EmailTextField.inputView = emojiInputView;
 
 #pragma mark -
 #pragma mark EmojiInputViewDelegate
 
 - (void)switchEmojiInputView
 {
 m_EmailTextField.inputView = nil;
 [m_EmailTextField reloadInputViews];
 }
 
 - (void)setEmojiFromEmojiInputView:(NSString *)emojiStr
 {
 [m_EmailTextField insertText:emojiStr];
 }
 
 - (void)deleteEmoji
 {
 [m_EmailTextField deleteBackward];
 }
 */