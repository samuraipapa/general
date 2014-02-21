//
//  MyScene.m
//  NSFastEnumeration Example  For Loop
//
//  Created by yg on 2/21/14.
//  Copyright (c) 2014 Yury. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene{
    NSMutableArray* touchDrawArray;
}



-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMinY(self.frame));
        
        
        

        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        NSLog(@"touch locationInNode: %f x %f",location.x, location.y);

        touchDrawArray  = [@[[NSValue valueWithCGPoint:location]] mutableCopy];
        
        
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
     
        
        [touchDrawArray addObject:[NSValue valueWithCGPoint:location]];
        
        
        
   //     NSLog(@"touch locationInNode: %f x %f",location.x, location.y);
   //     [self drawSmallSquareInLocation:location];
        
    }

}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    //for (NSString *person in touchDrawArray) {
     //   NSLog(@"element say %@", person);
        for (NSValue* myPoint in touchDrawArray) {
     //       NSLog(@"myPoint: %@",myPoint  );
            [self drawSmallSquareInLocation:[myPoint CGPointValue]];
      //  }
    }
}

-(void) drawSmallSquareInLocation: (CGPoint) location{
    SKSpriteNode *smallSquare = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(5, 5)];
    [smallSquare setPosition:location];
    [self addChild:smallSquare];

 
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
