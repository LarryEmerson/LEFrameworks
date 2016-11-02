# LEFrameworks
IOS Development Frameworks 持续更新中 

## Installation

LEFrameworks is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
platform :ios, '7.0'
target "ProjectName” do 
pod "LEFrameworks"
end 
```

### 导入头文件
```
 #import <LEFrameworks/LEFrameworks.h>
```

# 2016-10-18 推出 自动排版V2
特点：

1- 一行生成UI控件：view、UILabel、UIImageView、UIButton、UITextfield

2- 自动排版

3- 每行最后需要追加方法leAutoLayout，逻辑是根据之前的设置进行排版

gif演示：

![](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LEUIFrameworkExtra.gif)

主要接口：
```
/**
 设置父view，配合leAnchor。
 */
-(void) leSuperView:(UIView *) view;
/**
 设置参照view。等同父view时可忽略。配合leAnchor，参照view为父view时使用LEAnchorInside，否则使用LEAnchorOutside
 */
-(void) leRelativeView:(UIView *) view;
/**
 设置对齐方式，配合leRelativeView参照view使用。参照view为父view时使用LEAnchorInside，否则使用LEAnchorOutside
 */
-(void) leAnchor:(LEAnchors) anchor;
/**
 设置与参照view的偏移量。左:-x,右:x,上:-y,下:y
 */
-(void) leOffset:(CGPoint) offset;
/**
 设置view的size。Label、image、button的设置可能会失效。
 */
-(void) leSize:(CGSize) size;
/**
 设置内嵌于父view时的edgeInsects。设置后无需设置leAnchor、leOffset及leSize
 */
-(void) leEdgeInsects:(UIEdgeInsets) edgeInsects;
/**
 设置背景色。
 */
-(void) leBackground:(UIColor *) color;
/**
 根据提供条件排版
 */
-(UIView *) leAutoLayout;
/**
 设置是否运行用户交互
 */
-(void) leUserInteraction:(BOOL) enable;
/**
 为了去除类型的警告，进行类型适配。
 */
-(id) leType;
/**
 等同于 leExtraInits+leType。使用情况：view比较复杂，初始化时需要执行并且已经实现了leExtraInits
 */
-(id) leInitSelf;
/**
 给当前view添加tap事件，如果是button走addTarget方式
 */
-(void) leTapEvent:(SEL) sel Target:(id) target;
/**
 设置view的圆角
 */
-(void) leRoundCorner:(CGFloat) radius;
#pragma mark Common settings
/**
 设置文字，用于label、textfield、button
 */
-(void) leText:(NSString *) text;
/**
 设置文号，用于label、textfield、button
 */
-(void) leFont:(UIFont *) font;
/**
 设置view最大宽度，用于所有
 */
-(void) leWidth:(CGFloat) width;
/**
 设置view最大高度，用于所有
 */
-(void) leHeight:(CGFloat) height;
/**
 设置颜色，用于label、textfield、button的normal未选中状态文字颜色
 */
-(void) leColor:(UIColor *) color;
/**
 设置对齐方式，用于label、textfield
 */
-(void) leAlignment:(NSTextAlignment) alignment;
/**
 设置image，用于imageview或button的normal状态的image
 */
-(void) leImage:(UIImage *) image;
#pragma mark label
/**
 设置文字行数
 */
-(void) leLine:(int) line;
/**
 设置文字行间距
 */
-(void) leLineSpace:(CGFloat) linespace;
#pragma mark _Button
/**
 设置选中状态的image
 */
-(void) leImageHighlighted:(UIImage *) image;
/**
 设置未选中状态的背景图backgroundimage
 */
-(void) leBackgroundImage:(UIImage *) image;
/**
 设置选中状态的背景图backgroundimage
 */
-(void) leBackgroundImageHighlighted:(UIImage *) image;
/**
 设置选中状态的文字颜色
 */
-(void) leHighlightedColor:(UIColor *) color;
/**
 设置选中状态的image
 */
-(void) leButtonHorizontalEdgeInsects:(int) gap;
#pragma mark _TextField
/**
 设置文字占位符
 */
-(void) lePlaceHolder:(NSString *) placeHolder;
/**
 设置键盘右下角按钮样式
 */
-(void) leRetureType:(UIReturnKeyType) returnType;
/**
 设置textfield的delegate
 */
