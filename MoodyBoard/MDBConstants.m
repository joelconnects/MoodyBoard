//
//  MDBConstants.m
//  MoodyBoard
//
//  Created by Joel Bell on 2/13/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import "MDBConstants.h"

// Firebase
NSString * const FirebaseAppReferenceURL = @"https://moodyboard.firebaseio.com";

// Notifications
NSString * const SignUpSelectedNotificationName = @"SignUpSelectedNotification";
NSString * const BoardSelectedNotificationName = @"BoardSelectedNotification";
NSString * const AddContentSelectedNotificationName = @"AddContentSelectedNotification";
NSString * const PhotoLibrarySelectedNotificationName = @"PhotoLibrarySelectedNotification";

// StoryboardIDs
NSString * const SignUpViewControllerStoryBoardID = @"SignUpViewController";
NSString * const BoardViewControllerStoryBoardID = @"BoardViewController";
NSString * const AddContentViewControllerStoryboardID = @"AddContentViewController";
NSString * const PhotoLibraryContainerViewControllerStoryBoardID = @"PhotoLibraryContainerViewController";

// BoardViewController
// BoardViewLayout
NSUInteger const BoardItemsPerSection = 14;

// App Controller Navigation Actions
NSString * const SignUpNavAction = @"Login";
NSString * const AddContentNavAction = @"Add Content";
NSString * const SettingsMenuNavAction = @"Settings Menu";
NSString * const BoardDetailsNavAction = @"Board Details";
NSString * const BoardActivityNavAction = @"Board Activity";
NSString * const ReturnToBoardNavAction = @"Return to Board";
NSString * const PhotoLibraryNavAction = @"Photo Library";



