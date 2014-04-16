#import <NMSSH/NMSSH.h>


@protocol SshChannelDelegate <NSObject>
@end


@interface SSHChannel : NSObject <NMSSHSessionDelegate> {
@private
    NMSSHSession* session;
}

@property NSString* host;
@property int port;

- (id)initWithNetworkAddress :(NSString*)targetHost :(int)targetPort;
- (BOOL)open :(NSString*)user;

@end