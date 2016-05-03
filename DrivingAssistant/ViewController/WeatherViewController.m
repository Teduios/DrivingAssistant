//
//  WeatherViewController.m
//  DrivingAssistant
//
//  Created by ji on 16/4/25.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "WeatherViewController.h"
#import "HomeHeaderView.h"
#import "HomeCollectionViewCell.h"
#import "Constants.h"
#import "UIView+Extension.h"
#import "LocationManager.h"
#import "JKNetManager.h"
#import "DataManager.h"
#import "MBProgressHUD.h"
#import "HomeHeader.h"

@interface WeatherViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) HomeHeaderView *headerView;
//记录所有每天数组
@property (nonatomic, strong) NSArray *dailyArray;
//头部视图TRHomeHeader
@property (nonatomic, strong) HomeHeader *homeHeaderModel;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, copy) NSString *cityID;


@end

@implementation WeatherViewController

static NSString * const reuseIdentifier = @"collectionCell";

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        
        UIImage *newImge = [[UIImage imageNamed:@"icon_homepage_lifeServiceCategory"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = newImge;
        self.tabBarItem.selectedImage = newImge;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景图片
    [self setBackgroundImageAndButton];
    
    //创建并添加相应视图
    [self createAndAddViews];
    
    //创建并添加colletionView
    [self createCollectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //获取用户位置
    [self getUserLocationCity];
}

#pragma mark - 和界面相关方法
- (void)setBackgroundImageAndButton {
    //设置背景图片
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backgroundImage.image = [UIImage imageNamed:@"weatherbackground"];
    [self.view addSubview:backgroundImage];
    
    UIButton *freshButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-REFRESH_BOTTON_WIDTH, REFRESH_BOTTON_Y, REFRESH_BOTTON_WIDTH, REFRESH_BOTTON_HEIGHT)];
    [freshButton setTitle:@"刷新" forState:UIControlStateNormal];
    [freshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [freshButton addTarget:self action:@selector(clickFreshButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:freshButton];
    
}

- (void)createCollectionView {
    //创建flowlayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.itemSize = CGSizeMake(COLLECTION_CELL_WIDTH, COLLECTION_CELL_HEIGHT);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.headerView.y+self.headerView.width+COLLECTION_CELL_INSET, SCREEN_WIDTH, COLLECTION_CELL_HEIGHT) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    //设置代理和数据元
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    
    //注册collectionViewCell
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)createAndAddViews {
    self.headerView = [HomeHeaderView getHomeHeaderView];
    self.headerView.frame = CGRectMake(HOME_HEADER_VIEW_X, HOME_HEADER_VIEW_Y, HOME_HEADER_VIEW_WIDTH, HOME_HEADER_VIEW_HEIGHT);
    [self.view addSubview:self.headerView];
}
//点击右上角的刷新按钮触发方法
- (void)clickFreshButton {
    //刷新开始
    [TSMessage setDefaultViewController:self];
    if (self.cityID) {
        //发送请求
        [self sendRequestToSeverByCityID:self.cityID];
    } else {
        self.cityID = @"CN101010100";//默认北京
        [self sendRequestToSeverByCityID:self.cityID];
    }
    //刷新结束
    [TSMessage showNotificationWithTitle:@"刷新成功" subtitle:nil type:TSMessageNotificationTypeSuccess];
}


#pragma mark - 获取用户位置(模拟器语言为中文)

- (void)getUserLocationCity {
    [LocationManager getUserCityName:^(NSString *cityName) {
        self.cityID = [DataManager getCityIDByName:cityName];
        if (self.cityID) {
            //发送请求
            [self sendRequestToSeverByCityID:self.cityID];
        }
    }];
}

#pragma mark - 和网络请求相关的方法
- (void)sendRequestToSeverByCityID:(NSString *)cityID {
    
    NSString *urlstr = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?cityid=%@&key=%@", cityID, REQUEST_KEY];
    
    [JKNetManager sendGetRequest:urlstr withParams:nil withSuccess:^(id responseObject) {
        //服务器成功返回
        self.homeHeaderModel = [DataManager returnHomeHeaderData:responseObject];
        self.dailyArray = [DataManager returnAllDailyData:responseObject];
        
        
        //更新头部视图数据
        [self updateHomeHeaderData];
        //重新加载collectionView数据
        [self.collectionView reloadData];
        
    } withFailure:^(NSError *error) {
        
        
        //创建MBProgressHUD控件
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //设置属性
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"网络繁忙,请稍后再试";
        hud.margin = 10;
        //延迟时间
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:3];
    }];
}

- (void)updateHomeHeaderData {
    
    self.headerView.homeHeaderModel = self.homeHeaderModel;
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dailyArray.count == 0) {
        return 7;
    } else {
        return self.dailyArray.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor = [UIColor clearColor];
    
    //设置cell
    if (self.dailyArray.count > 0) {
        
        cell.dailyModel = self.dailyArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//点中item的触发方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
