//
//  wiEmojiImagePageView.m
//  wiIos
//
//  Created by qq on 12-6-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmojiImagePageView.h"

@implementation EmojiImagePageView
@synthesize delegate;
@synthesize m_EmojiCodeArray;

- (id)initWithEmojiArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        // Initialization code
        CGRect frame = CGRectMake(0, 0, UI_SCREEN_WIDTH, EMOJI_VIEW_HEIGHT);
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        
        self.m_EmojiCodeArray = array;
    }
    
    return self;
}

- (void)dealloc
{
    //    [m_EmojiCodeArray release];
    //    
    //    [super dealloc];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)drawPageAtIndex:(NSInteger)index
{
    CGFloat leftGap = EMOJI_LEFTGAP;
    CGFloat topGap = EMOJI_TOPGAP;
    CGFloat width = EMOJI_WIDTH;
    CGFloat height = EMOJI_HEIGHT;
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"LEFrameworks" ofType:@"bundle"]];
    UIImage *img=[[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png",bundle.bundlePath,@"emoji_btn_hbg"]];
    //row number
    for (int i = 0; i < EMOJI_LINE; i++)
    {
        //column numer
        for (int j = 0; j < EMOJI_ONELINE_COUNT; j++)
        {
            if (i * EMOJI_ONELINE_COUNT + j + index * EMOJI_ONEPAGE_COUNT >= [m_EmojiCodeArray count])
            {
                return;
            }
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            button.titleLabel.font = [UIFont fontWithName:@"AppleColorEmoji" size:30.0f];
            [button setTitle:[m_EmojiCodeArray objectAtIndex:i * EMOJI_ONELINE_COUNT + j + index * EMOJI_ONEPAGE_COUNT] forState:UIControlStateNormal];
            [button setBackgroundImage:img forState:UIControlStateHighlighted];
            [button setFrame:CGRectMake(leftGap + j * width, topGap + i * height, width, height)];
            button.tag = i*EMOJI_ONELINE_COUNT+j+(index*EMOJI_ONEPAGE_COUNT);
            [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(8, 0, 0, 0)];
            [self addSubview:button];
        }
    }
}

-(void)selected:(UIButton*)button
{
    //    NSString *str = [m_EmojiCodeArray objectAtIndex:button.tag];
    
    [self.delegate selectedEmojiatIndex:button.tag];
}


@end
