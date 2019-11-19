//
//  FirstTableViewCell.m
//  Save
//
//  Created by 解辉 on 2019/2/25.
//  Copyright © 2019年 FM. All rights reserved.
//

#import "SixCell.h"
#import "Masonry.h"
#import "NSString+Extension.h"
#define ZF_FONT(__fontsize__) [UIFont systemFontOfSize:WScale(__fontsize__)]
@implementation SixCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setDataDict:(NSDictionary *)dataDict
{
    self.productImg.image = [UIImage imageNamed:@"product"];
    self.productName.text = @"哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    
    NSArray * array =[NSArray array];
    if (_selectRow==1) {
    }
    else
    {
        array = @[@"M14-2.0*110",@" 12.9级",@"40Cr(合金钢)",@"淬黑",@"紧固之星"];
        
    }
    
    
    HeightF = WScale(30);
    [self setStandWithArray:array];
    
    self.parameterLabel.text = @"包装参数：哈哈哈哈哈 哈哈哈哈哈 ";
    //    self.cellLabel.text = @"最小销售单位：哈哈哈哈哈 哈哈哈哈哈 或或或或或或或或 哈哈哈";
    //    self.countLabel.text = @"库存数：72.0000支 华东仓";
}
-(void)setGoodListModel:(GoodsListModel *)goodListModel
{
    _goodListModel =goodListModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodListModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodListModel.itemName;
    NSArray * array = @[goodListModel.spec?:@"",goodListModel.levelname?:@"",goodListModel.materialname?:@"",goodListModel.surfacename?:@"",goodListModel.brandname?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr.copy];
    self.parameterLabel.text = [NSString stringWithFormat:@"购买数量：%.3f%@  小计：￥%.3f",goodListModel.qty,goodListModel.basicUnitName,goodListModel.realAmt];
}
-(void)setHaveShopModel:(GoodsModel *)haveShopModel
{
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:haveShopModel.imgurl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =haveShopModel.itemname;
    NSArray * array = @[haveShopModel.spec?:@"",haveShopModel.levelname?:@"",haveShopModel.materialname?:@"",haveShopModel.surfacename?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr];
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([haveShopModel.basicunitid intValue]==5) {
        baseStr =@"千支";
    }
    if ([haveShopModel.basicunitid intValue]==6) {
        baseStr =@"公斤";
    }
    if ([haveShopModel.basicunitid intValue]==7) {
        baseStr =@"吨";
    }
    
    
    NSString *nameStr,*cellStr;
    if (haveShopModel.unitconversion1.length!=0&&![haveShopModel.unitconversion1 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[haveShopModel.unitconversion1 doubleValue],baseStr,haveShopModel.unitname1];
        cellStr =haveShopModel.unitname1;
    }
    if (haveShopModel.unitconversion2.length!=0&&![haveShopModel.unitconversion2 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[haveShopModel.unitconversion2 doubleValue],baseStr,haveShopModel.unitname2];
        if (cellStr.length==0) {
            cellStr =haveShopModel.unitname2;
            
        }
    }
    if (haveShopModel.unitconversion3.length!=0&&![haveShopModel.unitconversion3 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[haveShopModel.unitconversion3 doubleValue],baseStr,haveShopModel.unitname3];
        if (cellStr.length==0) {
            cellStr =haveShopModel.unitname3;
            
        }
    }
    if (haveShopModel.unitconversion4.length!=0&&![haveShopModel.unitconversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[haveShopModel.unitconversion4 doubleValue],baseStr,haveShopModel.unitname4];
        if (cellStr.length==0) {
            cellStr =haveShopModel.unitname4;
            
        }
    }
    if (haveShopModel.unitconversion5.length!=0&&![haveShopModel.unitconversion5 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[haveShopModel.unitconversion5 doubleValue],baseStr,haveShopModel.unitname5];
        if (cellStr.length==0) {
            cellStr =haveShopModel.unitname5;
            
        }
    }
    self.productType.text =haveShopModel.brandname?:@"";
    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];
   self.cellLabel.text = [NSString stringWithFormat:@"库存数：%@ %@  %@  ",haveShopModel.qty,haveShopModel.basicunitname,haveShopModel.storeName];
   self.countLabel.text =[NSString stringWithFormat:@"需求数量: %@ %@",haveShopModel.noticeqty,haveShopModel.basicunitname] ;
    
}
-(void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel =goodsModel;
    
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodsModel.imgurl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productType.text =goodsModel.brandname?:@"";
    self.productName.text =goodsModel.itemname;
    NSArray * array = @[goodsModel.spec?:@"",goodsModel.levelname?:@"",goodsModel.materialname?:@"",goodsModel.surfacename?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr];
    
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([goodsModel.basicunitid intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodsModel.basicunitid intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodsModel.basicunitid intValue]==7) {
        baseStr =@"吨";
    }
    
    
    NSString *nameStr,*cellStr;
    if (goodsModel.unitconversion1.length!=0&&![goodsModel.unitconversion1 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodsModel.unitconversion1 doubleValue],baseStr,goodsModel.unitname1];
        cellStr =goodsModel.unitname1;
    }
    if (goodsModel.unitconversion2.length!=0&&![goodsModel.unitconversion2 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion2 doubleValue],baseStr,goodsModel.unitname2];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname2;
            
        }
    }
    if (goodsModel.unitconversion3.length!=0&&![goodsModel.unitconversion3 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion3 doubleValue],baseStr,goodsModel.unitname3];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname3;
            
        }
    }
    if (goodsModel.unitconversion4.length!=0&&![goodsModel.unitconversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion4 doubleValue],baseStr,goodsModel.unitname4];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname4;
            
        }
    }
    if (goodsModel.unitconversion5.length!=0&&![goodsModel.unitconversion5 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodsModel.unitconversion5 doubleValue],baseStr,goodsModel.unitname5];
        if (cellStr.length==0) {
            cellStr =goodsModel.unitname5;
            
        }
    }
    
    self.cellLabel.text = [NSString stringWithFormat:@"库存数(%@): %.3f  %@",baseStr,[goodsModel.qty doubleValue],goodsModel.storeName];
    self.parameterLabel.text =[NSString stringWithFormat:@"包装参数：%@",nameStr];;
    self.countLabel.text =[NSString stringWithFormat:@"最小销售单位: %@  单规格起订量: %.3f%@",goodsModel.saleunitname,[goodsModel.minquantity doubleValue],goodsModel.saleunitname] ;
    self.moneyLabel.text =[NSString stringWithFormat:@"单价：￥%.2f/%@",[goodsModel.userprice doubleValue],goodsModel.basicunitname];
    [SNTool setTextColor:self.moneyLabel FontNumber:DR_FONT(18) AndRange:NSMakeRange(4, self.moneyLabel.text.length-5-goodsModel.basicunitname.length) AndColor:REDCOLOR];
}

