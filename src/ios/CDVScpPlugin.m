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
            
            
            CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            NSString* user = nil;
            NSString* pass = nil;
            NSString* source = nil;
            NSString* destination = nil;
            NMSSHSession* session = nil;
            
            @try {
                
                // getting parameters
                user = [command.arguments objectAtIndex:0];
                pass = [command.arguments objectAtIndex:1];
                source = [command.arguments objectAtIndex:2];
                destination = [command.arguments objectAtIndex:3];
                
                // opening SSH session
                NSLog(@"- Opening connection with %@ ", destination);
                session = [NMSSHSession connectToHost:destination withUsername:user];
                
                // checking connection
                if (session.isConnected) {
                    NSLog(@"- Connection with host has been stablished!");
                    NSLog(@"- Authenticating with %@", user);
                    
                    // authenticating
                    [session authenticateByPassword:pass];
                    
                    if (session.isAuthorized) {
                        NSLog(@"- Authentication succeeded");
                    } else {
                        NSLog(@"- Authentication failed");
                        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Failed during authentication process."];
                    }
                    
                    
                    // closing connection
                    [session disconnect];
                    
                } else {
                    NSLog(@"- Unable to connect with host");
                    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Failed during authentication process."];
                }
                
                
                /*
                NSError *error = nil;
                NSString *response = [session.channel execute:@"ls -l /var/www/" error:&error];
                NSLog(@"List of my sites: %@", response);
                
                BOOL success = [session.channel uploadFile:@"~/index.html" to:@"/var/www/9muses.se/"];
                */
            }
            @catch (NSException *exception) {
                NSLog(@"Exception: %@", exception);
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Unexpected exception when executing 'copyToRemote' action."];
                
                // releasing connection
                if (session.isConnected) {
                    [session disconnect];
                }
            }
            
            // answering
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
    }
}
@end