//
//  BCCaliperView.m
//  TestCommon
//
//  Created by Billy on 16/4/11.
//  Copyright © 2016年 zzjr. All rights reserved.
//

#import "BCCaliperView.h"
#import "BCScrollView.h"

@interface BCCaliperView () <UITextFieldDelegate>

@property (nonatomic, strong) BCScrollView *scrollView;
@property (nonatomic, strong) UITextField *textField_money; //监控数值变化
@end

@implementation BCCaliperView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self subViewsCration];
    }
    
    return self;
}


#pragma mark - TextField delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self.scrollView scrollToSpecifiedMoneyValue:textField.text];
}



#pragma mark - View configuraiton

- (void) subViewsCration {
    
    [self setBackgroundColor:[UIColor darkGrayColor]];
    
    // textfiled
    
    [self addSubview:self.textField_money];
    
    // 游标
    
    [self addSubview:self.scrollView];
    
    //中间指定数值的红线
    
    UIView *view_redVertical = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 1, 40, 2, self.bounds.size.height - 96)];
    [self addSubview:view_redVertical];
    
    [view_redVertical setBackgroundColor:[UIColor redColor]];
}

#pragma mark - Setter methods

- (BCScrollView *)scrollView {
    
    if(!_scrollView) {
        
        _scrollView = [[BCScrollView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.textField_money.frame) + 30, SCREEN_WIDTH, 110)];
        // 设置默认显示值为10000
        [_scrollView scrollToSpecifiedMoneyValue:@"10000"];
    }
    
    return _scrollView;
}

- (UITextField *)textField_money {
    
    if (!_textField_money) {
        
        _textField_money = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        [_textField_money setTextAlignment:NSTextAlignmentCenter];
        [_textField_money setBackgroundColor:[UIColor whiteColor]];
        [_textField_money setDelegate:self];
        [_textField_money setKeyboardType:UIKeyboardTypeNumberPad];
        [_textField_money setText:@"10000"];
        [_textField_money setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_textField_money setTextColor:[UIColor orangeColor]];
        [_textField_money setTag:88];
        [_textField_money setBackgroundColor:[UIColor darkGrayColor]];
    }
    
    return _textField_money;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self endEditing:YES];
}

@end
