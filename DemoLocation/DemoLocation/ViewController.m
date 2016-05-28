//
//  ViewController.m
//  DemoLocation
//
//  Created by herman on 16/5/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"

// 导入位置头文件
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager; // 获取位置

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"地图定位";
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"start" style:UIBarButtonItemStyleDone target:self action:@selector(locationStart)];
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"stop" style:UIBarButtonItemStyleDone target:self action:@selector(locationStop)];
    self.navigationItem.rightBarButtonItems = @[btn1, btn2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 响应方法

- (void)locationStart
{
    // 定位开始
    // 判断定位操作是否被允许
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        // 提示用户无法进行定位操作
        [self alertMessage:@"定位不成功 ,请确认开启定位"];
    }
}

- (void)locationStop
{
    // 定位停止
    [self.locationManager stopUpdatingLocation];
}

- (void)alertMessage:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"知道了"
                      otherButtonTitles:nil, nil] show];
}

#pragma mark - CLLocationManagerDelegate

// 获取定位信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    // locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    // 纬度：loc.coordinate.latitude
    // 经度：loc.coordinate.longitude
    NSLog(@"纬度=%f，经度=%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error) {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             // 具体位置
             // NSLog(@%@,placemark.name);
             // 获取城市
             NSString *city = placemark.locality;
             if (!city)
             {
                 // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             [self alertMessage:[NSString stringWithFormat:@"city=%@\n纬度=%f，经度=%f", city, currentLocation.coordinate.latitude, currentLocation.coordinate.longitude]];
             
             // 系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [self locationStop];
         }
         else if (error == nil && [array count] == 0)
         {
             [self alertMessage:@"No results were returned."];
         }
         else if (error != nil)
         {
             [self alertMessage:[NSString stringWithFormat:@"An error occurred = %@", error]];
         }
     }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        [self alertMessage:@"定位未打开,请打开定位服务"];
    }

    [self locationStop];
}

#pragma mark - getter

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];

        // 设置当前类为其代理
        [_locationManager setDelegate:self];
        // 设置位置精确度 最佳精确度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        // 设置位置距离精确度
        [_locationManager setDistanceFilter:10.0f];
        
        // 始终允许访问位置信息
        if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [_locationManager requestAlwaysAuthorization];
        }
        // 使用应用程序期间允许访问位置数据
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
        {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    
    return _locationManager;
}

@end
