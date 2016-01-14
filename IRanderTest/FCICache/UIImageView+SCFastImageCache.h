//
//  UIImageView+SCFastImageCache.h
//  JuMei
//
//  Created by junlongj on 16/1/12.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (SCFastImageCache)


- (void)sc_setImageWithURL:(NSURL *)url;


- (void)sc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

@end
