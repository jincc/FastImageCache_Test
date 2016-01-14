//
//  SCImageEntity.h
//  JuMei
//
//  Created by junlongj on 16/1/12.
//  Copyright © 2016年 Jumei Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FastImageCache/FICEntity.h>
@interface SCImageEntity : NSObject<FICEntity>

@property (strong,nonatomic) NSURL *srcURL;

+ (instancetype)imageEntityWithURL:(NSURL *)url;


@end
