//
//  FilterGPUViewController.m
//  FilterIImageDemo
//
//  Created by 戴益波 on 15/7/4.
//  Copyright (c) 2015年 戴益波. All rights reserved.
//

#import "FilterGPUViewController.h"
#import "GPUImage.h"

@interface FilterGPUViewController ()

@property (strong, nonatomic) UIImage *orignalImage;
@property (strong, nonatomic) UIImage *GPUImage;

@property (strong, nonatomic) IBOutlet UIImageView *GPUImageView;
@property (strong, nonatomic) IBOutlet UIButton *sepiaFilterButton;
@property (strong, nonatomic) IBOutlet UIButton *exposureFilterButton;
@property (strong, nonatomic) IBOutlet UIButton *RGBFilterButton;
@property (strong, nonatomic) IBOutlet UIButton *gaussianFilterButton;

@end

@implementation FilterGPUViewController
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
}

- (void)initlization{
    self.orignalImage = [UIImage imageNamed:@"GPUImage"];
}

- (void)loadBaseUI{
    self.title = @"GPU滤镜";
    
    [self.sepiaFilterButton addTarget:self action:@selector(clickSepiaFilterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.exposureFilterButton addTarget:self action:@selector(clickExposureFilterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.RGBFilterButton addTarget:self action:@selector(clickRGBFilterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.gaussianFilterButton addTarget:self action:@selector(clickGaussianFilterButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark- Get, Set
- (void)setGPUImage:(UIImage *)GPUImage{
    if (GPUImage == nil) return;
    
    _GPUImage = GPUImage;
    self.GPUImageView.image = _GPUImage;
}

#pragma mark- Private method
- (void)clickSepiaFilterButtonAction:(UIButton*)button{
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    self.GPUImage = [sepiaFilter imageByFilteringImage:self.orignalImage];
}

- (void)clickExposureFilterButtonAction:(UIButton*)button{
    GPUImageExposureFilter *exposureFilter = [[GPUImageExposureFilter alloc] init];
    exposureFilter.exposure = 0.8;
    self.GPUImage = [exposureFilter imageByFilteringImage:self.orignalImage];
}

- (void)clickRGBFilterButtonAction:(UIButton*)button{
    GPUImagePicture *imagePicture = [[GPUImagePicture alloc] initWithImage:[self.orignalImage copy]];
    GPUImageRGBFilter *RGBFilter = [[GPUImageRGBFilter alloc] init];
    RGBFilter.red = 0.2;
    [imagePicture addTarget:RGBFilter];
    [RGBFilter useNextFrameForImageCapture];
    [imagePicture processImage];
    
    self.GPUImage = [RGBFilter imageFromCurrentFramebuffer];
}

- (void)clickGaussianFilterButtonAction:(UIButton*)button{
    GPUImagePicture *imagePicture = [[GPUImagePicture alloc] initWithImage:self.orignalImage];
    GPUImageGaussianBlurFilter *gaussianBlurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    gaussianBlurFilter.blurRadiusInPixels = 10.0;
    [imagePicture addTarget:gaussianBlurFilter];
    [gaussianBlurFilter useNextFrameForImageCapture];
    [imagePicture processImage];
    
    self.GPUImage = [gaussianBlurFilter imageFromCurrentFramebuffer];
}

@end
