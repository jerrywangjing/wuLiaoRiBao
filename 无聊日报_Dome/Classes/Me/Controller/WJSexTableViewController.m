//
//  WJSexTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/13.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJSexTableViewController.h"

@interface WJSexTableViewController ()
@property (nonatomic,assign) NSInteger  currentRow;
@property (nonatomic,strong) NSArray * cellData;

@end

@implementation WJSexTableViewController

-(NSArray *)cellData{

    if (!_cellData) {
        _cellData = [NSArray arrayWithObjects:@"男孩",@"女孩", nil];
    }
    return _cellData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择性别";
    self.view.backgroundColor = LCColorForTabBar(240, 240, 240);
    self.tableView.rowHeight = 40;

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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == 0) {
        cell.textLabel.text = self.cellData[indexPath.row];
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
    
        cell.textLabel.text = self.cellData[indexPath.row];
    }
    // 从用户偏好设置中获取已被选中的行
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * rowStr = [defaults objectForKey:@"selectedSex"];
    
    NSInteger rowInt = [rowStr integerValue];
    if (indexPath.row == rowInt) {
        cell.imageView.image =[UIImage imageNamed:@"icon_ check~iphone"];
    }else{
        
        cell.imageView.image = nil;
    }

    
    return cell;
}

#pragma mark -- 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 显示对勾
    self.currentRow = indexPath.row;
    [self.tableView reloadData];
    // 发出标签改变的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sex" object:self.cellData[indexPath.row]];
    
    // 记录被选中的row
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sexStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    [defaults setObject:sexStr forKey:@"selectedSex"];
    // pop到上一个view
    [self.navigationController popViewControllerAnimated:YES];

}
@end
