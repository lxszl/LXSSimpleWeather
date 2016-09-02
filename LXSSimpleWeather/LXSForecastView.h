//
//  LXSForecastView.h
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年  lxs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXSWeatherDayModel;
@interface LXSForecastView : UIView
//每天的天气数据
@property (nonatomic, strong) LXSWeatherDayModel *dayModel;
@end
