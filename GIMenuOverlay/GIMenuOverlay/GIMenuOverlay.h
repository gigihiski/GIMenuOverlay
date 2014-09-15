//
//  GICircleMenu.h
//  Etsuri
//
//  Created by Gigih Iski Prasetyawan on 4/2/14.
//  Copyright (c) 2014 etsuri. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum FMFeedMenuEnum : int {
    FMERenew = 0,
    FMERespond,
    FMEPublishExtend,
    FMEPublishURL,
    FMETakePhoto,
    FMEPublish
} FMFeedMenuEnum;

@class GIMenu;
@protocol GIMenuDelegate <NSObject>
@optional
- (void) response : (NSIndexPath *) indexPath;
- (void) selectedMenu : (FMFeedMenuEnum) indexMenu;

@required

@end

@interface GIMenuOverlay : NSObject

@property (nonatomic, strong) UITableView *tableView;

/**
 * selection
 *
 */
@property (nonatomic) FMFeedMenuEnum selection;

/**
 * Delegate
 *
 */
@property (nonatomic, weak) id <GIMenuDelegate> delegate;

/**
 * init with viewController and Stand-alone Menu
 *
 */
- (id) initWithViewController;

/**
 * init with tableview
 *
 */
- (id) initWithTableView:(UITableView *)viewOfTable;

/**
 * remove overlayed menu
 *
 */
- (void) removeMenu;

/**
 * Init overlayed menu
 *
 */
- (void) initMenu;

/**
 * Show Stand-alone Menu
 *
 */
- (void)createSlidingMenu;

@property (strong, nonatomic) IBOutlet UIView *view;

@end
