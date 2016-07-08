//
//  WJRoleTableViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/4/13.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJRoleTableViewController.h"

@interface WJRoleTableViewController ()

@property (nonatomic,assign) NSInteger  currentRow;
@property (nonatomic,assign) NSInteger  previewRow;

@property (nonatomic,strong) NSArray * cellDataArr;


@end

@implementation WJRoleTableViewController

-(NSArray *)cellDataArr{

    if (!_cellDataArr) {
        _cellDataArr = [NSArray arrayWithObjects:@"初中生",@"高中生",@"大学生",@"职场新人",@"资深工作党", nil];
    }
    return _cellDataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择角色";
    self.view.backgroundColor = LCColorForTabBar(240, 240, 240);
    self.tableView.rowHeight = 40;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.text = self.cellDataArr[indexPath.row];
    
    // 从用户偏好设置中获取已被选中的行
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * rowStr = [defaults objectForKey:@"selectedRole"];
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"role" object:self.cellDataArr[indexPath.row]];

    // 记录被选中的row
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * roleStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    [defaults setObject:roleStr forKey:@"selectedRole"];
    // pop到上一个view
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
