//
//  GICircleMenu.m
//  Etsuri
//
//  Created by Gigih Iski Prasetyawan on 4/2/14.
//  Copyright (c) 2014 etsuri. All rights reserved.
//

#import "GIMenuOverlay.h"

#define BTN_WIDTH 75.0f
#define BTN_HEIGHT 75.0f

@implementation GIMenuOverlay {
    BOOL optionButtonON;
    NSDictionary *selected;
    
    UIButton *publishBtn, *renewsBtn, *videoBtn, *takePhotoBtn, *urlBtn, *writeBtn, *backBtn, *activityBtn;
    UIView *background;
    UIWindow* currentWindow;
    CGPoint selectedPoint;
    NSIndexPath *selectedIndexPath;
    
    UIControl *firstRootBackground;
}

@synthesize tableView;
@synthesize view;
@synthesize delegate;
@synthesize selection;

- (id) initWithTableView:(UITableView *)viewOfTable {
    if(self = [super init]){
        tableView = viewOfTable;
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        recognizer.minimumPressDuration = 0.3f;
        [tableView addGestureRecognizer:recognizer];
        
        publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"write-icon"]
                              forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(publishAction:)
             forControlEvents:UIControlEventTouchUpInside];
        
        renewsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [renewsBtn setBackgroundImage:[UIImage imageNamed:@"renews"]
                             forState:UIControlStateNormal];
        [renewsBtn addTarget:self action:@selector(renewAction:)
            forControlEvents:UIControlEventTouchUpInside];
        
        videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [videoBtn setBackgroundImage:[UIImage imageNamed:@"video-icon-action"]
                              forState:UIControlStateNormal];
        [videoBtn addTarget:self action:@selector(respondAction:)
             forControlEvents:UIControlEventTouchUpInside];
        
        takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"photo-icon"]
                                forState:UIControlStateNormal];
        [takePhotoBtn addTarget:self action:@selector(takePhotoAction:)
               forControlEvents:UIControlEventTouchUpInside];
        
        urlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [urlBtn setBackgroundImage:[UIImage imageNamed:@"url-icon"]
                          forState:UIControlStateNormal];
        [urlBtn addTarget:self action:@selector(urlAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [writeBtn setBackgroundImage:[UIImage imageNamed:@"write-icon"]
                            forState:UIControlStateNormal];
        [writeBtn addTarget:self action:@selector(writeAction:)
           forControlEvents:UIControlEventTouchUpInside];
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backplus"]
                           forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction:)
          forControlEvents:UIControlEventTouchUpInside];
        
        background = [[UIView alloc] init];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(backgroundAction:)];
        [background addGestureRecognizer:singleFingerTap];
        
        [background setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_dot_transparent_black"]]];
    }
    
    return self;
}

- (id) initWithViewController {
    if(self = [super init]){
        currentWindow = [UIApplication sharedApplication].keyWindow;
        
        publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"write-icon"]
                              forState:UIControlStateNormal];
        [publishBtn addTarget:self action:@selector(publishAction:)
             forControlEvents:UIControlEventTouchUpInside];
        
        renewsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [renewsBtn setBackgroundImage:[UIImage imageNamed:@"renews"]
                             forState:UIControlStateNormal];
        [renewsBtn addTarget:self action:@selector(renewAction:)
            forControlEvents:UIControlEventTouchUpInside];
        
        videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [videoBtn setBackgroundImage:[UIImage imageNamed:@"video-icon-action"]
                            forState:UIControlStateNormal];
        [videoBtn addTarget:self action:@selector(respondAction:)
           forControlEvents:UIControlEventTouchUpInside];
        
        takePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [takePhotoBtn setBackgroundImage:[UIImage imageNamed:@"photo-icon"]
                                forState:UIControlStateNormal];
        [takePhotoBtn addTarget:self action:@selector(takePhotoAction:)
               forControlEvents:UIControlEventTouchUpInside];
        
        urlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [urlBtn setBackgroundImage:[UIImage imageNamed:@"url-icon"]
                          forState:UIControlStateNormal];
        [urlBtn addTarget:self action:@selector(urlAction:)
         forControlEvents:UIControlEventTouchUpInside];
        
        writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [writeBtn setBackgroundImage:[UIImage imageNamed:@"write-icon"]
                            forState:UIControlStateNormal];
        [writeBtn addTarget:self action:@selector(writeAction:)
           forControlEvents:UIControlEventTouchUpInside];
        
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"backplus"]
                           forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction:)
          forControlEvents:UIControlEventTouchUpInside];
        
        background = [[UIView alloc] init];
        
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(backgroundAction:)];
        [background addGestureRecognizer:singleFingerTap];
        
        [background setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_dot_transparent_black"]]];
    }
    
    return self;
}

