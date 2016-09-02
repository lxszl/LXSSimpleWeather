//
//  LXSWeatherLineView.m
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import "LXSWeatherLineView.h"
#import "LXSWeatherModel.h"

//#define dayColor [UIColor colorWithRed:(250 / 255.0) green:(99 / 255.0) blue:(101 / 255.0) alpha:1.0]
//#define nightColor [UIColor colorWithRed:(72 / 255.0) green:(149 / 255.0) blue:(240 / 255.0) alpha:1.0]
#define dayColor [UIColor whiteColor]
#define nightColor [UIColor whiteColor]

@implementation LXSWeatherLineView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
}


- (void)drawRect:(CGRect)rect {

    [[UIColor whiteColor]set];
    
    LXSWeatherDayModel *weather = nil;
    NSMutableArray *maxTmp = [NSMutableArray array];
    NSMutableArray *minTmp = [NSMutableArray array];
    NSMutableArray *maxPoints = [NSMutableArray array];
    NSMutableArray *minPoints = [NSMutableArray array];
    
    if (!self.dataArray.count) {
        //如果没数据
        maxTmp = @[@"23℃",@"24℃",@"26℃",@"28℃",@"23℃",@"24℃",@"36℃"].mutableCopy;
        minTmp = @[@"16℃",@"15℃",@"17℃",@"15℃",@"17℃",@"18℃",@"16℃"].mutableCopy;
    }
        for (int i = 1; i< 7; i++) {
            weather = self.dataArray[i];
            [maxTmp addObject:weather.maxTmp];
            [minTmp addObject:weather.minTmp];
        }
    
    NSInteger max = [[maxTmp valueForKeyPath:@"@max.intValue"]integerValue];
    NSInteger min = [[minTmp valueForKeyPath:@"@min.intValue"]integerValue];
    double firstX = self.frame.size.width / 12;
    double xLenth = firstX * 2;
    double yLenth = self.frame.size.height;
    double gap = yLenth / (max - min);
    
    UIBezierPath *dayLinePath = [UIBezierPath bezierPath];
    UIBezierPath *dayPointPath = [UIBezierPath bezierPath];
    UIBezierPath *nightLinePath = [UIBezierPath bezierPath];
    UIBezierPath *nightPointPath = [UIBezierPath bezierPath];
    
    CGSize paddingSize = [@"23℃" sizeWithAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:12]}];
    CGFloat paddingX = paddingSize.width * 0.5;
    CGFloat paddingY = paddingSize.height + 10;
    //温度转化为坐标点，填入对应数组，绘制点
    CGPoint point;
    for (int i = 0; i < 6; i++) {
        NSString *maxtemp = maxTmp[i];
        NSInteger maxi = maxtemp.intValue;
        NSString *mintemp = minTmp[i];
        NSInteger mini = mintemp.intValue;
        point = CGPointMake(firstX + i * xLenth, (max - maxi) * gap+yLenth*0.15);
        [maxPoints addObject:[NSValue valueWithCGPoint:point]];
        
        [dayPointPath moveToPoint:point];
        [dayPointPath addArcWithCenter:point radius:3.0 startAngle:M_PI * 2 endAngle:0 clockwise:NO];
        //
        [maxTmp[i] drawAtPoint:CGPointMake(point.x-paddingX, point.y-paddingY) withAttributes:@{NSForegroundColorAttributeName : dayColor,NSFontAttributeName : [UIFont systemFontOfSize:12]}];
//        [maxTmp[i] drawAtPoint:CGPointMake(point.x-paddingX, point.y-paddingY) withAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        
        [dayColor set];
        [dayPointPath fill];
        
        //
        point = CGPointMake(firstX + i * xLenth, (max - mini) * gap-yLenth*0.15);
        [minPoints addObject:[NSValue valueWithCGPoint:point]];
        
        [nightPointPath moveToPoint:point];
        [nightPointPath addArcWithCenter:point radius:3.0 startAngle:M_PI * 2 endAngle:0 clockwise:NO];
        //
        [minTmp[i] drawAtPoint:CGPointMake(point.x-paddingX, point.y-paddingY) withAttributes:@{NSForegroundColorAttributeName : nightColor,NSFontAttributeName : [UIFont systemFontOfSize:12]}];
//        [minTmp[i] drawAtPoint:CGPointMake(point.x-paddingX, point.y-paddingY) withAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        
        [nightColor set];
        [nightPointPath fill];
    }
    
    [maxPoints enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = [obj CGPointValue];
        
        if (idx == 0) {
            [dayLinePath moveToPoint:point];
        } else {
            
            [dayLinePath addLineToPoint:point];
        }
    }];
    [dayColor set];
    [dayLinePath stroke];
    
    [minPoints enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = [obj CGPointValue];
        
        if (idx == 0) {
            [nightLinePath moveToPoint:point];
        } else {
            [nightLinePath addLineToPoint:point];
        }
    }];
    
    [nightColor set];
    [nightLinePath stroke];
}

@end
