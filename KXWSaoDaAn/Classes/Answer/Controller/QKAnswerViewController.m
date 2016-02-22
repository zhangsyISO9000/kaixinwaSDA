//
//  QKAnswerViewController.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/1.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKAnswerViewController.h"
#import "QKTitleScrollView.h"
#import "LCCSqliteManager.h"

@interface QKAnswerViewController ()
@property(nonatomic,strong)QKTitleScrollView * tsc;
@property(nonatomic,strong)LCCSqliteManager * sqlManager;
@end

@implementation QKAnswerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    LCCSqliteManager * sqlManager = [LCCSqliteManager shareInstance];
    self.sqlManager = sqlManager;
    //设置查询条件
    NSString * condition = [NSString stringWithFormat:@"\"unique_code\" = \'%@\'",self.unique_code];
    NSArray * array = [sqlManager searchDataFromSheet:@"answerAndPage" where:condition];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor greenColor]];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithTarget:self action:@selector(toHome)];
    
    if (array.count != 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"已收藏" style:UIBarButtonItemStylePlain target:self action:nil];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(toCollection:)];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * title = [self getTitleWithUniqueCode:self.unique_code];
    self.title = title;
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    frame.size.height = SCREEN_HEIGHT - 64;
    self.tsc = [[QKTitleScrollView alloc]initWithFrame:frame];
    self.tsc.unique_code = self.unique_code;
    [self.view addSubview:self.tsc];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)toHome
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)toCollection:(UIBarButtonItem *)item
{
    item.enabled = NO;
    item.title = @"已收藏";

    NSDate* nowDate = [NSDate date];
    NSString * nowTimeStr = [NSString stringWithFormat:@"%d",(int)nowDate.timeIntervalSince1970];
    //插入数据
    [self.sqlManager insertDataToSheet:@"answerAndPage" withData:@[self.unique_code,nowTimeStr,self.title]];
    
}

/**
 *  获得中文标题方法
 *
 *  @param unique_code 网络请求关键参数
 *
 *  @return 标题
 */
-(NSString *)getTitleWithUniqueCode:(NSString *)unique_code
{
    NSString * xq;
    NSString * kemu;
    NSRange range;
    range.location = unique_code.length - 3;
    range.length = 1;
    NSString * xqNum = [unique_code substringWithRange:range];
    if ([xqNum isEqualToString:@"a"]) {
        xq = @"上学期";
    }else{
        xq = @"下学期";
    }
    
    if ([unique_code containsString:@"chinese"]) {
        kemu = @"语文";
    }else if([unique_code containsString:@"english"]){
        kemu = @"英语";
    }else{
        kemu = @"数学";
    }
    
    range.location = unique_code.length - 6;
    range.length = 1;
    NSString * yearStr;
    int year = [unique_code substringWithRange:range].intValue;
    yearStr = [NSString stringWithFormat:@"%d年级",year];
    
    range.location = unique_code.length-5;
    range.length = 2;
    NSString * unitStr;
    int unit = [unique_code substringWithRange:range].intValue;
    unitStr = [NSString stringWithFormat:@"%d单元",unit];
    
    range.location = unique_code.length -2;
    range.length = 2;
    NSString * classStr;
    int classNum = [unique_code substringWithRange:range].intValue;
    classStr = [NSString stringWithFormat:@"第%d课",classNum];
    NSString * title = [NSString stringWithFormat:@"%@%@%@%@%@",xq,kemu,yearStr,unitStr,classStr];
    
    return title;
}





@end
