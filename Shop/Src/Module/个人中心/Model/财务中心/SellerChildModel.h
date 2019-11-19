//
//  SellerChildModel.h
//  Shop
//
//  Created by BWJ on 2019/7/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SelleModel;
@interface SellerChildModel : DRBaseModel
@property (nonatomic,retain)NSString *detail_id;
@property (nonatomic , assign) CGFloat              payAmt;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSMutableArray<SelleModel *>   *list;
@property (nonatomic , assign) NSInteger              onlineReturnAmt;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , assign) NSInteger              lineReturnAmt;
@property (nonatomic , assign) NSInteger              onlineAmt;
@property (nonatomic , assign) CGFloat              totalAmt;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , assign) CGFloat              lineAmt;

@end

@interface SelleModel :DRBaseModel
@property (nonatomic , copy) NSString              * list_id;
@property (nonatomic , assign) NSInteger             orderDate;
@property (nonatomic , copy) NSString              * sellerId;
@property (nonatomic , copy) NSString              * dzNo;
@property (nonatomic , copy) NSString              * dzId;
@property (nonatomic , copy) NSString              * billType;
@property (nonatomic , copy) NSString              * orderNo;
@property (nonatomic ,assign)CGFloat                orderAmt;
@property (nonatomic , copy) NSString              * compType;
@property (nonatomic , copy) NSString              * orderId;
@property (nonatomic ,assign)NSInteger             addTime;
@property (nonatomic ,assign)CGFloat                qty;
@property (nonatomic , copy) NSString              * payType;
@property (nonatomic ,assign)NSInteger              orderCompleteTime;
@property (nonatomic , copy) NSString              * sellerName;
@property (nonatomic , copy) NSString              * returnOrderNo;
@property (nonatomic , copy) NSString              * feeAmt;
@property (nonatomic , copy) NSString              *feeRatio;
@property (nonatomic , copy) NSString              *returnOrderId;
@property (nonatomic , copy) NSString              *rorderExpressPrice;
@end
