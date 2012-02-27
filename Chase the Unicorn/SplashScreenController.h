//
//  SplashScreenController.h
//  Chase the Unicorn
//
//  Created by Matthew Atkins on 02/02/2012.
//  Copyright (c) 2012 Yoomee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSArray *phrases;
@property (weak, nonatomic) IBOutlet UITextView *phraseLabel;

-(void)changePhrase;

@end
