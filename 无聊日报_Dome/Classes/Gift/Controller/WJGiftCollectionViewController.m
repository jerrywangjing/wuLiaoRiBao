//
//  WJGiftCollectionViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJGiftCollectionViewController.h"
#import "WJGiftCollectionViewCell.h"
#import "AFNetworking.h"
#import "WJGiftData.h"
#import "WJGiftDetailViewController.h"

#define WJColorForRGB(r, g, b)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

@interface WJGiftCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

// cell 数据数组
@property (nonatomic,strong) NSArray * cellDataArr;

@end

@implementation WJGiftCollectionViewController

static NSString * const reuseIdentifier = @"collectionCell";

// 数据懒加载
-(NSArray *)cellDataArr{

    if (!_cellDataArr) {
        
        // 数据api
        static NSString * apiUrl = @"http://api.wuliaoribao.com/v2/items?gender=1&generation=1&limit=20&offset=0";
        
        // 网络数据解析json
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:apiUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 加载成功
            NSDictionary * temp1 = responseObject;
            NSDictionary * temp2 = temp1[@"data"];
            NSArray * tempArr = temp2[@"items"];
            
            // 字典数据转模型
            // 临时可变模型数组
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dic in tempArr) {
                
                NSDictionary * dicTmp = dic[@"data"];
                WJGiftData * cellData = [WJGiftData GiftDataWithDic:dicTmp];
                [temp addObject:cellData];
                
            }
            _cellDataArr = temp;
            [self.collectionView reloadData];// 注意这个必须刷新一次表格才能获取到数据
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 加载失败
            
            //NSLog(@"网络数据加载失败-->：%@",error);
            
            
        }];
    }
    return _cellDataArr;

}

-(instancetype)init{

    CGFloat screenWith = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    // 创建一个流水布局方式的布局对象
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    if (self = [super initWithCollectionViewLayout:flowLayout]) {
        // cell的大小是由流水布局决定的，xib中无法控制
        // 设置cell尺寸
        CGFloat itemW = (screenWith - 10 *3)/2;
        CGFloat itemH = (screenHeight - 10*3)/2.6;
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        // 设置cell行的间距
        flowLayout.minimumLineSpacing = 10;
        // 设置cell列间距最小值
        flowLayout.minimumInteritemSpacing = 0;
        // 设置section的 上下左右 缩进
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"WJGiftCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
    // 设置collectiongView的背景色
    self.collectionView.backgroundColor = WJColorForRGB(239, 239, 244);
    
    // 下拉刷新控件
    MJRefreshNormalHeader * refresh = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshControlAction)];
//    refresh.lastUpdatedTimeLabel.hidden = YES;
//    refresh.stateLabel.hidden = YES;
    self.collectionView.mj_header = refresh;
}

-(void)refreshControlAction{

    if (self.collectionView.mj_header.isRefreshing) {
        // 模拟2秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 刷新表视图数据
            [self.collectionView reloadData];
            // 停止刷新
            [self.collectionView.mj_header endRefreshing];
            
        });
    }
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.cellDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建可重用cell
    WJGiftCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 获取数据给cell赋值 
    cell.giftData = self.cellDataArr[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
// 进入商品详情页
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    WJGiftDetailViewController * detail = [[WJGiftDetailViewController alloc] init];
    detail.giftData =self.cellDataArr[indexPath.row];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
