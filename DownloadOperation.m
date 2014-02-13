//
//  DownloadOperation.m
//  XMLRPC
//
//  Created by Isaac Paul on 2/12/14.
//
//

#import "DownloadOperation.h"

@interface DownloadOperation ()
@property(assign) BOOL isExecuting;
@property(assign) BOOL isFinished;
@end

@implementation DownloadOperation
@synthesize isExecuting;
@synthesize isFinished;

//static int totalOperations = 0;

#pragma mark Initialization

- (id) initWithConnection: (XMLRPCConnection*) rq
{
    if (self = [super init])
        connection = rq;
    return self;
}

#pragma mark NSOperation Stuff

- (void) start
{
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:true];
        return;
    }
    NSParameterAssert(connection);
    [self setIsExecuting:YES];
    [self setIsFinished:NO];
    

    [connection start];
//    totalOperations += 1;
//    NSLog(@"Total operations++: %i", totalOperations);
}

- (BOOL) isConcurrent
{
    return YES;
}

- (void)finish {
    if (!isFinished && isExecuting)
    {
        [self setIsExecuting:NO];
        [self setIsFinished:YES];
//        totalOperations -= 1;
//        NSLog(@"Total operations--: %i", totalOperations);
    }
    else
    {
        [self setIsExecuting:NO];
        [self setIsFinished:YES];
    }
    
}

- (void)cancel {
    [connection cancel];
    [self finish];
}

+ (BOOL) automaticallyNotifiesObserversForKey: (NSString*) key
{
    return YES;
}

@end
