//
//  HomeHeaderView.m
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "HomeHeaderView.h"

@interface HomeHeaderView()

@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;

@property (weak, nonatomic) IBOutlet UILabel *weatherConditionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@property (weak, nonatomic) IBOutlet UILabel *userLocationLabel;

@property (weak, nonatomic) IBOutlet UILabel *windDescLabel;


@end

@implementation HomeHeaderView

+ (HomeHeaderView *)getHomeHeaderView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:self options:nil] firstObject];
}

- (void)setHomeHeaderModel:(HomeHeader *)homeHeaderModel {
    //当前温度
    self.currentTempLabel.text = homeHeaderModel.currentTemp;
    //天气描述
    self.weatherConditionLabel.text = homeHeaderModel.weatherDesc;
    //天气iconURL
    [self.weatherImageView sd_setImageWithURL:[NSURL URLWithString:homeHeaderModel.weatherIconUrl] placeholderImage:nil];
    //位置
    self.userLocationLabel.text = homeHeaderModel.cityName;
    //风向+风级别
    self.windDescLabel.text = [NSString stringWithFormat:@"%@ %@", homeHeaderModel.windDirection, homeHeaderModel.windLevel];
}

@end
