//
//  HomeCollectionViewCell.h
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Daily.h"

@interface HomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) Daily *dailyModel;

+ (HomeCollectionViewCell *)getHomeCollectionCell;

@end
