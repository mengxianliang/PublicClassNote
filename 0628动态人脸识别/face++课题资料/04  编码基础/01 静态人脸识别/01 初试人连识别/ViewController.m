//
//  ViewController.m
//  01 初试人连识别
//
//  Created by CC老师 on 2017/5/23.
//  Copyright © 2017年 . All rights reserved.
//

#import "ViewController.h"
#import "FaceppAPI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //修改图片填充样式
    [_CC_img setContentMode:UIViewContentModeScaleAspectFill];
    
    _CC_img.clipsToBounds = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
//选择相片
- (IBAction)selecteImg:(id)sender {
    
    //1.是否允许使用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        return;
    }
    
    //2.创建相片选择控制器
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];

    
    //3.设置类型
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //4.设置代理
    picker.delegate = self;
    
    //5.退出相片选择控制器。
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"picker");
    }];
    
}

//选择相机
- (IBAction)selectCm:(id)sender {
    
    //1.是否允许使用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    
    //2.创建相片选择控制器
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    
    //3.设置类型
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //4.设置代理
    picker.delegate = self;
    
    //5.退出相片选择控制器。
    [self presentViewController:picker animated:YES completion:^{
        NSLog(@"picker");
    }];
    

    
}




-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    //1.获取图片对象
    _img = info[@"UIImagePickerControllerOriginalImage"];
    NSLog(@"%@",_img);
    
    //2.矫正方向
    _img = [self fixOrientation:_img];
    
    //3.开始检测
    NSData *tempData = UIImageJPEGRepresentation(_img, 0.5);
    
    _result = [[FaceppAPI detection]detectWithURL:nil orImageData:tempData];
    
    
    NSArray *faceArr = _result.content[@"face"];
    if (faceArr.count <= 0)
    {
         _CC_Label.text = @"没有检测到人脸，请重新上传照片！";
        
        _CC_img.image = _img;
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        return;
        
    }
    
    
    NSDictionary *attributeDic = [faceArr[0]objectForKey:@"attribute"];
    
    NSString *ageStr = attributeDic[@"age"][@"value"];
    NSString *genderStr = [attributeDic[@"gender"][@"value"]isEqualToString:@"Female"]?@"女孩":@"男孩";
    
    _CC_Label.text = [NSString stringWithFormat:@"你是一个%@的%@",ageStr,genderStr];
    
    _CC_img.image = _img;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

//换脸
- (IBAction)exchangeFace:(id)sender {
    
    
    if (_result == nil)
    {
        _CC_Label.text = @"没有检测到人脸，请重新上传照片！";
        return;
    }
    
    
    NSArray *array = _result.content[@"face"];
    if (array.count <= 0)
    {
         _CC_Label.text = @"没有检测到人脸，请重新上传照片！";
        return;
    }
    
    //获取脸部位置（比例值）
    NSDictionary *positionDic = _result.content[@"face"][0][@"position"];
    CGFloat h = [positionDic[@"height"]floatValue];
    CGFloat w = [positionDic[@"width"]floatValue];
    CGFloat x =[positionDic[@"center"][@"x"]floatValue] - w*0.5;
    CGFloat y =[positionDic[@"center"][@"y"]floatValue] -h * 0.5;
    
    //6 画图-》 画图到人脸
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(_img.size, NO, 0);
    
    //2.将原图先绘制到底部，从（0，0）点开始绘制
    [_img drawAtPoint:CGPointZero];
    
    //3.将素材替换到原来的脸部位置
    UIImage *aImage = [UIImage imageNamed:@"angle"];
    
    //根据原图的大小比例来计算自己的位置
    CGFloat imageW = _img.size.width;
    CGFloat imageH = _img.size.height;
    [aImage drawInRect:CGRectMake(x * 0.01 *imageW, y * 0.01*imageH, w * 0.01 *imageW, h * 0.01 *imageH)];
    
    //320 50% 160
    //50 * 0.01 * 320 = 160
    
    //6.4 合成图形上下文
     UIImage *newImag =  UIGraphicsGetImageFromCurrentImageContext();
    
    
    //6.5 关闭图像上下文
    UIGraphicsEndImageContext();
    
    _CC_img.image = newImag;
    
    
    
    

    
    
    
    
    
   
}

/*
 方向矫正
1.先将头朝上
2.将镜象反转
3.重新合成图片
 
 */

- (UIImage*)fixOrientation:(UIImage*)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage* img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}




@end
