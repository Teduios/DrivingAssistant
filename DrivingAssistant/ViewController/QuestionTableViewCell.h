//
//  QuestionTableViewCell.h
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UIImageView *questionImageView;
@property (weak, nonatomic) IBOutlet UIButton *chooseOneButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseTwoButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseThreeButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseFourButton;
@property (weak, nonatomic) IBOutlet UILabel *resultOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultThreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultFourLabel;
@property (weak, nonatomic) IBOutlet UILabel *oneAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *examNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *examType;


@end
