//  Created by Nikunj Rola - TheAppGuruz

#import "IOSNativeUtility.h"

@implementation IOSNativeUtility

static IOSNativeUtility *_sharedInstance;
static NSString* templateReviewURLIOS7  = @"itms-apps://itunes.apple.com/app/idAPP_ID";
NSString *templateReviewURL = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=APP_ID";

+ (id)sharedInstance {
    
    if (_sharedInstance == nil)  {
        _sharedInstance = [[self alloc] init];
    }
    
    return _sharedInstance;
}

-(void) redirectToRatigPage:(NSString *)appId {
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
#else
    
    NSString *reviewURL;
    NSArray *vComp = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    
    if ([[vComp objectAtIndex:0] intValue] >= 7) {
        reviewURL = [templateReviewURLIOS7 stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", appId]];
    }  else {
        reviewURL = [templateReviewURL stringByReplacingOccurrencesOfString:@"APP_ID" withString:[NSString stringWithFormat:@"%@", appId]];
    }
    
    NSLog(@"redirecting to iTunes page, IOS version: %i", [[vComp objectAtIndex:0] intValue]);
    NSLog(@"redirect URL: %@", reviewURL);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewURL]];
    #endif
}

-(void) openWebPage:(NSString *)urlString{
    #if TARGET_IPHONE_SIMULATOR
    NSLog(@"APPIRATER NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page.");
    #else
    NSURL *url = [ [ NSURL alloc ] initWithString:urlString];
    
    [[UIApplication sharedApplication] openURL:url];
    
    #endif
}

extern "C" {
    
    void _TAG_RedirectToAppStoreRatingPage(char* appId) {
        [[IOSNativeUtility sharedInstance] redirectToRatigPage: [DataConvertor charToNSString:appId ]];
    }
    
    void _TAG_RedirectToWebPage(char* urlString){
        [[IOSNativeUtility sharedInstance] openWebPage:[DataConvertor charToNSString:urlString]];
    }
}
@end
