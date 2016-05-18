//  Created by Nikunj Rola - TheAppGuruz

#import "IOSNativePopUpsManager.h"

@implementation IOSNativePopUpsManager

static UIAlertController* _currentAllert =  nil;

+ (void) unregisterAllertView {
    if(_currentAllert != nil) {
        _currentAllert = nil;
    }
}

+(void) dismissCurrentAlert {
    if(_currentAllert != nil) {
        [_currentAllert dismissViewControllerAnimated:NO completion:nil];
        _currentAllert = nil;
    }
}

+(void) showRateUsPopUp: (NSString *) title message: (NSString*) msg b1: (NSString*) b1 b2: (NSString*) b2 b3: (NSString*) b3 {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *rateAction = [UIAlertAction actionWithTitle:b1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [IOSNativePopUpsManager unregisterAllertView];
        UnitySendMessage("IOSRateUsPopUp", "OnRatePopUpCallBack",  [DataConvertor NSIntToChar:0]);
    }];
    
    UIAlertAction *laterAction = [UIAlertAction actionWithTitle:b2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [IOSNativePopUpsManager unregisterAllertView];
        UnitySendMessage("IOSRateUsPopUp", "OnRatePopUpCallBack",  [DataConvertor NSIntToChar:1]);
    }];

    UIAlertAction *declineAction = [UIAlertAction actionWithTitle:b3 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [IOSNativePopUpsManager unregisterAllertView];
        UnitySendMessage("IOSRateUsPopUp", "OnRatePopUpCallBack",  [DataConvertor NSIntToChar:2]);
    }];

    [alertController addAction:rateAction];
    [alertController addAction:laterAction];
    [alertController addAction:declineAction];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    _currentAllert = alertController;
}

+ (void) showDialog: (NSString *) title message: (NSString*) msg yesTitle:(NSString*) b1 noTitle: (NSString*) b2{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:b1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [IOSNativePopUpsManager unregisterAllertView];
        UnitySendMessage("IOSDialogPopUp", "OnDialogPopUpCallBack",  [DataConvertor NSIntToChar:0]);
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:b2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [IOSNativePopUpsManager unregisterAllertView];
        UnitySendMessage("IOSDialogPopUp", "OnDialogPopUpCallBack",  [DataConvertor NSIntToChar:1]);
    }];
    
    [alertController addAction:yesAction];
    [alertController addAction:noAction];
    
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    _currentAllert = alertController;
}

+(void)showMessage: (NSString *) title message: (NSString*) msg okTitle:(NSString*) b1 {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:b1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [IOSNativePopUpsManager unregisterAllertView];
        UnitySendMessage("IOSMessagePopUp", "OnPopUpCallBack",  [DataConvertor NSIntToChar:0]);
    }];
    [alertController addAction:okAction];
    
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
    _currentAllert = alertController;
}

extern "C" {
    // Unity Call
    
    void _TAG_ShowRateUsPopUp(char* title, char* message, char* b1, char* b2, char* b3) {
        [IOSNativePopUpsManager showRateUsPopUp:[DataConvertor charToNSString:title] message:[DataConvertor charToNSString:message] b1:[DataConvertor charToNSString:b1] b2:[DataConvertor charToNSString:b2] b3:[DataConvertor charToNSString:b3]];
    }
    
    void _TAG_ShowDialog(char* title, char* message, char* yes, char* no) {
        [IOSNativePopUpsManager showDialog:[DataConvertor charToNSString:title] message:[DataConvertor charToNSString:message] yesTitle:[DataConvertor charToNSString:yes] noTitle:[DataConvertor charToNSString:no]];
    }
    
    void _TAG_ShowMessage(char* title, char* message, char* ok) {
        [IOSNativePopUpsManager showMessage:[DataConvertor charToNSString:title] message:[DataConvertor charToNSString:message] okTitle:[DataConvertor charToNSString:ok]];
    }
    
    void _TAG_DismissCurrentAlert() {
        [IOSNativePopUpsManager dismissCurrentAlert];
    }
}

@end
