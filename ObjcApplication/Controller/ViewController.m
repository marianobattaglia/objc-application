//
//  ViewController.m
//  ObjcApplication
//
//  Created by Mariano Martin Battaglia on 04/01/2023.
//

#import "ViewController.h"
#import "HTTPService.h"
#import "Video.h"
#import "VideoCell.h"
#import "VideoVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *videoList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /// TableView delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    /// Mutable array for getting service
    self.videoList = [[NSArray alloc] init];
    
    /// HTTPS Service
    [[HTTPService instance] getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable errMessage) {
        if (dataArray) {
            NSLog(@"Dictionary: %@",dataArray.debugDescription);
            
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            
            for (NSDictionary *d in dataArray) {
                Video *vid = [[Video alloc]init];
                vid.videoTitle = [d objectForKey:@"title"];
                vid.videoDescription = [d objectForKey:@"description"];
                vid.thumbnailUrl = [d objectForKey:@"thumbnail"];
                vid.videoIframe = [d objectForKey:@"iframe"];
                
                [arr addObject:vid];
            }
            self.videoList = arr;
            [self updateTableData];
            
        } else if (errMessage) {
            // Display alert to user
        }
    }];
    
    /// Navigation Bar
    //[self initNavigationBar];
}

-(void)updateTableData {
    /// Reload data when data is loaded
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(void)initNavigationBar {
    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"ObjC-App"];
    [navbar setBarTintColor:[UIColor systemBlueColor]];
    /// That code is for adding navigationBar buttons
    //UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onTapCancel:)];
    //navItem.leftBarButtonItem = cancelBtn;
    //UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone:)];
    //navItem.rightBarButtonItem = doneBtn;
    [navbar setItems:@[navItem]];
    [self.view addSubview:navbar];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = (VideoCell*)[tableView dequeueReusableCellWithIdentifier:@"main"];
    
    if (!cell) {
        cell = [[VideoCell alloc]init];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    VideoCell *vidCell = (VideoCell*)cell;
    [vidCell updateUI:video];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"videoVC" sender:video];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    VideoVC *vc = (VideoVC*)segue.destinationViewController;
    Video *video = (Video*)sender;
    /// Asign vc video to video class property
    vc.video = video;
}

@end
