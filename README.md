#IOS--实现滤镜效果

##使用CIFilter来完成IOS中滤镜效果

在IOS中可以使用系统自带的方法来达到路径效果：需要用到的类为：`CIContext`, `CIImage`, `CIFilter`

####使用CIFilter实现滤镜效果的方法步骤如下：

```

    ​1.创建图像上下文CIContext

    ​2.创建过滤原图片CIImage

    ​3.创建滤镜CIFilter

    ​4.调用CIFilter的setValue： forKey：方法为滤镜指定源图片

    ​5.设置滤镜参数【可选】

    ​6.取得输出图片显示或保存

```
####下面是一个简单的代码例子：


```
 	 //获取毛玻璃图片
    self.orignalImage = [CIImage imageWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"image1" withExtension:@"png"]];
    //获取滤镜，并设置（使用KVO键值输入）
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:@"inputImage", self.orignalImage, @"inputRadius", @1.0f, nil];
    //从滤镜中获取图片
    CIImage *result = filter.outputImage;
    self.filterImage = [UIImage imageWithCIImage:result];
    //将图片添加到filterImageView上
    self.filterImageView.image = filterImage;
    
```

####注意：
在iOS和OS X平台上，Core Image都提供了大量的滤镜（Filter），这也是Core Image库中比较核心的东西之一。按照官方文档记载，在OS X上有120多种Filter，而在iOS上也有90多。可以通过查看官方文档，来查看相应效果需要参数数据：
https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/#//apple_ref/doc/filter/ci/CIGaussianBlur


----------


----------

----------


##使用GPUImage来完成IOS中滤镜效果
除了苹果官方提供的之外，第三方也有这方面图片处理的工具。一个叫Brad Larson的老兄就搞了一套叫做GPUImage的开源库。同样的，里面提供了很多Filter。

####同样是做高斯模糊，用GPUImage可以这样：

```
GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
blurFilter.blurRadiusInPixels = 2.0;
UIImage * image = [UIImage imageNamed:@"xxx"];
UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
```
至少看起来，代码上比使用Core Image的情况简单得多。

在使用这个库在完成滤镜的时候，我们可以使用下面的两种方式来完成：

####1. 官方比较详细的操作方法：

```
UIImage *inputImage = [UIImage imageNamed:@"Lambeau.jpg"];

GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];

[stillImageSource addTarget:stillImageFilter];
[stillImageFilter useNextFrameForImageCapture];
[stillImageSource processImage];

UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
```

####2. 针对当个的滤镜操作方法：

```
GPUImageSepiaFilter *stillImageFilter2 = [[GPUImageSepiaFilter alloc] init];
UIImage *quickFilteredImage = [stillImageFilter2 imageByFilteringImage:inputImage];
```

####GPUImage库的详细使用看github上的文档：
GPUImage库可以完成许多操作，比如拍照时使用滤镜，录像时使用滤镜等……下面是github上的网址，可以参考https://github.com/BradLarson/GPUImage

####这边有一个别人归纳的比较好的GPUImage滤镜总结：

