//
//  ViewController.m
//  LXSSimpleWeather
//
//  Created by 梁兴胜 on 16/9/2.
//  Copyright © 2016年 lxs. All rights reserved.
//

#import "ViewController.h"
#import "LXSWeatherViewController.h"

@interface ViewController ()

@end

//  部分代码和素材来自https://github.com/SilentWalker/SimpleWeather
//                 https://github.com/jiachenmu/WallpaperWeather


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)push {
    
    [self.navigationController pushViewController:[[LXSWeatherViewController alloc] init] animated:YES];
}

@end
