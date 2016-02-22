//
//  QKCollectionModel.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/4.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKCollectionModel.h"

@implementation QKCollectionModel

-(void)setUnique_code:(NSString *)unique_code{
    _unique_code = unique_code;
    if (!([unique_code hasPrefix:@"math"]||[unique_code hasPrefix:@"chinese"]||[unique_code hasPrefix:@"english"])) {
        _urlString = unique_code;
    }
}


-(NSString *)timeStp{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    NSTimeInterval time = _timeStp.doubleValue;
    // 获得收藏的具体时间
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    if ([createDate isThisYear]) {
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }else{
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }

}
@end
