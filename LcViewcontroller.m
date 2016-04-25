
//
//  LcViewcontroller.m
//  LC
//
//  Created by 罗超 on 16/4/21.
//  Copyright © 2016年 timeface. All rights reserved.
//

#import "LcViewcontroller.h"
#import <RETableViewManager/RETableViewSection.h>
@implementation LcViewcontroller

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"测试", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor blueColor];
    [self showBackButton];
//    [self removeStateView];
    [self showStateView:1];
    
}

- (void)didFinishLoad:(DataLoadPolicy)loadPolicy error:(NSError *)error {
    RETableViewSection *section  = [[self.dataSource.manager sections] objectAtIndex:0];
    RETableViewItem *item = [[section items] objectAtIndex:0];
    
}
- (void)actionOnView:(id)item actionType:(NSInteger)actionType {
    switch (actionType) {
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
}
-(void)actionItemClick:(id)item {
    
}
@end