-(void)setGoodSellOutModel:(GoodsList *)goodSellOutModel
{
    _goodSellOutModel =goodSellOutModel;
    [self.productImg sd_setImageWithURL:[NSURL URLWithString:goodSellOutModel.imgUrl] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    self.productName.text =goodSellOutModel.itemName;
    NSArray * array = @[goodSellOutModel.spec?:@"",goodSellOutModel.levelname?:@"",goodSellOutModel.materialname?:@"",goodSellOutModel.surfacename?:@"",goodSellOutModel.brandname?:@""];
    NSMutableArray *titArr =[NSMutableArray array];
    for (NSString *str in array) {
        if (str.length!=0) {
            [titArr addObject:str];
        }
    }
    HeightF = WScale(30);
    [self setStandWithArray:titArr.copy];
    NSString *baseStr;//basicunitid 5千支  6公斤  7吨
    if ([goodSellOutModel.basicUnitId intValue]==5) {
        baseStr =@"千支";
    }
    if ([goodSellOutModel.basicUnitId intValue]==6) {
        baseStr =@"公斤";
    }
    if ([goodSellOutModel.basicUnitId intValue]==7) {
        baseStr =@"吨";
    }
    NSString *nameStr,*cellStr;
    if ([goodSellOutModel.unitConversion1 intValue]!=0&&![goodSellOutModel.unitConversion1 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%.3f%@/%@",[goodSellOutModel.unitConversion1 doubleValue],baseStr,goodSellOutModel.unitName1];
        cellStr =goodSellOutModel.unitName1;
    }
    if ([goodSellOutModel.unitConversion2 intValue]!=0&&![goodSellOutModel.unitConversion2 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion2 doubleValue],baseStr,goodSellOutModel.unitName2];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName2;
        }
    }
    if ([goodSellOutModel.unitConversion3 intValue]!=0&&![goodSellOutModel.unitConversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion3 doubleValue],baseStr,goodSellOutModel.unitName3];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName3;
            
        }
    }
    if ([goodSellOutModel.unitConversion4 intValue]!=0&&![goodSellOutModel.unitConversion4 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion4 doubleValue],baseStr,goodSellOutModel.unitName4];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName4;
            
        }
    }
    if ([goodSellOutModel.unitConversion5 intValue]!=0&&![goodSellOutModel.unitConversion5 isEqualToString:@"0"]) {
        nameStr =[NSString stringWithFormat:@"%@ %.3f%@/%@",nameStr?:@"",[goodSellOutModel.unitConversion5 doubleValue],baseStr,goodSellOutModel.unitName5];
        if (cellStr.length==0) {
            cellStr =goodSellOutModel.unitName5;
            
        }
    }
    self.parameterLabel.text = [NSString stringWithFormat:@"价格：￥%@  包装参数：%@",goodSellOutModel.returnPrice,nameStr];
    
}
-(UIImageView *)productImg
{
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [self addSubview:_productImg];
        [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(WScale(10));
            make.top.mas_equalTo(WScale(12));
            make.height.mas_equalTo(WScale(85));
            make.width.mas_equalTo(WScale(90));
        }];
    }
    return _productImg;
}