```
// Base classes
#import "GPUImageOpenGLESContext.h"
#import "GPUImageOutput.h"
#import "GPUImageView.h"
#import "GPUImageVideoCamera.h"
#import "GPUImageStillCamera.h"
#import "GPUImageMovie.h"
#import "GPUImagePicture.h"
#import "GPUImageRawDataInput.h"
#import "GPUImageRawDataOutput.h"
#import "GPUImageMovieWriter.h"
#import "GPUImageFilterPipeline.h"
#import "GPUImageTextureOutput.h"
#import "GPUImageFilterGroup.h"
#import "GPUImageTextureInput.h"
#import "GPUImageUIElement.h"
#import "GPUImageBuffer.h"

// Filters
#import "GPUImageFilter.h"
#import "GPUImageTwoInputFilter.h"


#pragma mark - 调整颜色 Handle Color

#import "GPUImageBrightnessFilter.h"                //亮度
#import "GPUImageExposureFilter.h"                  //曝光
#import "GPUImageContrastFilter.h"                  //对比度
#import "GPUImageSaturationFilter.h"                //饱和度
#import "GPUImageGammaFilter.h"                     //伽马线
#import "GPUImageColorInvertFilter.h"               //反色
#import "GPUImageSepiaFilter.h"                     //褐色（怀旧）
#import "GPUImageLevelsFilter.h"                    //色阶
#import "GPUImageGrayscaleFilter.h"                 //灰度
#import "GPUImageHistogramFilter.h"                 //色彩直方图，显示在图片上
#import "GPUImageHistogramGenerator.h"              //色彩直方图
#import "GPUImageRGBFilter.h"                       //RGB
#import "GPUImageToneCurveFilter.h"                 //色调曲线
#import "GPUImageMonochromeFilter.h"                //单色
#import "GPUImageOpacityFilter.h"                   //不透明度
#import "GPUImageHighlightShadowFilter.h"           //提亮阴影
#import "GPUImageFalseColorFilter.h"                //色彩替换（替换亮部和暗部色彩）
#import "GPUImageHueFilter.h"                       //色度
#import "GPUImageChromaKeyFilter.h"                 //色度键
#import "GPUImageWhiteBalanceFilter.h"              //白平横
#import "GPUImageAverageColor.h"                    //像素平均色值
#import "GPUImageSolidColorGenerator.h"             //纯色
#import "GPUImageLuminosity.h"                      //亮度平均
#import "GPUImageAverageLuminanceThresholdFilter.h" //像素色值亮度平均，图像黑白（有类似漫画效果）

#import "GPUImageLookupFilter.h"                    //lookup 色彩调整
#import "GPUImageAmatorkaFilter.h"                  //Amatorka lookup
#import "GPUImageMissEtikateFilter.h"               //MissEtikate lookup
#import "GPUImageSoftEleganceFilter.h"              //SoftElegance lookup




#pragma mark - 图像处理 Handle Image

#import "GPUImageCrosshairGenerator.h"              //十字
#import "GPUImageLineGenerator.h"                   //线条

#import "GPUImageTransformFilter.h"                 //形状变化
#import "GPUImageCropFilter.h"                      //剪裁
#import "GPUImageSharpenFilter.h"                   //锐化
#import "GPUImageUnsharpMaskFilter.h"               //反遮罩锐化

#import "GPUImageFastBlurFilter.h"                  //模糊
#import "GPUImageGaussianBlurFilter.h"              //高斯模糊
#import "GPUImageGaussianSelectiveBlurFilter.h"     //高斯模糊，选择部分清晰
#import "GPUImageBoxBlurFilter.h"                   //盒状模糊
#import "GPUImageTiltShiftFilter.h"                 //条纹模糊，中间清晰，上下两端模糊
#import "GPUImageMedianFilter.h"                    //中间值，有种稍微模糊边缘的效果
#import "GPUImageBilateralFilter.h"                 //双边模糊
#import "GPUImageErosionFilter.h"                   //侵蚀边缘模糊，变黑白
#import "GPUImageRGBErosionFilter.h"                //RGB侵蚀边缘模糊，有色彩
#import "GPUImageDilationFilter.h"                  //扩展边缘模糊，变黑白
#import "GPUImageRGBDilationFilter.h"               //RGB扩展边缘模糊，有色彩
#import "GPUImageOpeningFilter.h"                   //黑白色调模糊
#import "GPUImageRGBOpeningFilter.h"                //彩色模糊
#import "GPUImageClosingFilter.h"                   //黑白色调模糊，暗色会被提亮
#import "GPUImageRGBClosingFilter.h"                //彩色模糊，暗色会被提亮
#import "GPUImageLanczosResamplingFilter.h"         //Lanczos重取样，模糊效果
#import "GPUImageNonMaximumSuppressionFilter.h"     //非最大抑制，只显示亮度最高的像素，其他为黑
#import "GPUImageThresholdedNonMaximumSuppressionFilter.h" //与上相比，像素丢失更多

#import "GPUImageSobelEdgeDetectionFilter.h"        //Sobel边缘检测算法(白边，黑内容，有点漫画的反色效果)
#import "GPUImageCannyEdgeDetectionFilter.h"        //Canny边缘检测算法（比上更强烈的黑白对比度）
#import "GPUImageThresholdEdgeDetectionFilter.h"    //阈值边缘检测（效果与上差别不大）
#import "GPUImagePrewittEdgeDetectionFilter.h"      //普瑞维特(Prewitt)边缘检测(效果与Sobel差不多，貌似更平滑)
#import "GPUImageXYDerivativeFilter.h"              //XYDerivative边缘检测，画面以蓝色为主，绿色为边缘，带彩色
#import "GPUImageHarrisCornerDetectionFilter.h"     //Harris角点检测，会有绿色小十字显示在图片角点处
#import "GPUImageNobleCornerDetectionFilter.h"      //Noble角点检测，检测点更多
#import "GPUImageShiTomasiFeatureDetectionFilter.h" //ShiTomasi角点检测，与上差别不大
#import "GPUImageMotionDetector.h"                  //动作检测
#import "GPUImageHoughTransformLineDetector.h"      //线条检测
#import "GPUImageParallelCoordinateLineTransformFilter.h" //平行线检测

#import "GPUImageLocalBinaryPatternFilter.h"        //图像黑白化，并有大量噪点

#import "GPUImageLowPassFilter.h"                   //用于图像加亮
#import "GPUImageHighPassFilter.h"                  //图像低于某值时显示为黑


#pragma mark - 视觉效果 Visual Effect

#import "GPUImageSketchFilter.h"                    //素描
#import "GPUImageThresholdSketchFilter.h"           //阀值素描，形成有噪点的素描
#import "GPUImageToonFilter.h"                      //卡通效果（黑色粗线描边）
#import "GPUImageSmoothToonFilter.h"                //相比上面的效果更细腻，上面是粗旷的画风
#import "GPUImageKuwaharaFilter.h"                  //桑原(Kuwahara)滤波,水粉画的模糊效果；处理时间比较长，慎用

#import "GPUImageMosaicFilter.h"                    //黑白马赛克
#import "GPUImagePixellateFilter.h"                 //像素化
#import "GPUImagePolarPixellateFilter.h"            //同心圆像素化
#import "GPUImageCrosshatchFilter.h"                //交叉线阴影，形成黑白网状画面
#import "GPUImageColorPackingFilter.h"              //色彩丢失，模糊（类似监控摄像效果）

#import "GPUImageVignetteFilter.h"                  //晕影，形成黑色圆形边缘，突出中间图像的效果
#import "GPUImageSwirlFilter.h"                     //漩涡，中间形成卷曲的画面
#import "GPUImageBulgeDistortionFilter.h"           //凸起失真，鱼眼效果
#import "GPUImagePinchDistortionFilter.h"           //收缩失真，凹面镜
#import "GPUImageStretchDistortionFilter.h"         //伸展失真，哈哈镜
#import "GPUImageGlassSphereFilter.h"               //水晶球效果
#import "GPUImageSphereRefractionFilter.h"          //球形折射，图形倒立

#import "GPUImagePosterizeFilter.h"                 //色调分离，形成噪点效果
#import "GPUImageCGAColorspaceFilter.h"             //CGA色彩滤镜，形成黑、浅蓝、紫色块的画面
#import "GPUImagePerlinNoiseFilter.h"               //柏林噪点，花边噪点
#import "GPUImage3x3ConvolutionFilter.h"            //3x3卷积，高亮大色块变黑，加亮边缘、线条等
#import "GPUImageEmbossFilter.h"                    //浮雕效果，带有点3d的感觉
#import "GPUImagePolkaDotFilter.h"                  //像素圆点花样
#import "GPUImageHalftoneFilter.h"                  //点染,图像黑白化，由黑点构成原图的大致图形


#pragma mark - 混合模式 Blend

#import "GPUImageMultiplyBlendFilter.h"             //通常用于创建阴影和深度效果
#import "GPUImageNormalBlendFilter.h"               //正常
#import "GPUImageAlphaBlendFilter.h"                //透明混合,通常用于在背景上应用前景的透明度
#import "GPUImageDissolveBlendFilter.h"             //溶解
#import "GPUImageOverlayBlendFilter.h"              //叠加,通常用于创建阴影效果
#import "GPUImageDarkenBlendFilter.h"               //加深混合,通常用于重叠类型
#import "GPUImageLightenBlendFilter.h"              //减淡混合,通常用于重叠类型
#import "GPUImageSourceOverBlendFilter.h"           //源混合
#import "GPUImageColorBurnBlendFilter.h"            //色彩加深混合
#import "GPUImageColorDodgeBlendFilter.h"           //色彩减淡混合
#import "GPUImageScreenBlendFilter.h"               //屏幕包裹,通常用于创建亮点和镜头眩光
#import "GPUImageExclusionBlendFilter.h"            //排除混合
#import "GPUImageDifferenceBlendFilter.h"           //差异混合,通常用于创建更多变动的颜色
#import "GPUImageSubtractBlendFilter.h"             //差值混合,通常用于创建两个图像之间的动画变暗模糊效果
#import "GPUImageHardLightBlendFilter.h"            //强光混合,通常用于创建阴影效果
#import "GPUImageSoftLightBlendFilter.h"            //柔光混合
#import "GPUImageChromaKeyBlendFilter.h"            //色度键混合
#import "GPUImageMaskFilter.h"                      //遮罩混合
#import "GPUImageHazeFilter.h"                      //朦胧加暗
#import "GPUImageLuminanceThresholdFilter.h"        //亮度阈
#import "GPUImageAdaptiveThresholdFilter.h"         //自适应阈值
#import "GPUImageAddBlendFilter.h"                  //通常用于创建两个图像之间的动画变亮模糊效果
#import "GPUImageDivideBlendFilter.h"               //通常用于创建两个图像之间的动画变暗模糊效果


#pragma mark - 尚不清楚
#import "GPUImageJFAVoroniFilter.h"
#import "GPUImageVoroniConsumerFilter.h"

```


