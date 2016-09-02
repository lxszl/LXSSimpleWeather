//
//  LXSWeatherView.m
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import "LXSWeatherView.h"
#import "LXSForecastView.h"
#import "LXSWeatherLineView.h"
#import "LXSWeatherModel.h"

@interface LXSWeatherView ()
//气温折线
@property (nonatomic, strong) LXSWeatherLineView *lineView;
//每天的天气View的数组
@property (nonatomic, strong) NSArray *forecastViewArray;

@property (nonatomic, strong) NSDateFormatter *formatter;
//日期
@property (nonatomic, strong) NSArray *realDates;
//周几
@property (nonatomic, strong) NSArray *weekDates;
//今天
@property (nonatomic, copy) NSString *todayStr;
@end

@implementation LXSWeatherView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    [self forecastViewArray];
}


-(void)setWeatherViewWithData:(NSArray *)dataArray{
    
    if (!dataArray) {
        
        if (_lineView) {
            
            [_lineView removeFromSuperview];
            _lineView = nil;
        }
        return;
        
    }else if (dataArray.count == 7) {
        
        for (NSInteger i = 0; i < 6; i++) {
            
            LXSForecastView *forecastView = self.forecastViewArray[i];
            LXSWeatherDayModel *dayModel = dataArray[i];
            dayModel.dateStr = self.realDates[i];
            dayModel.weekedStr = self.weekDates[i];
            forecastView.dayModel = dayModel;
        }
        
        if (_lineView) {
            
            [_lineView removeFromSuperview];
            _lineView = nil;
        }
        
        _lineView = [[LXSWeatherLineView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height*0.4)];
        _lineView.dataArray = dataArray.mutableCopy;
        [self addSubview:_lineView];
        _lineView.centerY = self.height*0.5;
    }
}



//每天天气的view
-(NSArray *)forecastViewArray{
    
    if (!_forecastViewArray) {
        
    CGFloat width = SCREEN_WIDTH / 6;
    CGFloat height = SCREEN_HEIGHT - 64;
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:6];
    
    for (NSInteger i = 0; i < 6; i++) {
        
        LXSForecastView *forecastView = [[LXSForecastView alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];
        [self addSubview:forecastView];
        [temp addObject:forecastView];
    }
        self.forecastViewArray = temp;
        
    }
    return _forecastViewArray;
}



-(NSDateFormatter *)formatter{
    
    if (!_formatter) {
        
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"MM/dd";
    }
    return _formatter;
}

//
-(NSArray *)realDates{
    
    if (!_realDates) {
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:6];
        NSDate *date = nil;
        NSString *dateStr = nil;
        for (NSInteger i = 0; i < 6; i++) {
            
            date = [NSDate dateWithTimeIntervalSinceNow:60*60*24*i];
            dateStr = [self.formatter stringFromDate:date];
            NSLog(@"%@",dateStr);
            [temp addObject:dateStr];
        }
        _realDates = temp;
    }
    return _realDates;
}

-(NSArray *)weekDates{
    
    if (!_weekDates) {
        
        NSMutableArray *temp = [NSMutableArray arrayWithCapacity:6];
        NSDate *date = nil;
        NSString *weekStr = nil;
        
        [temp addObject:@"今天"];
        for (NSInteger i = 1; i < 6; i++) {
            
            date = [NSDate dateWithTimeIntervalSinceNow:60*60*24*i];
            weekStr = [self getweekDayStringWithDate:date];
            [temp addObject:weekStr];
        }
        _weekDates = temp;
    }
    return _weekDates;
}


-(NSString *) getweekDayStringWithDate:(NSDate *) date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
 
    // 1 是周日，2是周一 3.以此类推
 
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *weekDayString = nil;
    switch (weekInt) {
        case 1:
        {
            weekDayString = @"周日";
        }
            break;
 
        case 2:
        {
            weekDayString = @"周一";
        }
            break;
 
        case 3:
        {
            weekDayString = @"周二";
        }
            break;
 
        case 4:
        {
            weekDayString = @"周三";
        }
            break;
 
        case 5:
        {
            weekDayString = @"周四";
        }
            break;
 
        case 6:
        {
            weekDayString = @"周五";
        }
            break;
 
        case 7:
        {
            weekDayString = @"周六";
        }
            break;
 
        default:
            break;
    }
    return weekDayString;
}
@end
