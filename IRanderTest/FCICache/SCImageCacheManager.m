//
//  SCImageCacheManager.m
//  JuMei
//
//  Created by junlongj on 16/1/12.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import "SCImageCacheManager.h"
#import "SCImageEntity.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCacheOperation.h>
#import <objc/runtime.h>

NSUInteger const kMaxConcurrentDownloads = 8;
@interface SCImageCacheManager()<FICImageCacheDelegate>
@property (nonatomic  ,strong, readwrite)NSMutableArray<FICImageFormat *> *formats;
@end

@implementation SCImageCacheManager

#pragma mark - Action

-(BOOL)asynchronouslyRetrieveImageForImageUrl:(NSURL *)imageUrl
                                   formatName:(NSString *)formatName
                              completionBlock:(void (^)(UIImage *))completionBlock{
    
    return [[FICImageCache sharedImageCache]asynchronouslyRetrieveImageForEntity:[SCImageEntity imageEntityWithURL:imageUrl] withFormatName:formatName completionBlock:^(id<FICEntity> entity, NSString *formatName, UIImage *image) {
            completionBlock(image);
    }];
}

-(void)appendFormatWithName:(NSString *)name
                  imageSize:(CGSize)imageSize
               maximumCount:(NSInteger)maximumCount{
    
    FICImageFormat *format = [FICImageFormat formatWithName:name
                                                     family:nil
                                                  imageSize:imageSize
                                                      style:FICImageFormatStyle32BitBGRA
                                               maximumCount:maximumCount
                                                    devices:FICImageFormatDevicePhone
                                             protectionMode:FICImageFormatProtectionModeNone];
    [self.formats addObject:format];
    [[FICImageCache sharedImageCache] setFormats:@[format]];
}
+(instancetype)manager{
    
    static dispatch_once_t onceToken;
    static SCImageCacheManager *manager ;
    dispatch_once(&onceToken, ^{
        manager = [[[self class]alloc]init];
        [manager setup];
    });
    return manager;
}

-(instancetype)init{
   
    if (self = [super init]) {
        self.formats = [NSMutableArray array];
    }
    return self;
}

- (void)setup{
    [[FICImageCache sharedImageCache] setDelegate:self];
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader setMaxConcurrentDownloads:kMaxConcurrentDownloads];
}
#pragma mark FICImageCacheDelegate
-(void)imageCache:(FICImageCache *)imageCache wantsSourceImageForEntity:(id<FICEntity>)entity withFormatName:(NSString *)formatName completionBlock:(FICImageRequestCompletionBlock)completionBlock{
    

    SCImageEntity *theEntity = (SCImageEntity *)entity;
 
        // download from network

     [[SDWebImageDownloader sharedDownloader]downloadImageWithURL:theEntity.srcURL options:SDWebImageDownloaderLowPriority progress:NULL
                                                               completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            completionBlock(image);
    }];
    

  

}

- (void)imageCache:(FICImageCache *)imageCache cancelImageLoadingForEntity:(id <FICEntity>)entity withFormatName:(NSString *)formatName{
    
}
- (BOOL)imageCache:(FICImageCache *)imageCache shouldProcessAllFormatsInFamily:(NSString *)formatFamily forEntity:(id <FICEntity>)entity
{
    return  true;
}
- (void)imageCache:(FICImageCache *)imageCache errorDidOccurWithMessage:(NSString *)errorMessage{
    
}

@end
