//
//  UILabel+Custom.m
//  
//
//  Created by 梁兴胜 on 16/7/25.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import "UILabel+Custom.h"

@implementation UILabel (Custom)

-(UILabel *)customLabelWithText:(NSString *)text font:(CGFloat)size color:(UIColor *)textColor{
    
    UILabel *cust = [[UILabel alloc] init];
    [cust setText:text];
    [cust setFont:[UIFont systemFontOfSize:size?size:12]];
    [cust setTextColor:textColor?textColor:[UIColor blackColor]];
    [cust sizeToFit];
    return cust;
}

@end
