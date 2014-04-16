#import <Cordova/CDV.h>
#import "SSHChannel.h"

@interface CDVSSHPlugin : CDVPlugin <SshChannelDelegate> {
    NSMutableDictionary *pool;
}

-(void) connect: (CDVInvokedUrlCommand *) command;
-(void) disconnect: (CDVInvokedUrlCommand *) command;
-(void) disconnectAll: (CDVInvokedUrlCommand *) command;
-(BOOL) disposeChannel :(NSString *)key;

-(void) authenticateByKeyboard: (CDVInvokedUrlCommand *) command;

-(void) scp: (CDVInvokedUrlCommand *) command;

@end