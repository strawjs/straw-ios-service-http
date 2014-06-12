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
    NSString *charset = params[@"charset"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:[timeout doubleValue]];

    NSHTTPURLResponse *response;
    NSError *error;

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSInteger statusCode = [response statusCode];

    if (error) {

        if ([error code] == NSURLErrorTimedOut) {
            [context failWithCode:STWServiceHttpErrorTimeOut withMessage:@"error: timeout"];
        }

        [context failWithCode:STWServiceHttpErrorUnknown withMessage:@"failed!"];

    } else {

        [context succeedWithObject:@{@"responseText":responseText, @"statusCode":@(statusCode)}];

    }
}


- (void)post:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context
{
}

@end
