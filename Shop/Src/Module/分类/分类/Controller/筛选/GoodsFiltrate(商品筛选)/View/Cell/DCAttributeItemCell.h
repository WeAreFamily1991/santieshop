//
//  DCAttributeItemCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DCContentItem;
@interface DCAttributeItemCell : UICollectionViewCell
/* item按钮 */
@property (strong , nonatomic)UIButton *contentButton;
/* 内容 */
@property (strong , nonatomic)DCContentItem *contentItem;
/* 内容 */
@property (strong , nonatomic)DCContentItem *titleItem;



@end
