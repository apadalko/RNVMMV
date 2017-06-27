//
//  RNVMMVCallBackManager.h
//  Gabbermap
//
//  Created by Alex Padalko on 4/19/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^RNVMMVFunctionCallback) (BOOL success,id data, NSError * error);
@interface RNVMMVCallBackManager : NSObject
+(instancetype)sharedInstance;
/**

 @returns callback identifier
 */
-(NSString*)registerCallBack:(RNVMMVFunctionCallback)callback;
@end