-(void) leDelegateOfTextField:(id<UITextFieldDelegate>) delegateOfTextField;
```
Demo代码示例：
```
    UIView *BG=[UIView new].leSuperView(view.leViewBelowCustomizedNavigation).leEdgeInsects(UIEdgeInsetsMake(10, 10, 10, 10)).leBackground(LEColorMask).leRoundCorner(8).leAutoLayout;
    autoLayoutLabel=[UILabel new].leSuperView(BG).leAnchor(LEAnchorInsideTopCenter).leOffset(CGPointMake(0, LELayoutSideSpace)).leSize(CGSizeMake(BG.bounds.size.width-LELayoutSideSpace, 0)).leWidth(BG.bounds.size.width-LELayoutSideSpace).leAlignment(NSTextAlignmentCenter).leFont(LEFont(LELayoutFontSize14)).leColor([UIColor colorWithRed:0.0879 green:0.6668 blue:0.079 alpha:1.0]).leAutoLayout.leType;
    UIView *split=[UIView new].leSuperView(BG).leRelativeView(autoLayoutLabel).leAnchor(LEAnchorOutsideBottomCenter).leOffset(CGPointMake(0, LELayoutSideSpace)).leBackground(LEColorBlack).leSize(CGSizeMake(BG.bounds.size.width-LELayoutSideSpace, 1)).leAutoLayout;
    UIButton *btnLeft=[UIButton new].leSuperView(BG).leRelativeView(split).leAnchor(LEAnchorOutsideBottomLeft).leOffset(CGPointMake(LELayoutSideSpace, LELayoutSideSpace)).leBackgroundImage([LEColorBlue leImageStrechedFromSizeOne]).leBackgroundImageHighlighted([LEColorMask leImageStrechedFromSizeOne]).leColor(LEColorWhite).leHighlightedColor(LEColorTextGray).leText(@"左侧按钮追加").leTapEvent(@selector(onClickForAppenddingPathComponent),self).leAutoLayout.leType;
    [[UIButton new].leSuperView(BG).leRelativeView(split).leAnchor(LEAnchorOutsideBottomRight).leOffset(CGPointMake(-LELayoutSideSpace, LELayoutSideSpace)).leBackgroundImage([LEColorRed leImageStrechedFromSizeOne]).leBackgroundImageHighlighted([LEColorMask leImageStrechedFromSizeOne]).leColor(LEColorWhite).leHighlightedColor(LEColorTextGray).leText(@"右侧按钮删除").leTapEvent(@selector(onClickForDeletingLastPathComponent),self).leAutoLayout leExecAutoLayout];
    UIView *viewGroup=[UIView new].leSuperView(BG).leRelativeView(btnLeft).leAnchor(LEAnchorOutsideBottomLeft).leSize(CGSizeMake(BG.bounds.size.width-LELayoutSideSpace*3, 80)).leOffset(CGPointMake(0, LELayoutSideSpace)).leBackground(LEColorWhite).leRoundCorner(8).leAutoLayout;
    [[UIButton new].leSuperView(viewGroup).leEdgeInsects(UIEdgeInsetsZero).leTapEvent(@selector(onClickForDeletingLastPathComponent),self).leBackgroundImageHighlighted([LEColorMask leImageStrechedFromSizeOne]).leAutoLayout leExecAutoLayout];
    UIImageView *icon=[UIImageView new].leSuperView(viewGroup).leAnchor(LEAnchorInsideLeftCenter).leOffset(CGPointMake(LELayoutSideSpace, 0)).leSize(LESquareSize(viewGroup.bounds.size.height-LELayoutSideSpace*2)).leBackground(LEColorMask2).leUserInteraction(YES).leRoundCorner(6).leAutoLayout.leType;
    UIButton *iconTap=[UIButton new].leSuperView(icon).leEdgeInsects(UIEdgeInsetsZero).leAutoLayout.leType;
    [iconTap leSetForTapEventWithSel:@selector(onClickForAppenddingPathComponent) Target:self];
    autoLayoutMultiLineLabel=[UILabel new].leSuperView(viewGroup).leRelativeView(icon).leAnchor(LEAnchorOutsideRightTop).leOffset(CGPointMake(LELayoutSideSpace, 0)).leLine(2).leWidth(viewGroup.bounds.size.width-LELayoutSideSpace*3-icon.bounds.size.width).leFont(LEBoldFont(LELayoutFontSize14)).leAutoLayout.leType;
    [[UILabel new].leSuperView(viewGroup).leRelativeView(icon).leAnchor(LEAnchorOutsideRightBottom).leOffset(CGPointMake(LELayoutSideSpace, 0)).leColor(LEColorTextGray).leText(@"副标题").leAutoLayout leExecAutoLayout];
    
