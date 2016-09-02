//
//  UILabel+Custom.h
//  
//
//  Created by 梁兴胜 on 16/7/25.
//  Copyright © 2016年 梁兴胜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Custom)
///  自定义label
-(UILabel *)customLabelWithText:(NSString *)text font:(CGFloat)size color:(UIColor *)textColor;
@end
