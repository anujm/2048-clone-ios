//
//  ANJMyScene.m
//  game
//
//  Created by anujmathur on 15/03/14.
//  Copyright (c) 2014 anujmathur. All rights reserved.
//

#import "ANJMyScene.h"
#import <ObjectiveSugar/ObjectiveSugar.h>

int LENGTH = 150;
int BREADTH = 150;

@interface ANJMyScene()
@property ANJGameBoard * gameBoard;
@end

@implementation ANJMyScene

- (id)initMyScene:(CGSize)size with:(ANJGameBoard*)gameBoard {
    if (self = [super initWithSize:size]) {
        self.gameBoard = gameBoard;
        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1.0];
    }
    return self;
}

-(void)update:(NSTimeInterval)currentTime {
    [self removeAllChildren];
    [self drawEmptyBoard];
    [self drawBlocks];
    [self drawScore];
    [self sleep];
}

- (void) drawEmptyBoard {
    for(NSMutableArray *row in self.gameBoard.blocks) {
        for(ANJBlock *block in row) {
            ANJBlock *emptyBlock = [[ANJBlock alloc ] initBlock:block.x with:block.y And:0 And:FALSE];
            [self drawBlock:emptyBlock];
        }
    }
}

- (void)drawScore {
    NSString *score = [NSString stringWithFormat:@"%d", self.gameBoard.score];
    SKLabelNode *scorecard = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    scorecard.text = score;
    scorecard.fontSize = 30;
    scorecard.fontColor = [SKColor blackColor];
    scorecard.position = CGPointMake(self.size.width - 200, self.size.height - 200);
    [self addChild:scorecard];
}

- (void)drawBlocks {
    for(int i = 0; i < self.gameBoard.rows; i++) {
        for(int j = 0; j < self.gameBoard.columns; j++) {
            ANJBlock *block = (ANJBlock *)[self gameBoard].blocks[i][j];
            [self drawBlock:block];
        }
    }
}

- (void)drawBlock:(ANJBlock *)block {
    NSString * filename= [self getImageName:block];
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithImageNamed:filename];
    node.position = CGPointMake(151 + block.x * LENGTH, 101 + block.y * BREADTH);
    block.merged = FALSE;
    [self addChild:node];
}

- (void)sleep {
    struct timespec time1, time2;
    time1.tv_sec = 0;
    time1.tv_nsec = 30000000;
    nanosleep(&time1, &time2);
}

- (NSString *)getImageName:(ANJBlock *)block {
    if (block.merged) {
        return NSStringWithFormat(@"%d_big", block.value);
    }
    return NSStringWithFormat(@"%d", block.value);
}
@end