- (void) initMenu {
    [self.tableView setScrollEnabled:YES];
}

- (IBAction)backgroundAction:(id)sender {
    [self removeBackground];
}

- (IBAction)longPressAction:(UILongPressGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
		CGPoint p = [recognizer locationInView:tableView];
        CGPoint tp = [recognizer locationInView:view];
        selectedPoint = tp;
        NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:p];
        selectedIndexPath = indexPath;
        if (indexPath == nil){
            //[self createEmptyOptionButtons:tp];
        }else{
            // Remove existing button if any
            [self removeOptionButton];
            
            currentWindow = [UIApplication sharedApplication].keyWindow;
            [self showActivityButton:tp];
        }
	}
}

- (void) showActivityButton:(CGPoint)midPoint {
    firstRootBackground = [[UIControl alloc] init];
    [firstRootBackground setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [firstRootBackground setBackgroundColor:[UIColor clearColor]];
    [firstRootBackground addTarget:self action:@selector(removeActivity:) forControlEvents:UIControlEventTouchUpInside];
    [firstRootBackground setAlpha:1.0f];
    [self.view addSubview:firstRootBackground];
    
    activityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [activityBtn setImage:[UIImage imageNamed:@"compose-button-icon"] forState:UIControlStateNormal];
    activityBtn.frame = CGRectMake(midPoint.x - 35, midPoint.y - 35, BTN_WIDTH, BTN_WIDTH);
    activityBtn.alpha = 0;
    [activityBtn addTarget:self action:@selector(activityAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:activityBtn];
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        activityBtn.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

- (IBAction)removeActivity:(id)sender {
    [self removeOptionButton];
}

- (IBAction)activityAction:(id)sender {
    [activityBtn removeFromSuperview];
    [firstRootBackground removeFromSuperview];
    
    [self createSlidingMenu];
    [delegate response:selectedIndexPath];
}

- (void) removeBackground {
    optionButtonON = TRUE;
    
    background.frame = CGRectMake(0, 20, self.view.frame.size.width, currentWindow.frame.size.height);
    
    background.alpha = 1;
    
    [currentWindow addSubview:background];
    
    CGRect show = CGRectMake(0, currentWindow.frame.size.height + 20, self.view.frame.size.width, currentWindow.frame.size.height);
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        background.frame = show;
    } completion:^(BOOL finished) {
        [background removeFromSuperview];
        [self.tableView setScrollEnabled:YES];
    }];
}

- (void) createSlidingMenu {
    optionButtonON = TRUE;
    
    background.frame = CGRectMake(0, currentWindow.frame.size.height + 20, self.view.frame.size.width, currentWindow.frame.size.height - 20);
    
    background.alpha = 1;
    
    videoBtn.alpha = 0;
    writeBtn.alpha = 0;
    takePhotoBtn.alpha = 0;
    urlBtn.alpha = 0;
    
    [writeBtn setFrame:[self buttonPosition:0]];
    [urlBtn setFrame:[self buttonPosition:1]];
    [takePhotoBtn setFrame:[self buttonPosition:2]];
    [videoBtn setFrame:[self buttonPosition:3]];
    
    UILabel *writeLabel = [[UILabel alloc] init];
    [writeLabel setText:@"Write"];
    [writeLabel setFrame:CGRectMake(320/2 - 100 + 17, 520/2 - 155, 50, 20)];
    [writeLabel setTextColor:[UIColor whiteColor]];
    [background addSubview:writeLabel];
    [background addSubview:writeBtn];
    
    UILabel *urlLabel = [[UILabel alloc] init];
    [urlLabel setText:@"Url"];
    [urlLabel setFrame:CGRectMake(320/2 + 20 + 25, 520/2 - 155, 50, 20)];
    [urlLabel setTextColor:[UIColor whiteColor]];
    [background addSubview:urlLabel];
    [background addSubview:urlBtn];
    
    UILabel *photoLabel = [[UILabel alloc] init];
    [photoLabel setFrame:CGRectMake(320/2 - 100 + 15, 520/2 - 15, 50, 20)];
    [photoLabel setTextColor:[UIColor whiteColor]];
    [photoLabel setText:@"Photo"];
    [background addSubview:photoLabel];
    [background addSubview:takePhotoBtn];

    UILabel *videoLabel = [[UILabel alloc] initWithFrame:CGRectMake(320/2 + 20 + 15, 520/2 - 15, 50, 20)];
    [videoLabel setTextColor:[UIColor whiteColor]];
    [videoLabel setText:@"Video"];
    [background addSubview:videoLabel];
    [background addSubview:videoBtn];
    
    [currentWindow addSubview:background];
    
    CGRect show = CGRectMake(0, 20, self.view.frame.size.width, currentWindow.frame.size.height);
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        background.frame = show;
    } completion:^(BOOL finished) {
        [self.tableView setScrollEnabled:NO];
        
        videoBtn.alpha = 1;
        writeBtn.alpha = 1;
        takePhotoBtn.alpha = 1;
        urlBtn.alpha = 1;
    }];
}

