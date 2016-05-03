//
//  ExamTypeViewController.m
//  DrivingAssistant
//
//  Created by ji on 16/4/20.
//  Copyright © 2016年 ji. All rights reserved.
//

#import "ExamTypeViewController.h"

@interface ExamTypeViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic) UIPickerView *pickerView;
@property(nonatomic,strong)NSArray *examType;
@property(nonatomic,strong)NSArray *subject;
@property(nonatomic,strong)NSArray *chooseExamNumber;
@property(nonatomic,strong)NSString *userChooseExamType;
@property(nonatomic,strong)NSString *userChooseSubject;
@property(nonatomic,strong)NSString *userChooseNumber;
@end

@implementation ExamTypeViewController

#pragma mark - 懒加载
- (UIPickerView *)pickerView {
    if(_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        [self.view addSubview:_pickerView];
        [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

-(NSArray *)examType{
    if (!_examType) {
        _examType = @[@"驾证",@"c1",@"c2",@"a1",@"a2",@"b1",@"b2"];
    }
    return _examType;
}

-(NSArray *)subject{
    if (!_subject) {
        _subject = @[@"科目",@"科目1",@"科目4"];
    }
    return _subject;
}

-(NSArray *)chooseExamNumber{
    if (!_chooseExamNumber) {
        _chooseExamNumber = @[@"目的",@"考试",@"学习"];
    }
    return _chooseExamNumber;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 7;
    }else {
        return 3;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        self.userChooseExamType = self.examType[row];
    }else if(component == 1){
        self.userChooseSubject = self.subject[row];
    }else if(component == 2){
        self.userChooseNumber = self.chooseExamNumber[row];
    }
}

-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    !_chooseExamTypeHandler ?: _chooseExamTypeHandler(self.userChooseExamType,self.userChooseSubject,self.userChooseNumber);
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return self.examType[row];
    }else if(component == 1){
        return self.subject[row];
    }
    return self.chooseExamNumber[row];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userChooseExamType = @"c1";
    self.userChooseSubject = @"科目1";
    self.userChooseNumber = @"随机";
    [self.pickerView reloadAllComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
