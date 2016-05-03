//
//  MapViewController.m
//  DrivingAssistant
//
//  Created by ji on 16/4/22.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *baiduMapView;
@property (nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation MapViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        
        UIImage *newImge = [[UIImage imageNamed:@"icon_homepage_foottreatCategory"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = newImge;
        self.tabBarItem.selectedImage = newImge;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.baiduMapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    self.baiduMapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));//精准度
    [self.baiduMapView setRegion:region animated:YES];
}

#pragma mark -- 跳转到高德地图
- (IBAction)gotoMapAPP:(UIButton *)sender {
    NSString *urlString = [[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&saddr=slat,slng",self.baiduMapView.userLocation.coordinate.latitude, self.baiduMapView.userLocation.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
