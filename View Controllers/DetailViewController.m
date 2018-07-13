//
//  DetailViewController.m
//  Instagram
//
//  Created by Jessica Au on 7/10/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *likesAndCommentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *postImageURLString = self.post.image.url;
    NSURL *postImageURL = [NSURL URLWithString:postImageURLString];
    [self.postImageView setImageWithURL:postImageURL];
    self.likesAndCommentsLabel.text = [NSString stringWithFormat:@"%@%@%@%@", self.post.likeCount, @" likes and ", self.post.commentCount, @" comments"];
    self.usernameLabel.text = self.post.author.username;
    self.postLabel.text = self.post.caption;
    
    self.dateLabel.text = self.post.createdAt.shortTimeAgoSinceNow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    DetailViewController *goToHomeFeedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeFeed"];
    [self.navigationController pushViewController:goToHomeFeedViewController animated:YES];
    [self dismissViewControllerAnimated:false completion:nil];
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
