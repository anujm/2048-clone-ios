//
//  ANJMyScene.h
//  game
//

//  Copyright (c) 2014 anujmathur. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NSArray+ObjectiveSugar.h"
#import "ANJGameBoard.h"

@interface ANJMyScene : SKScene
@property(nonatomic) CGPoint startPosition;

- (id)initMyScene:(CGSize)size with:(ANJGameBoard *)gameBoard;
@end
