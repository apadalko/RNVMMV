//
//  RNBlackBox.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/19/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RNViewModel;
@interface RNBlackBox : NSObject
+(instancetype)sharedInstance;
-(void)addViewModel:(RNViewModel*)viewModel;
@end
