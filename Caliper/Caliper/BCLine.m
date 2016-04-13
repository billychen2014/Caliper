//
//  BCLine.m
//  TestCommon
//
//  Created by Billy on 16/4/6.
//  Copyright © 2016年 zzjr. All rights reserved.
//

#define LINESEP 10 //线与线的间隔
#define LINENUMBER (SCREEN_WIDTH/LINESEP) //一个屏幕要画多少条线
#define LINEINCREASE 10 //长线与短线高度差
#define LINEMONEYVALUE 1000 //长线与长线间隔值多少钱


#import "BCLine.h"

@interface BCLine()

@end

@implementation BCLine

#pragma mark - Addling lines

- (void) addLineForPage:(int) page {
    
    UIBezierPath *bgPath = [UIBezierPath bezierPath];
    
    for ( int i = page * LINENUMBER ; i <   LINENUMBER * (1 + page); i ++) {
        
        [bgPath moveToPoint:CGPointMake(i * LINESEP, self.bounds.size.height )];
        
        if (i%10 == 0) {
            
            [bgPath addLineToPoint:CGPointMake(i * LINESEP, self.bounds.size.height/2 - LINEINCREASE )];
            
            //添加金额说明
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i * LINESEP - MULTIPLYWIDTH(90.0/2) , -15, MULTIPLYWIDTH(90.0), MULTIPLYHEIGHT(30))];
            
            [self addSubview:label];
            
            if (i == 0) {
                
                [label setFrame:CGRectMake( 0 , -15, 10, MULTIPLYHEIGHT(30))];
            }
            [label setTextColor:[UIColor orangeColor]];
            
            if (iPhone4) {
                
                [label setFont:[UIFont systemFontOfSize:12]];
                [label setFrame:CGRectMake(i * LINESEP - MULTIPLYWIDTH(90.0/2) , -13, MULTIPLYWIDTH(90.0), MULTIPLYHEIGHT(30))];
            }else {
                
                [label setFont:[UIFont systemFontOfSize:14]];
            }
            
            [label setTextAlignment:NSTextAlignmentCenter];
            
            NSString *str_show = [self formatterNumberWithStyle:NSNumberFormatterDecimalStyle formatterString:[NSString stringWithFormat:@"%d",LINEMONEYVALUE*(i/10) ]];
            
            [label setText:str_show];
            
            [label setAdjustsFontSizeToFitWidth:YES];
            
        }else {
            
            [bgPath addLineToPoint:CGPointMake(i * LINESEP, self.bounds.size.height/2 )];
        }
    }
    
    CAShapeLayer *tmp = [CAShapeLayer layer];
    
    [tmp setStrokeStart:0.0];
    [tmp setStrokeEnd:1.0];
    [tmp setStrokeColor:[UIColor lightGrayColor].CGColor];
    [tmp setFillColor:[UIColor clearColor].CGColor]; //fill color默认为clear color
    [tmp setPath:bgPath.CGPath];
    [tmp setLineWidth:1.0];
    
    [self.layer addSublayer:tmp];
}

#pragma mark - Setter methods

- (void)setCurrnetPage:(int)currnetPage {
    
    _currnetPage = currnetPage;
    
    [self addLineForPage:currnetPage]; //为当前页面画线
    
    //添加最底部的线
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * currnetPage, self.bounds.size.height -1, self.bounds.size.width, 1)];
    [self addSubview:view];
    
    [view setBackgroundColor:[UIColor lightGrayColor]];
}

//显示格式

- (NSString *) formatterNumberWithStyle:(NSNumberFormatterStyle)style formatterString:(NSString *) formatterStr{
    
    NSString *str_result = nil;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:style];
    
    if ([formatterStr containsString:@"."]) {
        
        NSString *str_prefix = [formatterStr componentsSeparatedByString:@"."].firstObject;
        NSString *str_suffxi = [formatterStr componentsSeparatedByString:@"."].lastObject;
        if (formatterStr) {
            
            str_result = [formatter stringFromNumber:[NSNumber numberWithInt:str_prefix.intValue]];
            str_result = [NSString stringWithFormat:@"%@.%@",str_result,str_suffxi];
        }else {
            str_result = @"";
        }
    }else {
        
        str_result = [formatter stringFromNumber:[NSNumber numberWithInt:formatterStr.intValue]];
    }
    
    return str_result;
}

@end
