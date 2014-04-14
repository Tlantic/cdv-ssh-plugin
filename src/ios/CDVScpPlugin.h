#import <Cordova/CDV.h>

@interface CDVScpPlugin : CDVPlugin

-(void) copyToRemote: (CDVInvokedUrlCommand *) command;

@end