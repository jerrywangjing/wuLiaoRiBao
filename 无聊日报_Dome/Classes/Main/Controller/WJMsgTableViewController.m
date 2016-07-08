//
//  WJMsgTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/3.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJMsgTableViewController.h"
#import "WJMsgCellData.h"
#import "WJMsgTableViewCell.h"

@interface WJMsgTableViewController ()

// cell数据
@property (nonatomic,strong) NSArray * cellData;


@end

@implementation WJMsgTableViewController

-(NSArray *)cellData{

    if (!_cellData) {
        
        NSString * api =@"http://api.wuliaoribao.com/v1/posts/4655/comments?limit=20&offset=0";
        
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        // 接受网络返回json对象
        [manager GET:api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // 网络数据获取成功
            //图片数据赋值给数据数组
            NSDictionary * picArrs = responseObject;
            NSDictionary * banners = picArrs[@"data"];
            NSArray * bannerArr = banners[@"comments"];
            
            NSMutableArray * temp = [NSMutableArray array];
            for (NSDictionary * dic in bannerArr) {
                
                NSDictionary * tmp = dic[@"user"];
                
                NSString * content = dic[@"content"];
                NSString * iconStr = tmp[@"avatar_url"];
                NSString * name = tmp[@"nickname"];
                
                NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
                [dataDic setValue:content forKey:@"content"];
                [dataDic setValue:iconStr forKey:@"iconImg"];
                [dataDic setValue:name forKey:@"name"];
                
                WJMsgCellData * cellData = [WJMsgCellData msgCellWithDic:dataDic];
                [temp addObject:cellData];
            }
            _cellData = temp;
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error = %@",error);
        }];
    }
    return _cellData;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title =@"评论";
    UIBarButtonItem * doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnClick)];
    
    self.navigationItem.rightBarButtonItem = doneBtn;
    
    //
}

-(void)doneBtnClick{
    // 关闭模态视图
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cellData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WJMsgTableViewCell * cell = [WJMsgTableViewCell cellWithTableView:tableView];
    
    cell.cellData = self.cellData[indexPath.row];
    return cell;
}
// 设置自适应行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    WJMsgTableViewCell * cell = [WJMsgTableViewCell cellWithTableView:tableView];
    cell.cellData = self.cellData[indexPath.row];

    return cell.rowHeight;
}
@end
