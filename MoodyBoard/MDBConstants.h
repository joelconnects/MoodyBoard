//
//  MDBConstants.h
//  MoodyBoard
//
//  Created by Joel Bell on 2/13/16.
//  Copyright © 2016 Joel Bell. All rights reserved.
//

#import <Foundation/Foundation.h>

// Firebase
extern NSString * const FirebaseAppReferenceURL;

// Notifications
extern NSString * const SignUpSelectedNotificationName;
extern NSString * const BoardSelectedNotificationName;
extern NSString * const AddContentSelectedNotificationName;
extern NSString * const PhotoLibrarySelectedNotificationName;

// StoryboardIDs
extern NSString * const SignUpViewControllerStoryBoardID;
extern NSString * const BoardViewControllerStoryBoardID;
extern NSString * const AddContentViewControllerStoryboardID;
extern NSString * const PhotoLibraryContainerViewControllerStoryBoardID;

// BoardViewController
// BoardViewLayout
extern NSUInteger const BoardItemsPerSection;

// App Controller Navigation Actions
extern NSString * const SignUpNavAction;
extern NSString * const AddContentNavAction;
extern NSString * const SettingsMenuNavAction;
extern NSString * const BoardDetailsNavAction;
extern NSString * const BoardActivityNavAction;
extern NSString * const ReturnToBoardNavAction;
extern NSString * const PhotoLibraryNavAction;