//
//  QKStoreCell.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/22.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKStoreCell.h"

#define QKMargin 10
@interface QKStoreCell()
@property (weak, nonatomic)UILabel *dateLabel;
@property (weak, nonatomic)UIImageView *icon;
@property (weak, nonatomic)UILabel *titleLabel;
@end

@implementation QKStoreCell

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    static NSString * reuseId = @"storeCell";
    QKStoreCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[QKStoreCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel * dateLable = [[UILabel alloc]init];
        dateLable.font= [UIFont boldSystemFontOfSize:17];
        dateLable.textColor = [UIColor grayColor];
        [self.contentView addSubview:dateLable];
        self.dateLabel = dateLable;
        
        UIImageView * icon = [[UIImageView alloc]init];
        icon.backgroundColor = [UIColor greenColor];
        
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        UILabel * titleLable = [[UILabel alloc]init];
        titleLable.font = [UIFont systemFontOfSize:14];
        titleLable.textColor = [UIColor greenColor];
        [self.contentView addSubview:titleLable];
        self.titleLabel = titleLable;
        
    }
    return self;
}

-(void)setCollectModel:(QKCollectionModel *)collectModel
{
    _collectModel = collectModel;
    
    self.dateLabel.text = collectModel.timeStp;
    self.dateLabel.size = [collectModel.timeStp sizeWithAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17]}];
    self.dateLabel.x = QKMargin;
    self.dateLabel.y = (80 - self.dateLabel.height)/2;
    
    if (!([collectModel.unique_code hasPrefix:@"math"]||[collectModel.unique_code hasPrefix:@"chinese"]||[collectModel.unique_code hasPrefix:@"english"])) {
        self.icon.image = [UIImage imageNamed:@"link"];
    }else{
        self.icon.image = [UIImage imageNamed:@"key"];
    }
    self.icon.size = CGSizeMake(60, 60);
    self.icon.layer.cornerRadius = 5;
    self.icon.clipsToBounds = YES;
    self.icon.x = CGRectGetMaxX(self.dateLabel.frame)+QKMargin;
    self.icon.y = (80 - self.icon.height)/2;
    
    self.titleLabel.text = collectModel.title;
    self.titleLabel.size = [collectModel.title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    self.titleLabel.x = CGRectGetMaxX(self.icon.frame) + QKMargin;
    self.titleLabel.y = (80 - self.titleLabel.height)/2;
    
}

@end
