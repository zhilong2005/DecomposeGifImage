//
//  ViewController.m
//  decompose decompose DecomposeGifImage
//
//  Created by zhuzhilong on 17/1/26.
//  Copyright © 2017年 zhuzhilong. All rights reserved.
//
//1 我们要拿到我们的gif数据
//2 将gif分解成一帧帧
//3 将单帧数据转化为UIImage
//4 单帧保存为图片
#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self compositionGif];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)compositionGif{
    //1 拿到gif数据
    NSString *gifPathSource = [[NSBundle mainBundle]pathForResource:@"ceshi" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:gifPathSource];
    CGImageSourceRef source  = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
   //2 将gif分解成一帧帧
    NSMutableArray *muArray = [[NSMutableArray alloc]init];
    
    size_t count = CGImageSourceGetCount(source);
    for (size_t i = 0; i<count; i++) {
        CGImageRef imageref = CGImageSourceCreateImageAtIndex(source, i, NULL);
        //将单针数据转为UIImage
        UIImage *image = [UIImage imageWithCGImage:imageref scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
        //备份数据
        [muArray addObject:image];
        CGImageRelease(imageref);
        
    }
    CFRelease(source);
    //4 单帧图片的保存
    int i = 0;
    for (UIImage *image in muArray) {
        NSData *data = UIImagePNGRepresentation(image);
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *gifPath = path[0];
        NSString *pathNum = [gifPath stringByAppendingString:[NSString stringWithFormat:@"%d.png",i]];
        i++;
        [data writeToFile:pathNum atomically:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
