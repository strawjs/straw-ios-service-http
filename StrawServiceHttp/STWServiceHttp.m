#import "STWServiceHttp.h"

// the default encoding is UTF-8
#define STWServiceHTTPDefaultStringEncoding NSUTF8StringEncoding

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

    NSStringEncoding encoding = [self selectEncoding:charset];

    // check if timeout is a NSNull
    if ([timeout isKindOfClass:[NSNull class]]) {
        timeout = @0;
    }

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]
                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval:[timeout doubleValue]];

    NSHTTPURLResponse *response;
    NSError *error;

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseText = [[NSString alloc] initWithData:data encoding:encoding];

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


- (NSStringEncoding)selectEncoding:(NSString *)charset
{
    if (!charset) {
        // if charset is nil, then returns the default
        return STWServiceHTTPDefaultStringEncoding;
    }

    charset = [charset lowercaseString];

    if ([charset isEqualToString:@"utf8"] || [charset isEqualToString:@"utf-8"]) {

        return NSUTF8StringEncoding;

    } else if ([charset isEqualToString:@"shitfjis"] || [charset isEqualToString:@"shift_jis"]) {

        return NSShiftJISStringEncoding;

    } else if ([charset isEqualToString:@"eucjp"] || [charset isEqualToString:@"euc-jp"]) {

        return NSJapaneseEUCStringEncoding;

    }
    // please add here what you need...

    // otherwise returns the default
    return STWServiceHTTPDefaultStringEncoding;

}

@end
