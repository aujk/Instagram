//
//  ComposeViewController.m
//  Instagram
//
//  Created by Jessica Au on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "HomeFeedViewController.h"
#import "Post.h"
#import "SVProgressHUD.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *toPostImageView;
@property (weak, nonatomic) IBOutlet UITextField *toCaptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toPostImageView.image = self.toPostImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonTapped:(id)sender {
   
    ComposeViewController *goToHomeFeedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeFeed"];
    [self.navigationController pushViewController:goToHomeFeedViewController animated:YES];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)shareButtonTapped:(id)sender {

    [SVProgressHUD show];

    [Post postUserImage:self.toPostImage withCaption:self.toCaptionTextField.text withLocation:self.locationTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error posting: %@", error.localizedDescription);
        }
        else {
            NSLog(@"Post posted!");
            [self.delegate didPost:self.post];
            
            ComposeViewController *goToHomeFeedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeFeed"];
            [self.navigationController pushViewController:goToHomeFeedViewController animated:YES];
            [self dismissViewControllerAnimated:true completion:nil];
        }
        [SVProgressHUD dismiss];
    }];
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
