//
//  LXSWeatherModel.h
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LXSWeatherInfo,LXSWeatherWeekModel,LXSWeatherDayModel;
//返回的根节点
@interface LXSWeatherModel : NSObject
//所查询地区的信息
@property (nonatomic, strong) LXSWeatherInfo *c;
//一周的天气
@property (nonatomic, strong) LXSWeatherWeekModel *f;

@end

//所查询地区的信息
@interface LXSWeatherInfo : NSObject

@property (nonatomic, copy) NSString *c7;

@property (nonatomic, assign) CGFloat c14;

@property (nonatomic, copy) NSString *c3;

@property (nonatomic, copy) NSString *c17;

@property (nonatomic, copy) NSString *c8;

@property (nonatomic, copy) NSString *c12;

@property (nonatomic, copy) NSString *c4;

@property (nonatomic, copy) NSString *c15;

@property (nonatomic, copy) NSString *c10;

@property (nonatomic, copy) NSString *c9;

@property (nonatomic, copy) NSString *c5;

@property (nonatomic, assign) CGFloat c13;

@property (nonatomic, copy) NSString *c1;

@property (nonatomic, copy) NSString *c6;

@property (nonatomic, copy) NSString *c16;

@property (nonatomic, copy) NSString *c11;

@property (nonatomic, copy) NSString *c2;

@end

//一周的天气,七天
@interface LXSWeatherWeekModel : NSObject
//每天的天气
@property (nonatomic, strong) NSArray<LXSWeatherDayModel *> *f1;

@property (nonatomic, copy) NSString *f0;

@end

//每天的天气
@interface LXSWeatherDayModel : NSObject
//fe 0无持续风向 1表示东北风 2表示东风 3表示东南风 4表示南风 5表示西南风 6西风 7表示西北风 8表示北风
@property (nonatomic, copy) NSString *windDirection;
//fa和fb表示的是早晚间（fi对应的天气状况）：00表示晴 01表示多云 02 表示阴 03表示阵雨 04 05 06  待定  07 小雨 08 中雨 09 大雨
//fa
@property (nonatomic, copy) NSString *dayCond;
//fb 同上
@property (nonatomic, copy) NSString *nightCond;
//fc表示当前天最高温度
@property (nonatomic, copy) NSString *maxTmp;
//fd表示最低温度
@property (nonatomic, copy) NSString *minTmp;
//fg:表示风级：0 表示无风 1表示 3~4级小风 2表示4~5级 以此类推
@property (nonatomic, copy) NSString *windScale;
//不是返回的字段,自己添加的,方便使用,早间天气图片
@property (nonatomic, copy) NSString *dayImage;
//不是返回的字段,自己添加的,方便使用,晚间天气图片
@property (nonatomic, copy) NSString *nightImage;
//不是返回的字段,自己添加的,方便使用,日期
@property (nonatomic, copy) NSString *dateStr;
//不是返回的字段,自己添加的,方便使用,显示周几
@property (nonatomic, copy) NSString *weekedStr;

@property (nonatomic, copy) NSString *fh;

@property (nonatomic, copy) NSString *ff;

@property (nonatomic, copy) NSString *fi;

@end

