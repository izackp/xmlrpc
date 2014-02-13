#import "XMLRPCConnectionManager.h"
#import "XMLRPCConnection.h"
#import "XMLRPCRequest.h"
#import "DownloadOperation.h"

@interface XMLRPCConnectionManager ()
@property (strong, nonatomic) NSOperationQueue* connectionQueue;
@end

@implementation XMLRPCConnectionManager

static XMLRPCConnectionManager *sharedInstance = nil;

- (id)init {
    self = [super init];
    if (self) {
        _connectionQueue = [[NSOperationQueue alloc] init];
        [_connectionQueue setMaxConcurrentOperationCount:100];
    }
    
    return self;
}

#pragma mark -

+ (XMLRPCConnectionManager *)sharedManager {
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

#pragma mark -
- (void)spawnConnectionWithXMLRPCRequest: (XMLRPCRequest *)request delegate: (id<XMLRPCConnectionDelegate>)delegate name:(NSString*)name {
    DownloadOperation* operation = [DownloadOperation alloc];
    XMLRPCConnection *newConnection = [[XMLRPCConnection alloc] initWithXMLRPCRequest: request delegate: delegate operation:operation name:name];
    operation = [operation initWithConnection:newConnection];
    [self.connectionQueue addOperation:operation];
}

#pragma mark -
- (void)closeConnections {
    [self.connectionQueue cancelAllOperations];
//    [[myConnections allValues] makeObjectsPerformSelector: @selector(cancel)];
//    
//    [myConnections removeAllObjects];
}

#pragma mark -

- (void)finalize {
    [self closeConnections];
    
    [super finalize];
}

#pragma mark -

- (void)dealloc {
    [self closeConnections];
}

@end
