//
//  VideoVC.m
//  ObjcApplication
//
//  Created by Mariano Martin Battaglia on 12/01/2023.
//

#import "VideoVC.h"
#import "Video.h"

@interface VideoVC ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;

@end

@implementation VideoVC

- (IBAction)donePressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /// Delegates
    self.webView.delegate = self;
    
    /// Initialize labels
    self.titleLbl.text = self.video.videoTitle;
    self.descLbl.text = self.video.videoDescription;
    
    /// WebView
    [self.webView loadHTMLString:self.video.videoIframe baseURL:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    /// Create CSS
    NSString *css = @".container { position: relative; width: 100%; height: 0; padding-bottom: 56.25%; } .video { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }";
    /// Create JS injecting CSS format
    NSString* js = [NSString stringWithFormat:
                    @"var styleNode = document.createElement('style');\n"
                     "styleNode.type = \"text/css\";\n"
                     "var styleText = document.createTextNode('%@');\n"
                     "styleNode.appendChild(styleText);\n"
                     "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
        NSLog(@"js:\n%@",js);
        [self.webView stringByEvaluatingJavaScriptFromString:js];
}

@end
