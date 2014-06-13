#import <Foundation/Foundation.h>
#import <Straw/Straw.h>

typedef NS_ENUM(NSInteger, STWServiceHttpError) {
    STWServiceHttpErrorUnknown = -1,
    STWServiceHttpErrorTimeOut = -1001,
    STWServiceHttpErrorCannotConnectToHost = -1004,
};

@interface STWServiceHttp : NSObject <STWService>

/**
 @serviceMethod
 Perform a http GET request to the url.

 Success Object:
 - {String} responseText The response text
 - {Number} statusCode The status code of the response

 Error Codes:
 - -1: Unknown error occured
 - -1001: Connection timed out
 - -1004: Cannot connect to the host

 @param params The parameters for the method call. params[@"url"] is the url. params[@"timeout"] is the timeout in seconds. params[@"charset"] is the charset to use in decoding the response text.
 @param context The Service Call context of the Method.

 */
- (void)get:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context;
- (void)post:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context;

@end