-(void)removeOptionButton{
    optionButtonON = NO;
    [firstRootBackground removeFromSuperview];
    [background removeFromSuperview];
    [publishBtn removeFromSuperview];
    [renewsBtn removeFromSuperview];
    [videoBtn removeFromSuperview];
    [takePhotoBtn removeFromSuperview];
    [urlBtn removeFromSuperview];
    [writeBtn removeFromSuperview];
    [activityBtn removeFromSuperview];
}

#pragma mark - OptionButton Action

- (void)backAction:(id)sender {
    if(!optionButtonON){
        optionButtonON = YES;
        [UIView animateWithDuration:0.3 animations:^{
            publishBtn.alpha = 1;
            videoBtn.alpha = 1;
            renewsBtn.alpha = 1;
            
            writeBtn.alpha = 0;
            takePhotoBtn.alpha = 0;
            urlBtn.alpha = 0;
            
            backBtn.alpha = 0.2;
        }];
    } else {
        [self removeOptionButton];
    }
}

- (void) removeMenu {
    [self removeOptionButton];
}

- (void)renewAction:(id)sender {
    [self removeOptionButton];
    [self setSelection:FMERenew];
    
    [delegate selectedMenu:FMERenew];
}

- (void)respondAction:(id)sender {
    [self removeOptionButton];
    [self setSelection:FMERespond];
    
    [delegate selectedMenu:FMERespond];
}

- (void)publishAction:(id)sender {
    optionButtonON = NO;
    [UIView animateWithDuration:0.3 animations:^{
        publishBtn.alpha = 0;
        videoBtn.alpha = 0;
        renewsBtn.alpha = 0;
        
        writeBtn.alpha = 1;
        takePhotoBtn.alpha = 1;
        urlBtn.alpha = 1;
        
        backBtn.alpha = 1;
        [self setSelection:FMEPublishExtend];
        
        [delegate selectedMenu:FMEPublishExtend];
    }];
}

- (void)urlAction:(id)sender {
    [self removeOptionButton];
    [self setSelection:FMEPublishURL];
    
    [delegate selectedMenu:FMEPublishURL];
}

- (void)takePhotoAction:(id)sender {
    [self removeOptionButton];
    [self setSelection:FMETakePhoto];
    
    [delegate selectedMenu:FMETakePhoto];
}

- (void)writeAction:(id)sender {
    [self removeOptionButton];
    [self setSelection:FMEPublish];
    
    [delegate selectedMenu:FMEPublish];
}

- (CGRect) buttonPosition:(int)position {
    switch (position) {
        case 0:
            return CGRectMake(320/2 - 100, 520/2 - 125, BTN_WIDTH, BTN_HEIGHT);
            break;
        case 1:
            return CGRectMake(320/2 + 20, 520/2 - 125, BTN_WIDTH, BTN_HEIGHT);
            break;
        case 2:
            return CGRectMake(320/2 - 100, 520/2 + 15, BTN_WIDTH, BTN_HEIGHT);
            break;
        case 3:
            return CGRectMake(320/2 + 20, 520/2 + 15, BTN_WIDTH, BTN_HEIGHT);
            break;
            
        default:
            return CGRectMake(320/2 - 100, 520/2 - 125, BTN_WIDTH, BTN_HEIGHT);
            break;
    }
}

@end
