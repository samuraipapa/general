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
    NSMutableArray* touchDrawArrayAllOfThem;
    SKSpriteNode *smallSquare;
    SKPhysicsJointLimit* myJointLimit;
}


- (void) createSceneContents
{
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
 
        [self createSceneContents];
        touchDrawArrayAllOfThem = [@[[NSValue valueWithCGPoint:CGPointMake(0, 0)]] mutableCopy];

        
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
        [touchDrawArrayAllOfThem addObject:[NSValue valueWithCGPoint:location]];
        
        
        
   //     NSLog(@"touch locationInNode: %f x %f",location.x, location.y);
   //     [self drawSmallSquareInLocation:location];
        
    }

}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
    
        for (NSValue* myPoint in touchDrawArray) {
            [self drawSmallJointedSquareInLocation:[myPoint CGPointValue]];
    }
//    [touchDrawArrayAllOfThem addObjectsFromArray:touchDrawArray];

}

-(void) drawSmallSquareInLocation: (CGPoint) location{
    smallSquare = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(5, 5)];
    [smallSquare setPosition:location];
    [self addChild:smallSquare];
}


-(void) drawSmallJointedSquareInLocation: (CGPoint) location{
    smallSquare = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(5, 5)];
    [smallSquare setPosition:location];
    [smallSquare setName:@"squareName"];
    smallSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:smallSquare.size];
    
    
    
//    SKPhysicsJointLimit * myJointLimit = [SKPhysicsJointLimit jointWithBodyA: bodyB:<#(SKPhysicsBody *)#> anchorA:<#(CGPoint)#> anchorB:<#(CGPoint)#>
    [self addChild:smallSquare];
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"squareName" usingBlock:^(SKNode *node, BOOL *stop) {
//        if (node.position.y < 0){
//            [node removeFromParent];
//        }
    //    NSLog(@"%i",[touchDrawArray count]);
        NSLog(@"%i",[touchDrawArrayAllOfThem count]);
        
        if ([touchDrawArrayAllOfThem count]  > 50) {
            [node removeFromParent];
            [touchDrawArrayAllOfThem removeAllObjects];
        }
        
        
    }]; }


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
