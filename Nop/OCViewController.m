//
//  OCViewController.m
//  Nop
//
//  Created by dengzhihao on 2022/3/5.
//

#import "OCViewController.h"

@interface OCViewController ()

@property (nonatomic, nullable, copy) NSMutableDictionary *dic;

@end

@implementation OCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableDictionary *)dic {
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc] init];
    }
    return _dic;
}

@end
