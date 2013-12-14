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
        [vc setBackgroundImage:_pickedImage];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
