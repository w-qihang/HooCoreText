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
    //[view1 appendNewLine];
    [view1 appendImage:[UIImage imageNamed:@"test"] ];
    //[view1 appendNewLine];
    //[view1.muastring appendString:@"999999999djhfalvlafdkadvjakdfhk999999999djhfalvlafdkadvjakdfhk999999999djhfalvlafdkadvjakdfhk999999999djhfalvlafdkadvjakdfhk999999999djhfalvlafdkadvjakdfhk999999999djhfalvlafdkadvjakdfhk999999999djhfalvlafdkadvjakdfhk" font:[UIFont systemFontOfSize:10] color:[UIColor blueColor]];
    
    [view1 appendSpaceWithWidth:40 height:40 backgroundColor:[UIColor redColor]];
    //[view1 appendNewLine];Z
    [view1.muastring appendString:@"wwwww"];
    [view1.muastring appendString:@"123456" font:[UIFont systemFontOfSize:20]];
    [view1 appendNewLine];
    [view1.muastring appendString:@"wwwww"];
    [view1 appendNewLineWithHeight:20];
    [view1.muastring appendString:@"wwwww"];
    //view1.muastring = [[NSMutableAttributedString alloc]initWithString:@"666"];
    //[view1 appendImage:[UIImage imageNamed:@"test"]];
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
    slider.backgroundColor = [UIColor greenColor];
    [view1 appendView:slider];
    
    //[view1.muastring hoo_setLineSpacing:5];
    //[view1 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(0, 0, 50, 50) ];
    [view1.muastring appendString:@"999999999djhfalvlafdkadvjakdfhk"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[view1 appendImage:[UIImage imageNamed:@"test"] frame:CGRectMake(10, 10, 50, 50)];
    //view1.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //[view1 appendNewLine];
    //view1.muastring = [[NSMutableAttributedString alloc]initWithString:@"666" attributes:nil];
    [view1.muastring hoo_setFirstLineHeadIndent:5];
    [view1.muastring hoo_setHeadIndent:5];
    //[view1 setContentInsets:UIEdgeInsetsMake(10, 10, 20, 0)];
    //[view1.muastring hoo_setLineSpacing:5];
    //[view1 hoo_resizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

@end
