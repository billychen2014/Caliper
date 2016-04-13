//
//  BCCaliperScrollView.m
//  NiuBanGold
//
//  Created by Billy on 16/4/12.
//  Copyright © 2016年 zzjr. All rights reserved.
//

#import "BCScrollView.h"
#import "BCLine.h"

@interface BCScrollView () <UIScrollViewDelegate>

@property (nonatomic, assign) int currentPage; //当前显示的页数

@end

@implementation BCScrollView

#pragma mark - Scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 计算当前page
    int page = (int)scrollView.contentOffset.x/SCREEN_WIDTH ;
    
    // 自动扩展contentSize if needed
    if (page >=2 ) {
        
        [self setContentSize:CGSizeMake(SCREEN_WIDTH *(page +2), 0)];
    }
    
    //确定 左右滑动
    
    if (self.currentPage > page) { //右滑
        
        if (page >= 0) {
            
            [self destoryOffScreenViewByPage:(page +2)];//干掉一个
            [self addingLineToScrollViewByPage:(page -1 )]; //创建一个
            
            NSLog(@"当前显示第%d页面，预加载第%d页的线 ,删除第%d页的线:",page, page-1,page+2);
        }
        
    }else  if (self.currentPage < page){ //左滑
        
        if (page >= 1) { //最开始有，0，1，2 三张，左滑到当前显示为2的时候，就应该画第3张，那么删除第0张，保持有三张
            
            [self addingLineToScrollViewByPage:(page +1 )]; //创建一个
            
            [self destoryOffScreenViewByPage:(page - 2)];//干掉一个
            
            NSLog(@"当前显示第%d页面，预加载第%d页的线 ,删除第%d页的线:",page, page+1,page-2);
        }
    }
    
    // 用于判定左滑右滑
    self.currentPage = page;
    
    // 当前页面滚动的时候对应的值,显示到父view上的textfiled里
    
    NSString *value_scrolled = [self currentShownValueinPage:scrollView.contentOffset.x];//可以用于显示当前滚动的值
    
    if (self.superview) {
        
        UITextField *textFiled = [self.superview viewWithTag:88];
        [textFiled setText:value_scrolled];
    }
    
    // 控制最左边只能显示到100
    
    if (scrollView.contentOffset.x <=10) { //用户只能滚动到100，不能滚动到0
        
        CGPoint offSet = scrollView.contentOffset;
        offSet.x = 10;
        
        [scrollView setContentOffset:offSet animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.superview) { //保证显示为100的整数倍
        
        NSString *str_selectedMoney = [self currentShownValueinPage:scrollView.contentOffset.x];
        
        int acutalValue = str_selectedMoney.intValue / 100 * 100 + ( str_selectedMoney.intValue  % 100 < 50 ? 0 : 100) ;
        UITextField *textFiled = [self.superview viewWithTag:88];
        [textFiled setText:[NSString stringWithFormat:@"%d",acutalValue]];
        [self scrollToSpecifiedMoneyValue:[NSString stringWithFormat:@"%d",acutalValue]];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.superview) { //保证显示为100的整数倍
        
        NSString *str_selectedMoney = [self currentShownValueinPage:scrollView.contentOffset.x];
        
        int acutalValue = str_selectedMoney.intValue / 100 * 100 + ( str_selectedMoney.intValue  % 100 < 50 ? 0 : 100) ;
        UITextField *textFiled = [self.superview viewWithTag:88];
        [textFiled setText:[NSString stringWithFormat:@"%d",acutalValue]];
        [self scrollToSpecifiedMoneyValue:[NSString stringWithFormat:@"%d",acutalValue]];
    }
}

#pragma mark - Location postion of specified value

- (void) scrollToSpecifiedMoneyValue:(NSString *) moneyValue {
    
    int page =   moneyValue.intValue / (SCREEN_WIDTH /10  * 100 );//  一个屏幕的钱
    
    // 去掉旧的 (理论上应该去掉这三个值，重新绘制)
    //            [self destoryOffScreenViewByPage:0];
    //            [self destoryOffScreenViewByPage:1];
    //            [self destoryOffScreenViewByPage:2];
    
    // 设置新的默认三个页面
    [self addingLineToScrollViewByPage:page];
    [self addingLineToScrollViewByPage:page+1];
    [self addingLineToScrollViewByPage:page-1];
    
    /*
     *   算法描述
     *    每一个页面有起始值，那么指定值会与起始值会有一定的差額，算出这个差额将offsetx加上即可
     */
    
    float startValue = SCREEN_WIDTH/10 *100 * page; // 10 和100 的设置基准 是来源于LINESEP ,LINEMONEYVALUE/10 (BCLine.m里的宏定义)
    
    float offSetx = (moneyValue.intValue - startValue )/100  *10 ;
    
    [self setContentOffset:CGPointMake(SCREEN_WIDTH * page+offSetx  ,0) animated:YES];
}

// 跳到选中的值
- (NSString *) currentShownValueinPage:(CGFloat) offSet {
    
    NSString *str_value = [NSString stringWithFormat:@"%.f", offSet/10*100];
    
    return str_value;
}


#pragma mark - Initial && configure

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self scrollViewConfiguration];
    }
    
    return self;
}

- (void) scrollViewConfiguration {
    
    [self setDelegate:self];
    [self setBounces:YES];
    [self setContentSize:CGSizeMake(SCREEN_WIDTH *3, 0)];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    
    for (int i =0 ; i < 3; i ++) {
        
        [self addingLineToScrollViewByPage:i];
    }
}

#pragma mark - Adding lines

// 添加线的方法
- (void) addingLineToScrollViewByPage: (int ) page {
    
    if (page >= 0) {
        
        BCLine *line = [[BCLine alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 20, SCREEN_WIDTH, MULTIPLYHEIGHT(40.0))];
        
        line.currnetPage = page;
        
        [line setTag:page+30];
        
        [self addSubview:line];
        
        //        NSLog(@"预加载第%d页的线:",page);
    }else {
        
        NSLog(@"没必要画不存在的线");
    }
}

#pragma mark - Remove lines

- (void) destoryOffScreenViewByPage:(int) page {
    
    if (page >=0) {
        
        BCLine *line = [self viewWithTag:(page +30)];
        
        //        NSLog(@"清除第%d页的线:",page);
        //清除line本身
        [line removeFromSuperview];
        
        //        [line.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        for (int i =0 ; i ++; i < line.subviews.count) {
            
            UIView *view_tmp = [line.subviews objectAtIndex:i];
            
            [view_tmp removeFromSuperview];
            view_tmp = nil;
        }
        
        line = nil;
    }else {
        
        NSLog(@"没必删除不存在的线");
    }
}

@end
