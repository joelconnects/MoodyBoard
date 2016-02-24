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


@interface MDBAppViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) IBOutlet UIButton *settingsMenuBtn;
@property (weak, nonatomic) IBOutlet UIButton *addContentBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *boardActivityBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSString *navAction;


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAddContentSelected)
                                                 name:PhotoLibrarySelectedNotificationName
                                               object:nil];
    
}

-(void)setScreenshotOfBoardToImageView {
    
    MDBBoardViewController *boardController = (MDBBoardViewController *)self.currentViewController;
    self.imageView.image = [boardController boardScreenshot];
    self.imageView.alpha = 1.0;
    
}

-(void)handleAddContentSelected {
    
    self.navAction = AddContentNavAction;
    [self setScreenshotOfBoardToImageView];
    UIViewController *addContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContentViewController"];
    [self cycleFromViewController:self.currentViewController toViewController:addContentViewController];
    self.currentViewController = addContentViewController;
    
}

-(void)handleBoardSelected {
     
    self.navAction = ReturnToBoardNavAction;
    UIViewController *boardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardViewController"];
    [self showHideButtonsForNavAction:self.navAction];
    [self cycleFromViewController:self.currentViewController toViewController:boardViewController];
    self.currentViewController = boardViewController;
    
}

-(void)handlePhotoLibrarySelected {
    
    self.navAction = PhotoLibraryNavAction;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalInPopover = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.navigationBar.tintColor = [UIColor blackColor];
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromRight;
//    
//    [self.view.window.layer addAnimation:transition forKey:nil];
//    [self presentViewController:picker animated:NO completion:nil];

    [self cycleFromViewController:self.currentViewController toViewController:picker];
    
}

- (IBAction)addContent:(id)sender {
    
    [self handleAddContentSelected];
    
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
    
    [self constrainSubView:newViewController.view
              toParentView:self.containerView
              forNavAction:self.navAction
              includeOldVC:oldViewController];
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         newViewController.view.alpha = 1.0;
                         self.imageView.alpha = 0.3;
                         
                         if ([self.navAction isEqualToString:ReturnToBoardNavAction]) {
                             [oldViewController.view layoutIfNeeded];
                         }
                         if ([self.navAction isEqualToString:AddContentNavAction]) {
                             [newViewController.view layoutIfNeeded];
                         }
                         
                         [self setButtonsAlphaForNavAction:self.navAction];
                     }
                     completion:^(BOOL finished) {
                         
                         [self showHideButtonsForNavAction:self.navAction];
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                         
                     }];
}



-(void)setButtonsAlphaForNavAction:(NSString *)navAction
{
    if ([navAction isEqualToString:ReturnToBoardNavAction]) {
        [self setButtonsOpaque];
    }
    if ([navAction isEqualToString:AddContentNavAction]) {
        [self setButtonsAlphaToZero];
    }
    if ([navAction isEqualToString:SettingsMenuNavAction]) {
        //
    }
    if ([navAction isEqualToString:BoardDetailsNavAction]) {
        //
    }
    if ([navAction isEqualToString:BoardActivityNavAction]) {
        //
    }
}

-(void)showHideButtonsForNavAction:(NSString *)navAction
{
    if ([navAction isEqualToString:ReturnToBoardNavAction]) {
        [self setButtonsToShow];
    }
    if ([navAction isEqualToString:AddContentNavAction]) {
        [self setButtonsToHidden];
    }
    if ([navAction isEqualToString:SettingsMenuNavAction]) {
        //
    }
    if ([navAction isEqualToString:BoardDetailsNavAction]) {
        //
    }
    if ([navAction isEqualToString:BoardActivityNavAction]) {
        //
    }
}

-(void)setButtonsAlphaToZero {
    self.settingsMenuBtn.alpha = 0.0;
    self.boardActivityBtn.alpha = 0.0;
    self.addContentBtn.alpha = 0.0;
    self.boardDetailsBtn.alpha = 0.0;
}
-(void)setButtonsOpaque {
    self.settingsMenuBtn.alpha = 1.0;
    self.boardActivityBtn.alpha = 1.0;
    self.addContentBtn.alpha = 1.0;
    self.boardDetailsBtn.alpha = 1.0;
}
-(void)setButtonsToHidden {
    self.settingsMenuBtn.hidden = YES;
    self.boardActivityBtn.hidden = YES;
    self.addContentBtn.hidden = YES;
    self.boardDetailsBtn.hidden = YES;
}
-(void)setButtonsToShow {
    self.settingsMenuBtn.hidden = NO;
    self.boardActivityBtn.hidden = NO;
    self.addContentBtn.hidden = NO;
    self.boardDetailsBtn.hidden = NO;
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
