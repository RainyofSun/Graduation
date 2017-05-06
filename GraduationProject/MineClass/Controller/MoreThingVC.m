//
//  MoreThingVC.m
//  GraduationProject
//
//  Created by MS on 17/3/9.
//  Copyright © 2017年 LR. All rights reserved.
//

#import "MoreThingVC.h"
#import "WBBaseTableView.h"

@interface MoreThingVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)NSArray* dataSource;
@property(nonatomic,strong)NSArray* titleSource;

@end

@implementation MoreThingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@{@"data":@[@{@"image":@"",@"title":@"检查更新"}]},
                        @{@"data":@[
                            @{@"image":@"",@"title":@"清除缓存"},
                            @{@"image":@"",@"title":@"定位"}]},
                        @{@"data":@[
                            @{@"image":@"",@"title":@"评价打分"},
                            @{@"image":@"",@"title":@"问题与建议"}]},
                        @{@"data":@[@{@"image":@"",@"title":@"关于"}]}];
    self.titleSource = @[@"检查更新",@"系统设置",@"反馈建议",@"关于我们"];
    [self tableView];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary* dict = self.dataSource[section];
    NSArray* array = dict[@"data"];
    return array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary* dict = self.dataSource[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:dict[@"data"][indexPath.row][@"image"]];
    cell.textLabel.text = dict[@"data"][indexPath.row][@"title"];
    return cell;
}

#pragma mark - 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
