//
//  PostCell.m
//  Instagram
//
//  Created by Jessica Au on 7/9/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPost {
    NSString *postImageURLString = self.post.image.url;
    NSURL *postImageURL = [NSURL URLWithString:postImageURLString];
    [self.postImageView setImageWithURL:postImageURL];
    
    self.postLabel.text = self.post.caption;
    self.usernameLabel.text = self.post.author.username;
}

- (IBAction)likeButtonTapped:(id)sender {
    int likeCount = [self.post.likeCount intValue];
    
    if (!self.userDidLike) {
        likeCount++;
        self.post.likeCount = [NSNumber numberWithInt:likeCount];
        [self.likeButton setImage:[UIImage imageNamed: @"like-icon-red"] forState:UIControlStateNormal];
        self.userDidLike = YES;
    }
    else if (self.userDidLike) {
        likeCount--;
        self.post.likeCount = [NSNumber numberWithInt:likeCount];
        [self.likeButton setImage:[UIImage imageNamed: @"like-icon"] forState:UIControlStateNormal];
        self.userDidLike = NO;
    }
}






@end
