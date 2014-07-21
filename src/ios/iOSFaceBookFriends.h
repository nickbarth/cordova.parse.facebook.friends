#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>
#import <Cordova/CDV.h>

@interface iOSFaceBookFriends: CDVPlugin{
  NSString* callbackId;
}

@property (nonatomic, retain) NSString* callbackId;
- (void)iOSFaceBookFriends:(CDVInvokedUrlCommand *)command;
@end
