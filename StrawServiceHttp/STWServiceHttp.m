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
    NSString *urlString = params[@"url"];
    NSNumber *timeout = params[@"timeout"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:[timeout doubleValue]];

    NSURLResponse *response;
    NSError *error;

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    [context succeedWithString:responseText];
}


- (void)post:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
}

@end
