#import "CYAppDelegate.h"
#import "CYRootViewController.h"
#import <UIKit/UIKit.h>

@implementation CYAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CYRootViewController *rootViewController = [[CYRootViewController alloc] init];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
