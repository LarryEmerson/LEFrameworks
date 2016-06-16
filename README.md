# LEFrameworks
IOS Development Frameworks 公司IOS开发库：自动排版、列表封装、数据模型、网络库封装...持续更新中
一、实用的自动排版的库:
    LEUIFramework，主要的用法是在新建视图时确定好其父视图，相对位置，大小后，之后父视图的变动，或者自身的变动无需花费大量监听代码去处理视图之间的关系。基本原理是子视图在初始化时，提供父视图、与父视图或者与其他子视图的相对位置、偏移量，大小（Label和Image可以设置为CGSizeZero，从而选择让库来自动处理大小）后，视图位置即可确定。当父视图或者相对位置的参考子视图有所变动时，子视图都会收到重排的指令，从而可以自动排版。而子视图在使用leSetOffset改变偏移量，leSetSize变动大小或者leSetFrame设置整个frame时，其他与之有相对位置关系的视图都会收到消息，从而所有视图都可以自动重排。

    1）、所有的view在新建时都可以使用如下的3个初始化方法
        -(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor Offset:(CGPoint) offset CGSize:(CGSize) size;相对位置参考物为父视图
        -(id) initWithSuperView:(UIView *) superView Anchor:(LEAnchors) anchor RelativeView:(UIView *) relativeView Offset:(CGPoint) offset CGSize:(CGSize) size;相对位置是父视图中的某一个子视图
        -(id) initWithSuperView:(UIView *)superView EdgeInsects:(UIEdgeInsets) edge;相对于父视图，子视图的大小为父视图的大小减去edge
    2）、相对位置LEAnchors
        相对位置参考物为父视图时：用9宫格法
        上左  上中  上右    
        左中  中间  右中
        下左  下中  下右
        相对位置参考物为父视图中的某一子视图时：
        
        角（Outside1）          角（Outside2）
           1 上左  上中  上右 2
             _______________
        左上|               |右上
            |               |
        左中|               |右中
            |               |
        左下|               |右下
             ———————————————
           3 下左  下中  下右  4
        角（Outside3）           角（Outside4）
    3）、快速初始化组件（1句话初始化）：UILabel，UIImageView，UIButton
        +(UIImageView *) getUIImageViewWithSettings:(LEAutoLayoutSettings *) settings Image:(UIImage *) image ;
        +(UILabel *) getUILabelWithSettings:(LEAutoLayoutSettings *) settings LabelSettings:(LEAutoLayoutLabelSettings *) labelSettings ;  
        +(UIButton *) getUIButtonWithSettings:(LEAutoLayoutSettings *) settings ButtonSettings:(LEAutoLayoutUIButtonSettings *) buttonSettings ;
        
二、界面的初步封装(Base目录中)

    LEBaseEmptyView，全屏视图可以通过初始化接口设置导航栏内容，进入，退出效果
    
三、列表的封装：单组列表（LEBaseTableView） 

    1）、已接入下拉刷新（onRefreshData），上拉加载更多（onLoadMore）的效果
    2）、初始化简单- (id) initWithSettings:(LETableViewSettings *) settings; 
    3）、列表数据源：
        -(void) onRefreshedWithData:(NSMutableArray *)data;
        -(void) onLoadedMoreWithData:(NSMutableArray *)data;
    4）、初始化方法：参数有全屏视图，父视图，自定义Cell的类名，可自定义空列表Cell类名，列表数据源回调，列表Cell点击事件回调
        -(id) initWithSuperViewContainer:(UIView *) superView ParentView:(UIView *) parent TableViewCell:(NSString *) cell EmptyTableViewCell:(NSString *) empty GetDataDelegate:(id<LEGetDataDelegate>) get TableViewCellSelectionDelegate:(id<LETableViewCellSelectionDelegate>) selection;
    5）、可以重新自定义section及rows
四、Tabbar封装：LEBottomTabbar，LETabbarRelatedPageView

    -(id) initTabbarWithFrame:(CGRect) frame Delegate:(id) delegate NormalIcons:(NSArray *) icons HighlightedIcons:(NSArray *) iconsSelected Titles:(NSArray *) titles Pages:(NSArray *) pages NormalColor:(UIColor *) normalColor HighlightedColor:(UIColor *) highlightedColor;
    
五、LESegmentView顶部封装：

    -(id) initWithTitles:(NSArray *) titles Pages:(NSArray *) pages ViewContainer:(UIView *) container SegmentHeight:(int) segmentHeight Indicator:(UIImage *) indicator SegmentSpace:(int) space;
    
六、其他工具：

    图片多选框架（MultiImagePicker），
    弹出消息（LocalNotification），
    二维码扫码（LEScanQRCode），
    弹窗（LEPopup）、
    Badge（LEBadge），
    电池上涨动画（LEWaveProgressView），
    
七、其他

[![CI Status](http://img.shields.io/travis/LarryEmerson/LEFrameworks.svg?style=flat)](https://travis-ci.org/LarryEmerson/LEFrameworks)
[![Version](https://img.shields.io/cocoapods/v/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)
[![License](https://img.shields.io/cocoapods/l/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)
[![Platform](https://img.shields.io/cocoapods/p/LEFrameworks.svg?style=flat)](http://cocoapods.org/pods/LEFrameworks)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LEFrameworks is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby

platform :ios, '7.0'
target "ProjectName” do 
pod "LEFrameworks"
end 
```

## Author

LarryEmerson, larryemerson@163.com

## License

LEFrameworks is available under the MIT license. See the LICENSE file for more info.



