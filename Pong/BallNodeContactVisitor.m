//
//  BallContactVisitor.m
//  Pong
//
//  Created by Michael Koukoullis on 29/07/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import "BallNodeContactVisitor.h"
#import "BallNode.h"
#import "PlayfieldScene.h"
#import "ScoreNode.h"

@implementation BallNodeContactVisitor

- (void)visitPlayfieldScene:(SKPhysicsBody *)playfieldBody
{
    BallNode *ball = (BallNode *) self.body.node;
    PlayfieldScene *playfield = (PlayfieldScene *) playfieldBody.node;
    
    // Check to see if the ball has touched the edges behind the paddle so a score can be lodged
    if ([playfield isPointOnLeftEdge:self.contact.contactPoint]) {
        ScoreNode *score = (ScoreNode *) [playfield childNodeWithName:@"//rightScore"];
        [score increment];
        [ball serveLeftwards];
    }
    else if ([playfield isPointOnRightEdge:self.contact.contactPoint]) {
        ScoreNode *score = (ScoreNode *) [playfield childNodeWithName:@"//leftScore"];
        [score increment];
        [ball serveRightwards];
    } else {
        [ball reflectVerticalVelocity];
    }
}

// Alternatively we can handle the paddle hitting the ball here
//
//- (void)visitPaddleNode:(SKPhysicsBody *)paddleBody
//{
//    BallNode *ball = (BallNode *) self.body.node;
//    [ball reflectHorizontalVelocity];
//}

@end
