//
//  ExamViewController.m
//  DrivingAssistant
//
//  Created by ji on 16/4/19.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "ExamViewController.h"
#import "QuestionTableViewCell.h"
#import "JKNetManager.h"
#import "ExamTypeViewController.h"
#import <Reachability.h>
#import "WebViewController.h"
//#import <AVFoundation/AVFoundation.h>



@interface ExamViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray <ExamQuestionModel *> *questioArray;
@property (nonatomic,assign)BOOL chooseOne;
@property (nonatomic,assign)BOOL chooseTwo;
@property (nonatomic,assign)BOOL chooseThree;
@property (nonatomic,assign)BOOL chooseFour;
//@property (nonatomic,strong) AVSpeechSynthesizer *speechSynt;
@property (weak, nonatomic) IBOutlet UIButton *examTypeButton;
/** 驾驶证等级 */
@property (nonatomic,strong)NSString *userChooseExamType;
/** 科目 */
@property (nonatomic,assign)NSInteger userChooseSubject;
/** 测试题数 */
@property (nonatomic,strong)NSString *userChooseNumber;
@end

@implementation ExamViewController
//赖加载
//-(AVSpeechSynthesizer *)speechSynt{
//    if (!_speechSynt) {
//        _speechSynt = [AVSpeechSynthesizer new];
//        _speechSynt.delegate = self;
//    }
//    return _speechSynt;
//}

-(NSArray<ExamQuestionModel *> *)questioArray{
    if (!_questioArray) {
        _questioArray = [NSArray array];
        }
    return _questioArray;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]){
        
        UIImage *newImge = [[UIImage imageNamed:@"icon_homepage_hotCategory"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.image = newImge;
        self.tabBarItem.selectedImage = newImge;
        self.tabBarItem.title = @"驾考";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 适应自动布局 行高自适应
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 期望高度 预估高度
    self.tableView.estimatedRowHeight = 90;
    [self judgeMobileNetworks];
    self.userChooseExamType = @"c1";
    self.userChooseSubject = 1;
    self.userChooseNumber = @"rand";
    [self getExamData];
   
}

#pragma mark -- 判断手机网络
-(void)judgeMobileNetworks{
     BOOL isExistenceNetwork = YES;
     Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
     switch ([r currentReachabilityStatus]) {
     case NotReachable:
     isExistenceNetwork=NO;
    [self networkingTipError:@"当前无网络，请检查您的手机网络连接是否正常！"];
     break;
     case ReachableViaWWAN:
     isExistenceNetwork=YES;
    [self networkingTipError:@"当前手机未连接WiFi,加载数据将使用手机流量！"];
     break;
     case ReachableViaWiFi:
     isExistenceNetwork=YES;
     break;
     }
}


#pragma mark -- 获取驾考数据
-(void)getExamData{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = NO;
    [header beginRefreshing];
    self.tableView.mj_header = header;
}


#pragma mark -- 网络请求数据
-(void)loadData{
    [TSMessage setDefaultViewController:self];
    [JKNetManager getQuestionBankWithSubject:self.userChooseSubject  model:self.userChooseExamType testType:self.userChooseNumber completionHandler:^(ExamModel *model, NSError *error) {
        self.questioArray = model.questions;
        [self.tableView.mj_header endRefreshing];
        self.tableView.mj_header.hidden = YES;
        [self.tableView reloadData];
        NSString *message = [NSString stringWithFormat:@"选择类型为：驾驶证%@ 科目%ld 模式：%@",self.userChooseExamType,self.userChooseSubject,[self.userChooseNumber isEqualToString:@"rand"]? @"模拟考试":@"学习"];
        [TSMessage showNotificationWithTitle:@"请求成功" subtitle:message type:TSMessageNotificationTypeSuccess];
        if (error) {
            [TSMessage showNotificationWithTitle:@"错误！" subtitle:@"数据获取失败，请重新加载！" type:TSMessageNotificationTypeError];
        }
    }];
}
#pragma mrak -- 网络提示框
-(void)networkingTipError:(NSString *)tipMessage{
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"提示" message:tipMessage preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alter addAction:cancle];
        [self presentViewController:alter animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark -- 表格代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.questioArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    ExamQuestionModel *question = self.questioArray[indexPath.row];
    cell.questionLabel.text = question.question;
    if (![question.imageUrl isEqualToString:@""]) {
        [cell.questionImageView sd_setImageWithURL:[NSURL URLWithString:question.imageUrl] placeholderImage:[UIImage imageNamed:@"tortoise"]];
    }
    cell.resultOneLabel.text = [question.item1 stringByAppendingString:@"."];
    cell.resultTwoLabel.text = [question.item2 stringByAppendingString:@"."];
    cell.resultThreeLabel.text = [question.item3 stringByAppendingString:@"."];
    cell.resultFourLabel.text = [question.item4 stringByAppendingString:@"."];
    //重新做题
    if (![cell.oneAnswerLabel.text isEqualToString:@"🤔"]||![cell.twoAnswerLabel.text isEqualToString:@"🤔"]||![cell.threeAnswerLabel.text isEqualToString:@"🤔"]||![cell.fourAnswerLabel.text isEqualToString:@"🤔"]) {
        cell.oneAnswerLabel.text = @"🤔";
        [cell.chooseOneButton setImage:[UIImage imageNamed:@"darkButton"] forState:UIControlStateNormal];
        
        cell.twoAnswerLabel.text = @"🤔";
        [cell.chooseTwoButton setImage:[UIImage imageNamed:@"darkButton"] forState:UIControlStateNormal];
        
        cell.threeAnswerLabel.text = @"🤔";
        [cell.chooseThreeButton setImage:[UIImage imageNamed:@"darkButton"] forState:UIControlStateNormal];
        
        cell.fourAnswerLabel.text = @"🤔";
        [cell.chooseFourButton setImage:[UIImage imageNamed:@"darkButton"] forState:UIControlStateNormal];
    }
    //按钮1
    [cell.chooseOneButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            if (sender.tag == question.answer.intValue||[question.answer isEqualToString:@"7"]||[question.answer isEqualToString:@"8"]||[question.answer isEqualToString:@"9"]||[question.answer isEqualToString:@"13"]||[question.answer isEqualToString:@"14"]||[question.answer isEqualToString:@"15"]||[question.answer isEqualToString:@"17"]) {
                cell.oneAnswerLabel.text = @"🤗";
                [cell.chooseOneButton setImage:[UIImage imageNamed:@"lightButton"] forState:UIControlStateNormal];
            }else{
            [cell.chooseOneButton setImage:[UIImage imageNamed:@"darkButtonX"] forState:UIControlStateNormal];
            cell.oneAnswerLabel.text = @"😱";
        }

    }];
    //按钮2
    [cell.chooseTwoButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            if (sender.tag == question.answer.intValue||[question.answer isEqualToString:@"7"]||[question.answer isEqualToString:@"10"]||[question.answer isEqualToString:@"11"]||[question.answer isEqualToString:@"13"]||[question.answer isEqualToString:@"14"]||[question.answer isEqualToString:@"17"]||[question.answer isEqualToString:@"16"]) {
                cell.twoAnswerLabel.text = @"🤗";
                [cell.chooseTwoButton setImage:[UIImage imageNamed:@"lightButton"] forState:UIControlStateNormal];
            }else{
            [cell.chooseTwoButton setImage:[UIImage imageNamed:@"darkButtonX"] forState:UIControlStateNormal];
            cell.twoAnswerLabel.text = @"😱";
        }
    }];
    //按钮3
    [cell.chooseThreeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            if (sender.tag == question.answer.intValue||[question.answer isEqualToString:@"15"]||[question.answer isEqualToString:@"8"]||[question.answer isEqualToString:@"10"]||[question.answer isEqualToString:@"12"]||[question.answer isEqualToString:@"13"]||[question.answer isEqualToString:@"16"]||[question.answer isEqualToString:@"17"]) {
                cell.threeAnswerLabel.text = @"🤗";
                [cell.chooseThreeButton setImage:[UIImage imageNamed:@"lightButton"] forState:UIControlStateNormal];
            }else{
            [cell.chooseThreeButton setImage:[UIImage imageNamed:@"darkButtonX"] forState:UIControlStateNormal];
                cell.threeAnswerLabel.text = @"😱";
        }
    }];
    //按钮4
    [cell.chooseFourButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
            if (sender.tag == question.answer.intValue||[question.answer isEqualToString:@"9"]||[question.answer isEqualToString:@"11"]||[question.answer isEqualToString:@"12"]||[question.answer isEqualToString:@"14"]||[question.answer isEqualToString:@"15"]||[question.answer isEqualToString:@"16"]||[question.answer isEqualToString:@"17"]) {
                cell.fourAnswerLabel.text = @"🤗";
                [cell.chooseFourButton setImage:[UIImage imageNamed:@"lightButton"] forState:UIControlStateNormal];
            }else{
                [cell.chooseFourButton  setImage:[UIImage imageNamed:@"darkButtonX"] forState:UIControlStateNormal];
                cell.fourAnswerLabel.text = @"😱";
            }
    }];
    cell.examNumberLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.examType.text = question.answer.intValue < 5 ? @"单选题":@"多选题";
    return cell;
}

