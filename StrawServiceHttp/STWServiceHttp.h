#import <Foundation/Foundation.h>
#import <Straw/Straw.h>

@interface STWServiceHttp : NSObject <STWService>

- (void)get:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context;
- (void)post:(NSDictionary *)params withContext:(id<STWServiceCallContext>)context;

@end
