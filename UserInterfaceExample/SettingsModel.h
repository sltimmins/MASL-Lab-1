//
//  SettingsModel.h
//  UserInterfaceExample
//
//  Created by Sammy Timmins on 9/15/22.
//  Copyright © 2022 Eric Larson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingsModel : NSObject

+(SettingsModel*)sharedInstance;

-(UIColor*)background;
-(NSInteger)imageAmount;

@property (strong, nonatomic) UIColor* background;
@property (nonatomic, assign) NSInteger imageAmount;

@end

NS_ASSUME_NONNULL_END
