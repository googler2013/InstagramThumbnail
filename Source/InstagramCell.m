//
//  InstagramCell.m
//  InstagramThumbnail
//
//  Created by 曾 宪华 on 14-2-23.
//  Copyright (c) 2014年 HUAJIE. All rights reserved.
//

#import "InstagramCell.h"

@implementation InstagramCell

- (void)setEntity:(InstagramMediaModel *)entity andIndexPath:(NSIndexPath *)index {
    [self setupCell];
    
    [self.thumbnailButton setBackgroundImage:[UIImage imageNamed:@"placeholder"] forState:UIControlStateNormal];
    _entity = entity;
    
    [_entity downloadImageWithBlock:^(UIImage *image, NSError *error) {
        if (self.indexPath.row == index.row) {
            [self.thumbnailButton setBackgroundImage:image forState:UIControlStateNormal];
        }
    }];
    
    self.thumbnailButton.userInteractionEnabled = self.showThumbnail;
    self.thumbnailButton.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    
    if (!self.showThumbnail) {
        self.userNameLabel.text = self.entity.userName;
        [self.contentView addSubview:self.userNameLabel];
        
        self.pictureCaptionLabel.text = self.entity.caption;
        [self.contentView addSubview:self.pictureCaptionLabel];
        
        [self.userProfileImageView setImage:[UIImage imageNamed:@"InstagramLoading.png"]];
        [self.contentView addSubview:self.userProfileImageView];
        
        [_entity downloadImageWithBlock:^(UIImage *image, NSError *error) {
            if (image && !error && self.indexPath.row == index.row) {
                [self.userProfileImageView setImage:image];
            }
        }];
    }
}

#pragma mark - Action

- (void)selectedThumbnailImage:(UIButton *)sender {
    
}

- (void)setupCell {
    if (!_thumbnailButton) {
        _thumbnailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [_thumbnailButton setFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.width)];
    [_thumbnailButton addTarget:self action:@selector(selectedThumbnailImage:) forControlEvents:UIControlEventTouchUpInside];
    [_thumbnailButton setBackgroundImage:[UIImage imageNamed:@"InstagramLoading.png"] forState:UIControlStateNormal];
    self.thumbnailButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_thumbnailButton];
    
    if (!self.showThumbnail) {
        if (!_userNameLabel) {
            _userNameLabel = [[UILabel alloc] init];
        }
        _userNameLabel.frame = CGRectMake(40, 0, CGRectGetWidth(self.frame) - 45, 35);
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.font = [_userNameLabel.font fontWithSize:12];
        
        if (!_pictureCaptionLabel) {
            _pictureCaptionLabel = [[UILabel alloc] init];
        }
        
        _pictureCaptionLabel.frame = CGRectMake(5, CGRectGetHeight(self.frame) - 40, CGRectGetWidth(self.frame) - 10, 30);
        _pictureCaptionLabel.numberOfLines = 0;
        _pictureCaptionLabel.textColor = [UIColor blackColor];
        _pictureCaptionLabel.font = [_pictureCaptionLabel.font fontWithSize:12];
        
        if (!_userProfileImageView) {
            _userProfileImageView = [[UIImageView alloc] init];
        }
        _userProfileImageView.frame = CGRectMake(0, 0, 35, 35);
        _userProfileImageView.contentMode = UIViewContentModeScaleAspectFit;
        _userProfileImageView.layer.masksToBounds = YES;
        _userProfileImageView.layer.cornerRadius = 17.5;
    }
}

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
