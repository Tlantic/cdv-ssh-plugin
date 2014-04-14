#import "CDVScpPlugin.h"
#import <Cordova/CDV.h>
#import <NMSSH/NMSSH.h>

@implementation CDVScpPlugin: CDVPlugin

- (void) copyToRemote:(CDVInvokedUrlCommand *)command {
    
    // checking parameters
    if ([command.arguments count] < 4) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing arguments for copyToRemote"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    
    } else {
        
        // running in background to avoid thread locks
        [self.commandDelegate runInBackground:^{
            
            
            CDVPluginResult* result = nil;
            NSString* user = nil;
            NSString* pass = nil;
            NSString* source = nil;
            NSString* destination = nil;
            
            @try {
                user = [command.arguments objectAtIndex:0];
                pass = [command.arguments objectAtIndex:1];
                source = [command.arguments objectAtIndex:2];
                destination = [command.arguments objectAtIndex:3];
                
                
            }
            @catch (NSException *exception) {
                NSLog(@"Exception: %@", exception);
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Unexpected exception when executing 'copyToRemote' action."];
                
            }
            
            // answering
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
    }
}
@end