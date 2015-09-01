//
//  ZXImageAvatarBrowser.m
//  ZXChatTableView
//
//  Created by pro on 15/8/21.
//  Copyright (c) 2015年 vickyTest. All rights reserved.
//

#import "ZXImageAvatarBrowser.h"


static UIImageView *orignImageView;
@implementation ZXImageAvatarBrowser

+ (void)showImage:(UIImageView *)avatarImageView
{
    UIImage *image = avatarImageView.image;
    orignImageView = avatarImageView;
    orignImageView.alpha = 0;
    //获取跟窗口
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    CGRect oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    
    backgroudView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    backgroudView.alpha = 1;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldframe];
    imageView.image = image;
    imageView.tag = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [backgroudView addSubview:imageView];
    [window addSubview:backgroudView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
    [backgroudView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0 , ([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroudView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hideImage:(UITapGestureRecognizer *)tap
{
    UIView *backgroupView = tap.view;
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = [orignImageView convertRect:orignImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        [backgroupView removeFromSuperview];
        orignImageView.alpha = 1;
        backgroupView.alpha = 0;
    }];
}


@end

















