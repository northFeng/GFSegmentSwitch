//
//  ViewController.m
//  GFSegmentSwitch
//
//  Created by gaoyafeng on 2018/6/25.
//  Copyright © 2018年 north_feng. All rights reserved.
//

#import "ViewController.h"

#import "GFSegmentManager.h"//引入头文件

#import "FengViewController.h"

@interface ViewController ()

/**  */
@property (nonatomic,strong) GFSegmentHead *segHead;

/**  */
@property (nonatomic,strong) GFSegmentScroll *segScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //*************************************
    //************ 用法示例 *************
    //*************************************
    
    NSArray *list = @[@"商品", @"商家信息", @"评价"];
    
    //第三方head tabBtn按钮条
    _segHead = [[GFSegmentHead alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 44) titles:list headStyle:SegmentHeadStyleLine layoutStyle:GFSegmentLayoutDefault];
    _segHead.fontScale = 1.2;
    _segHead.fontSize = 14;
    _segHead.deSelectColor = [UIColor lightGrayColor];
    _segHead.selectColor = [UIColor redColor];
    _segHead.lineScale = 1;
    _segHead.lineColor = [UIColor redColor];
    
    //第三方scrollView
    _segScroll = [[GFSegmentScroll alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segHead.frame), SCREEN_WIDTH, 300) vcOrViews:[self vcArr:list.count]];//添加子视图
    _segScroll.backgroundColor = [UIColor lightGrayColor];
    _segScroll.loadAll = YES;
    _segScroll.showIndex = 0;
    
    //绑定两个head 和 ScrollView && 使内部产生联动
    //[GFSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
    //    [self.view addSubview:_segHead];
    //    [self.view addSubview:_segScroll];
    //}];
    
    //用这个可以获取滑动的触发位置
    __weak typeof(self) weakSelf = self;
    [GFSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        [weakSelf.view addSubview:weakSelf.segHead];
        [weakSelf.view addSubview:weakSelf.segScroll];
    } selectEnd:^(NSInteger index) {
        NSLog(@"滑动到位置：%ld",index);
    }];
    
}

//获取添加的视图数组
- (NSArray *)vcArr:(NSInteger)count {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        FengViewController *vc = [[FengViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
        vc.view.backgroundColor = [UIColor lightGrayColor];
        [arr addObject:vc];
    }
    return arr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
