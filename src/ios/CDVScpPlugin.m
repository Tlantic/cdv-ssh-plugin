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
            NSString* source = nil;
            NSString* destination = nil;
            NMSSHSession* session = nil;
            
            @try {
                
                // getting parameters
                user = [command.arguments objectAtIndex:0];
                self->shhpwd = [command.arguments objectAtIndex:1];
                source = [command.arguments objectAtIndex:2];
                destination = [command.arguments objectAtIndex:3];
                
                // opening SSH session
                NSLog(@"- Opening connection with %@ ", destination);
                session = [[NMSSHSession alloc] initWithHost:destination andUsername:user];
                session.delegate = self;
                [session connect];

                
                
                //NSArray* m = [session supportedAuthenticationMethods];
                
                // checking connection
                if ([session isConnected]) {
                    NSLog(@"- Connection with host has been stablished!");
                    NSLog(@"- Authenticating with %@", user);
                    
                    // authenticating
                    [session authenticateByKeyboardInteractive];
                    
                    if ([session isAuthorized]) {
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


- (void)session:(NMSSHSession *)session didDisconnectWithError:(NSError *)error {
    NSLog(@"DISCONNECT!!!");
}

- (NSString *)session:(NMSSHSession *)session keyboardInteractiveRequest:(NSString *)request {
    NSLog(@"### THIS IS THE REQUEST %@", request);
    return self->shhpwd;
}
- (BOOL)session:(NMSSHSession *)session shouldConnectToHostWithFingerprint:(NSString *)fingerprint{
    NSLog(@"FINGERPRINT STUFF");
    return YES;
}

@end