```


## LEBaseTableViewV2 优化列表滚动效果，大大增强滚动流畅性
	16-09-07 在研究了开发者LiuWei（https://github.com/waynezxcv/LWAsyncDisplayView）的Gallop，主要是朋友圈模块后，顿然醒悟，原来Cell中的内容可以提前预加载并缓存，以空间换时间的概念，避免列表滚动过程中的计算，大大提高性能，列表滚动的流畅性。
	
	能发现Gallop并非偶然，最近刚完成的项目中就有朋友圈模块。于是完成LEBaseTableViewV2立马开始优化工作。
	
	优化工作非常简单，前提是列表继承LEBaseTableView：
	
	1-替换原有的LEBaseTableView为LEBaseTableViewV2
	2-对应的Cell继承类从LEBaseTableViewCell换成LEBaseTableViewDisplayCell，并且把-(void) leSetData:(id) data IndexPath:(NSIndexPath *) path换成-(void) leSetData:(id) data
	
	当然如果列表Section>1，这种情况优化工作就不仅仅是替换这么简单了，得看列表具体情况。主要是复写tb的delegate及datasource。
	
	Demo工程中首页右上角新增了一个switch，用于切换列表的加载方式，默认使用了LEBaseTableViewV2。具体优化效果，还需要真机测试，Cell越复杂对比越明显！



## 新增Demo工程于Example目录下，Demo的gif

![](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LEFrameworks.gif)

### 关于库中导航栏处理说明：

		之前因为使用第三方库的原因不得不使用UINavigationController，从而表示之后不再自定义导航栏，但是后期发现系统导航栏自定义实在是不方便，同时考虑到界面跳转最合理的方式还是使用系统导航栏提供的push方式。现提出的方案是：应用导航栏隐藏，界面拉伸到全屏。导航栏处理则使用LEBaseNavigation来自定义。界面跳转则还是使用导航栏的push、pop方式。这样既可以自定义导航栏，也可以在特殊需求时使用系统导航栏，方式灵活。
		另外，目前为NSobject提供了一个隐式的方法leExtraInits，这个方法的定义是，凡是在初始化后需要做进一步初始化时统一使用这个方法。目前所有的View，凡是使用initWithAutoLayoutSettings初始化的都已经自动执行了该方法。

一、组件封装：

#### 1- LESegmentView顶部封装

![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LESegmentView.gif)

#####-(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentHeight Indicator:(UIImage *) indicator SegmentSpace:(int) space;

Gif中组件测试代码如下：

```
-(void) onTestSegmentView{
	LEBaseViewController *vc=[[LEBaseViewController alloc] init];
	[vc leSetNavigationTitle:@"LESegmentView"];
	LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
	UIView *v1=[[UIView alloc] init];
	[v1 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.5216 blue:0.563 alpha:1.0]];
	UIView *v2=[[UIView alloc] init];
	[v2 setBackgroundColor:[UIColor colorWithRed:0.7397 green:1.0 blue:0.795 alpha:1.0]];
	UIView *v3=[[UIView alloc] init];
	[v3 setBackgroundColor:[UIColor colorWithRed:0.6962 green:0.7723 blue:1.0 alpha:1.0]];
	UIView *v4=[[UIView alloc] init];
	[v4 setBackgroundColor:[UIColor colorWithRed:1.0 green:0.7302 blue:0.9259 alpha:1.0]];
	UIView *v5=[[UIView alloc] init];
	[v5 setBackgroundColor:[UIColor colorWithRed:0.9925 green:0.909 blue:0.7724 alpha:1.0]];
	LESegmentView *segment=[[LESegmentView alloc] initWithTitles:nil Pages:nil ViewContainer:view.leViewContainer SegmentHeight:40 Indicator:[LEColorRed leImageWithSize:CGSizeMake(20, 6)] SegmentSpace:20];
	[segment leOnSetTitles:@[@"One",@"第二页",@"再来一个",@"这一个应该可以超出屏幕宽了吧",@"好了可以结束了"]];
	[segment onSetPages:@[v1,v2,v3,v4,v5]];
	[self.leCurrentViewController.navigationController pushViewController:vc animated:YES];
}
```

#### 2- LECurveProgressView:圆形镂空进度组件（可以只显示一段弧形）


![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LECircleChart.gif)

```
-(void) onTestCurveProgressView{
	LEBaseViewController *vc=[[LEBaseViewController alloc] init];
	[vc leSetNavigationTitle:@"LECurveProgressView"];
	LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
	curveProgress=[[LECurveProgressView alloc] initWithAutoLayoutSettings:	[[LEAutoLayoutSettings alloc] initWithSuperView:view.leViewContainer Anchor:LEAnchorInsideBottomCenter Offset:CGPointMake(0, LEStatusBarHeight) CGSize:CGSizeMake(240, 240)] MinAngle:-225 MaxAngle:45 Color:[UIColor colorWithRed:0.345 green:0.748 blue:0.885 alpha:1.000] ShadowColor:[UIColor colorWithRed:0.271 green:0.496 blue:0.712 alpha:1.000] LineWidth:12 ShadowLineWidth:6 Progrss:12];
	[curveProgress leStrokeChart];
	[self.leCurrentViewController.navigationController pushViewController:vc animated:YES];
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onCheckCurveProgressView) userInfo:nil repeats:YES];
}
-(void) onCheckCurveProgressView{
	[curveProgress leGrowChartByAmount:12];
}
```
#### 3-LELineChart：统计线形图

![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LELineChart.gif)

Gif中组件测试代码：

```

