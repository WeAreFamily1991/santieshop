//
//  DRShouKuanChildVC.m
//  Shop
//
//  Created by BWJ on 2019/7/23.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRShouKuanChildVC.h"
#import "SalesOrderModel.h"
#import "SellerChildModel.h"
#import "SaleOrderCell.h"
#import "DetailOrdervc.h"
#import "DRDetailSelloutVC.h"
@interface DRShouKuanChildVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UIView *bootView;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIButton *zhifuBtn;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic,strong)NSMutableArray *MsgListArr;
@property (nonatomic,strong)SellerChildModel *detailModel;
@property (nonatomic,strong)ListModel *listMOdel;
@end
@implementation DRShouKuanChildVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"未税收款详情";
    [self loadTableView];
    [self orderDzInfo];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =CLEARCOLOR;
    if (@available(iOS 11.0, *)) {
        
        _tableView.estimatedRowHeight = 0;
        
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
}
-(void)orderDzInfo
{
    //    DRWeakSelf;
   

    NSString *urlStr =@"buyer/wsOrderDzInfo";
  
//    NSString * stateStr;
//    stateStr =@"0";
    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[self.saleModel.sale_id,@""] forKeys:@[@"dzId",@"type"]];
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        if ([[NSString stringWithFormat:@"%ld",(long)result.state] isEqualToString:@"200"]) {
            self.MsgListArr =[NSMutableArray array];
            self.countLab.text =[NSString stringWithFormat:@"账单金额：%@",result.data[@"totalAmt"]];
            [SNTool setTextColor:self.countLab FontNumber:DR_FONT(14) AndRange:NSMakeRange(5, self.countLab.text.length-5) AndColor:REDCOLOR];
            if ([[NSString stringWithFormat:@"%@",result.data[@"payStatus"]] isEqualToString:@"2"]) {
                [self.zhifuBtn setTitle:@"立即支付" forState:UIControlStateNormal];

                self.zhifuBtn.backgroundColor =REDCOLOR;
                self.zhifuBtn.enabled =YES;
            }
            else
            {
                [self.zhifuBtn setTitle:@"已支付" forState:UIControlStateNormal];
                self.zhifuBtn.backgroundColor =[UIColor lightGrayColor];
                self.zhifuBtn.enabled =NO;
            }
            NSArray *resultArr =result.data[@"sellerList"];
                NSMutableArray *modelArray = [SellerChildModel mj_objectArrayWithKeyValuesArray:resultArr];
                [self.MsgListArr addObjectsFromArray:modelArray];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HScale(110);
}
#pragma mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.MsgListArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.detailModel =self.MsgListArr[section];
    return self.detailModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailModel = self.MsgListArr[indexPath.section];
    self.listMOdel =[ListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
//    if (self.fatherStatus==0) {
        SaleOrderCell4 *cell =[SaleOrderCell4 cellWithTableView:tableView];
        if ([self.listMOdel.billType intValue]==1) {
            cell.orderLab.text =@"单据类型：销售订单";
        }else
        {
            cell.orderLab.text =@"单据类型：退货订单";
        }

        cell.getTimeLab.text =[NSString stringWithFormat:@"生成时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",self.listMOdel.orderDate]]];
        cell.getTimeLab.textColor =BLACKCOLOR;
        cell.saleTimeLab.text =[NSString stringWithFormat:@"对账数量：%.3f",self.listMOdel.qty];

    cell.saleCountLab.text =[NSString stringWithFormat:@"对账金额：￥%.2f",self.listMOdel.orderAmt];
        cell.saleCountLab.textColor =REDCOLOR;
        cell.typeLab.text =[self.listMOdel.payType boolValue]?@"在线支付":@"额度支付";
        cell.yunfeiLab.text=[NSString stringWithFormat:@"运费：￥%@",self.listMOdel.orderExpressPrice];
        cell.detailClickBlock = ^{
            self.detailModel = self.MsgListArr[indexPath.section];
            self.listMOdel =[ListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
            if ([self.listMOdel.billType intValue]==1) {

                DetailOrdervc *detailVC =[[DetailOrdervc alloc]init];
                detailVC.orderID =self.listMOdel.orderId;
                [self.navigationController pushViewController:detailVC animated:YES];
            }else
            {
                DRDetailSelloutVC *sellOutVc =[[DRDetailSelloutVC alloc]init];

                sellOutVc.returnId =self.listMOdel.orderId;
                [self.navigationController pushViewController:sellOutVc animated:YES];
            }

        };
        return cell;
//    }
//    SaleOrderCell *cell =[SaleOrderCell cellWithTableView:tableView];
//
//    cell.orderLab.text =[NSString stringWithFormat:@"订单号：%@",self.listMOdel.orderNo];
//    cell.getTimeLab.text =[NSString stringWithFormat:@"退货单号：%@",self.listMOdel.returnOrderNo];
//
//    cell.getTimeLab.textColor =BLACKCOLOR;
//    cell.saleTimeLab.text =[NSString stringWithFormat:@"生成时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",(long)self.listMOdel.orderDate]]];
//    cell.saleCountLab.text =[NSString stringWithFormat:@"退货金额：￥%f  费率：%.0f",self.listMOdel.orderAmt,[self.listMOdel.feeRatio doubleValue]];
//    cell.moneyCountLab.text =[NSString stringWithFormat:@"费用金额：￥%f",[self.listMOdel.feeAmt doubleValue]];
//    //    cell.saleCountLab.textColor =REDCOLOR;
//    cell.typeLab.text =[self.listMOdel.payType boolValue]?@"在线支付":@"额度支付";
//    cell.yunfeiLab.hidden =YES;
//    cell.detailClickBlock = ^{
//        self.detailModel = self.MsgListArr[indexPath.section];
//        self.listMOdel =[ListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
//        DRDetailSelloutVC *sellOutVc =[[DRDetailSelloutVC alloc]init];
//        sellOutVc.returnId =self.listMOdel.returnOrderId;
//        [self.navigationController pushViewController:sellOutVc animated:YES];
//    };
//    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.detailModel =self.MsgListArr[section];
    
    UIView*  headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale(30))];
    headView.backgroundColor=BACKGROUNDCOLOR;
    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(15, HScale(5), WScale(50), HScale(20))];
    button.titleLabel.font =DR_FONT(12);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button setTitle:@"自营" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    [button setTitle:@"厂家" forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateSelected];
    button.selected =[self.detailModel.compType boolValue];
    [headView addSubview:button];
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(button.dc_right+15, 0, 2*ScreenW/3, HScale(30))];
    headLab.font =DR_FONT(14);
    headLab.textColor =BLACKCOLOR;
    headLab.textAlignment = 0;
    headLab.text=self.detailModel.sellerName;
    [headView addSubview:headLab];
    return headView;
    
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, HScale(55))];
//    headView.backgroundColor =[UIColor whiteColor];
//    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button setFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    button.tag=100+section;
//    button.titleLabel.font =[UIFont systemFontOfSize:14];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [button setTitleColor:REDCOLOR forState:UIControlStateSelected];
//
//    [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10];
//    [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
//    [headView addSubview:button];
//    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 70, HScale(55))];
//    headLab.font =DR_FONT(14);
//    headLab.textColor =BLACKCOLOR;
//    headLab.textAlignment = 0;
//    headLab.text=self.detailModel.sellerName;
//    [headView addSubview:headLab];
//    return headView;
//}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return HScale(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.01;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)zhifuBtnClick:(id)sender {
    
}

@end
