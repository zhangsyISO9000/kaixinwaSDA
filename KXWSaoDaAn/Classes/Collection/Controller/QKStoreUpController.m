//
//  QKStoreUpController.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/22.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKStoreUpController.h"
#import "LCCSqliteManager.h"

@interface QKStoreUpController ()
@property(nonatomic,strong)NSMutableArray * allDataArray;

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
    LCCSqliteManager * manager= [LCCSqliteManager shareInstance];
    self.allDataArray = [[manager getSheetDataWithSheet:@"answerAndPage"] mutableCopy];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UITableViewDelegate


@end
