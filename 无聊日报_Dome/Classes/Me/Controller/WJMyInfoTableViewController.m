
//
//  WJMyInfoTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/13.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJMyInfoTableViewController.h"
#import "WJSexTableViewController.h"
#import "WJRoleTableViewController.h"

#define CELL_HEIGHT 40

@interface WJMyInfoTableViewController ()
// cell上的label
@property (nonatomic,strong) UILabel * sex;
@property (nonatomic,strong) UILabel * role;

@end

@implementation WJMyInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"我的身份";
    self.view.backgroundColor = LCColorForTabBar(240, 240, 240);
    self.tableView.rowHeight = 40;
    [self addLabel];
    
    // 注册role通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valueChanged:) name:@"role" object:nil];
    // 注册sex通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexValueChanged:) name:@"sex" object:nil];
    
    // 添加下拉刷新控件
    __unsafe_unretained typeof(self) weakSelf = self;//定义安全的self
    
   self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           //刷新数据
           [weakSelf.tableView reloadData];
           [weakSelf.tableView.mj_header endRefreshing];
       });
    }];
}

#pragma mark - 通知响应方法
-(void)valueChanged:(NSNotification *)noti{

    NSString * currentRole = noti.object;

    // 保存数据
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentRole forKey:@"currentRole"];
    //[defaults synchronize]; // 立即写入偏好设置
    
    [self.tableView reloadData];
    
}
-(void)sexValueChanged:(NSNotification *)noti{

    NSString * currentSex = noti.object;
   // NSLog(@"1.接收到的通知数据——%@",currentSex);
    // 保存数据
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentSex forKey:@"currentSex"];
    //[defaults synchronize]; // 立即写入偏好设置
    
    [self.tableView reloadData];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        if (indexPath.row == 0) {
            _sex = [self creatCellLabels];
            [cell addSubview:_sex];
        }else{
        
            _role = [self creatCellLabels];
            [cell addSubview:_role];
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    /** 这里注意：由于cell重用机制,cell上的label控件需要在if(!cell)的时候一次性创建，下次reload tableview的时候系统会自动重用cell，只需在下面的选择赋值条件语句中更新label的值，才会避免label重叠问题*/
    if (indexPath.row == 0) {
        cell.textLabel.text = @"性别";
        NSString * tempSex = [defaults objectForKey:@"currentSex"];
        //NSLog(@"2.reload后，从用户偏好设置获取的数据--%@",tempSex);
        _sex.text = tempSex;
        //NSLog(@"3.给sexLabel 赋值后的结果--%@",_sex.text);
        
    }else{
    
        cell.textLabel.text = @"角色";
        // 从用户偏好设置获取
        NSString * tempRole = [defaults objectForKey:@"currentRole"];
        _role.text = tempRole;
        //NSLog(@"role -- 赋值后的结果 -%@",_role.text);

    }
    
    return cell;
}

-(UILabel * )creatCellLabels{

    CGFloat labelW = 70;
    CGFloat labelH = 20;
    CGFloat labelX = SCREEN_WIDTH - (labelW +30);
    CGFloat labelY = (CELL_HEIGHT - labelH)/2;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = LCColorForTabBar(150, 150, 150);
    label.textAlignment = NSTextAlignmentRight;
    
    return  label;
}
-(void)addLabel{

    CGFloat margin = 10;
    CGFloat lineW = 50;
    UILabel * info = [[UILabel alloc] initWithFrame:CGRectMake(lineW + 2*margin, 120, SCREEN_WIDTH - 2*(lineW +2*margin), 20)];
    info.text = @"我们将根据您的身份推荐最合适的内容";
    info.font = [UIFont systemFontOfSize:13];
    info.textColor = LCColorForTabBar(150, 150, 150);
    info.textAlignment = NSTextAlignmentCenter;
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(margin, CGRectGetMidY(info.frame), lineW, 1)];
    line.backgroundColor = LCColorForTabBar(200, 200, 200);
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(info.frame)+margin, CGRectGetMidY(info.frame), lineW, 1)];
    line1.backgroundColor = line.backgroundColor;
    
    [self.view addSubview:info];
    [self.view addSubview:line];
    [self.view addSubview:line1];
}

#pragma mark -- 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        WJSexTableViewController * sex = [[WJSexTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:sex animated:YES];
    }else{
    
        WJRoleTableViewController * role =[[WJRoleTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:role animated:YES];
    }
}
@end
