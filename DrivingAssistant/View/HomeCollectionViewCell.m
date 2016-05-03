//
//  HomeCollectionViewCell.m
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowHightTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@end

@implementation HomeCollectionViewCell


+ (HomeCollectionViewCell *)getHomeCollectionCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeCollectionViewCell" owner:self options:nil] firstObject];
}

- (void)setDailyModel:(Daily *)dailyModel {
    
    //日期
    self.weekLabel.text = dailyModel.dataWeekStr;
    //最低/最高温度
    self.lowHightTempLabel.text = dailyModel.lowHighTempStr;
    //天气描述
    self.weatherDescLabel.text = dailyModel.weatherDesc;
    //天气url
    [self.weatherImageView sd_setImageWithURL:[NSURL URLWithString:dailyModel.weatherIconUrl] placeholderImage:nil];
}


@end
