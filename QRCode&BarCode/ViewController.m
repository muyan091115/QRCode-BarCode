//
//  ViewController.m
//  QRCode&BarCode
//
//  Created by 蒋伟 on 2019/6/28.
//  Copyright © 2019 中国人寿. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)creatQRCode:(id)sender {
    
    NSString *message = @"https://github.com/muyan091115/QRCode-BarCode";
    NSData *inputData = [message dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:inputData forKey:@"inputMessage"];
    
    //设置高容错率
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *ciImage = filter.outputImage;
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, 10.0, 10.0)];
    UIImage *image = [UIImage imageWithCIImage:ciImage];
    
    self.imageView.image = image;
    
}

- (IBAction)creatCenterImageQRCode:(id)sender {
    
    NSString *message = @"https://github.com/muyan091115/QRCode-BarCode";
    NSData *inputData = [message dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:inputData forKey:@"inputMessage"];
    
    //设置高容错率
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    CIImage *ciImage = filter.outputImage;
    ciImage = [ciImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, 10.0, 10.0)];
    UIImage *backImage = [UIImage imageWithCIImage:ciImage];
    
    UIGraphicsBeginImageContext(backImage.size);
    [backImage drawInRect:CGRectMake(0, 0, backImage.size.width, backImage.size.height)];
    double centerImageWH = backImage.size.width * 0.2;
    
    UIImage *centerImage = [UIImage imageNamed:@"github"];
    [centerImage drawInRect:CGRectMake((backImage.size.width - centerImageWH)*0.5, (backImage.size.height - centerImageWH)*0.5, centerImageWH, centerImageWH)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.imageView.image = image;
    
    
}

- (IBAction)creatBarCode:(id)sender {
    
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setDefaults];
    
    NSString *string = @"9787111213826";
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    UIImage* image =  [UIImage imageWithCIImage:outputImage scale:10.0 orientation:UIImageOrientationUp];
    self.imageView.image = image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
