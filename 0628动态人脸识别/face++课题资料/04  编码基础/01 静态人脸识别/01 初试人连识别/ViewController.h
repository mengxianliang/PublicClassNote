//
//  ViewController.h
//  01 初试人连识别
//
//  Created by CC老师 on 2017/5/23.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceppAPI.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *CC_img;
@property (weak, nonatomic) IBOutlet UILabel *CC_Label;

@property(nonatomic,strong)UIImage *img;
@property(nonnull,strong)FaceppResult *result;

@end

