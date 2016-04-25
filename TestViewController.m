//
//  TestViewController.m
//  LC
//
//  Created by zguanyu on 10/26/15.
//  Copyright © 2015 timeface. All rights reserved.
//

#import "TestViewController.h"
#import "LcViewcontroller.h"
#import "TNavigationViewController.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self removeStateView];
//    [self showStateView:]
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap{
    LcViewcontroller *vc = [[LcViewcontroller alloc]init];
//    TNavigationViewController *nav = [[TNavigationViewController alloc]initWithRootViewController:vc];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
