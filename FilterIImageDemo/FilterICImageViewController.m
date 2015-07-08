//
//  ViewController.m
//  FilterIImageDemo
//
//  Created by 戴益波 on 15/7/3.
//  Copyright (c) 2015年 戴益波. All rights reserved.
//

#import "FilterICImageViewController.h"

@interface FilterICImageViewController ()

@property (strong, nonatomic) CIImage *orignalImage;
@property (strong, nonatomic) UIImage *filterImage;

@property (strong, nonatomic) IBOutlet UIImageView *filterImageView;
@property (strong, nonatomic) IBOutlet UIButton *gaussianBlurButton;
@property (strong, nonatomic) IBOutlet UIButton *colorClampButton;
@property (strong, nonatomic) IBOutlet UIButton *linearRGBButton;
@property (strong, nonatomic) IBOutlet UIButton *colorMapButton;
@end

@implementation FilterICImageViewController
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
    //获取毛玻璃图片
    self.orignalImage = [CIImage imageWithCGImage:[[UIImage imageNamed:@"Image1"] CGImage]];
}

- (void)loadBaseUI{
    self.title = @"ICFilter";
    
    //button
    [self.gaussianBlurButton addTarget:self action:@selector(clickGaussianBlurButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.colorClampButton addTarget:self action:@selector(clickColorClamButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.linearRGBButton addTarget:self action:@selector(clickLinearRGBButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.colorMapButton addTarget:self action:@selector(clickColorMapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark- Get, Set
- (void)setFilterImage:(UIImage *)filterImage{
    if (filterImage == nil) return;
    
    _filterImage = filterImage;
    //将图片添加到filterImageView上
    self.filterImageView.image = filterImage;
}

#pragma mark- Private method
- (void)clickGaussianBlurButtonAction:(UIButton*)button{
    //获取滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:@"inputImage", self.orignalImage, @"inputRadius", @1.0f, nil];
    //从滤镜中获取图片
    CIImage *result = filter.outputImage;
    self.filterImage = [UIImage imageWithCIImage:result];
}

- (void)clickColorClamButtonAction:(UIButton*)button{
    CIFilter *filter = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputImage", self.orignalImage, @"inputMinComponents", [CIVector vectorWithX:0.1 Y:0 Z:0 W:0], @"inputMaxComponents", [CIVector vectorWithX:1 Y:1 Z:1 W:1], nil];
    
    CIImage *result = filter.outputImage;
    self.filterImage = [UIImage imageWithCIImage:result];
}

- (void)clickLinearRGBButtonAction:(UIButton*)button{
    
    CIFilter *filter = [CIFilter filterWithName:@"CILinearToSRGBToneCurve" keysAndValues:@"inputImage", self.orignalImage, nil];
    self.filterImage = [UIImage imageWithCIImage:filter.outputImage];
}

- (void)clickColorMapButtonAction:(UIButton*)button{
    CIFilter *filter = [CIFilter filterWithName:@"CIMaximumComponent" keysAndValues:@"inputImage", self.orignalImage, nil];
    
    CIImage *result = filter.outputImage;
    self.filterImage = [UIImage imageWithCIImage:result];
}

@end
