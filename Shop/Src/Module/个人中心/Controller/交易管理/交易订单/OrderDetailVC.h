//
//  OrderDetailVC.h
//  Shop
//
//  Created by BWJ on 2019/2/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailVC : STBaseViewController
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property(nonatomic,assign)NSInteger status;
@property (nonatomic,retain)NSMutableDictionary *mudic;
@end

NS_ASSUME_NONNULL_END
