//
//  LXSForecastView.m
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import "LXSForecastView.h"
#import "LXSWeatherModel.h"

@interface LXSForecastView ()
@property (nonatomic, strong) UILabel *weekedLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *dayImageView;
@property (nonatomic, strong) UIImageView *nightImageView;
@property (nonatomic, strong) UILabel *windDirectionLabel;
@property (nonatomic, strong) UILabel *windScaleLabel;
@end
@implementation LXSForecastView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat margin = 5;
    
    _weekedLabel = [[UILabel alloc] customLabelWithText:@" " font:12 color:[UIColor whiteColor]];
    _weekedLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel = [[UILabel alloc] customLabelWithText:@" " font:12 color:[UIColor whiteColor]];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@" "]];
    _nightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@" "]];
    _windDirectionLabel = [[UILabel alloc] customLabelWithText:@" " font:12 color:[UIColor whiteColor]];
    _windDirectionLabel.textAlignment = NSTextAlignmentCenter;
    _windDirectionLabel.numberOfLines = 2;
    _windScaleLabel = [[UILabel alloc] customLabelWithText:@" " font:12 color:[UIColor whiteColor]];
    _windScaleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_weekedLabel];
    [self addSubview:_dateLabel];
    [self addSubview:_dayImageView];
    [self addSubview:_nightImageView];
    [self addSubview:_windDirectionLabel];
    [self addSubview:_windScaleLabel];
    
    [_weekedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(margin);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self);
        make.top.mas_equalTo(_weekedLabel.mas_bottom).mas_offset(margin);
    }];
    
    [_dayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.width-margin, self.width-margin));
        make.top.mas_equalTo(_dateLabel.mas_bottom).mas_offset(2*margin);
        
    }];
    
    [_windScaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-margin);
        
    }];
    
    [_windDirectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(_windScaleLabel.mas_top).mas_offset(-margin);
        
    }];
    
    [_nightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.width-margin-margin, self.width-margin-margin));
        make.bottom.mas_equalTo(_windScaleLabel.mas_top).mas_offset(-_windScaleLabel.height*2-margin);
        
    }];
    
}

//fe 0无持续风向 1表示东北风 2表示东风 3表示东南风 4表示南风 5表示西南风 6西风 7表示西北风 8表示北风
//@property (nonatomic, copy) NSString *windDirection;
//fa和fb表示的是早晚间（fi对应的天气状况）：00表示晴 01表示多云 02 表示阴 03表示阵雨 04 05 06  待定  07 小雨 08 中雨 09 大雨
//fa
//@property (nonatomic, copy) NSString *dayCond;
//fb 同上
//@property (nonatomic, copy) NSString *nightCond;
//fc表示当前天最高温度
//@property (nonatomic, copy) NSString *maxTmp;
//fd表示最低温度
//@property (nonatomic, copy) NSString *minTmp;
//fg:表示风级：0 表示无风 1表示 3~4级小风 2表示4~5级 以此类推
//@property (nonatomic, copy) NSString *windScale;
//不是返回的字段,自己添加的,方便使用,早间天气图片
//@property (nonatomic, copy) NSString *dayImage;
//不是返回的字段,自己添加的,方便使用,晚间天气图片
//@property (nonatomic, copy) NSString *nightImage;
//不是返回的字段,自己添加的,方便使用,日期
//@property (nonatomic, copy) NSString *dateStr;
//不是返回的字段,自己添加的,方便使用,显示周几
//@property (nonatomic, copy) NSString *weekStrStr;


-(void)setDayModel:(LXSWeatherDayModel *)dayModel{
    
    if (_dayModel == dayModel) {
        return;
    }
    
    _dayModel = dayModel;
    _dateLabel.text = dayModel.dateStr;
    _weekedLabel.text = dayModel.weekedStr;
    _windDirectionLabel.text = dayModel.windDirection;
    _windScaleLabel.text = dayModel.windScale;
    _dayImageView.image = [UIImage imageNamed:dayModel.dayImage];
    _nightImageView.image = [UIImage imageNamed:dayModel.nightImage];
}


@end
