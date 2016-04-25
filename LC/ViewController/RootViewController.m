//
//  RootViewController.m
//  LC
//
//  Created by 罗超 on 16/4/22.
//  Copyright © 2016年 timeface. All rights reserved.
//

#import "RootViewController.h"
#import "TNavigationViewController.h"


#import "TestViewController.h"
#import "LcViewcontroller.h"


#define kTabbarDiscoveryImage    1231
#define kTabbarMineImage         1230
#define kTabbarTimeCircleImage   1232

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    
    [JDStatusBarNotification addStyleNamed:@"PostTimeStyle"
                                   prepare:^JDStatusBarStyle *(JDStatusBarStyle *style)
     {
         style.barColor          = [UIColor blueColor];
         style.textColor         = [UIColor whiteColor];
         
         style.animationType     = JDStatusBarAnimationTypeMove;
         style.progressBarHeight = 2.0;
         return style;
     }];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupViewControllers {
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
                                             forState:UIControlStateSelected];
    
    
    
    
    TestViewController *homeViewController = [[TestViewController alloc]init];
    TNavigationViewController *tNavHome = [[TNavigationViewController alloc]initWithRootViewController:homeViewController];
    tNavHome.tabBarItem = [[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"首页", nil)
                                                       image:[[UIImage imageNamed:@"tabbarIconHome.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[[UIImage imageNamed:@"tabbarIconHomeSelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    
    LcViewcontroller *mainPagerViewController = [[LcViewcontroller alloc]init];
    TNavigationViewController *tNavDiscovery = [[TNavigationViewController alloc]initWithRootViewController:mainPagerViewController];
    tNavDiscovery.tabBarItem = [[UITabBarItem alloc]initWithTitle:NSLocalizedString(@"发现", nil)
                                                            image:[[UIImage imageNamed:@"tabbarIconDicovery.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                    selectedImage:[[UIImage imageNamed:@"tabbarIconDicoverySelected.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    tNavDiscovery.tabBarItem.tag = 1231;
    
       [self setViewControllers:@[tNavHome,tNavDiscovery]];
    [self.tabBar setBackgroundImage:[[Utility sharedUtility] createImageWithColor:[UIColor greenColor]]];
    
    UIView *viewTagGuide = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    viewTagGuide.backgroundColor = [UIColor clearColor];
    viewTagGuide.tag = 10002;
    [self.tabBar addSubview:viewTagGuide];
    CGFloat sw = self.tabBar.tfWidth / 4;
    viewTagGuide.tfCenterX = sw * 2.5;
    viewTagGuide.tfTop = 20.f;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    TFAsyncRun(^{
        //        [self checkNewVersion];
//        [[TFUploadAssistant sharedInstanceWithConfiguration:_configuration] checkTask];
        //        [[UploadAssistant sharedAssistant] startAllTask];
    });
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[[Utility sharedUtility] createImageWithColor:RGBACOLOR(255, 255, 255, 0)]];
    imageView.tfWidth = self.tabBar.tfWidth / 5 / 2;
    imageView.tfHeight = self.tabBar.tfHeight - 5;
    imageView.tfCenterX = self.tabBar.tfWidth / 10 * 3;
    imageView.tfCenterY = self.tabBar.tfHeight / 2;
    
    //    imageView.layer.borderWidth = 1;
    imageView.tag = kTabbarDiscoveryImage;
    
    [self.tabBar addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithImage:[[Utility sharedUtility] createImageWithColor:RGBACOLOR(255, 255, 255, 0)]];
    imageView2.tfWidth = self.tabBar.tfWidth / 5 / 2;
    imageView2.tfHeight = self.tabBar.tfHeight - 5;
    imageView2.tfCenterX = self.tabBar.tfWidth / 10 * 9;
    imageView2.tfCenterY = self.tabBar.tfHeight / 2;
    
    //    imageView2.layer.borderWidth = 1;
    imageView2.tag = kTabbarMineImage;
    
    [self.tabBar addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithImage:[[Utility sharedUtility] createImageWithColor:RGBACOLOR(255, 255, 255, 0)]];
    imageView3.tfWidth = self.tabBar.tfWidth / 5 / 2;
    imageView3.tfHeight = self.tabBar.tfHeight - 5;
    imageView3.tfCenterX = self.tabBar.tfWidth / 10 * 7;
    imageView3.tfCenterY = self.tabBar.tfHeight / 2;
    
    //    imageView2.layer.borderWidth = 1;
    imageView3.tag = kTabbarTimeCircleImage;
    
    [self.tabBar addSubview:imageView3];
    
  
    
}


- (void)actionCircleMenuClick:(NSString *)title {
    
}
@end
