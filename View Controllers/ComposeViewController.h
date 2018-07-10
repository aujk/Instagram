//
//  ComposeViewController.h
//  Instagram
//
//  Created by Jessica Au on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol ComposeViewControllerDelegate

- (void)didPost:(Post *)post;

@end

@interface ComposeViewController : UIViewController

@property (strong, nonatomic) UIImage *toPostImage;

@property (strong, nonatomic) Post *post;

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end
