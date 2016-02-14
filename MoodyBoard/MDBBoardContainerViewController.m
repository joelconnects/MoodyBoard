//
//  MDBBoardContainerViewController.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/10/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBBoardContainerViewController.h"
#import "MDBAddContentViewController.h"

@interface MDBBoardContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) IBOutlet UIButton *settingsMenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *addContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardActivityBtn;

@end

@implementation MDBBoardContainerViewController




- (void)viewDidLoad {
    
//    [self.view addSubview:self.containerView];
    UIView *subView = self.containerView;
    
    NSDictionary * views = @{@"subView" : subView};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [self.view addConstraints:constraints];
    
    
    
    self.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardViewController"];
    self.currentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.currentViewController];
    [self addSubview:self.currentViewController.view toView:self.containerView];
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserDidLogOut:) name:UserDidLogOutNotificationName object:nil];
//    
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUserDidLogIn:) name:UserDidLogInNotificationName object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleShowHamburgerMenu:) name:ShowHamburgerMenuNotificationName object:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)addSubview:(UIView *)subView toView:(UIView*)parentView {
    [parentView addSubview:subView];
    
    NSDictionary * views = @{@"subView" : subView,};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];
}

- (IBAction)settingsMenu:(id)sender {
}

- (IBAction)boardDetails:(id)sender {
}

- (IBAction)boardActivity:(id)sender {
}

/*
- (IBAction)showComponent:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PurpleView"];
        newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self cycleFromViewController:self.currentViewController toViewController:newViewController];
        self.currentViewController = newViewController;
    } else {
        UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BlueView"];
        newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self cycleFromViewController:self.currentViewController toViewController:newViewController];
        self.currentViewController = newViewController;
    }
}
 */

-(void)cycleFromViewController:(UIViewController *)oldViewController
              toViewController:(UIViewController *)newViewController
{
    
    self.settingsMenuBtn.hidden = YES;
    self.boardActivityBtn.hidden = YES;
    self.addContentBtn.hidden = YES;
    self.boardDetailsBtn.hidden = YES;
    
    [oldViewController willMoveToParentViewController:nil];
    
    [self addChildViewController:newViewController];
    
    [self.containerView addSubview:newViewController.view];
    
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
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [newViewController.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
                         
                         
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                         self.currentViewController = newViewController;
                         
                         
                     }];
    
    
    
}

- (IBAction)addContent:(id)sender {
    
    
    UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContentViewController"];
    newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self cycleFromViewController:self.currentViewController toViewController:newViewController];
  
    
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
