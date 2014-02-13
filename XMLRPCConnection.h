#import <Foundation/Foundation.h>
#import "XMLRPCConnectionDelegate.h"

@class XMLRPCConnectionManager, XMLRPCRequest, XMLRPCResponse, DownloadOperation;

@interface XMLRPCConnection : NSObject {
    DownloadOperation *myManager;
    XMLRPCRequest *myRequest;
    NSString *myIdentifier;
    NSMutableData *myData;
    NSURLConnection *myConnection;
    id<XMLRPCConnectionDelegate> myDelegate;
    bool invalid;
}

- (id)initWithXMLRPCRequest: (XMLRPCRequest *)request delegate: (id<XMLRPCConnectionDelegate>)delegate operation:(DownloadOperation*)operation name:(NSString*)name;

#pragma mark -

+ (XMLRPCResponse *)sendSynchronousXMLRPCRequest: (XMLRPCRequest *)request error: (NSError **)error;
+ (void)setCredential:(NSURLCredential*)creds;

#pragma mark -

- (NSString *)identifier;

#pragma mark -

- (id<XMLRPCConnectionDelegate>)delegate;

#pragma mark -

- (void)start;
- (void)cancel;

@end