-(UILabel *)productType
{
    if (!_productType) {
        _productType = [[UILabel alloc] init];
        _productType.backgroundColor =RGBHex(0XFD8A30);
        _productType.textColor = WHITECOLOR;
        _productType.textAlignment =1;
        _productType.layer.cornerRadius =1.0;
        _productType.font = DR_FONT(10);
        [self addSubview:_productType];
        [_productType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productImg.mas_right).offset(WScale(10));
            make.top.mas_equalTo(WScale(12));
            make.height.mas_equalTo(WScale(17));
        }];
        
    }
    return _productType;
}

-(UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.textColor = [UIColor blackColor];
        _productName.font = DR_FONT(14);
        [self addSubview:_productName];
        [_productName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType.mas_right).offset(WScale(5));
            make.top.mas_equalTo(self.productImg);
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(WScale(17));
        }];
    }
    return _productName;
}


-(UIView *)standardView
{
    if (!_standardView) {
        _standardView = [[UIView alloc] init];
        [self addSubview:_standardView];
        [_standardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.productType);
            make.top.mas_equalTo(self.productName.mas_bottom).offset(WScale(5));
            make.right.mas_equalTo(WScale(-10));
            make.height.mas_equalTo(HeightF);
        }];
    }
    return _standardView;
}
-(void)setStandWithArray:(NSArray *)array
{
    [self.standardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat tagBtnX = 0;
    CGFloat tagBtnY = 0;
    for (int i = 0; i<array.count; i++) {
        CGSize tagTextSize = [array[i] sizeWithFont:ZF_FONT(12) maxSize:CGSizeMake(WScale(280),WScale(12))];
        if (tagBtnX+tagTextSize.width+HScale(12) >WScale(250)) {
            
            tagBtnX = 0;
            tagBtnY += WScale(12)+WScale(5);
        }
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake(tagBtnX, tagBtnY, tagTextSize.width+WScale(5),WScale(12));
        label.text = array[i];
        label.textColor = [UIColor blackColor];
        label.font = DR_FONT(12);
        label.textAlignment = 0;
//        label.layer.cornerRadius = 2;
        label.layer.masksToBounds = YES;
//        label.backgroundColor = BACKGROUNDCOLOR;
        [self.standardView addSubview:label];
        tagBtnX = CGRectGetMaxX(label.frame)+WScale(5);
    }
    HeightF = tagBtnY +WScale(12);
    [self.standardView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HeightF);
    }];
    
}

-(UILabel *)cellLabel
{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.textColor = BLACKCOLOR;
        _cellLabel.font = DR_FONT(12);
        _cellLabel.numberOfLines = 0;
        [self addSubview:_cellLabel];
        [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.standardView.mas_bottom).offset(WScale(10));
            make.left.mas_equalTo(self.productType);
            make.right.mas_equalTo(WScale(-10));
                        
        }];
    }
    return _cellLabel;
}

-(UILabel *)parameterLabel
{
    if (!_parameterLabel) {
        _parameterLabel = [[UILabel alloc] init];
        _parameterLabel.textColor = RGBHex(0X888888);
        _parameterLabel.font = DR_FONT(11);
        _parameterLabel.numberOfLines = 0;
        [self addSubview:_parameterLabel];
        [_parameterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.cellLabel.mas_bottom).offset(WScale(8));
            make.left.mas_equalTo(self.productType);
            make.right.mas_equalTo(WScale(-10));
        }];
    }
    return _parameterLabel;
}
-(UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = RGBHex(0X888888);
        _countLabel.font = DR_FONT(11);
        _countLabel.numberOfLines = 0;
        [self addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.parameterLabel.mas_bottom).mas_equalTo(WScale(5));
            make.left.mas_equalTo(self.productType);
            make.right.mas_equalTo(WScale(-10));
        }];
    }
    return _countLabel;
}

-(UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textColor = REDCOLOR;
        _moneyLabel.font = DR_FONT(12);
        _moneyLabel.numberOfLines = 0;
        [self addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.countLabel.mas_bottom).mas_equalTo(WScale(10));
            make.left.mas_equalTo(self.productType.mas_left);
            make.right.mas_equalTo(WScale(-10));
            make.bottom.mas_equalTo(WScale(-12));
        }];
    }
    return _moneyLabel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
