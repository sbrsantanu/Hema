//
//  GlobalObjects.h
//  Hema
//
//  Created by Mac on 16/12/14.
//  Copyright (c) 2014 Hema. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PreSelectednavigationTypeNone,
    PreSelectednavigationTypeHome,
    PreSelectednavigationTypeLogin,
    PreSelectednavigationTypeRegister,
    PreSelectednavigationTypeHelp
} PreSelectednavigation;

typedef enum {
    NavigationBackButtonTypeNone,
    NavigationBackButtonTypeYes
} NavigationBackButtonType;

@interface GlobalObjects : UIViewController


@property (assign) PreSelectednavigation SelectedTab;

-(UIView *)UIViewSetHeaderView;
-(UIView *)UIViewSetHeaderViewWithbackButton:(BOOL)backButton;
-(UIView *)UIViewSetFooterView;
-(UIView *)UIViewSetHeaderNavigationViewWithSelectedTab:(NSString *)Selectedtab;
-(UIView *)UIViewSetHeaderAfterLoginNavigationViewWithSelectedTab:(NSString *)Selectedtab;

-(void)GotoDifferentViewWithAnimation:(UIViewController *)ViewControllerName;
@end
