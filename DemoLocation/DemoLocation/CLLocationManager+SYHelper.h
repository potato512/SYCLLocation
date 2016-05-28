//
//  CLLocationManager+SYHelper.h
//  DemoLocation
//
//  Created by herman on 16/5/28.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocationManager (SYHelper)

@end

/*
注意：一旦用户选择了“Don’t Allow”，意味着你的应用以后就无法使用定位功能，且当用户第一次选择了之后，以后就再也不会提醒进行设置。
因此在程序中应该进行判断，如果发现自己的定位服务没有打开，那么应该提醒用户打开定位服务功能。
CLLocationManager有个类方法可以判断当前应用的定位功能是否可用+ (BOOL)locationServicesEnabled;
说明：这里的定位服务是基于网络的。通常定位服务可以是基于GPS、基站或者是网络的。
 
 iOS8中使用CoreLocation定位
 1、在使用CoreLocation前需要调用如下函数【iOS8专用】：
 iOS8对定位进行了一些修改，其中包括定位授权的方法，CLLocationManager增加了下面的两个方法：
 （1）始终允许访问位置信息
 - (void)requestAlwaysAuthorization;
 （2）使用应用程序期间允许访问位置数据
 - (void)requestWhenInUseAuthorization;
 2、在Info.plist文件中添加如下配置，且值均为YES
 （1）NSLocationAlwaysUsageDescription app在前台、后台、挂起、结束进程状态时，都可以获取到定位信息
 （2）NSLocationWhenInUseUsageDescription 当app在前台的时候，才可以获取到定位信息
 3、设置NSLocationUsageDescription说明定位的目的(Privacy - Location Usage Description)
 
*/
