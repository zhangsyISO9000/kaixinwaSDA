//
//  QKHomeViewController.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/1.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKHomeViewController.h"
#import "QKQRCodeViewController.h"
#import "QKAnswerViewController.h"
#import "QKWebViewController.h"
#import "QKStoreUpController.h"
#import "LCCSqliteManager.h"

@interface QKHomeViewController ()

@end

@implementation QKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    //数据库操作
    LCCSqliteManager * manager = [LCCSqliteManager shareInstance];
    [manager openSqliteFile:@"storeData"];
    
    //建表
    [manager createSheetWithSheetHandler:^(LCCSqliteSheetHandler *sheet) {
        sheet.sheetName = @"answerAndPage";
        sheet.sheetType = LCCSheetTypeVariable;
        sheet.sheetField = @[@"unique_code",@"timeStampString",@"title"];
        sheet.primaryKey = @[@"unique_code",@"timeStampString"];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (IBAction)toMyCollection:(UIButton *)sender {
//    QKWebViewController * vc = [[QKWebViewController alloc]init];
//    NSString * http = @"https://www.baidu.com";
//    vc.urlString = http;
//    [self.navigationController pushViewController:vc animated:YES];
    QKStoreUpController * suc = [[QKStoreUpController alloc]init];
    [self.navigationController pushViewController:suc animated:YES];
    
}

- (IBAction)toScan:(id)sender {
    
    [self performSegueWithIdentifier:@"toScan" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
