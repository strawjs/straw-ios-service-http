#import "STWServiceHttp.h"

@implementation STWServiceHttp

- (NSString *)name
{
    return @"http";
}

- (BOOL)isBackgroundJob:(NSString *)method
{
    return YES;
}


- (void)get:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
}


- (void)post:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
}

@end
