//
//  UIBarButtonItem+Extension.h
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/4.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)backItemWithTarget:(id)target action:(SEL)action;
@end
