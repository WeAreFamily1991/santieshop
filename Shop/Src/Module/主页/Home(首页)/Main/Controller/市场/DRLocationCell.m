//
//  DRLocationCell.m
//  Shop
//
//  Created by BWJ on 2019/4/27.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRLocationCell.h"
#import "DRLocationModel.h"
#import "GoodsModel.h"
@implementation DRLocationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setLocationModel:(DRLocationModel *)locationModel
{
    _locationModel =locationModel;
    if (locationModel.favoriteId.length!=0) {
        self.collectionBtn.selected =YES;
    }
    else
    {
        self.collectionBtn.selected =NO;
    }
    [self.iconIMG sd_setImageWithURL:[NSURL URLWithString:locationModel.compLog] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    if (locationModel.storeTitle.length!=0) {        
        [self.titBtn setTitle:locationModel.storeTitle forState:UIControlStateNormal];
    }else
    {
        [self.titBtn setTitle:locationModel.compName forState:UIControlStateNormal];;
    }
    self.typeLab.text =[NSString stringWithFormat:@"主营产品：%@",locationModel.storePrdt];
    //compType 0 自营 1厂家  2批发商
    NSString *typeStr;
    if ([locationModel.compType isEqualToString:@"0"]) {
        typeStr =@"自营";
    }else if ([locationModel.compType isEqualToString:@"1"])
    {
        typeStr =@"厂家";
    }
    else if ([locationModel.compType isEqualToString:@"2"])
    {
        typeStr =@"批发商";
    }
    self.modelLab.text =[NSString stringWithFormat:@"经营模式：%@",typeStr];
    self.addressLab.text =[NSString stringWithFormat:@"所在地：%@",locationModel.compAddr];
    
}
-(void)setFavorteModel:(FavoriteModel *)favorteModel
{
    _favorteModel =favorteModel;
    if (favorteModel.favorite_id.length!=0) {
        self.collectionBtn.selected =YES;
    }
    else
    {
        self.collectionBtn.selected =NO;
    }
    [self.iconIMG sd_setImageWithURL:[NSURL URLWithString:favorteModel.compLog] placeholderImage:[UIImage imageNamed:@"santie_default_img"]];
    if (favorteModel.storeTitle.length!=0) {
        [self.titBtn setTitle:favorteModel.storeTitle forState:UIControlStateNormal];
    }else
    {
        [self.titBtn setTitle:favorteModel.compName forState:UIControlStateNormal];
    }
    if ([favorteModel.isSendVoucher isEqualToString:@"1"]) {
        [self.titBtn setImage:[UIImage imageNamed:@"quan"] forState:UIControlStateNormal];
        
    }else
    {
        [self.titBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    self.typeLab.text =[NSString stringWithFormat:@"主营产品：%@",favorteModel.storePrdt];
    //compType 0 自营 1厂家  2批发商
    NSString *typeStr;
    if ([favorteModel.compType isEqualToString:@"0"]) {
        typeStr =@"自营";
    }else if ([favorteModel.compType isEqualToString:@"1"])
    {
        typeStr =@"厂家";
    }
    else if ([favorteModel.compType isEqualToString:@"2"])
    {
        typeStr =@"批发商";
    }
    self.modelLab.text =[NSString stringWithFormat:@"经营模式：%@",typeStr];
    self.addressLab.text =[NSString stringWithFormat:@"所在地：%@",favorteModel.compAddr];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)collectionBtnClick:(id)sender {
    if (_favorteModel) {
        !_collectionBtnBlock?:_collectionBtnBlock();
    }else
    {
        
        NSMutableDictionary *mudic =[NSMutableDictionary dictionary];
        NSString *urlStr;
        if (self.collectionBtn.selected) {
            urlStr =@"buyer/cancelSellerFavorite";
            
            mudic =[NSMutableDictionary dictionaryWithObject:self.locationModel.favoriteId forKey:@"id"];
            [SNIOTTool deleteWithURL:urlStr parameters:mudic success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    
                    self.locationModel.favoriteId =@"";
                    self.collectionBtn.selected =NO;
                    //               [MBProgressHUD showSuccess:@"取消成功"];
                }
            } failure:^(NSError *error) {
                [MBProgressHUD showError:error.description];
            }];
        }
        else
        {
            urlStr =@"buyer/favoriteSeller";
            NSDictionary *dic =@{@"id":self.locationModel.compId};
            
            [SNAPI postWithURL:urlStr parameters:dic.mutableCopy success:^(SNResult *result) {
                if (result.state==200) {
                    NSLog(@"result=%@",result.data);
                    self.locationModel.favoriteId=result.data;
                    self.collectionBtn.selected =YES;
                    [MBProgressHUD showSuccess:@"收藏成功"];
                    //
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }
}
- (IBAction)phoneBtnClick:(id)sender {
}

@end
