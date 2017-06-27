//
//  GMWelcomeGrid.m
//  Gabbermap
//
//  Created by Alex Padalko on 3/8/17.
//  Copyright © 2017 PlacePixel. All rights reserved.
//

#import "GMWelcomeGrid.h"

typedef void (^GMWelcomeGridComplitBlock) ();
@interface GMWelcomeGrid () <CAAnimationDelegate>

@property (nonatomic,retain)CAShapeLayer *  animMaskLayer;
@property (nonatomic,retain)CAGradientLayer * gradientLayer;

@property (nonatomic,copy)GMWelcomeGridComplitBlock complitBlock;


@property (nonatomic,retain)NSMutableDictionary * highlightedBlocks;

@end
@implementation GMWelcomeGrid

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor clearColor];
    
//        self.animMaskLayer.fillRule = kCAFillRuleEvenOdd;
        
  
        self.hidden=YES;
    }
    return self;
}

-(void)clean{
    [self.highlightedBlocks removeAllObjects];
    [self setNeedsDisplay];
}

-(void)appear:(void(^)())complitBlock{
    self.complitBlock = complitBlock;
    self.hidden=NO;
    
    
    
    
    self.animMaskLayer = [CAShapeLayer layer];
    
    float d = sqrtf(powf(self.frame.size.width, 2)+powf(self.frame.size.height, 2));
    d=floorf(d)+1;
    

    self.gradientLayer=[CAGradientLayer layer];
    
    self.gradientLayer.frame =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.gradientLayer.colors =
    [NSArray arrayWithObjects:
     (id)[[UIColor whiteColor] CGColor] ,
     (id)[[[UIColor whiteColor] colorWithAlphaComponent:0] CGColor],
     nil];
    
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(1.0f, 1.0f);
    self.gradientLayer.locations=@[@(1.0),@(1.5)];
    
    CABasicAnimation *gradAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];;
    gradAnimation.duration = 1.5;
    gradAnimation.removedOnCompletion=NO;
    gradAnimation.fromValue =@[@(0.0),@(0.0)];
    gradAnimation.toValue = @[@(1.0),@(1.5)];
    gradAnimation.delegate = self;
    [ self.gradientLayer  addAnimation:gradAnimation forKey:@"aa"];
    self.layer.mask = self.gradientLayer;

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.layer.mask = nil;
    [self setNeedsDisplay];
//    self.gradientLayer.locations=@[@(1.0),@(1.5)];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(0.5);
//        dispatch_async(dispatch_get_main_queue(), ^{
                self.complitBlock();
//        });
//    });

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
  
}

-(void)higlightBlock:(CGPoint)blockPoint{
    
    [self.highlightedBlocks setValue:@(YES) forKey:[NSString stringWithFormat:@"%d_%d",(int)blockPoint.x,(int)blockPoint.y]];
    
    [self setNeedsDisplay];
}

-(CGPoint)centerBlock:(CGPoint)blockPoint{
    
    
    return CGPointMake(blockPoint.x*   self.blockSize.width+1.5*blockPoint.x+1.5+self.blockSize.width/2, blockPoint.y*   self.blockSize.height+1.5*blockPoint.y+1.5+self.blockSize.height/2);
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];

    CGSize gridSize = CGSizeZero;
    if ([UIScreen mainScreen].bounds.size.height==480) {
        gridSize = CGSizeMake(5, 8);

    }else{
        gridSize = CGSizeMake(5, 9);
    }
    
    self.blockSize = CGSizeMake((rect.size.width-(gridSize.width+1)*1.5)/gridSize.width,(rect.size.width-(gridSize.width+1)*1.5)/gridSize.width);
//    blockSize=CGSizeMake(MIN(blockSize.width, blockSize.height), MIN(blockSize.width, blockSize.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(context, 16.0/255.0, 214.0/255.0, 210.0/255.0, 0 );

    
    for (int x = 0 ; x<gridSize.width; x++) {
       
  
        for (int y = 0 ; y<gridSize.height; y++) {
            
            
            NSString * k = [NSString stringWithFormat:@"%d_%d",x,y];
            
            if ([[self.highlightedBlocks valueForKey:k] boolValue]) {
                    CGContextSetRGBStrokeColor(context, 16.0/255.0,214.0/255.0,210.0/255.0,0.75);
                           [self drawRoundedRect:CGRectMake(x*   self.blockSize.width+1.5*x+1.5, y*   self.blockSize.height+1.5*y+1.5,    self.blockSize.width,    self.blockSize.height) andLineWidth:3 andRaious:4 DrawingMode:kCGPathFillStroke andContext:context];
            }else{
                    CGContextSetRGBStrokeColor(context, 16.0/255.0,214.0/255.0,210.0/255.0,0.25);
                           [self drawRoundedRect:CGRectMake(x*   self.blockSize.width+1.5*x+1.5, y*   self.blockSize.height+1.5*y+1.5,    self.blockSize.width,    self.blockSize.height) andLineWidth:3 andRaious:4 DrawingMode:kCGPathFillStroke andContext:context];
            }
            
 
            
        }
}




}
-(void)drawRoundedRect:(CGRect)rect andLineWidth:(float)lineWidth andRaious:(float)radius DrawingMode:(CGPathDrawingMode)drawMode andContext:(CGContextRef)context{
    
    
    
    CGContextSetLineWidth(context,lineWidth);
    
    
    CGRect rrect = CGRectInset(rect, lineWidth/2, lineWidth/2);
    
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    
    
    CGContextMoveToPoint(context, minx, midy);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    // Close the path
    CGContextClosePath(context);
    // Fill & stroke the path
    //        CGContextDrawPath(context, kCGPathFillStroke);
    CGContextDrawPath(context, drawMode);
}
-(NSMutableDictionary *)highlightedBlocks{
    if (!_highlightedBlocks) {
        _highlightedBlocks =[[NSMutableDictionary alloc] init];
    }
    return _highlightedBlocks;
}

@end
