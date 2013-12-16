//
//  PickStageViewController.h
//  PerronPong
//
//  Created by David van de Vondervoort on 10-12-13.
//  Copyright (c) 2013 David van de Vondervoort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GameViewController.h"

@interface PickImageViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage *pickedImage;
@property (weak, nonatomic) IBOutlet UIImageView *chosenImage;

- (IBAction)takePhoto:(id)sender;
- (UIImage *) cropImage:(UIImage *)originalImage cropSize:(CGSize)cropSize;

@end
