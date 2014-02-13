//
//  DownloadOperation.h
//  XMLRPC
//
//  Created by Isaac Paul on 2/12/14.
//
//

#import <Foundation/Foundation.h>
#import "XMLRPCConnection.h"

@interface DownloadOperation : NSOperation
{
    XMLRPCConnection *connection;
}

@property(readonly) BOOL isExecuting;
@property(readonly) BOOL isFinished;

- (id) initWithConnection: (XMLRPCConnection*) rq;
- (void)finish;

@end
