//
//  ProfileViewController.h
//  Instagram
//
//  Created by Jessica Au on 7/11/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) UIImage *profileImage;

@property (strong, nonatomic) PFUser *user;

@end
