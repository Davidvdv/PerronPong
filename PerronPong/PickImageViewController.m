//
//  PickStageViewController.m
//  PerronPong
//
//  Created by David van de Vondervoort on 10-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import "PickImageViewController.h"

@interface PickImageViewController ()

@end

@implementation PickImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [_chosenImage setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    _pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toGame"]) {
        GameViewController *vc = [segue destinationViewController];
        UIImage *theImage = [self cropImage:_pickedImage cropSize:[UIScreen mainScreen].bounds.size];
        [vc setBackgroundImage:theImage];
    }
}

- (IBAction) takePhoto:(id)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device has no camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [myAlertView show];
    } else {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        [ipc setDelegate:self];
        [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
        [ipc setEditing:NO];
        [ipc setNavigationBarHidden:YES];
        
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

- (UIImage *) cropImage:(UIImage *)originalImage cropSize:(CGSize)cropSize
{
    NSLog(@"original image orientation:%d",originalImage.imageOrientation);
    
    //calculate scale factor to go between cropframe and original image
    float SF = originalImage.size.width / cropSize.width;
    
    //find the centre x,y coordinates of image
    float centreX = originalImage.size.width / 2;
    float centreY = originalImage.size.height / 2;
    
    //calculate crop parameters
    float cropX = centreX - ((cropSize.width / 2) * SF);
    float cropY = centreY - ((cropSize.height / 2) * SF);
    
    CGRect cropRect = CGRectMake(cropX, cropY, (cropSize.width *SF), (cropSize.height * SF));
    
    CGAffineTransform rectTransform;
    switch (originalImage.imageOrientation)
    {
        case UIImageOrientationLeft:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI_2), 0, -originalImage.size.height);
            break;
        case UIImageOrientationRight:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI_2), -originalImage.size.width, 0);
            break;
        case UIImageOrientationDown:
            rectTransform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(-M_PI), -originalImage.size.width, -originalImage.size.height);
            break;
        default:
            rectTransform = CGAffineTransformIdentity;
    };
    rectTransform = CGAffineTransformScale(rectTransform, originalImage.scale, originalImage.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([originalImage CGImage], CGRectApplyAffineTransform(cropRect, rectTransform));
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:originalImage.scale orientation:originalImage.imageOrientation];
    CGImageRelease(imageRef);
    //return result;
    
    //Now want to scale down cropped image!
    //want to multiply frames by 2 to get retina resolution
    CGRect scaledImgRect = CGRectMake(0, 0, (cropSize.width * 2), (cropSize.height * 2));
    
    UIGraphicsBeginImageContextWithOptions(scaledImgRect.size, NO, [UIScreen mainScreen].scale);
    
    [result drawInRect:scaledImgRect];
    
    UIImage *scaledNewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledNewImage;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
