//
//  PostCell.h
//  Instagram
//
//  Created by Jessica Au on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (strong, nonatomic) Post *post;

@property (assign, nonatomic) BOOL userDidLike; 

- (void) setPost;

@end
