//
//  ViewController.m
//  WinnerCycle
//
//  Created by xubojoy on 2017/11/28.
//  Copyright © 2017年 xubojoy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *dateSourceArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dateSourceArray = @[@"静夜思",@"床前明月光",@"疑是地上霜",@"举头望明月",@"低头思故乡",@"静夜思",@"床前明月光",@"疑是地上霜",@"举头望明月",@"低头思故乡"];
    [self setUpUI];
}

- (void)setUpUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,100, self.view.bounds.size.width, 150) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self startAnimation];
}

- (void)startAnimation{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
//    if (@available(iOS 10.0, *)) {
//        self.displayLink.preferredFramesPerSecond = 1;
//    } else {
//        // Fallback on earlier versions
//    }
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
}

//CADisplayLink 定时器 系统默认每秒调用60次
- (void) tick:(CADisplayLink *)displayLink {
    
    self.count ++;
    //(25.0 / 30.0) * (float)self.count) ---> (tableview需要滚动的contentOffset / 一共调用的次数) * 第几次调用
    //比如该demo中 contentOffset最大值为 = cell的高度 * cell的个数 ,(150/60)秒执行一个循环则调用次数为 150,每1/60秒 count计数器加1,当count=300时,重置count为0,实现循环滚动.
    int totalCount = (int)(self.dateSourceArray.count/2);
    [self.tableView setContentOffset:CGPointMake(0, ((totalCount*30 / (totalCount*30)) * (float)self.count)) animated:NO];
    if (self.count >= totalCount*30) {
        self.count = 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dateSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dateSourceArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 30;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
