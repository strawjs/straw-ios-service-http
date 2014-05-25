#import <XCTest/XCTest.h>
#import "STWServiceHttp.h"

@interface STWServiceHttpTests : XCTestCase

@end

@implementation STWServiceHttpTests


- (void)testName
{
    id<STWService> service = [[STWServiceHttp alloc] init];

    XCTAssertEqual(@"http", [service name], @"The service name is `http`.");
}

@end
