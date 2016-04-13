//
//  Common.h
//  Caliper
//
//  Created by Billy on 16/4/13.
//  Copyright © 2016年 zzjr. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define MULTIPLYWIDTH(x) x*SCALE_RATE_WIDTH
#define MULTIPLYHEIGHT(x) x*SCALE_RATE_HEIGHT

#define SCALE_RATE_HEIGHT SCREEN_HEIGHT *2.0/1334
#define SCALE_RATE_WIDTH SCREEN_WIDTH *2.0/750

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#endif /* Common_h */
