//
//  MyScene.m
//  NSFastEnumeration Example  For Loop
//
//  Created by yg on 2/21/14.
//  Copyright (c) 2014 Yury. All rights reserved.
//

#import "MyScene.h"

static NSString* smallSquareCategoryName = @"smallSquare";
static NSString* bigSquareCategoryName = @"bigSquare";
static NSString* outScreenCategoryName = @"outScreen";
//static NSString* blockNodeCategoryName = @"blockNode";

static const uint32_t smallSquareCategory  = 0x1 << 0;  // 00000000000000000000000000000001
static const uint32_t bigSquareCategory = 0x1 << 1; // 00000000000000000000000000000010
static const uint32_t outScreenCategory = 0x1 << 2;  // 00000000000000000000000000000100
//static const uint32_t paddleCategory = 0x1 << 3; // 00000000000000000000000000001000


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
 //   self.name = outScreenCategoryName;
   // self.physicsBody.categoryBitMask = outScreenCategory;
    [self.physicsWorld setGravity:CGVectorMake(0, -2)];


    
    
    
//    // 1 Create a physics body that borders the screen
//    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
//    // 2 Set physicsBody of scene to borderBody
//    self.physicsBody = borderBody;
    // 3 Set the friction of that physicsBody to 0
//    self.physicsBody.friction = 0.0f;
    
    
    
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        

        [self createSceneContents];
//        touchDrawArrayAllOfThem = [@[[NSValue valueWithCGPoint:CGPointMake(0, 0)]] mutableCopy];
        self.physicsWorld.contactDelegate = self;
        
        
        
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
     
  //      [self drawSmallSquareInLocation:location];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
    
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInNode:self];
       [self drawBigSquare2InLocation:location];
        [self drawJointToBigSquares];
    }

}


-(void) didBeginContact:(SKPhysicsContact *)contact{
    
    NSLog(@"didBeginContact");
    
    // 1 Create local variables for two physics bodies
    SKPhysicsBody* firstBody;
    SKPhysicsBody* secondBody;
    // 2 Assign the two physics bodies so that the one with the lower category is always stored in firstBody
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        
        NSLog(@" <<< ");
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        NSLog(@" else ");

        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
        NSLog(@" === ");

    }
    

    // 3 react to the contact between ball and bottom
//    if (firstBody.categoryBitMask == smallSquareCategory && secondBody.categoryBitMask == bigSquareCategory ) {


        if (firstBody.categoryBitMask == smallSquareCategory) {
        
            NSLog(@"firstBody.categoryBitMask == smallSquareCategory");
            SKAction *sound = [SKAction playSoundFileNamed:@"pling.mp3" waitForCompletion:YES];
            [self runAction:sound];
            [firstBody.node removeFromParent];
        }

        if (contact.bodyA.categoryBitMask == bigSquareCategory || contact.bodyB.categoryBitMask ==  bigSquareCategory){
    

              NSLog(@"firstBody.categoryBitMask == bigSquareCategory");


                SKAction *sound = [SKAction playSoundFileNamed:@"Ting.mp3" waitForCompletion:YES];
                [self runAction:sound];
                
            }
    
            


}



-(void) drawBigSquare1InLocation: (CGPoint) location{
    squareBig1 = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(50, 50)];
    [squareBig1 setPosition:location];
    squareBig1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:squareBig1.size];
    squareBig1.name = bigSquareCategoryName;
    squareBig1.physicsBody.categoryBitMask = bigSquareCategory;
    squareBig1.physicsBody.contactTestBitMask = smallSquareCategory;
  //  squareBig1.physicsBody.usesPreciseCollisionDetection = YES;
    
    [self addChild:squareBig1];
    
    
}

-(void) drawBigSquare2InLocation: (CGPoint) location{
    squareBig2 = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
    [squareBig2 setPosition:location];
    squareBig2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:squareBig2.size];
    squareBig2.name = bigSquareCategoryName;
    squareBig2.physicsBody.categoryBitMask = bigSquareCategory;
    squareBig2.physicsBody.contactTestBitMask = smallSquareCategory;
   // squareBig2.physicsBody.usesPreciseCollisionDetection = YES;
    
    
    [self addChild:squareBig2];
    
 //   myJointLimit = [SKPhysicsJointLimit jointWithBodyA:squareBig1.physicsBody bodyB:squareBig2.physicsBody anchorA:squareBig1.position anchorB:squareBig2.position  ];
    
 //   [self.physicsWorld addJoint:myJointLimit];
}


-(void) drawSmallSquareInLocation: (CGPoint) location{
    smallSquare = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(15, 15)];
    [smallSquare setPosition:location];
    [smallSquare setColor:[SKColor orangeColor]];
    
    smallSquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:smallSquare.size];
    smallSquare.name = smallSquareCategoryName;
    smallSquare.physicsBody.categoryBitMask = smallSquareCategory;
   // smallSquare.physicsBody.usesPreciseCollisionDetection = YES;
    
  //  smallSquare.physicsBody.contactTestBitMask = smallSquareCategory;

    
    [self addChild:smallSquare];
}


-(void) drawJointToBigSquares{

 
 //   [self addChild:smallSquare];
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"bigSquareCategoryName" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.alpha < 0){
            [node removeFromParent];
        
            SKAction *sound = [SKAction playSoundFileNamed:@"ting.mp3" waitForCompletion:YES];
            [self runAction:sound];
            
        }
        
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
