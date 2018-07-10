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

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *toPostImageView;
@property (weak, nonatomic) IBOutlet UITextField *toCaptionTextField;

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

- (void) createPost {
    
}


- (IBAction)cancelButtonTapped:(id)sender {
   
    ComposeViewController *gotoHomeFeedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeFeedViewController"];
    [self.navigationController pushViewController:gotoHomeFeedViewController animated:YES];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)shareButtonTapped:(id)sender {
    
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
