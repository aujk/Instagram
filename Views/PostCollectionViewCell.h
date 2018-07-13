//
//  PostCollectionViewCell.h
//  Instagram
//
//  Created by Jessica Au on 7/12/18.
//  Copyright © 2018 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface PostCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *postImageView;

@property (strong, nonatomic) Post *post;

- (void) setPost;

@end
