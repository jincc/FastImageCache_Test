//
//  SCImageCacheManager.h
//  JuMei
//
//  Created by junlongj on 16/1/12.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FastImageCache/FICImageCache.h>
@interface SCImageCacheManager : NSObject

+ (instancetype)manager;
- (void)appendFormatWithName:(NSString *)name
                   imageSize:(CGSize)imageSize
                maximumCount:(NSInteger)maximumCount;


-(BOOL)asynchronouslyRetrieveImageForImageUrl:(NSURL *)imageUrl
                                   formatName:(NSString *)formatName
                              completionBlock:(void (^)(UIImage *))completionBlock;
@end
