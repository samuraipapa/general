//
//  MyScene.m
//  NSFastEnumeration Example  For Loop
//
//  Created by yg on 2/21/14.
//  Copyright (c) 2014 Yury. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene{

    SKSpriteNode *squareBig1;
    SKSpriteNode *squareBig2;
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
 
        [self createSceneContents];
//        touchDrawArrayAllOfThem = [@[[NSValue valueWithCGPoint:CGPointMake(0, 0)]] mutableCopy];

        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMinY(self.frame));
        
        
        

        
        
    }
    return self;
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        NSLog(@"touch locationInNode: %f x %f",location.x, location.y);
        [self drawBigSquare1InLocation:location];
    }
}


-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
     
        [self drawSmallSquareInLocation:location];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInNode:self];
       [self drawBigSquare2InLocation:location];
        [self drawJointToBigSquares];
    }

}



-(void) drawBigSquare1InLocation: (CGPoint) location{
    squareBig1 = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(50, 50)];
    [squareBig1 setPosition:location];
    squareBig1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:squareBig1.size];
    [self addChild:squareBig1];
}

-(void) drawBigSquare2InLocation: (CGPoint) location{
    squareBig2 = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
    [squareBig2 setPosition:location];
    squareBig2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:squareBig2.size];

    [self addChild:squareBig2];
    
    myJointLimit = [SKPhysicsJointLimit jointWithBodyA:squareBig1.physicsBody bodyB:squareBig2.physicsBody anchorA:squareBig1.position anchorB:squareBig2.position  ];
    
    [self.physicsWorld addJoint:myJointLimit];
}


-(void) drawSmallSquareInLocation: (CGPoint) location{
    smallSquare = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(5, 5)];
    [smallSquare setPosition:location];
    [smallSquare setColor:[SKColor orangeColor]];
    [self addChild:smallSquare];
}


-(void) drawJointToBigSquares{

 
 //   [self addChild:smallSquare];
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"squareName" usingBlock:^(SKNode *node, BOOL *stop) {
////        if (node.position.y < 0){
////            [node removeFromParent];
////        }
//    //    NSLog(@"%i",[touchDrawArray count]);
//        NSLog(@"%i",[touchDrawArrayAllOfThem count]);
//        
//        if ([touchDrawArrayAllOfThem count]  > 50) {
//            [node removeFromParent];
//            [touchDrawArrayAllOfThem removeAllObjects];
//        }
//        
        
    }]; }


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
