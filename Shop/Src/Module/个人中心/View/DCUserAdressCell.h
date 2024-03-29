//
//  DCUserAdressCell.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2017/12/19.
//Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DRAdressListModel;

@interface DCUserAdressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;

@property (weak, nonatomic) IBOutlet UILabel *morenLab;
@property (nonatomic, copy) void (^selectBtnClickBlock)(BOOL isSelected);

/* 模型数据 */
@property (strong , nonatomic)DRAdressListModel *adItem;

/** 删除点击回调 */
@property (nonatomic, copy) dispatch_block_t deleteClickBlock;
/** 编辑点击回调 */
@property (nonatomic, copy) dispatch_block_t editClickBlock;

@end
