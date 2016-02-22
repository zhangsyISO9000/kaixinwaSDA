//
//  QKStoreUpController.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/22.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKStoreUpController.h"
#import "LCCSqliteManager.h"
#import "QKStoreCell.h"
#import "QKAnswerViewController.h"

@interface QKStoreUpController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * allDataArray;
@property(nonatomic,weak)UITableView * tableView;
@end

@implementation QKStoreUpController

-(NSArray *)allDataArray
{
    if (_allDataArray == nil) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的收藏";
    [self creatUI];
    
    //数据库操作
    LCCSqliteManager * manager= [LCCSqliteManager shareInstance];
    NSArray * dataArray = [manager getSheetDataWithSheet:@"answerAndPage"];
    for (NSArray * datas in dataArray) {
        QKCollectionModel * cm = [[QKCollectionModel alloc]init];
        cm.unique_code = datas[0];
        cm.timeStp = datas[1];
        cm.title = datas[2];
        
        [self.allDataArray addObject:cm];
    }
    
    
    
    
}
-(void)creatUI
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc]init];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview: tableView];
    self.tableView = tableView;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QKStoreCell * cell = [QKStoreCell cellWithTableView:tableView];
    cell.collectModel = self.allDataArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QKAnswerViewController * avc = [[QKAnswerViewController alloc]init];
    QKCollectionModel * cm = (QKCollectionModel *)self.allDataArray[indexPath.row];
    
    
    avc.unique_code = cm.unique_code;
    [self.navigationController pushViewController:avc animated:YES];
    
}
@end
