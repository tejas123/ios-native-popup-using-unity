//  Created by Nikunj Rola - TheAppGuruz

#import <Foundation/Foundation.h>
#import "DataConvertor.h"
#if UNITY_VERSION < 450
#include "iPhone_View.h"
#endif

@interface IOSNativeUtility : NSObject

@property (strong)  UIActivityIndicatorView *spinner;

 + (id) sharedInstance;

 - (void) redirectToRatigPage: (NSString *) appId;

@end