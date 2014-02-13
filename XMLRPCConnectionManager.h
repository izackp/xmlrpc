#import <Foundation/Foundation.h>
#import "XMLRPCConnectionDelegate.h"

@class XMLRPCConnection, XMLRPCRequest;

@interface XMLRPCConnectionManager : NSObject {
    //NSMutableDictionary *myConnections;
}

+ (XMLRPCConnectionManager *)sharedManager;

#pragma mark -

- (void)spawnConnectionWithXMLRPCRequest: (XMLRPCRequest *)request delegate: (id<XMLRPCConnectionDelegate>)delegate name:(NSString*)name;

- (void)closeConnections;

@end
