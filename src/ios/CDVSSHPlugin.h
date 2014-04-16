#import <Cordova/CDV.h>
#import <NMSSH/NMSSH.h>

@interface CDVScpPlugin : CDVPlugin <NMSSHSessionDelegate> {
    NSString* shhpwd;
}

-(void) copyToRemote: (CDVInvokedUrlCommand *) command;

- (void)session:(NMSSHSession *)session didDisconnectWithError:(NSError *)error;
- (NSString *)session:(NMSSHSession *)session keyboardInteractiveRequest:(NSString *)request;
- (BOOL)session:(NMSSHSession *)session shouldConnectToHostWithFingerprint:(NSString *)fingerprint;

@end