UILabel *labelLineChart;

-(void) onTestLELineChart{
	LEBaseViewController *vc=[[LEBaseViewController alloc] init];
	[vc leSetNavigationTitle:@"LELineChart"];
	LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
	LELineChart *line=[[LELineChart alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.leCurrentFrameWidth, self.leCurrentFrameWidth/2)] LineWidth:2 RulerLineWidth:1 Color:LEColorRed RulerColor:[UIColor greenColor] Padding:14 VerticalPadding:20 Target:self];
	labelLineChart=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.leViewContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:line Offset:CGPointMake(0, LELayoutSideSpace) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorRed Line:1 Alignment:NSTextAlignmentCenter]];
	[line leOnSetValues:@[@"10",@"100",@"50",@"60",@"20",@"5",@"90",@"100",@"40",@"80"] Min:5 Max:100];
	[line setBackgroundColor:[UIColor colorWithRed:0.4686 green:0.7222 blue:0.8368 alpha:1.0]];
	[self.leCurrentViewController.navigationController pushViewController:vc animated:YES];
}
-(void) leOnLineChartSelection:(NSUInteger)index{
	[labelLineChart leSetText:[NSString stringWithFormat:@"当前移动到了第%zd个位置",index+1]];
}
```

#### 4-LEBarChart:统计柱状图

![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LEBarChart.gif)

GIF中组件测试代码：


```
UILabel *labelBarChart;

-(void) onTestBarChart{
	LEBaseViewController *vc=[[LEBaseViewController alloc] init];
	[vc leSetNavigationTitle:@"LEBarChart"];
	LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
	LEBarChart *bar=[[LEBarChart alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointZero CGSize:CGSizeMake(self.leCurrentFrameWidth, self.leCurrentFrameWidth/2)] BarChartSettings:[[LEBarChartSettings alloc] init] Delegate:self];
	labelBarChart=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.leViewContainer Anchor:LEAnchorOutsideBottomCenter RelativeView:bar Offset:CGPointMake(0, LELayoutSideSpace) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorRed Line:1 Alignment:NSTextAlignmentCenter]];
	[bar leOnSetValues:@[@"10",@"100",@"50",@"60",@"20",@"5",@"90",@"100",@"40",@"80"] Tags:@[@"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eight",@"Nine",@"Ten"]];
	[self.leCurrentViewController.navigationController pushViewController:vc animated:YES];
}
-(void) leOnBarSelectedWithIndex:(int)index{
	[labelBarChart leSetText:[NSString stringWithFormat:@"当前点击了第%d个bar",index+1]];
}
```

#### 5-LEWaveProgressView:波浪上涨动画

![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LEWaveProgressView.gif)

GIF中组件测试代码如下：


```
-(void) onTestWaveProgressView{
	LEBaseViewController *vc=[[LEBaseViewController alloc] init];
	[vc leSetNavigationTitle:@"LEWaveProgressView"];
	LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
	curWaveProgressView=[[LEWaveProgressView alloc] initWithAutoLayoutSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:view.leViewContainer Anchor:LEAnchorInsideTopCenter Offset:CGPointMake(0, LENavigationBarHeight) CGSize:CGSizeMake(250, 260)]];
	[curWaveProgressView setBackgroundColor:[UIColor colorWithRed:0.3515 green:0.7374 blue:1.0 alpha:1.0]];
	[curWaveProgressView leSetPercentage:0];
	[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(onWaveTimer) userInfo:nil repeats:YES];
	[self.leCurrentViewController.navigationController pushViewController:vc animated:YES];
}
-(void) onWaveTimer{
	[curWaveProgressView leSetPercentage:rand()%10*1.0/10];
}

