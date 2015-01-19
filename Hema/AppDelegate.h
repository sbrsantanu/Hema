//
//  AppDelegate.h
//  Hema
//
//  Created by Mac on 03/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

typedef enum {
    SocialAccountTypeNone,
    SocialAccountTypeTwitter,
    SocialAccountTypeFacebook,
    SocialAccountTypeYoutube,
    SocialAccountTypeGooglePlus
} SocialAccountType;

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WebserviceProtocol.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic,retain) UINavigationController *NavigationController;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@property (assign) SocialAccountType AccountType;
-(SocialAccountType )SetAndGateSocialAccountType;
@end

