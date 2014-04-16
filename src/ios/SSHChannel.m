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
    //session.delegate = self;
    [session connect];
    return [session isConnected];
}
@end