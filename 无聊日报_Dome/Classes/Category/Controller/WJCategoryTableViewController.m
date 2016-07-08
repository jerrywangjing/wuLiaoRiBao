//
//  WJCategoryTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/2.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJCategoryTableViewController.h"
#import "AFNetworking.h"
#import "WJCategoryData.h"
#import "WJXiaoDianDiTableViewCell.h"
#import "WJDetailViewController.h"

@interface WJCategoryTableViewController ()

//模型数组
@property (nonatomic,strong) NSArray * cellDataArr;

@end

@implementation WJCategoryTableViewController

-(NSString *)apiUrl{

    if (!_apiUrl) {
        _apiUrl = [[NSString alloc] init];

    }
    return _apiUrl;
}

// 懒加载cell 数据
-(NSArray * )cellDataArr{
    
    if (!_cellDataArr) {
        
        // 数据api
//        static NSString * apiUrl = @"http://api.wuliaoribao.com/v1/collections/3/posts?gender=1&generation=1&limit=20&offset=0";
        NSString * webUrl = self.apiUrl;
        
        // 网络数据解析json
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:webUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 加载成功
            NSDictionary * temp1 = responseObject;
            NSDictionary * temp2 = temp1[@"data"];
            NSArray * tempArr = temp2[@"posts"];
            
            // 字典数据转模型
            // 临时可变模型数组
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dic in tempArr) {
                
                WJCategoryData * cellData = [WJCategoryData categoryCellWithDic:dic];
                [temp addObject:cellData];
                
            }
            _cellDataArr = temp;
            [self.tableView reloadData];// 注意这个必须刷新一次表格才能获取到数据
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 加载失败
            
            //NSLog(@"网络数据加载失败-->：%@",error);
            
            
        }];
    }
    return _cellDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加刷新指示器
    MJRefreshNormalHeader * refresh = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)] ;
    self.tableView.mj_header = refresh;
    
    // 设置cell 行高
    self.tableView.rowHeight = 150; //注意这里的行高要和Cell的xib视图里的一致
    // 去掉tableviewCell 分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 标题
}

// 刷新表视图
-(void)refreshTableView{
    
    if (self.tableView.mj_header.isRefreshing) {
        // 模拟2秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表视图数据
            [self.tableView reloadData];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 创建cell
    WJXiaoDianDiTableViewCell * cell
    = [WJXiaoDianDiTableViewCell homeCellWithTableView:tableView];
    
    // 获取数据
    WJTabelViewData * cellData = self.cellDataArr[indexPath.row];
    cell.cellData = cellData;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
// 点击cell进入详情页

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WJDetailViewController * detailVc = [[WJDetailViewController alloc] init];
    
    detailVc.detailData = self.cellDataArr[indexPath.row];
    
    detailVc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}
@end
