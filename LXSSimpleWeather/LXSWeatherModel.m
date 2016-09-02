//
//  LXSWeatherModel.m
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import "LXSWeatherModel.h"
#import "MJExtension.h"

@implementation LXSWeatherModel

@end

@implementation LXSWeatherInfo

@end


@implementation LXSWeatherWeekModel

+ (NSDictionary *)objectClassInArray{
    return @{@"f1" : [LXSWeatherDayModel class]};
}

@end


@implementation LXSWeatherDayModel

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

// 此方法为MJExtension中的,用于修改属性名和key的对应关系
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{
             @"windDirection" : @"fe",
             @"dayCond" : @"fa",
             @"nightCond" : @"fb",
             @"maxTmp" : @"fc",
             @"minTmp" : @"fd",
             @"windScale" : @"fg"
             };
}




///  此方法为MJExtension中的,用于过滤字典的值
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    
    if ([property.name isEqualToString:@"windDirection"]) {
        return [self setWindDirectionValuesFor:oldValue];
    }else if ([property.name isEqualToString:@"dayCond"]){
        return [self setDayCondValuesFor:oldValue];
    }else if ([property.name isEqualToString:@"nightCond"]){
        return [self setNightCondValuesFor:oldValue];
    }else if ([property.name isEqualToString:@"windScale"]){
        return [self setWindScaleValuesFor:oldValue];
    }else if ([property.name isEqualToString:@"maxTmp"] || [property.name isEqualToString:@"minTmp"]){
        return [self setTmpValuesFor:oldValue];
    }
    
    return oldValue;
}


-(NSString *)setWindDirectionValuesFor:(id)oldValue{
    
    NSInteger old = [oldValue integerValue];
    
        switch (old) {
            case 0:{
                return @"无持续\n风向";
            }
                break;
            case 1:{
                return @"东北风";
            }
                break;
            case 2:{
                return @"东风";
            }
                break;
            case 3:{
                return @"东南向";
            }
            case 4:{
                return @"南风";
            }
                break;
            case 5:{
                return @"西南风";
            }
                break;
            case 6:{
                return @"西风";
            }
                break;
            case 7:{
                return @"西北风";
            }
                break;
            case 8:{
                return @"北风";
            }
                break;
                
            default:
                break;
        }
    return oldValue;
}


-(NSString *)setDayCondValuesFor:(id)oldValue{
    
    NSInteger old = [oldValue integerValue];
    
    switch (old) {
        case 0:{
            _dayImage = @"qing";
            return @"晴";
        }
            break;
        case 1:{
            _dayImage = @"duoyun";
            return @"多云";
        }
            break;
        case 2:{
            _dayImage = @"yin";
            return @"阴";
        }
            break;
        case 3:{
            _dayImage = @"zhenyu";
            return @"阵雨";
        }
        case 4:{
            _dayImage = @"qing";
            return @"待定";
        }
            break;
        case 5:{
            _dayImage = @"qing";
            return @"待定";
        }
            break;
        case 6:{
            _dayImage = @"qing";
            return @"待定";
        }
            break;
        case 7:{
            _dayImage = @"xiaoyu";
            return @"小雨";
        }
            break;
        case 8:{
            _dayImage = @"zhongyu";
            return @"中雨";
        }
            break;
        case 9:{
            _dayImage = @"dayu";
            return @"大雨";
        }
            break;
            
        default:
            break;
    }
    return oldValue;
}

-(NSString *)setNightCondValuesFor:(id)oldValue{
    
    NSInteger old = [oldValue integerValue];
    
    switch (old) {
        case 0:{
            _nightImage = @"qing";
            return @"晴";
        }
            break;
        case 1:{
            _nightImage = @"duoyun";
            return @"多云";
        }
            break;
        case 2:{
            _nightImage = @"yin";
            return @"阴";
        }
            break;
        case 3:{
            _nightImage = @"zhenyu";
            return @"阵雨";
        }
        case 4:{
            _nightImage = @"qing";
            return @"待定";
        }
            break;
        case 5:{
            _nightImage = @"qing";
            return @"待定";
        }
            break;
        case 6:{
            _nightImage = @"qing";
            return @"待定";
        }
            break;
        case 7:{
            _nightImage = @"xiaoyu";
            return @"小雨";
        }
            break;
        case 8:{
            _nightImage = @"zhongyu";
            return @"中雨";
        }
            break;
        case 9:{
            _nightImage = @"dayu";
            return @"大雨";
        }
            break;
            
        default:
            break;
    }
    return oldValue;
}


-(NSString *)setWindScaleValuesFor:(id)oldValue{
    
    NSInteger old = [oldValue integerValue];
    
    switch (old) {
        case 0:{
            return @"无风";
        }
            break;
        case 1:{
            return @"3~4级";
        }
            break;
        case 2:{
            return @"4~5级";
        }
            break;
        case 3:{
            return @"5~6级";
        }
        case 4:{
            return @"6~7级";
        }
            break;
        case 5:{
            return @"7~8级";
        }
            break;
        case 6:{
            return @"8~9级";
        }
            break;
        case 7:{
            return @"9~10级";
        }
            break;
        case 8:{
            return @"10~11级";
        }
            break;
        case 9:{
            return @"11~12级";
        }
            break;
            
        default:
            break;
    }
    return oldValue;
}

-(NSString *)setTmpValuesFor:(id)oldValue{
    
    NSString *tmp= [NSString stringWithFormat:@"%@℃",(NSString *)oldValue];
    return tmp;
}

@end