----------

----------

----------

##使用vImage API来完成IOS中滤镜效果

其实，说完上面的Core Image和GPUImage，很多情况下就已经足够用了。下面我们再来看一个，那就是vImage。vImage也是苹果推出的库，在Accelerate.framework中。

Accelerate这个framework主要是用来做数字信号处理、图像处理相关的向量、矩阵运算的库。我们可以认为我们的图像都是由向量或者矩阵数据构成的，Accelerate里既然提供了高效的数学运算API，自然就能方便我们对图像做各种各样的处理。

基于vImage我们可以根据图像的处理原理直接做模糊效果


####下面是别人写的一个比较好的方法：
直接贴代码到工程中，就可以在工程中使用了。
不要忘记了还需要导入`Accelerate.framework`， 在类代码的开头导入头文件`#import <Accelerate/Accelerate.h>`
```
/**
 *  使用vImage API进行图像的模糊处理
 *
 *  @param image 原图像
 *  @param blur  模糊度（0.0~1.0）
 *
 *  @return 模糊处理之后的图像
 */
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }//判断曝光度
    int boxSize = (int)(blur * 100);//放大100，就是小数点之后两位有效
    boxSize = boxSize - (boxSize % 2) + 1;//如果是偶数，+1，变奇数
    
    CGImageRef img = image.CGImage;//获取图片指针
    
    vImage_Buffer inBuffer, outBuffer;//获取缓冲区
    vImage_Error error;//一个错误类，在后调用画图函数的时候要用
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);//放回一个图片供应者信息
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);//拷贝数据，并转化
    
    inBuffer.width = CGImageGetWidth(img);//放回位图的宽度
    inBuffer.height = CGImageGetHeight(img);//放回位图的高度
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);//放回位图的
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);//填写图片信息
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));//创建一个空间
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,//这个数一定要是奇数的，因此我们一开始的时候需要转化
                                       boxSize,//这个数一定要是奇数的，因此我们一开始的时候需要转化
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //将刚刚得出的数据，画出来。
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

```
----------


