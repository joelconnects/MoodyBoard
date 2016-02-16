//
//  MDBAppViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBAppViewController.h"
#import "MDBConstants.h"
#import "MDBAppViewController+Constraints.h"
#import "MDBAddContentViewController.h"
#import "MDBBoardViewController.h"


@interface MDBAppViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) IBOutlet UIButton *settingsMenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *addContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardActivityBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation MDBAppViewController


- (void)viewDidLoad {
    
    self.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:BoardViewControllerStoryBoardID];
    self.currentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.currentViewController];
    [self.containerView addSubview:self.currentViewController.view];
    [self constrainSubView:self.currentViewController.view toParentView:self.containerView];
    
    [super viewDidLoad];
    
    [self addNotificationObservers];

}


-(void)addNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleBoardSelected)
                                                 name:BoardSelectedNotificationName
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAddContentSelected)
                                                 name:AddContentSelectedNotificationName
                                               object:nil];
    
}

-(void)setScreenshotOfBoardToImageView {
    
    MDBBoardViewController *boardController = (MDBBoardViewController *)self.currentViewController;
    self.imageView.image = [boardController boardScreenshot];
    self.imageView.alpha = 0.3;
    
}

-(void)handleAddContentSelected {
    
    [self setScreenshotOfBoardToImageView];
    
    UIViewController *addContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContentViewController"];
//    addContentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    

    
    [self cycleFromViewController:self.currentViewController toViewController:addContentViewController];
    
    
    
    self.currentViewController = addContentViewController;
    
}

-(void)handleBoardSelected {
    
    UIViewController *boardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardViewController"];
//    boardViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    

    
    [self cycleFromAddController:self.currentViewController toBoardController:boardViewController];
    
    self.settingsMenuBtn.hidden = NO;
    self.boardActivityBtn.hidden = NO;
    self.addContentBtn.hidden = NO;
    self.boardDetailsBtn.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.settingsMenuBtn.alpha = 1.0;
        self.boardActivityBtn.alpha = 1.0;
        self.addContentBtn.alpha = 1.0;
        self.boardDetailsBtn.alpha = 1.0;
    }];
    
    
    self.currentViewController = boardViewController;
    
}

- (IBAction)addContent:(id)sender {
    
    [self handleAddContentSelected];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)settingsMenu:(id)sender {
}

- (IBAction)boardDetails:(id)sender {
}

- (IBAction)boardActivity:(id)sender {
}

-(void)cycleFromViewController:(UIViewController *)oldViewController
              toViewController:(UIViewController *)newViewController
{
    newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    [self.containerView addSubview:newViewController.view];
    
    newViewController.view.alpha = 0;
    
    [self preAnimationConstrainAddContentSubView:newViewController.view
                                    toParentView:self.containerView];
    
    [self constrainSubView:newViewController.view
              toParentView:self.containerView];
    
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         newViewController.view.alpha = 1.0;
                         oldViewController.view.alpha = 0.0;
                         [newViewController.view layoutIfNeeded];
                         
                         self.settingsMenuBtn.alpha = 0.0;
                         self.boardActivityBtn.alpha = 0.0;
                         self.addContentBtn.alpha = 0.0;
                         self.boardDetailsBtn.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         
                         self.settingsMenuBtn.hidden = YES;
                         self.boardActivityBtn.hidden = YES;
                         self.addContentBtn.hidden = YES;
                         self.boardDetailsBtn.hidden = YES;
                         
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                         
                         
                     }];
    
    
    
}

-(void)cycleFromAddController:(UIViewController *)addController
              toBoardController:(UIViewController *)boardController
{
    
    NSLog(@"\n\ncycle views - add to board\n\n");
    
    boardController.view.translatesAutoresizingMaskIntoConstraints = NO;

    
    [addController willMoveToParentViewController:nil];
    
    [self addChildViewController:boardController];
    
    [self.containerView addSubview:boardController.view];
    
    
    boardController.view.alpha = 0;
    
    [self.containerView removeConstraints:self.containerView.constraints];
    
    NSDictionary *viewsDictionary = @{@"boardView":boardController.view,
                                      @"addView":addController.view};
    
    NSArray *boardConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[boardView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *boardConstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[boardView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                       views:viewsDictionary];
    
    [self.containerView addConstraints:boardConstraint_H];
    [self.containerView addConstraints:boardConstraint_V];
    
    [boardController.view layoutIfNeeded];
    

    
    NSArray *addContentConstraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[addView(0)]|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    NSArray *addContentConstraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[addView(0)]"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:viewsDictionary];
    
    [self.containerView addConstraints:addContentConstraint_H];
    [self.containerView addConstraints:addContentConstraint_V];
    
    
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         [addController.view layoutIfNeeded];
                         boardController.view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         
                         
                         
                         [addController.view removeFromSuperview];
                         [addController removeFromParentViewController];
                         [boardController didMoveToParentViewController:self];
                         
                         
                     }];
    
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.addContentBtn.bounds];
//    self.addContentBtn.layer.masksToBounds = NO;
//    self.addContentBtn.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.addContentBtn.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
//    self.addContentBtn.layer.shadowOpacity = 0.5f;
//    self.addContentBtn.layer.shadowPath = shadowPath.CGPath;
//    self.addContentBtn.layer.shouldRasterize = YES;
//    self.addContentBtn.layer.rasterizationScale = [UIScreen mainScreen].scale;
