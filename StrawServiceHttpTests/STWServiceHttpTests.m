#import <XCTest/XCTest.h>
#import "STWServiceHttp.h"

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

@interface STWServiceHttpTests : XCTestCase

@end

@implementation STWServiceHttpTests


- (void)testName
{
    id<STWService> service = [[STWServiceHttp alloc] init];

    XCTAssertEqual(@"http", [service name], @"The service name is `http`.");
}

- (void)testIsBackgroundJob
{
    id<STWService> service = [[STWServiceHttp alloc] init];

    XCTAssert([service isBackgroundJob:@"get"], @"`get` method is a background job.");
    XCTAssert([service isBackgroundJob:@"post"], @"`post` method is a background job.");
}


- (void)testGet
{
    // create the service instance
    STWServiceHttp *serviceHttp = [[STWServiceHttp alloc] init];

    // mock the context up
    id<STWServiceCallContext> serviceCallContext = mockProtocol(@protocol(STWServiceCallContext));

    [serviceHttp get:@{@"url": @"http://0.0.0.0:57577/hello"} withContext:serviceCallContext];

    [verifyCount(serviceCallContext, times(1)) succeedWithObject:@{@"responseText":@"Hello, world!", @"statusCode":@200}];

    [serviceHttp get:@{@"url": @"http://0.0.0.0:57577/404"} withContext:serviceCallContext];

    [verifyCount(serviceCallContext, times(1)) succeedWithObject:@{@"responseText":@"Not Found", @"statusCode":@404}];
}


- (void)testGetWithTimeout
{
    // create the service instance
    STWServiceHttp *serviceHttp = [[STWServiceHttp alloc] init];

    // mock the context up
    id<STWServiceCallContext> serviceCallContext = mockProtocol(@protocol(STWServiceCallContext));

    // request with 1.5 sec timeout
    [serviceHttp get:@{@"url": @"http://0.0.0.0:57577/slow1000", @"timeout": @1.5} withContext:serviceCallContext];

    // it should succeed with a response because 1.5 secs timeout and 1.0 sec response
    [verifyCount(serviceCallContext, times(1)) succeedWithObject:@{@"responseText":@"1000", @"statusCode":@200}];

    // request with 0.5 sec timeout
    [serviceHttp get:@{@"url": @"http://0.0.0.0:57577/slow1000", @"timeout": @0.5} withContext:serviceCallContext];

    // it should fail because 0.5 secs timeout and 1.0 sec response
    [verifyCount(serviceCallContext, times(1)) failWithCode:-1001 withMessage:@"error: timeout"];
}

- (void)testGetNonexistent
{
    // create the service instance
    STWServiceHttp *serviceHttp = [[STWServiceHttp alloc] init];

    // mock the context up
    id<STWServiceCallContext> serviceCallContext = mockProtocol(@protocol(STWServiceCallContext));

    // request with 1.5 sec timeout
    [serviceHttp get:@{@"url": @"http://0.0.0.0:57578/hello"} withContext:serviceCallContext];

    // it should succeed with a response because 1.5 secs timeout and 1.0 sec response
    [verifyCount(serviceCallContext, times(1)) failWithCode:-1 withMessage:@"failed!"];
}

- (void)testGetWithNullTimeout
{
    // create the service instance
    STWServiceHttp *serviceHttp = [[STWServiceHttp alloc] init];

    // mock the context up
    id<STWServiceCallContext> serviceCallContext = mockProtocol(@protocol(STWServiceCallContext));

    // request with NSNull timeout (it happens when JSON from browser is like {"url":"...","timeout":null})
    [serviceHttp get:@{@"url": @"http://0.0.0.0:57577/slow1000", @"timeout": [NSNull null]} withContext:serviceCallContext];

    // it should succeed with a response
    [verifyCount(serviceCallContext, times(1)) succeedWithObject:@{@"responseText":@"1000", @"statusCode":@200}];

}

@end
