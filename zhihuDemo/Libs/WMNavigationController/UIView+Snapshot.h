//
//  UIView+Snapshot.h
//
//  Created by zwm on 6/4/14.
//  Copyright (c) 2014 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Snapshot)

- (UIImage *)snapshot;

- (UIImage *)snapshotWithRect:(CGRect)rect;

@end
