#import "CYRootViewController.h"

@implementation CYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Khởi tạo và thiết lập WKWebView
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    // Tạo nút Reload
    UIButton *reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reloadButton setImage:[UIImage imageNamed:@"reload.png"] forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(reloadWebView) forControlEvents:UIControlEventTouchUpInside];
    reloadButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 40, 20, 30, 30); // Góc bên phải của màn hình
    [self.view addSubview:reloadButton];
    
    // Tạo nút Back
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBackWebView) forControlEvents:UIControlEventTouchUpInside];
    backButton.frame = CGRectMake(10, 20, 30, 30); // Góc bên trái của màn hình
    [self.view addSubview:backButton];
    
    // Load trang web
    NSURL *url = [NSURL URLWithString:@"https://cylight.click/auth-login.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    // Load âm thanh
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"cylight" ofType:@"mp3"];
    NSURL *musicFileURL = [NSURL fileURLWithPath:musicFilePath];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicFileURL error:&error];
    if (self.audioPlayer) {
        [self.audioPlayer play];
    } else {
        NSLog(@"Unable to play background music: %@", error);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *username = @"testipa";
        NSString *password = @"1";
        
        // Tự động điền tên người dùng và mật khẩu vào trang web
        NSString *script = [NSString stringWithFormat:@"document.getElementById('username').value = '%@'; document.getElementById('password').value = '%@';", username, password];
        [webView evaluateJavaScript:script completionHandler:nil];
        
        // Thêm mã JavaScript để tự động nhấp vào nút đăng nhập
        NSString *loginScript = @"document.querySelector('.login-button').click();";
        [webView evaluateJavaScript:loginScript completionHandler:nil];
        
        // Cập nhật khung của web view để phù hợp với kích thước màn hình
        CGFloat scale = self.view.frame.size.width / webView.scrollView.contentSize.width;
        webView.scrollView.zoomScale = scale;
        
        // Đánh dấu trang đã được tải
        self.didFinishLoading = YES;
    });
}

- (void)reloadWebView {
    [self.webView reload];
}

- (void)goBackWebView {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

#pragma mark - Application Delegate Methods

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // Kiểm tra các URL scheme của các ứng dụng khác
    if ([url.scheme isEqualToString:@"scheme1"]) {
        // Xử lý liên kết cho ứng dụng có URL scheme là scheme1
        return YES;
    } else if ([url.scheme isEqualToString:@"scheme2"]) {
        // Xử lý liên kết cho ứng dụng có URL scheme là scheme2
        return YES;
    } else {
        // Xử lý mở URL từ các ứng dụng khác ở đây
        return NO;
    }
}

@end
