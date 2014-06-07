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
    STWServiceHttp *serviceHttp = [[STWServiceHttp alloc] init];

    id<STWServiceCallContext> serviceCallContext = mockProtocol(@protocol(STWServiceCallContext));

    [serviceHttp get:@{@"url": @"http://0.0.0.0:57577/hello"} withContext:serviceCallContext];

    [verifyCount(serviceCallContext, times(1)) succeedWithString:@"Hello, world!"];
}


- (void)testGetWithTimeout
{
    STWServiceHttp *serviceHttp = [[STWServiceHttp alloc] init];

    id<STWServiceCallContext> serviceCallContext = mockProtocol(@protocol(STWServiceCallContext));

    [serviceHttp get:@{@"url": @"http://0.0.0.0:57577/slow1000", @"timeout": @1.5} withContext:serviceCallContext];

    [verifyCount(serviceCallContext, times(1)) succeedWithString:@"1000"];
}

@end
