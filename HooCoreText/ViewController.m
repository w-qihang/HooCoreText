//
//  ViewController.m
//  HooCoreText
//
//  Created by 汪启航 on 2018/9/7.
//  Copyright © 2018年 q.h. All rights reserved.
//

#import "ViewController.h"
#import "HooCoreTextView.h"
@interface ViewController ()
{
    HooCoreTextView *view1,*view2,*view3;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    view1 = [[HooCoreTextView alloc] initWithFrame:CGRectMake(20, 50, self.view.frame.size.width-40, 150)];
    [view1 setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:view1];
    [view1.muastring appendString:@"123456"];
    [view1.muastring appendString:@"ashdjahsdhakjas" font:[UIFont systemFontOfSize:20] color:[UIColor blueColor]];
    [view1 appendSpaceWithWidth:40 height:40 backgroundColor:[UIColor redColor]];
    [view1 appendNewLineWithHeight:20];

    [view1 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50)];

    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    slider.backgroundColor = [UIColor greenColor];
    [view1 appendView:slider];
    
    view2 = [[HooCoreTextView alloc] initWithFrame:CGRectMake(20, 250, self.view.frame.size.width-40, 150) lineVerticalAlignment:kLineVerticalAlignmentCenter];
    [view2 setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:view2];
    
    [view2.muastring appendString:@"123456"];
    [view2 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 30, 30)];
    [view2.muastring appendString:@"ashdjahsdhakjas" font:[UIFont systemFontOfSize:20] color:[UIColor blueColor]];
    [view2 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 30, 30)];
    [view2.muastring appendString:@"123456" font:[UIFont systemFontOfSize:30]];
    [view2.muastring appendString:@"ashdjahsdhakjas" font:[UIFont systemFontOfSize:25] color:[UIColor blueColor]];
    [view2 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50)];
    [view2.muastring hoo_setAlignment:NSTextAlignmentLeft];
    
    view3 = [[HooCoreTextView alloc] initWithFrame:CGRectMake(20, 450, self.view.frame.size.width-40, 150) lineVerticalAlignment:kLineVerticalAlignmentBottom];
    [view3 setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:view3];
    [view3.muastring appendString:@"123456"];
    [view3 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50)];
    [view3 appendNewLine];
    [view3.muastring appendString:@"ashdjahsdhakjas" font:[UIFont systemFontOfSize:20] color:[UIColor blueColor]];
    [view3 appendNewLineWithHeight:20];
    [view3.muastring appendString:@"123456" font:[UIFont systemFontOfSize:30]];
    [view3 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 30, 30)];
    [view3.muastring appendString:@"ashdjahsdhakjas" font:[UIFont systemFontOfSize:25] color:[UIColor blueColor]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

@end
