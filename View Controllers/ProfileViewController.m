//
//  ProfileViewController.m
//  Instagram
//
//  Created by Jessica Au on 7/11/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profileImageView.image = self.profileImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)profileImageTapped:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Change Profile Photo"
                                                                   message:@"Select the source of your photo"
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *accessCamera = [UIAlertAction actionWithTitle:@"Camera"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             UIImagePickerController *imagePickerVC = [UIImagePickerController new];
                                                             imagePickerVC.delegate = self;
                                                             imagePickerVC.allowsEditing = YES;
                                                             
                                                             if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                                 imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                             }
                                                             else {
                                                                 NSLog(@"Camera 🚫 available so we will use photo library instead");
                                                                 imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                             }
                                                             
                                                             [self presentViewController:imagePickerVC animated:YES completion:nil];
                                                         }];
    
    
    UIAlertAction *accessCameraRoll = [UIAlertAction actionWithTitle:@"Camera Roll"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 UIImagePickerController *imagePickerVC = [UIImagePickerController new];
                                                                 imagePickerVC.delegate = self;
                                                                 imagePickerVC.allowsEditing = YES;
                                                                 imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                                 
                                                                 [self presentViewController:imagePickerVC animated:YES completion:nil];
                                                             }];
    // add the cancel action to the alertController
    [alert addAction:accessCamera];
    [alert addAction:accessCameraRoll];
    
    [self presentViewController:alert animated:YES completion:^{
        // after finished action
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    // UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    CGSize imageSize = CGSizeMake(50, 50);
    
    editedImage = [self resizeImage:editedImage withSize:imageSize];
    
    // Do something with the images (based on your use case)
    self.profileImage = editedImage;
    self.profileImageView.image = self.profileImage;
    
    self.post.user[@"profileimage"] = [Post getPFFileFromImage:editedImage];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
      //  [self performSegueWithIdentifier:@"ComposeController" sender:nil];
    }];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
