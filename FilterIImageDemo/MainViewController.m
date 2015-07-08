//
//  MainViewController.m
//  FilterIImageDemo
//
//  Created by 戴益波 on 15/7/3.
//  Copyright (c) 2015年 戴益波. All rights reserved.
//

#import "MainViewController.h"

#import "FilterICImageViewController.h"
#import "FilterGPUViewController.h"
#import "FilterVImageViewController.h"
#import "FilterIos8BlurViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) IBOutlet UIButton *ICFilterButton;
@property (strong, nonatomic) IBOutlet UIButton *GPUFilterButton;
@property (strong, nonatomic) IBOutlet UIButton *vImageButton;
@property (strong, nonatomic) IBOutlet UIButton *ios8BlurButton;


@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //initlization
        [self initlizaition];
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

- (void)initlizaition{
    
}

- (void)loadBaseUI{
    self.title = @"滤镜demo";
    
    //button
    [self.ICFilterButton addTarget:self action:@selector(clickICFilterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.GPUFilterButton addTarget:self action:@selector(clickGPUFilterButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.vImageButton addTarget:self action:@selector(clickVImageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ios8BlurButton addTarget:self action:@selector(clickIos8BlurButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark- private method
- (void)clickICFilterBtn:(UIButton*)button{
    FilterICImageViewController *view = [[FilterICImageViewController alloc] initWithNibName:@"FilterICImageViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)clickGPUFilterButton:(UIButton*)button{
    FilterGPUViewController *view = [[FilterGPUViewController alloc] initWithNibName:@"FilterGPUViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)clickVImageButtonAction:(UIButton*)button{
    FilterVImageViewController *view = [[FilterVImageViewController alloc] initWithNibName:@"FilterVImageViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)clickIos8BlurButtonAction:(UIButton*)button{
    FilterIos8BlurViewController *view = [[FilterIos8BlurViewController alloc] initWithNibName:@"FilterIos8BlurViewController" bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
}

@end
