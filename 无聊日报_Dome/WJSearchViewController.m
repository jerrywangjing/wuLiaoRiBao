//
//  WJSearchViewController.m
//  无聊日报_Dome
//
//  Created by JerryWang on 16/3/23.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJSearchViewController.h"

@interface WJSearchViewController ()<UISearchBarDelegate>
@property (nonatomic,strong) UIBarButtonItem * cancel;

@end

@implementation WJSearchViewController

-(UISearchBar *)searchBar{

    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 隐藏系统返回按钮
    self.navigationItem.hidesBackButton = YES;
    
    // 添加搜索框,取消按钮,大家搜Label
    [self addCancelBtn];
    [self addSearchBar];
    [self addLabelAnybodySearch];
    
}
// 添加“大家都在搜Label”
-(void)addLabelAnybodySearch{

    UILabel * anybodySearch = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 20)];
    anybodySearch.text = @"大家都在搜";
    anybodySearch.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:anybodySearch];
}
// 添加‘取消’按钮
-(void)addCancelBtn{

    _cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelSearchBar)];
    self.navigationItem.rightBarButtonItem = _cancel;

}
-(void)cancelSearchBar{
    
    [self.searchBar resignFirstResponder];
    // 返回上一个视图
    [self.navigationController popViewControllerAnimated:YES];
    
}

// 添加搜索框
-(void)addSearchBar{

    CGRect sechRect = CGRectMake(0, 0,self.view.frame.size.width- 60, 30);
    
    UIView * searchVie = [[UIView alloc] initWithFrame:sechRect];
    //UISearchBar * searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.frame = sechRect;
//    self.searchBar.backgroundColor = self.navigationController.navigationBar.tintColor;
    self.searchBar.barTintColor = [UIColor whiteColor];
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchBar.layer.cornerRadius = 5;
    self.searchBar.layer.masksToBounds  = YES;
    self.searchBar.placeholder = @"搜索商品、专题";
    
    [searchVie addSubview:self.searchBar];
    
    self.navigationItem.titleView = searchVie;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.searchBar becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    [self.searchBar resignFirstResponder];
}
#pragma mark -搜索框代理方法
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//
//    // return NO to not become first responder
//    return YES;
//}
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
// // called when text starts editing
//    //NSLog(@"开始输入搜索");
//    
//}
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
//
//    // return NO to not resign first responder
//    return YES;
//
//}
@end
