//
//  WJCategoryCollectionViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/31.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJCategoryCollectionViewController.h"
#import "WJSearchViewController.h"
#import "WJCategoryCollectionViewCell.h"
#import "WJCategoryTableViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WJCategoryData.h"
#import "WJXiaoDianDiTableViewController.h"
#import "WJZhuanTiTableViewController.h"

/*
 吐槽能手api：http://api.wuliaoribao.com/v1/collections?limit=6&offset=0
 专栏：http://api.wuliaoribao.com/v1/channel_groups/all?
 */

#define WJColorForRGB(r, g, b)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define WJColorForRGB(r, g, b)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface WJCategoryCollectionViewController ()
// banner 视图
@property (nonatomic,strong) UIButton * imgLeftBtn;
@property (nonatomic,strong) UIButton * imgRightBtn;

// 专栏模型数据
@property (nonatomic,strong) NSArray * iconArr;
// collectionCell api 数组
@property (nonatomic,strong) NSArray * cellApi;

@end

@implementation WJCategoryCollectionViewController

-(NSArray *)cellApi{

    if (!_cellApi) {
        // 网络获取cell api 赋值给数组
        
    }
    return _cellApi;
}
-(NSArray *)iconArr{

    if (!_iconArr) { // 这里一定要做if判断，不然会一直网络请求，消耗内存

        // api
        NSString * webUrl = @"http://api.wuliaoribao.com/v1/channel_groups/all?";
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        // get 数据
        [manager GET:webUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSDictionary * picArrs = responseObject;
            NSDictionary * banners = picArrs[@"data"];
            NSArray * bannerArr = banners[@"channel_groups"];
            NSDictionary * iconDic = bannerArr[0];
            NSArray * iconArrs = iconDic[@"channels"];
            
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dic in iconArrs) {
                // 转模型
                WJCategoryData * data = [WJCategoryData categoryCellWithDic:dic];
                [temp addObject:data];
            }

            _iconArr = temp;
            [self.collectionView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"icon 图片加载失败");
        }];
    }
    return _iconArr;
}

-(void)loadBannerImg{
    
        // 网络加载数据
        // api连接
        NSString * webUrl = @"http://api.wuliaoribao.com/v1/collections?limit=6&offset=0";
        
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        // 接受网络返回json对象
        [manager GET:webUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 网络数据获取成功
            //图片数据赋值给数据数组
            NSDictionary * picArrs = responseObject;
            NSDictionary * banners = picArrs[@"data"];
            NSArray * bannerArr = banners[@"collections"];
            
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dic in bannerArr) {
                
                NSString * url = dic[@"banner_image_url"];
                [temp addObject:url];
            }
            // 更新UI
            NSURL * leftUrl = [NSURL URLWithString:temp[0]];
            NSURL * rightUrl = [NSURL URLWithString:temp[1]];
            NSData * leftData = [NSData dataWithContentsOfURL:leftUrl];
            NSData * rightData = [NSData dataWithContentsOfURL:rightUrl];
            
            [self.imgLeftBtn setImage:[UIImage imageWithData:leftData] forState:UIControlStateNormal];
            [self.imgRightBtn setImage:[UIImage imageWithData:rightData] forState:UIControlStateNormal];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error = %@",error);
        }];
    
}
static NSString * const reuseIdentifier = @"categoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"WJCategoryCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    // 添加搜索按钮
    [self addSearchBarButton];
    // 背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 添加头部视图
    [self addHeaderView];
    [self loadBannerImg];
}

