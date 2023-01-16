//
//  VideoCell.h
//  ObjcApplication
//
//  Created by Mariano Martin Battaglia on 12/01/2023.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Video;

@interface VideoCell : UITableViewCell
-(void)updateUI:(nonnull Video*)video;
@end

NS_ASSUME_NONNULL_END
