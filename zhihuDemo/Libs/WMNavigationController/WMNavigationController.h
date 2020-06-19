//
//  WMNavigationController.h
//
//  Created by zwm on 11/20/14.
//
//

#import <UIKit/UIKit.h>

@interface WMNavigationController : UINavigationController
@property (readonly, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@end

@protocol WMNavigationDelegate <NSObject>

@optional
- (BOOL)enablePanBack:(WMNavigationController *)panNavigationController;
- (void)startPanBack:(WMNavigationController *)panNavigationController;
- (void)finshPanBack:(WMNavigationController *)panNavigationController;
- (void)resetPanBack:(WMNavigationController *)panNavigationController;

- (UIViewController *)viewControllerToPush;//
- (BOOL)viewControllerToPop;//

@end