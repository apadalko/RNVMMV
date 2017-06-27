//
//  RNViewModel.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RNViewModel : NSObject
-(instancetype)initWithIndentifier:(NSString*)identifier;
@property (nonatomic,retain,readonly)NSString * identifier;

-(void)observe:(NSString*)something resultBlock:(void(^)(id x))resultBlock;


-(void)callFuncton:(NSString*)functionName params:(NSArray*)params callBack:(void(^)(BOOL success,id data, NSError * error))callBack;
-(void)callFuncton:(NSString*)functionName params:(NSArray*)params;
@end
