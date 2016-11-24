//
//  ViewController.m
//  DemoLocation
//
//  Created by herman on 16/5/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"

// 导入封装类头文件
#import "SYCLLocation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"地图定位";
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"start" style:UIBarButtonItemStyleDone target:self action:@selector(locationStart)];
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"stop" style:UIBarButtonItemStyleDone target:self action:@selector(locationStop)];
    self.navigationItem.rightBarButtonItems = @[btn1, btn2];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 60.0)];
    [self.view addSubview:activityView];
    activityView.tag = 1000;
    activityView.color = [UIColor redColor];
    activityView.hidesWhenStopped = YES;
    activityView.center = self.view.center;
    [activityView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 响应方法

- (void)locationStart
{
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[self.view viewWithTag:1000];
    [activityView startAnimating];
    
    // 封装方法 开启定位
    [[SYCLLocation shareLocation] locationStart:^(CLLocation *location, CLPlacemark *placemark) {
        
        [activityView stopAnimating];
        
        NSString *name = placemark.name;
        NSString *thoroughfare = placemark.thoroughfare;
        NSString *subThoroughfare = placemark.subThoroughfare;
        NSString *subLocality = placemark.subLocality;
        NSString *administrativeArea = placemark.administrativeArea;
        NSString *subAdministrativeArea = placemark.subAdministrativeArea;
        NSString *postalCode = placemark.postalCode;
        NSString *ISOcountryCode = placemark.ISOcountryCode;
        NSString *country = placemark.country;
        NSString *inlandWater = placemark.inlandWater;
        NSString *ocean = placemark.ocean;
        NSArray *areasOfInterest = placemark.areasOfInterest;
        // 获取城市
        NSString *city = placemark.locality;
        if (!city)
        {
            // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            city = placemark.administrativeArea;
        }
        
        NSMutableString *text = [[NSMutableString alloc] initWithFormat:@"纬度=%f，经度=%f\n", location.coordinate.latitude, location.coordinate.longitude];
        [text appendFormat:@"city=%@\n", city];
        [text appendFormat:@"name=%@\n", name];
        [text appendFormat:@"thoroughfare=%@\n", thoroughfare];
        [text appendFormat:@"subThoroughfare=%@\n", subThoroughfare];
        [text appendFormat:@"subLocality=%@\n", subLocality];
        [text appendFormat:@"administrativeArea=%@\n", administrativeArea];
        [text appendFormat:@"subAdministrativeArea=%@\n", subAdministrativeArea];
        [text appendFormat:@"postalCode=%@\n", postalCode];
        [text appendFormat:@"ISOcountryCode=%@\n", ISOcountryCode];
        [text appendFormat:@"country=%@\n", country];
        [text appendFormat:@"inlandWater=%@\n", inlandWater];
        [text appendFormat:@"inlandWater=%@\n", inlandWater];
        [text appendFormat:@"ocean=%@\n", ocean];
        [text appendFormat:@"areasOfInterest=%@\n", areasOfInterest];
        [self alertMessage:text];
        
    } faile:^(NSError *error) {
        
        [activityView stopAnimating];
        
        if (error)
        {
            if (([error code] == kCLErrorDenied))
            {
                [self alertMessage:@"定位未打开,请打开定位服务"];
            }
            else
            {
                [self alertMessage:[NSString stringWithFormat:@"An error occurred = %@", error]];
            }
        }
        else
        {
            [self alertMessage:@"No results were returned."];
        }
    }];
}

- (void)locationStop
{
    // 封装方法 结束定位
    [[SYCLLocation shareLocation] locationStop];
}

- (void)alertMessage:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:@"提示"
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"知道了"
                      otherButtonTitles:nil, nil] show];
}

@end
