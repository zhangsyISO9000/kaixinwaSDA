//
//  QKStoreCell.h
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/22.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCollectionModel.h"

@interface QKStoreCell : UITableViewCell


@property(nonatomic,strong)QKCollectionModel * collectModel;

+(instancetype)cellWithTableView:(UITableView*)tableView;

@end
