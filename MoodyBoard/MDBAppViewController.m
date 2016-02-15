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


@interface MDBAppViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) IBOutlet UIButton *settingsMenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *addContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardActivityBtn;

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


-(void)handleAddContentSelected {
    
    UIViewController *addContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContentViewController"];
    addContentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.settingsMenuBtn.hidden = YES;
    self.boardActivityBtn.hidden = YES;
    self.addContentBtn.hidden = YES;
    self.boardDetailsBtn.hidden = YES;
    
    [self cycleFromViewController:self.currentViewController toViewController:addContentViewController];
    
    self.currentViewController = addContentViewController;
    
}

-(void)handleBoardSelected {
    
    UIViewController *boardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardViewController"];
    boardViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    

    
    [self cycleFromAddController:self.currentViewController toBoardController:boardViewController];
    
    self.currentViewController = boardViewController;
    
}

- (IBAction)addContent:(id)sender {
    
    [self handleAddContentSelected];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
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
    
    
    
    [oldViewController willMoveToParentViewController:nil];
    
    [self addChildViewController:newViewController];
    
    [self.containerView addSubview:newViewController.view];
    
    newViewController.view.alpha = 0;
    
    NSDictionary *viewsDictionary = @{@"newView":newViewController.view};
    
    NSArray *constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[newView(0)]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    NSArray *constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView(0)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary];
    
    [self.containerView addConstraints:constraint_H];
    [self.containerView addConstraints:constraint_V];
    
    [newViewController.view layoutIfNeeded];
    
    [self.containerView removeConstraints:constraint_H];
    [self.containerView removeConstraints:constraint_V];
    
    constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[newView]|"
                                                           options:0
                                                           metrics:nil
                                                             views:viewsDictionary];
    
    constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView]|"
                                                           options:0
                                                           metrics:nil
                                                             views:viewsDictionary];
    [self.containerView addConstraints:constraint_H];
    [self.containerView addConstraints:constraint_V];
    
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         newViewController.view.alpha = 1;
                         [newViewController.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
                         NSLog(@"\n\nanimation complete\n\n");
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                         
                         
                         
                         
                     }];
    
    
    
}

-(void)cycleFromAddController:(UIViewController *)addController
              toBoardController:(UIViewController *)boardController
{
    
    NSLog(@"\n\ncycle views - add to board\n\n");
    

    
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
                         
                         self.settingsMenuBtn.hidden = NO;
                         self.boardActivityBtn.hidden = NO;
                         self.addContentBtn.hidden = NO;
                         self.boardDetailsBtn.hidden = NO;
                         
                         
                         
                         NSLog(@"\n\nanimation complete\n\n");
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
