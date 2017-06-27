//
//  RNVMMV.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "RNVMMV.h"


#import <React/RCTLog.h>
#import <React/RCTJavaScriptLoader.h>
#import "RNRouter.h"
#import "RNBlackBox.h"
@interface RNVMMV () <RCTBridgeDelegate>

@property (nonatomic,retain)NSURL * bundleURL;

@end
@implementation RNVMMV
static RNVMMV * inst;
+(instancetype)loadApplicationWithURL:(NSURL *)url withLaunchOptions:(NSDictionary *)launchOptions{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    inst = [[self alloc] initWithURL:url launchOptions:launchOptions];
  });
  
  return inst;
}
+(instancetype)sharedInstance{
  return inst;
}
-(instancetype)initWithURL:(NSURL*)url launchOptions:(NSDictionary*)launchOptions{
  if (self=[super init]) {
      self.bundleURL = url;
    
    _bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
    
    
//                          return @[[RNRouter sharedInstance],[RNBlackBox sharedInstance]];
  }
  return self;
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge{
  
  return self.bundleURL;
  
}
- (NSArray<id<RCTBridgeModule>> *)extraModulesForBridge:(RCTBridge *)bridge{
      return @[[RNRouter sharedInstance],[RNBlackBox sharedInstance]];
  
}


-(void)startApp{
  [self.bridge enqueueJSCall:@"RNVMMVRouter"
                                           method:@"deadlock"
                                             args:@[] completion:nil];
}

- (void)loadSourceForBridge:(RCTBridge *)bridge
                 onProgress:(RCTSourceLoadProgressBlock)onProgress
                 onComplete:(RCTSourceLoadBlock)loadCallback{
  
  
  [RCTJavaScriptLoader loadBundleAtURL:self.bundleURL onProgress:onProgress onComplete:^(NSError *error, NSData *source, int64_t sourceLength) {
    if (error && [self respondsToSelector:@selector(fallbackSourceURLForBridge:)]) {
      NSURL *fallbackURL = [self fallbackSourceURLForBridge:self.bridge];
      if (fallbackURL && ![fallbackURL isEqual:self.bundleURL]) {
        RCTLogError(@"Failed to load bundle(%@) with error:(%@)", self.bundleURL, error.localizedDescription);
        self.bundleURL = fallbackURL;
        [RCTJavaScriptLoader loadBundleAtURL:self.bundleURL onProgress:onProgress onComplete:loadCallback];
        return;
      }
    }
    loadCallback(error, source, sourceLength);
    
    [self startApp];
  }];
  
}
@end
