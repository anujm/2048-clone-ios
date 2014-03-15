//
//  ANJViewController.m
//  game
//
//  Created by anujmathur on 15/03/14.
//  Copyright (c) 2014 anujmathur. All rights reserved.
//

#import "ANJViewController.h"
#import "ANJMyScene.h"

@implementation ANJViewController {
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self hookUpSwipe];

    self.gameBoard= [[ANJGameBoard alloc] init];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    // Create and configure the scene.
    SKScene * scene = [[ANJMyScene alloc] initMyScene:skView.bounds.size with:self.gameBoard];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene.
    [skView presentScene:scene];
}

- (void)hookUpSwipe {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];

    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];

    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
}

-(void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    int preSwipeEmptyBlockCount = [self.gameBoard emptyBlockCount];
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self.gameBoard moveBlocksLeft];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.gameBoard moveBlocksRight];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        [self.gameBoard moveBlocksUp];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionDown) {
        [self.gameBoard moveBlocksDown];
    }
    int postSwipeEmptyBlockCount = [self.gameBoard emptyBlockCount];
    if (postSwipeEmptyBlockCount <= preSwipeEmptyBlockCount) {
        [[self gameBoard] addRandomBlock];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
