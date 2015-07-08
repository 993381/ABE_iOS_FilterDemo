//
//  FilterIos8BlurViewController.m
//  FilterIImageDemo
//
//  Created by 戴益波 on 15/7/5.
//  Copyright (c) 2015年 戴益波. All rights reserved.
//

#import "FilterIos8BlurViewController.h"

@interface FilterIos8BlurViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *luImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ldImageView;
@property (strong, nonatomic) IBOutlet UIImageView *ruImageView;
@property (strong, nonatomic) IBOutlet UIImageView *rdImageView;

@end

@implementation FilterIos8BlurViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //initlization
        [self initlization];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadBaseUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initlization{
    
}

- (void)loadBaseUI{
    self.luImageView.image = [UIImage imageNamed:@"Image1"];
    self.ldImageView.image = [UIImage imageNamed:@"Image1"];
    self.ruImageView.image = [UIImage imageNamed:@"Image1"];
    self.rdImageView.image = [UIImage imageNamed:@"Image1"];
}

- (void)viewDidLayoutSubviews{
    //设置模糊，效果为BlurEffectStyleLight
    UIVisualEffectView *ruVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    ruVisualEffectView.frame = self.ruImageView.bounds;
    ruVisualEffectView.alpha = 1.0;
    [self.ruImageView addSubview:ruVisualEffectView];
    
    //设置模糊，效果为BlurEffectStyleDark
    UIVisualEffectView *ldVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    ldVisualEffectView.frame = self.ldImageView.bounds;
    ldVisualEffectView.alpha = 1.0;
    [self.ldImageView addSubview:ldVisualEffectView];
    
    //设置模糊，效果为BlurEffectStyleExtraLight
    UIVisualEffectView *rdVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    rdVisualEffectView.frame = self.rdImageView.bounds;
    rdVisualEffectView.alpha = 1.0;
    [self.rdImageView addSubview:rdVisualEffectView];
}

@end