#pragma mark -- 选择cell给出提示并读出
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *explainString = self.questioArray[indexPath.row].explains;
    UIAlertController *tipAlter = [UIAlertController alertControllerWithTitle:@"提示" message:explainString preferredStyle:UIAlertControllerStyleAlert];
//    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirmation = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [weakSelf.speechSynt stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    }];
    [tipAlter addAction:confirmation];
    //读出提示答案
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:explainString];
//    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-TW"];
//    utterance.rate = 0.5;//设置语速
//    [self.speechSynt speakUtterance:utterance];
    [self presentViewController:tipAlter animated:YES completion:nil];
}
#pragma mark -- 选择考取驾驶证类型科目
- (IBAction)examButtonClick:(UIButton *)sender {
    ExamTypeViewController *examTypeVC = [[ExamTypeViewController alloc]initWithSourceView:sender sourceRect:sender.bounds delegate:nil];
    examTypeVC.contentSize = CGSizeMake(250, 260);
    examTypeVC.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    examTypeVC.chooseExamTypeHandler = ^(NSString *examType,NSString *subject,NSString *chooseNumber){
        if ([examType isEqualToString:@"驾证"]||[subject isEqualToString:@"科目"]||[chooseNumber isEqualToString:@"目的"]) {
            return;
        }
        self.userChooseExamType = examType;
        self.userChooseSubject = [subject isEqualToString:@"科目1"]? 1: 4;
        self.userChooseNumber = [chooseNumber isEqualToString:@"考试"]? @"rand":@"order";
        [self getExamData];
    };
    [self presentViewController:examTypeVC animated:YES completion:nil];
}


/** 滑动百度搜索 */
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"百度一下" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        id vc = [story instantiateViewControllerWithIdentifier:@"WebViewController"];
        if ([vc isKindOfClass:[WebViewController class]]) {
            WebViewController *webView = vc;
            webView.searchInfo = self.questioArray[indexPath.row].question;
            [self.navigationController pushViewController:webView animated:YES];
        }
        
    }];
    return @[action];
}

@end
