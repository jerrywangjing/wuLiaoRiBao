//
//  WJJinXuanTableTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/23.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJJinXuanTableTableViewController.h"
#import "WJJinXuanTableViewCell.h"
#import "WJTabelViewData.h"
#import "WJDetailViewController.h"
#import "WJCategoryTableViewController.h"
#import "MJChiBaoZiHeader.h"

@interface WJJinXuanTableTableViewController ()<UITableViewDataSource,UITableViewDelegate>
// cell数据模型数组
@property (nonatomic,strong) NSArray * cellDataArr;
// banner 图片数据
@property (nonatomic,strong) NSArray * bannerUrl;

@end

@implementation WJJinXuanTableTableViewController

// 懒加载cell 数据
-(NSArray * )cellDataArr{
    
    if (!_cellDataArr) {
    
    // 数据api
    static NSString * apiUrl = @"http://api.wuliaoribao.com/v1/channels/4/items?gender=1&generation=1&limit=20&offset=0";
    
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
                
                WJTabelViewData * cellData = [WJTabelViewData homeCellWithDic:dic];
                [temp addObject:cellData];
                
            }

            _cellDataArr = temp;
            [self.tableView reloadData];// 注意这个必须刷  新一次表格才能获取到数据
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 加载失败
            
            //NSLog(@"网络数据加载失败-->：%@",error);

            
        }];
    }
    return _cellDataArr;
}

// 懒加载轮播图数据
-(NSArray *)bannerUrl{

    if(!_bannerUrl)
    {
        // 自定义view(网络加载广告轮播图)
        // json数据解析
        NSString * webUrl = @"http://api.wuliaoribao.com/v1/banners?channel=iOS";
        
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        // 接受网络返回json对象
        [manager GET:webUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 网络数据获取成功
            //图片数据赋值给数据数组
            NSDictionary * picArrs = responseObject;
            NSDictionary * banners = picArrs[@"data"];
            NSArray * bannerArr = banners[@"banners"];
            
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dic in bannerArr) {
                
                NSString * url = dic[@"image_url"];
                [temp addObject:url];
            }
            _bannerUrl = temp;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error = %@",error);
        }];

    }
    return _bannerUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加刷新指示器
    
    MJChiBaoZiHeader * refresh = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView:)];
    refresh.lastUpdatedTimeLabel.hidden = YES;// 隐藏时间
    refresh.stateLabel.hidden = YES;
    
    self.tableView.mj_header = refresh;
    // 设置cell 行高
    self.tableView.rowHeight = 150; //注意这里的行高要和Cell的xib视图里的一致
    // 去掉tableviewCell 分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //NSString * path = NSHomeDirectory(); // 获取沙盒主目录

}

-(void)refreshTableView:(UIRefreshControl * )refersh{
    
    if (self.tableView.mj_header.isRefreshing) {
        
    // 模拟2秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 刷新表视图数据
            [self.tableView reloadData];
            // 停止刷新
            [self.tableView.mj_header endRefreshing];
            
        });
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cellDataArr.count;
}

#pragma  mark - 代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 148;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 125;
}
// 自定义headerView
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    static NSString * ID = @"headerView";
    
    UITableViewHeaderFooterView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
    }
    
    // 创建轮播图
    DCPicScrollView * picScrollView = [DCPicScrollView picScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 140) WithImageUrls:self.bannerUrl];
    
    // 图片点击事件
    [picScrollView setImageViewDidTapAtIndex:^(NSInteger index) {
        // 实现图片点击事件
        switch (index) {
            case 0:
                [self picScrollClick:@"http://api.wuliaoribao.com/v1/collections/2/posts?gender=1&generation=1&limit=20&offset=0" andTitle:@"少女心"];
                break;
            case 1:
                [self picScrollClick:@"http://api.wuliaoribao.com/v1/collections/3/posts?gender=1&generation=1&limit=20&offset=0" andTitle:@"吐槽小能手"];
                break;
                
            default:
                break;
        }
    }];
    //default is 2.0f,如果小于0.5不自动播放
    picScrollView.AutoScrollDelay = 4.0f;
    //下载失败重复下载次数,默认不重复,
    [[DCWebImageManager shareManager] setDownloadImageRepeatCount:1];
    //url下载失败的imageurl
    [[DCWebImageManager shareManager] setDownLoadImageError:^(NSError *error, NSString *url) {
        NSLog(@"下载失败%@",error);
    }];

    
    [headerView addSubview:picScrollView];

    return headerView;
    
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    WJJinXuanTableViewCell * cell
    = [WJJinXuanTableViewCell homeCellWithTableView:tableView];
    
    // 在数据模型中加载xib cell
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WJJHTableViewCell" owner:nil options:nil] lastObject];
    }
    //取消cell 的选中高亮效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    // 获取数据
    WJTabelViewData * cellData = self.cellDataArr[indexPath.row];
    cell.cellData = cellData;
    return cell;
}

// 点击cell进入详情页

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    WJDetailViewController * detailVc = [[WJDetailViewController alloc] init];
    
    detailVc.detailData = self.cellDataArr[indexPath.row];
    
    detailVc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(void)picScrollClick:(NSString * )api andTitle:(NSString*)title{

    WJCategoryTableViewController * vc = [[WJCategoryTableViewController alloc] init];
    vc.apiUrl = api;
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