// 添加头部视图
-(void)addHeaderView{
    // 纯代码创建
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    UILabel * leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 8, 70, 30)];
    leftLabel.text = @"专题合集";
    leftLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton * rightLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightLabel setFrame:CGRectMake(self.view.frame.size.width-83, 8, 70, 30)];
    [rightLabel setTitle:@"查看全部" forState:UIControlStateNormal];
    [rightLabel setTitleColor:WJColorForRGB(130, 132, 140) forState:UIControlStateNormal];
    rightLabel.titleLabel.font = [UIFont systemFontOfSize:11];
    [rightLabel setImage:[UIImage imageNamed:@"Category_PostCollectionSeeAll_nightMode~iphone"]forState:UIControlStateNormal];
    [rightLabel setImageEdgeInsets:UIEdgeInsetsMake(-1, 62, 0, 0)];
    [rightLabel addTarget:self action:@selector(seeAll)
         forControlEvents:UIControlEventTouchUpInside];
    
    _imgLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_imgLeftBtn setFrame:CGRectMake(15, 53, (SCREEN_WIDTH -45)/2, 70)];
    _imgLeftBtn.layer.cornerRadius = 5;
    _imgLeftBtn.layer.masksToBounds = YES;
    [_imgLeftBtn addTarget:self action:@selector(leftImg) forControlEvents:UIControlEventTouchUpInside];
    
    _imgRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_imgRightBtn setFrame:CGRectMake(x, _imgLeftBtn.frame.origin.y, _imgLeftBtn.frame.size.width, _imgLeftBtn.frame.size.height)];
    _imgRightBtn.frame = CGRectMake(CGRectGetMaxX(_imgLeftBtn.frame)+15, 53, (SCREEN_WIDTH -45)/2, 70);
    _imgRightBtn.layer.cornerRadius = 5;
    _imgRightBtn.layer.masksToBounds = YES;
    [_imgRightBtn addTarget:self action:@selector(rightImg) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * marginView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 10)];
    marginView.backgroundColor = WJColorForRGB(239, 239, 244);
    
    [headView addSubview:leftLabel];
    [headView addSubview:rightLabel];
    [headView addSubview:_imgRightBtn];
    [headView addSubview:_imgLeftBtn];
    [headView addSubview:marginView];
    // 添加专栏label
    UILabel * collLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 160, 30, 20)];
    collLabel.text = @"专栏";
    collLabel.font = [UIFont systemFontOfSize:15];
    
    [self.collectionView addSubview:collLabel];
    [self.collectionView addSubview:headView];
    
    
}
// 重写构造方法创建流水布局对象
-(instancetype)init{

//    CGFloat screenWith = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:flowLayout]) {
        
        flowLayout.itemSize = CGSizeMake(70, 90);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 5;
        // 设置头视图大小
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 150);
        flowLayout.sectionInset = UIEdgeInsetsMake(40, 10, 0, 10);

    }
    return self;
}

-(void)addSearchBarButton{

    UIBarButtonItem * searchBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Feed_SearchBtn~iphone"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBarClick)];
    self.navigationItem.rightBarButtonItem = searchBar;
}

-(void)searchBarClick{

    WJSearchViewController * search = [[WJSearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.iconArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WJCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.cellData = self.iconArr[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

// collectionCell 点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    WJZhuanTiTableViewController * vc = [[WJZhuanTiTableViewController alloc] init];
    vc.apiUrl = @"http://api.wuliaoribao.com/v1/channels/12/items?limit=20&offset=0";
    WJCategoryData * dataTitle = self.iconArr[indexPath.row];
    vc.title = dataTitle.name;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - head 视图点击事件items
-(void)seeAll{
    
    WJCategoryTableViewController * vc = [[WJCategoryTableViewController alloc] init];
    vc.apiUrl = @"http://api.wuliaoribao.com/v1/collections/3/posts?gender=1&generation=1&limit=20&offset=0";
    [self.navigationController pushViewController:vc animated:YES];
 
}
-(void)leftImg{

    WJCategoryTableViewController * vc = [[WJCategoryTableViewController alloc] init];
    vc.apiUrl = @"http://api.wuliaoribao.com/v1/collections/3/posts?gender=1&generation=1&limit=20&offset=0";
    vc.title = @"吐槽小能手";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightImg{


    WJCategoryTableViewController * vc = [[WJCategoryTableViewController alloc] init];
    vc.apiUrl = @"http://api.wuliaoribao.com/v1/collections/2/posts?gender=1&generation=1&limit=20&offset=0";
    vc.title = @"少女心";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
