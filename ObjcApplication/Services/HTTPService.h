//
//  HTTPService.h
//  ObjcApplication
//
//  Created by Mariano Martin Battaglia on 04/01/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^onComplete)(NSArray *__nullable dataArray, NSString *__nullable errMessage);

@interface HTTPService : NSObject

+ (id) instance;
- (void) getTutorials:(nullable onComplete)completionHandler;

@end

NS_ASSUME_NONNULL_END
