//
//  GMWelcomeGrid.h
//  Gabbermap
//
//  Created by Alex Padalko on 3/8/17.
//  Copyright © 2017 PlacePixel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMWelcomeGrid : UIView
@property (nonatomic)CGSize blockSize;

-(void)appear:(void(^)())complitBlock;
-(CGPoint)centerBlock:(CGPoint)blockPoint;
-(void)higlightBlock:(CGPoint)blockPoint;
-(void)clean;
@end
