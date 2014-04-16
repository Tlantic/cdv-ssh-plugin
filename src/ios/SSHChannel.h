#import <NMSSH/NMSSH.h>


@protocol SshChannelDelegate <NSObject>
@end


@interface SSHChannel : NSObject <NMSSHSessionDelegate> {
@private
    NMSSHSession* session;
}

@property NSString* host;
@property int port;
@property NSString* kbpwd;

- (id)initWithNetworkAddress :(NSString*)targetHost :(int)targetPort;
- (BOOL)open :(NSString*)user;
- (BOOL)isConnected;
- (void)close;
- (BOOL) isAuthenticationMethodSupported :(NSString*)method;
- (BOOL) authenticateByKeyboardInteractive :(NSString*)password;

- (void)session:(NMSSHSession *)session didDisconnectWithError:(NSError *)error;
- (NSString *)session:(NMSSHSession *)session keyboardInteractiveRequest:(NSString *)request;
- (BOOL)session:(NMSSHSession *)session shouldConnectToHostWithFingerprint:(NSString *)fingerprint;
@end