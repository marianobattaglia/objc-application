//
//  VideoCell.m
//  ObjcApplication
//
//  Created by Mariano Martin Battaglia on 12/01/2023.
//

#import "VideoCell.h"
#import "Video.h"

@interface VideoCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@end

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.layer.cornerRadius = 2.0;
//    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
//    self.layer.shadowOpacity = 0.8;
//    self.layer.shadowRadius = 5.0;
//    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    
    self.cellView.layer.cornerRadius = 2.0;
    self.cellView.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
    self.cellView.layer.shadowOpacity = 0.8;
    self.cellView.layer.shadowRadius = 5.0;
    self.cellView.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

-(void)updateUI:(nonnull Video*)video {
    self.titleLbl.text = video.videoTitle;
    self.descLbl.text = video.videoDescription;
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:video.thumbnailUrl]]];
//    self.thumbImg.image = image;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:video.thumbnailUrl]]];
        self.thumbImg.image = image;
        [self.thumbImg reloadInputViews];
    });
}

@end
