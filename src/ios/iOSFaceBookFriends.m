#import "iOSFaceBookFriends.h"

@implementation iOSFaceBookFriends

@synthesize callbackId;

- (void)iOSFaceBookFriends:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;
    [[FBRequest requestForGraphPath:@"/me/friends?fields=id,name,picture"] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
            NSString *result = [NSString stringWithFormat:@"{ \"error\": \"Invalid Session Token\" }"];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        } else {
            NSError *writeError = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&writeError];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsonString];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        }
    }];
}

@end
