#import "iOSFaceBookFriends.h"

@implementation iOSFaceBookFriends

@synthesize callbackId;

- (void)iOSFaceBookFriends:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;
    [[FBRequest requestForGraphPath:@"/me/invitable_friends"] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (error) {
            NSString *result = [NSString stringWithFormat:@"{ \"error\": \"%@\" }", error];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        } else {
            NSArray *friends = [result objectForKey:@"data"];
            NSString *result = [NSString stringWithFormat: @"{ \"error\": false, \"friends\": ["];

            for (NSDictionary *friend in friends) {
                result = [NSString stringWithFormat:@"%@ { \"name\": \"%@\", \"id\": \"%@\" },", result, [friend objectForKey:@"name"], [friend objectForKey:@"id"]];
            }

            result = [NSString stringWithFormat:@"%@] }", [result substringToIndex:[result length] - 1]];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        }
    }];
}

@end
