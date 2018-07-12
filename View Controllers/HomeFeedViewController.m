//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Jessica Au on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "HomeFeedViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PostCell.h"
#import "Post.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"
// #import "UIScrollView+SVInfiniteScrolling.h"

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *postTableView;

@property (strong, nonatomic) NSArray *posts;

@property (strong, nonatomic) UIImage *toPostToComposeViewController;

// @property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation HomeFeedViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.postTableView insertSubview:refreshControl atIndex:0];
    
    self.postTableView.dataSource = self;
    self.postTableView.delegate = self;
    
    [self beginRefresh:refreshControl];
    
    /*
    [self.postTableView addInfiniteScrollingWithActionHandler:^{
        // append data to data source, insert new cells at the end of table view
        
        
    }];
    
    [self.postTableView.infiniteScrollingView stopAnimating];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonTapped:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}

- (IBAction)composeButtonTapped:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Post"
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
    
    CGSize imageSize = CGSizeMake(500, 500);
    
    editedImage = [self resizeImage:editedImage withSize:imageSize];
    
    // Do something with the images (based on your use case)
    self.toPostToComposeViewController = editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"ComposeController" sender:nil];
    }];
}

- (void) refreshData {

    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            
            [self.postTableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        
        // Reload the tableView now that there is new data
        [self.postTableView reloadData];
    }];
}


// Makes a network request to get updated data
// Makes a   // Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            
            [self.postTableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
        
        // Reload the tableView now that there is new data
        [self.postTableView reloadData];
        
        // Tell the refreshControl to stop spinning
        [refreshControl endRefreshing];
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UINavigationController *navigationController = [segue destinationViewController];
    
    if ([navigationController.topViewController isKindOfClass:[ComposeViewController class]]) {

        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        
        composeController.toPostImage = self.toPostToComposeViewController;
    }
    
    else if ([navigationController.topViewController isKindOfClass:[DetailViewController class]]) {
        
        DetailViewController *detailController = (DetailViewController*)navigationController.topViewController;
        
        UITableViewCell *tappedCell = sender;
        
        NSIndexPath *indexPath = [self.postTableView indexPathForCell:tappedCell];
        
        Post *post = self.posts[indexPath.row];
        
        detailController.post = post;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];

    Post *post = self.posts[indexPath.row];
    
    cell.post = post;
    
    [cell setPost];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void) didPost:(Post *)post {
    [self.posts arrayByAddingObject:post];
    [self.postTableView reloadData];
    [self refreshData];
    
    [self dismissViewControllerAnimated:true completion:nil];
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
-(void)loadMoreData{
    
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // Update flag
            self.isMoreDataLoading = false;
            
            // ... Use the new data to update the data source ...
            self.posts = posts;
            
            // Reload the tableView now that there is new data
            [self.postTableView reloadData];
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Handle scroll behavior here
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.postTableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.postTableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.postTableView.isDragging) {
            self.isMoreDataLoading = true;
            
            // ... Code to load more results ...
            [self loadMoreData];
        }
    }
}

*/


@end
