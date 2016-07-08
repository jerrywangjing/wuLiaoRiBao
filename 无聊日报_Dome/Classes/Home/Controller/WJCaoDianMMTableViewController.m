//
//  WJCaoDianMMTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/28.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJCaoDianMMTableViewController.h"
#import "AFNetworking.h"
#import "WJTabelViewData.h"
#import "WJXiaoDianDiTableViewCell.h"
#import "WJDetailViewController.h"

@interface WJCaoDianMMTableViewController ()

//模型数组
@property (nonatomic,strong) NSArray * cellDataArr;
@end

@implementation WJCaoDianMMTableViewController
// 懒加载cell 数据
-(NSArray * )cellDataArr{
    
    if (!_cellDataArr) {
        
        // 数据api
        static NSString * apiUrl = @"http://api.wuliaoribao.com/v1/channels/18/items?limit=20&offset=0";
        
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
    UIRefreshControl * freshCtr = [[UIRefreshControl alloc] init];
    freshCtr.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [freshCtr addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = freshCtr;
    // 设置cell 行高
    self.tableView.rowHeight = 150; //注意这里的行高要和Cell的xib视图里的一致
    // 去掉tableviewCell 分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

// 刷新表视图
-(void)refreshTableView:(UIRefreshControl * )refersh{
    
    if (self.refreshControl.refreshing) {
        refersh.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
        // 模拟2秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 停止刷新
            [refersh endRefreshing];
            refersh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
            
        });
        
        // 刷新表视图数据
        [self.tableView reloadData];
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
    
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
}
// 点击cell进入详情页

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WJDetailViewController * detailVc = [[WJDetailViewController alloc] init];
    
    detailVc.detailData = self.cellDataArr[indexPath.row];
    
    detailVc.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
