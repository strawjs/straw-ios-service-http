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


/**
 @serviceMethod
 Perform a http GET request to the url

 @param params The parameters for the method call. params[@"url"] is the url. params[@"timeout"] is the timeout in seconds. params[@"charset"] is the charset to use in decoding the response text.
 @param context The Service Call context of the Method.

 */
- (void)get:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
    NSString *urlString = params[@"url"];
    NSNumber *timeout = params[@"timeout"];
    NSString *charset = params[@"charset"];

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
