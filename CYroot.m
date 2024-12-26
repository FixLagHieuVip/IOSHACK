#import "CYRootViewController.h"
#import <WebKit/WebKit.h>

@interface CYRootViewController ()
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation CYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:@"https://cylight.click/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end