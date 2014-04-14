#import "CDVScpPlugin.h"
#import <Cordova/CDV.h>

@implementation CDVScpPlugin: CDVPlugin

- (void) copyToRemote:(CDVInvokedUrlCommand *)command {
    
    // checking parameters
    if ([command.arguments count] < 4) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing arguments for copyToRemote"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
    } else {
        
        // running in background to avoid thread locks
        [self.commandDelegate runInBackground:^{
            
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            
            
            
            // answering
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
    }
}
@end