//
//  LXSWeatherViewController.m
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import "LXSWeatherViewController.h"
#import "LXSWeatherModel.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "LXSWeatherView.h"
#import "TWSelectCityView.h"

@interface LXSWeatherViewController ()
//滚动
@property (nonatomic, strong) UIScrollView *scrollView;
//容器
@property (nonatomic, strong) UIView *contentView;
//天气视图
@property (nonatomic, strong) LXSWeatherView *weatherView;
//天气数据
@property (nonatomic, strong) NSArray *dataArray;
//保存导航栏图片,恢复用
//@property (nonatomic, strong) UIImage *navShadowImage;
//@property (nonatomic, strong) UIImage *navBackgroundImage;
//显示地址
@property (nonatomic, strong) UIButton *address;
@end

@implementation LXSWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self getWeatherData];
}

//透明导航栏
//-(void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    //先取出,退出时恢复用
//    _navShadowImage = [self.navigationController.navigationBar shadowImage];
//    _navBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:_navBackgroundImage forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:_navShadowImage];
//    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
//    
//}

//隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


//
-(void)setupUI{
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"BG7"].CGImage);
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.weatherView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
        make.bottom.mas_equalTo(self.weatherView).mas_offset(5);
    }];
    
    [self setNavBar];
}

//设置导航栏
-(void)setNavBar{
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"backk"] forState:UIControlStateNormal];
    [back sizeToFit];
    [self.view addSubview:back];
    back.top = 25;
    back.left = 10;
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    _address = [UIButton buttonWithType:UIButtonTypeCustom];
    [_address addTarget:self action:@selector(addressClick) forControlEvents:UIControlEventTouchUpInside];
    [_address setBackgroundColor:[UIColor clearColor]];
    [_address.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_address setTitle:@"北京市" forState:UIControlStateNormal];
    [_address setImage:[UIImage imageNamed:@"gps_location"] forState:UIControlStateNormal];
    [_address setImage:[UIImage imageNamed:@"gps_location"] forState:UIControlStateHighlighted];
    [_address setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_address sizeToFit];
    //文字在左,图片在右
    _address.titleEdgeInsets = UIEdgeInsetsMake(0,
                                      -(_address.imageView.size.width + 2),
                                      0,
                                      (_address.imageView.size.width + 2));
    
    _address.imageEdgeInsets = UIEdgeInsetsMake(0,
                                      (_address.titleLabel.size.width+ 2),
                                      0,
                                      -(_address.titleLabel.size.width+ 2));
    [self.view addSubview:_address];
    _address.centerX = SCREEN_WIDTH*0.5;
    _address.centerY = back.centerY;

}

//
-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

//contentView
-(UIView *)contentView{
    
    if (!_contentView) {
        
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}


//天气视图
-(LXSWeatherView *)weatherView{
    
    if (!_weatherView) {
        
        _weatherView = [[LXSWeatherView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    return _weatherView;
}

//获取数据
-(void)getWeatherData{
    
    //由于数据是抓来的,所以就不写接口了,这里采用本地数据
//    NSString *url = @"";
//    NSDictionary *para = @{};
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        LXSWeatherModel *data = [LXSWeatherModel mj_objectWithKeyValues:responseObject];
//        self.dataArray = data.f.f1;
//        NSLog(@"fi %@",[self.dataArray[0] windDirection]);
////        设置数据
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"error %@",error);
//    }];
    
    NSString *weatherPath = [[NSBundle mainBundle]pathForResource:@"weather.json" ofType:nil];
    NSData *wetherData = [NSData dataWithContentsOfFile:weatherPath];
    
    LXSWeatherModel *data = [LXSWeatherModel mj_objectWithKeyValues:wetherData];
    self.dataArray = data.f.f1;
    NSLog(@"fi %@",[self.dataArray[0] windDirection]);
            [self.weatherView setWeatherViewWithData:self.dataArray];
}

//选择地址
-(void)addressClick{
    
    TWSelectCityView *city = [[TWSelectCityView alloc] initWithTWFrame:self.view.bounds TWselectCityTitle:@"选择地区"];
    __weak typeof(self)blockself = self;
    [city showCityView:^(NSString *proviceStr, NSString *cityStr, NSString *distr) {
        
        [_address setTitle:[NSString stringWithFormat:@"%@%@",cityStr,distr] forState:UIControlStateNormal];
        [blockself reSetAddress];
        
        //查询天气数据
        
        NSLog(@"distr %@",cityStr);
    }];
    
}

//改变地址后重设位置和大小
-(void)reSetAddress{
    
    [_address sizeToFit];
    _address.titleEdgeInsets = UIEdgeInsetsMake(0,
                                      -(_address.imageView.size.width + 2),
                                      0,
                                      (_address.imageView.size.width + 2));
    
    _address.imageEdgeInsets = UIEdgeInsetsMake(0,
                                      (_address.titleLabel.size.width+ 2),
                                      0,
                                                -(_address.titleLabel.size.width+ 2));
    _address.centerX = SCREEN_WIDTH*0.5;
}

//返回
-(void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//状态栏
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end
