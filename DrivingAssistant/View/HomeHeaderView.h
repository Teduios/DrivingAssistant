//
//  HomeHeaderView.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeader.h"

@interface HomeHeaderView : UIView

@property (nonatomic, strong)HomeHeader *homeHeaderModel;

+ (HomeHeaderView *)getHomeHeaderView;

@end
