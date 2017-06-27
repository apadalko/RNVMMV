//
//  RNVMMV.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/15/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <React/RCTBridge.h>
@interface RNVMMV : NSObject 
+(instancetype)loadApplicationWithURL:(NSURL*)url withLaunchOptions:(NSDictionary*)launchOptions;
+(instancetype)sharedInstance;
@property (nonatomic,retain,readonly)RCTBridge * bridge;
@end
