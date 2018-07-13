//
//  PostCollectionViewCell.m
//  Instagram
//
//  Created by Jessica Au on 7/12/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import "PostCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation PostCollectionViewCell

- (void) setPost {
    NSString *postImageURLString = self.post.image.url;
    NSURL *postImageURL = [NSURL URLWithString:postImageURLString];
    [self.postImageView setImageWithURL:postImageURL];
}

@end
