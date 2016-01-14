//
//  UIImageView+SCFastImageCache.m
//  JuMei
//
//  Created by junlongj on 16/1/12.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import "UIImageView+SCFastImageCache.h"
#import "SCImageEntity.h"
#import "SCImageCacheManager.h"
#import <objc/runtime.h>
#import <SDWebImage/UIView+WebCacheOperation.h>
@implementation UIImageView (SCFastImageCache)

- (void)sc_setImageWithURL:(NSURL *)url{
    
    [self sc_setImageWithURL:url placeholderImage:nil];
    
}


- (void)sc_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    NSDate *date = [NSDate date];
    BOOL isReady = [[SCImageCacheManager manager]
                                asynchronouslyRetrieveImageForImageUrl:url formatName:@"32BitBGR" completionBlock:^(UIImage *image) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                            self.image = image;
                             NSTimeInterval  t = [[NSDate date]timeIntervalSinceDate:date];
                             NSLog(@"t:%f",t);
                         });
                    }];
    if (!isReady){
        self.image = placeholder;
    }
}

@end
