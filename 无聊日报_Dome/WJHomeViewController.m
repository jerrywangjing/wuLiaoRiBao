//
//  WJHomeViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/22.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJHomeViewController.h"
#import "WJSearchViewController.h"
#import "WJJinXuanTableTableViewController.h"
#import "WJXiaoDianDiTableViewController.h"
#import "WJZhangZhiShiTableViewController.h"
#import "WJCaoDianMMTableViewController.h"
#import "WJLoveMovieTableViewController.h"

static CGFloat const titleH = 35;
static CGFloat const navBarH = 64;
static CGFloat const titleInterval = 75; // 标题间距
static CGFloat const maxTitleScale = 1.3;

#define YCKScreenW [UIScreen mainScreen].bounds.size.width
#define YCKScreenH [UIScreen mainScreen].bounds.size.height

@interface WJHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *titleScrollView;
@property (nonatomic, weak) UIScrollView *contentScrollView;
// 选中按钮
@property (nonatomic, weak) UIButton *selTitleButton;

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation WJHomeViewController

- (NSMutableArray *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSearchBtn];
    [self setupTitleScrollView];
    [self setupContentScrollView];
    [self addChildViewController];
    [self setupTitle];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * YCKScreenW, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
}

// 给导航条添加自定义搜索按钮
-(void)addSearchBtn{
    
    UIBarButtonItem * seartchBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Feed_SearchBtn~iphone"] style:UIBarButtonItemStylePlain target:self action:@selector(searchItemClick)];
    self.navigationItem.rightBarButtonItem = seartchBar;
    

}
// 搜索点击事件
-(void)searchItemClick{
    
    WJSearchViewController * searchBarVc = [[WJSearchViewController alloc] init];
    
    // push searchBarVc的时候隐藏tabBar
    searchBarVc.hidesBottomBarWhenPushed  = YES;
    
    [self.navigationController pushViewController:searchBarVc animated:YES];
//    // 搜索框成为第一响应者
//    [searchBarVc.searchBar becomeFirstResponder];
    
}


#pragma mark - 设置头部标题栏
- (void)setupTitleScrollView
{
    // 判断是否存在导航控制器来判断y值
    CGFloat y = self.navigationController ? navBarH : 0;
    CGRect rect = CGRectMake(0, y, YCKScreenW, titleH);
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    titleScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleScrollView];
    
    self.titleScrollView = titleScrollView;
}

#pragma mark - 设置内容
- (void)setupContentScrollView
{
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect = CGRectMake(0, y, YCKScreenW, YCKScreenH - navBarH);
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    //    contentScrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
}

#pragma mark - 添加子控制器
- (void)addChildViewController
{
    
    WJJinXuanTableTableViewController * tabVc1 = [[WJJinXuanTableTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tabVc1.title = @"精选";

    [self addChildViewController:tabVc1];
    
    WJXiaoDianDiTableViewController * tabVc2 = [[WJXiaoDianDiTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tabVc2.title = @"笑点低";
    [self addChildViewController:tabVc2];
    
    WJZhangZhiShiTableViewController * tabVc3 = [[WJZhangZhiShiTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tabVc3.title = @"涨知识";
    [self addChildViewController:tabVc3];
    
    WJCaoDianMMTableViewController * tabVc4 = [[WJCaoDianMMTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tabVc4.title = @"槽点满满";
    [self addChildViewController:tabVc4];
    
    WJLoveMovieTableViewController * tabVc5 = [[WJLoveMovieTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tabVc5.title = @"爱电影";
    [self addChildViewController:tabVc5];
    
    UITableViewController * tabVc6 = [[UITableViewController alloc] init];
    tabVc6.title = @"科技";
    tabVc6.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:tabVc6];

}

#pragma mark - 设置标题
- (void)setupTitle
{
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat x = 0;
    CGFloat w = titleInterval; //  标题之间的间距
    CGFloat h = titleH;
    
    for (int i = 0; i < count; i++)
    {
        UIViewController *vc = self.childViewControllers[i];
        
        x = i * w;
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [[UIButton alloc] initWithFrame:rect];
        
        btn.tag = i;
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        [self.buttons addObject:btn];
        [self.titleScrollView addSubview:btn];
        
        if (i == 0)
        {
            [self click:btn];
        }
        
    }
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
}

// 按钮点击
- (void)click:(UIButton *)btn
{
    [self selTitleBtn:btn];
    
    NSUInteger i = btn.tag;
    CGFloat x = i * YCKScreenW;
    
    [self setUpOneChildViewController:i];
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    
}
// 选中按钮
- (void)selTitleBtn:(UIButton *)btn
{
    [self.selTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selTitleButton.transform = CGAffineTransformIdentity;
    
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.transform = CGAffineTransformMakeScale(maxTitleScale, maxTitleScale);
    
    self.selTitleButton = btn;
    [self setupTitleCenter:btn];
}

- (void)setUpOneChildViewController:(NSUInteger)i
{
    CGFloat x = i * YCKScreenW;
    
    UIViewController *vc = self.childViewControllers[i];
    
    if (vc.view.superview) {
        return;
    }
    vc.view.frame = CGRectMake(x, 0, YCKScreenW, YCKScreenH - self.contentScrollView.frame.origin.y);
    
    [self.contentScrollView addSubview:vc.view];
    
}

- (void)setupTitleCenter:(UIButton *)btn
{
    CGFloat offset = btn.center.x - YCKScreenW * 0.5;
    
    if (offset < 0)
    {
        offset = 0;
    }
    
    CGFloat maxOffset = self.titleScrollView.contentSize.width - YCKScreenW;
    if (offset > maxOffset)
    {
        offset = maxOffset;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger i = self.contentScrollView.contentOffset.x / YCKScreenW;
    [self selTitleBtn:self.buttons[i]];
    [self setUpOneChildViewController:i];
}

// 只要滚动UIScrollView就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger leftIndex = offsetX / YCKScreenW;
    NSInteger rightIndex = leftIndex + 1;
    
    //    NSLog(@"%zd,%zd",leftIndex,rightIndex);
    
    UIButton *leftButton = self.buttons[leftIndex];
    
    UIButton *rightButton = nil;
    if (rightIndex < self.buttons.count) {
        rightButton = self.buttons[rightIndex];
    }
    
    CGFloat scaleR = offsetX / YCKScreenW - leftIndex;
    
    CGFloat scaleL = 1 - scaleR;
    
    
    CGFloat transScale = maxTitleScale - 1;
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL * transScale + 1);
    
    rightButton.transform = CGAffineTransformMakeScale(scaleR * transScale + 1, scaleR * transScale + 1);
    
    
    UIColor *rightColor = [UIColor colorWithRed:scaleR green:0 blue:0 alpha:1];
    UIColor *leftColor = [UIColor colorWithRed:scaleL green:0 blue:0 alpha:1];
    
    [leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    [rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
    
}

@end