----------

----------

##使用UIVisualEffectView来完成IOS中滤镜效果（ios8以上版本）
使用方法很简单，就是创建一个模糊的view，然后放到需要覆盖的view上面

```
    //设置模糊，效果为BlurEffectStyleLight
    UIVisualEffectView *ruVisualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    ruVisualEffectView.frame = self.ruImageView.bounds;
    ruVisualEffectView.alpha = 1.0;
    [self.ruImageView addSubview:ruVisualEffectView];
```

----------

----------

----------
##性能与选择

既然已经知道了4个方法做到半透明模糊效果，那么我们要用的时候应该选择哪个呢？这是个问题。

从系统版本的支持上来看，这几个都差不多，都是iOS4、iOS5就支持了的，对于身在iOS8时代的开发者，这点兼容已经够了。

Core Image是苹果自己的图像处理库，本来就不错，如果苹果自身在某个版本做了优化处理，自然更好。主要是用起来比较麻烦，还要知道Filter的名字。

GPUImage来自第三方，但实现开放，用起来也比较简单，在很多场景下是替代Core Image的选择。

图像模糊处理是很复杂的计算，最终往往要看性能。这点上看，我更倾向选择vImage。

在ios8之后的系统中，如果要实现毛玻璃效果，最好使用系统提供的UIVisualEffectView来完成。

**在真正使用的时候，如果要考虑到性能，最好用vImage；**
**否则可以用GPUImage，因为性能比Core Image好，功能也全面；**
**如果是ios8，那么最好使用UIVisualEffectView来完成**

----------

----------

----------
##转载于大神:
http://my.oschina.net/zdiovo/blog/416986
http://www.cocoachina.com/ios/20141223/10731.html