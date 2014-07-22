#import "iOSFaceBookFriends.h"

@implementation iOSFaceBookFriends

@synthesize callbackId;

- (void)iOSFaceBookFriends:(CDVInvokedUrlCommand *)command {
    self.callbackId = command.callbackId;

    PFUser *currentUser = [PFUser currentUser];
    
    if (![PFFacebookUtils isLinkedWithUser:currentUser]) {
        [PFFacebookUtils linkUser:currentUser permissions:nil block:^(BOOL succeeded, NSError *error) {
            if (error) {
                NSString *result = [NSString stringWithFormat:@"{ \"error\": \"%@\" }", error];
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
                NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
                [self writeJavascript:javaScript];
            }
        }];
    }
    
    [[FBRequest requestForGraphPath:@"/me/friends?fields=id,name,picture"] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            
            NSString *result = [NSString stringWithFormat:@"{ \"error\": \"%@\" }", error];
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        } else {
            NSArray *friends = [result objectForKey:@"data"];
            NSString *result = [NSString stringWithFormat: @"{ \"error\": false, \"friends\": ["];

            for (NSDictionary *friend in friends) {
                result = [NSString stringWithFormat:@"%@ { \"id\": \"%@\", \"name\": \"%@\", \"picture\": \"%@\"},",
                    result, [friend objectForKey:@"id"], [friend objectForKey:@"name"], [[[friend objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"]];
            }

            result = [NSString stringWithFormat:@"%@] }", [result substringToIndex:[result length] - 1]];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result];
            NSString* javaScript = [pluginResult toSuccessCallbackString:self.callbackId];
            [self writeJavascript:javaScript];
        }
    }];
}

@end