```

#### 6-LEExcelView:表格方式展示数据

![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/ExcelView.gif)

GIF中组件测试代码如下：

```
-(void) onTestExcelView{
	LEBaseViewController *vc=[[LEBaseViewController alloc] init];
	[vc leSetNavigationTitle:@"LEExcelView"];
	LEBaseView *view=[[LEBaseView alloc] initWithViewController:vc];
	curExcelView=[[LEExcelView alloc] initWithSettings:[[LETableViewSettings alloc] initWithSuperViewContainer:view ParentView:view.leViewContainer TableViewCell:@"TestExcelViewCell" EmptyTableViewCell:nil GetDataDelegate:self TableViewCellSelectionDelegate:self] ImmovableViewWidth:120 MovableViewWidth:300 TabbarHeight:LEBottomTabbarHeight TabbarClassname:@"TestExcelViewTabbar"];
	[curExcelView leOnRefreshedWithData:	[@[@"",@"",@"",@"",@"",@"",@"",@""]mutableCopy]];
	[self.leCurrentViewController.navigationController pushViewController:vc animated:YES];
}

@interface TestExcelViewCell : LEExcelViewTableViewCell
@end
@implementation TestExcelViewCell{
UILabel *labelLeft;
UILabel *labelRight;
}
-(void) leExtraInits{
	[self.leImmovableViewContainer setBackgroundColor:[UIColor colorWithRed:0.8947 green:0.527 blue:0.3107 alpha:1.0]];
	[self.leMovableViewContainer setBackgroundColor:[UIColor colorWithRed:0.6922 green:0.4729 blue:0.6923 alpha:1.0]];
	[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leMovableViewContainer EdgeInsects:UIEdgeInsetsZero] Image:[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"lewave"]];
	[self leAddBottomSplitWithColor:LEColorRed Offset:CGPointZero Width:self.bounds.size.width];
	labelLeft=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leImmovableViewContainer Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
	labelRight=[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leMovableViewContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LELayoutSideSpace20, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
}
-(void) leSetData:(id)data IndexPath:(NSIndexPath *)path{
	[super leSetData:data IndexPath:path];
	[labelLeft leSetText:[NSString stringWithFormat:@"第%zd行",path.row]];
	[labelRight leSetText:[NSString stringWithFormat:@"第%zd行右侧可移动的内容，我是第%zd行内容",path.row,path.row]];
}
@end
@interface TestExcelViewTabbar : LEExcelViewTabbar
@end
@implementation TestExcelViewTabbar
-(void) leExtraInits{
	[self.leImmovableViewContainer setBackgroundColor:[UIColor colorWithRed:0.9991 green:0.5522 blue:0.9683 alpha:1.0]];
	[self.leMovableViewContainer setBackgroundColor:[UIColor colorWithRed:0.4642 green:0.6434 blue:0.9982 alpha:1.0]];
	[LEUIFramework leGetImageViewWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leMovableViewContainer EdgeInsects:UIEdgeInsetsZero] Image:[[LEUIFramework sharedInstance] leGetImageFromLEFrameworksWithName:@"lewave"]];
	[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leImmovableViewContainer Anchor:LEAnchorInsideCenter Offset:CGPointZero CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"左侧行数" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorTextBlack Line:1 Alignment:NSTextAlignmentCenter]];
	[LEUIFramework leGetLabelWithSettings:[[LEAutoLayoutSettings alloc] initWithSuperView:self.leMovableViewContainer Anchor:LEAnchorInsideLeftCenter Offset:CGPointMake(LELayoutSideSpace20, 0) CGSize:CGSizeZero] LabelSettings:[[LEAutoLayoutLabelSettings alloc] initWithText:@"右侧内容1        右侧内容2" FontSize:LELayoutFontSize14 Font:nil Width:0 Height:0 Color:LEColorTextBlack Line:1 Alignment:NSTextAlignmentLeft]];
}
@end
```

#### 7-LEMultiImagePicker：图片多选组件（注意需要配合系统导航栏使用）

![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/MultiImagePicker.gif)

GIF中组件测试代码如下：

```
[self.navigationController setNavigationBarHidden:NO];
MultiImagePicker *picker=[[MultiImagePicker alloc] initWithImagePickerDelegate:self];
[self.navigationController pushViewController:picker animated:YES];
```

二、实用的自动排版的库的原理解析：（Demo中的onTestAutoLayout有所体现）

LEUIFramework，主要的用法是在新建视图时确定好其父视图，相对位置，大小后，之后父视图的变动，或者自身的变动无需花费大量监听代码去处理视图之间的关系。基本原理是子视图在初始化时，提供父视图、与父视图或者与其他子视图的相对位置、偏移量，大小（Label和Image可以设置为CGSizeZero，从而选择让库来自动处理大小）后，视图位置即可确定。当父视图或者相对位置的参考子视图有所变动时，子视图都会收到重排的指令，从而可以自动排版。而子视图在使用leSetOffset改变偏移量，leSetSize变动大小或者leSetFrame设置整个frame时，其他与之有相对位置关系的视图都会收到消息，从而所有视图都可以自动重排。

1）、所有的view在新建时都可以使用如下的3个初始化方法

```
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor Offset:(CGPoint) offset CGSize:(CGSize) size;相对位置参考物为父视图
-(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor RelativeView:(UIView *) relativeView Offset:(CGPoint) offset CGSize:(CGSize) size;
```
相对位置是父视图中的某一个子视图

```
-(id) initWithSuperView:(UIView *)superView EdgeInsects:(UIEdgeInsets) edge;
```
相对于父视图，子视图的大小为父视图的大小减去edge
2）、相对位置LEAnchors

```
锚点说明：（粗体红色矩形表示父视图）
1-蓝色字体部分表示参照视图为父视图的情况，使用九宫格的方式划分区域，因而共用9种停靠情况。
2-黑色字体部分表示参照视图为父视图中的某一同级子视图。有12中停靠点+4个对角线延伸线上，共16种情况。
```
![image](https://github.com/LarryEmerson/LEAllFrameworksGif/blob/master/LEAnchor.png)

3）、快速初始化组件（1句话初始化）：UILabel，UIImageView，UIButton

```
+(UIImageView *) leGetImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(UIImage *) image ;
+(UILabel *) leGetLabelWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ;  
+(UIButton *) leGetButtonWithSettings:(LEAutoLayoutSettings *) settings ButtonSettings:(LEAutoLayoutUIButtonSettings *) buttonSettings ;
```

三、列表的封装：单组列表（LEBaseTableView）  见Demo工程中的 onTestLEBaseTableView

```
1）、已接入下拉刷新（leOnRefreshData），上拉加载更多（leOnLoadMore）的效果
2）、初始化简单- (id) initWithSettings:(LETableViewSettings *) settings; 
3）、列表数据源：
-(void) leOnRefreshedWithData:(NSMutableArray *)data;
-(void) leOnLoadedMoreWithData:(NSMutableArray *)data;
4）、初始化方法：参数有全屏视图，父视图，自定义Cell的类名，可自定义空列表Cell类名，列表数据源回调，列表Cell点击事件回调

-(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LETableViewDataSourceDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
5）、可以重新自定义section及rows
```

四、Tabbar封装：LEBottomTabbar，LETabbarRelatedPageView

```
-(id) initTabbarWithFrame:(CGRect) frame Delegate:(id) delegate NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *) pages NormalColor:(UIColor *) normalColor HighlightedColor:(UIColor *) highlightedColor;
```

五、其他工具：

弹出消息（LELocalNotification），
二维码扫码（LEScanQRCode），
弹窗（LEPopup）、 

七、其他
[![Version](https://img.shields.io/cocoapods/v/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)
[![License](https://img.shields.io/cocoapods/l/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)
[![Platform](https://img.shields.io/cocoapods/p/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)

 

## Author

LarryEmerson, larryemerson@163.com

## License

LEFrameworks is available under the MIT license. See the LICENSE file for more info.



