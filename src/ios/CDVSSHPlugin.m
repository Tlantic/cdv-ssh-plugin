#import <Cordova/CDV.h>
#import "CDVSSHPlugin.h"
#import "SSHChannel.h"

@implementation CDVSSHPlugin: CDVPlugin

- (NSString*)buildKey :(NSString*)host :(int)port {
    NSString* tempHost = [host lowercaseString];
    NSString* tempPort = [NSString stringWithFormat:@"%d", port];
    
    return  [[tempHost stringByAppendingString:@":"] stringByAppendingString:tempPort];
}

- (void)connect:(CDVInvokedUrlCommand*)command
{
    // validating parameters
    if ([command.arguments count] < 3) {
        
        // triggering parameter error
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Missing arguments when calling 'connect' action."];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        
    } else {
        
        // checking connection pool
        if (!pool) {
            self->pool = [[NSMutableDictionary alloc] init];
        }
        
        
        // running in background to avoid thread locks
        [self.commandDelegate runInBackground:^{
            
            CDVPluginResult* result= nil;
            SSHChannel* channel = nil;
            NSString* key = nil;
            NSString* host = nil;
            int port = 0;
            NSString* username = nil;
            
            // opening connection and adding into pool
            @try {
                
                // preparing parameters
                host = [command.arguments objectAtIndex:0];
                port = [[command.arguments objectAtIndex:1] integerValue];
                key = [self buildKey:host :port];
                username = [command.arguments objectAtIndex:2];
                
                
                // checking existing connections
                if ([pool objectForKey:key]) {
                    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:key];
                    NSLog(@"- Recovered connection with %@", key);
                } else {
                    
                    // creating connection
                    NSLog(@"- Opening connection with %@ ", key);
                    channel = [[SSHChannel alloc] initWithNetworkAddress:host :port];
                    
                    // opening connection
                    if ([channel open:username]) {

                        // connected successfully -- adding to pool
                        [self->pool setObject:channel forKey:key];
                        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:key];
                        NSLog(@"- Established connection with %@", key);
                    
                    } else {
                        NSLog(@"- Unable to connect with host");
                        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"- Failed during connection process."];
                    }
                }
            }
            @catch (NSException *exception) {
                NSLog(@"Exception: %@", exception);
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Unexpected exception when executing 'connect' action."];
            }
            
            //returning callback resolution
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
        
    }
    
}


@end