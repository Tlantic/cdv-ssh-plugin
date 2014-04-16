#import "SSHChannel.h"

@implementation SSHChannel: NSObject

- (id)initWithNetworkAddress:(NSString *)targetHost :(int)targetPort {
    self = [super init];
    if (self)
    {
        _host = targetHost;
        _port = targetPort;
    }
    return self;
}

- (BOOL)open :(NSString*)user {
    session = [[NMSSHSession alloc] initWithHost:_host port:_port andUsername:user];
    session.delegate = self;
    [session connect];
    return [session isConnected];
}

- (BOOL)isConnected {
    return [session isConnected];
}

- (void)close {
    if ([self isConnected]) {
        [session disconnect];
    }
}

- (BOOL) isAuthenticationMethodSupported :(NSString*)method {
    NSArray* supported = [session supportedAuthenticationMethods];
    
    return [supported containsObject:method];
}

- (BOOL) authenticateByKeyboardInteractive :(NSString*)password {
    // authenticating
    _kbpwd = password;
    [session authenticateByKeyboardInteractive];
    
    return [session isAuthorized];
}

- (void)session:(NMSSHSession *)session didDisconnectWithError:(NSError *)error {
    NSLog(@"DISCONNECTED!!!");
}

- (NSString *)session:(NMSSHSession *)session keyboardInteractiveRequest:(NSString *)request {
    return self->_kbpwd;
}
- (BOOL)session:(NMSSHSession *)session shouldConnectToHostWithFingerprint:(NSString *)fingerprint{
    return YES;
}

- (BOOL)uploadFile  :(NSString*)file    :(NSString*)path {
    return [session.channel uploadFile:file to:path];
}
@end