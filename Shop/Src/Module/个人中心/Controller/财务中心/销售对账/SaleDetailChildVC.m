//
//  ExampleViewController.m
//  SegmentView
//
//  Created by tom.sun on 16/5/27.
//  Copyright © 2016年 tom.sun. All rights reserved.
//

#import "SaleDetailChildVC.h"
#import "SaleOrderCell.h"
#import "CustomHeadView.h"
#import "ChildCustomHeadView.h"
#import "SalesOrderModel.h"
#import "DetailOrdervc.h"
#import "DRDetailSelloutVC.h"
@interface SaleDetailChildVC ()<UITableViewDelegate,UITableViewDataSource>
{
    int pageCount;
}
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *sendDataDictionary;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic,assign)NSInteger selectIndex;
@property (nonatomic,strong)NSMutableArray *MsgListArr,*isOpenArr;
@property (nonatomic,strong)ChildCustomHeadView *childheadView;
@property (nonatomic,strong)CustomHeadView *headView;
@property (nonatomic,strong)detailSalesOrderModel *detailModel;
@property (nonatomic,strong)ListModel *listMOdel;
@end

@implementation SaleDetailChildVC
- (instancetype)initWithIndex:(NSInteger)index title:(NSString *)title
{
    self = [super init];
    if (self) {
        _titleStr = title;
        NSLog(@"index=%ld",(long)index);
        _selectIndex =index;
        
    }
    return self;
}
-(void)selectWithIndex:(NSInteger)selectIndex
{
    NSLog(@"selectIndex=%ld",(long)selectIndex);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =BACKGROUNDCOLOR;
    [self loadTableView];
    if (self.fatherStatus==1) {
        [self addCustomChildHeadView];
    }
    else
    {
        [self addCustomHeadView];
    }
   
    //   self.tableView.height = self.tableView.height - 50 - DRTopHeight -100;
    [self orderDzInfo];
// Do any additional setup after loading the view.
}
-(void)loadTableView
{
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT-DRTopHeight-40) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor =CLEARCOLOR;
//    if (@available(iOS 11.0, *)) {
//
//        _tableView.estimatedRowHeight = 0;
//
//        _tableView.estimatedSectionHeaderHeight = 0;
//
//        _tableView.estimatedSectionFooterHeight = 0;
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
 
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
}
-(void)orderDzInfo
{
//    DRWeakSelf;
    NSString *urlStr;
  
    if (self.fatherStatus ==0) {
        urlStr =@"buyer/orderDzInfo";
       
    }
    else
    {
        urlStr =@"buyer/feeInfo";
        
    }
    NSString * stateStr;
    if (self.status==0) {
        stateStr =@"";
    }else if (self.status==1)
    {
        stateStr =@"1";
    }
    else if (self.status==2)
    {
        stateStr =@"0";
    }
     NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithObjects:@[self.saleModel.sale_id,stateStr] forKeys:@[@"dzId",@"type"]];
    [SNAPI getWithURL:urlStr parameters:dic success:^(SNResult *result) {
        
        self.MsgListArr =[NSMutableArray array];
        NSArray *resultArr =result.data[@"sellerList"];
        if (resultArr.count!=0) {
            NSMutableArray *modelArray = [detailSalesOrderModel mj_objectArrayWithKeyValuesArray:resultArr];
            [self.MsgListArr addObjectsFromArray:modelArray];
            
            self.isOpenArr=[[NSMutableArray alloc] init];
            for (int i=0; i<self.MsgListArr.count; i++) {
                NSString*  state=@"close";
                [self.isOpenArr addObject:state];
            }
            if (self.fatherStatus==0) {
                //"totalAmt":2408.90,"onlineAmt":0,"lineAmt":2408.90,"lineReturnAmt":0,"onlineReturnAmt":0,"payAmt":2408.90,"
                self.headView.payAllLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"payAmt"] doubleValue]]?:@"0.00";
                self.headView.allCountLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"totalAmt"] doubleValue]]?:@"0.00";
                self.headView.onlineLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"onlineAmt"] doubleValue]]?:@"0.00";
                self.headView.onlineBackLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"onlineReturnAmt"] doubleValue]]?:@"0.00";
                self.headView.EDuLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"lineAmt"] doubleValue]]?:@"0.00";
                self.headView.eDuBackLab.text =[NSString stringWithFormat:@"￥%.2f",[result.data[@"lineReturnAmt"] doubleValue]]?:@"0.00";
            }
            else
            {
                self.childheadView.allCountMoneyLab.text =[NSString stringWithFormat:@"您需支付金额:￥%@",result.data[@"totalAmt"]]?:@"0.00";
                self.childheadView.payCountMoneyLab.text =[NSString stringWithFormat:@"在线支付金额:￥%@",result.data[@"onlineAmt"]]?:@"0.00";
                self.childheadView.backCountLab.text =[NSString stringWithFormat:@"额度支付金额：￥%@",result.data[@"lineAmt"]]?:@"0.00";
            }
        }
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)addCustomChildHeadView
{
    self.childheadView = [[[NSBundle mainBundle] loadNibNamed:@"ChildCustomHeadView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。
    self.tableView.tableHeaderView =self.childheadView ;
}
-(void)addCustomHeadView
{
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"CustomHeadView" owner:self options:nil] lastObject]; // lastObject 可改为 firstObject，该数组只有一个元素，写哪个都行，看个人习惯。
    self.tableView.tableHeaderView =self.headView ;

}
-(void)getMsgList
{
    if (!_sendDataDictionary) {
        _sendDataDictionary = [[NSMutableDictionary alloc] init];
    }
    //    [MBProgressHUD showMessage:@""];
    [self loadDataSource:_sendDataDictionary withpagecount:[NSString stringWithFormat:@"%d",pageCount]];
}
-(void)loadDataSource:(NSMutableDictionary*)dictionary withpagecount:(NSString *)page
{
    
}-(void)addCustomView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH, 36)];
    backView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:backView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return WScale(340);
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
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return UITableViewAutomaticDimension;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailModel = self.MsgListArr[indexPath.section];
    self.listMOdel =[ListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
    if (self.fatherStatus==0) {
        SaleOrderCell4 *cell =[SaleOrderCell4 cellWithTableView:tableView];
        if ([self.listMOdel.billType intValue]==1) {
            cell.orderLab.text =@"单据类型：销售订单";
        }else
        {
            cell.orderLab.text =@"单据类型：退货订单";
        }
       
        cell.getTimeLab.text =[NSString stringWithFormat:@"生成时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",self.listMOdel.orderDate]]];
         cell.getTimeLab.textColor =BLACKCOLOR;
        cell.saleTimeLab.text =[NSString stringWithFormat:@"对账数量：%.2f",self.listMOdel.qty];
        cell.saleCountLab.text =[NSString stringWithFormat:@"对账金额：￥%.2f",self.listMOdel.orderAmt];
        cell.saleCountLab.textColor =REDCOLOR;
        cell.payLab.text =[self.listMOdel.payType boolValue]?@"在线支付":@"额度支付";
        cell.yunfeiLab.text=[NSString stringWithFormat:@"运费：￥%@",self.listMOdel.orderExpressPrice?:@"0"];
      
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
    }
    SaleOrderCell *cell =[SaleOrderCell cellWithTableView:tableView];
   
        cell.orderLab.text =[NSString stringWithFormat:@"订单号：%@",self.listMOdel.orderNo];
    cell.getTimeLab.text =[NSString stringWithFormat:@"退货单号：%@",self.listMOdel.returnOrderNo];
    
    cell.getTimeLab.textColor =BLACKCOLOR;
    cell.saleTimeLab.text =[NSString stringWithFormat:@"生成时间：%@",[SNTool StringTimeFormat:[NSString stringWithFormat:@"%ld",self.listMOdel.addTime]]];
    cell.saleCountLab.text =[NSString stringWithFormat:@"退货金额：￥%.2f  费率：%.0f",self.listMOdel.orderAmt,[self.listMOdel.feeRatio doubleValue]];
    cell.moneyCountLab.text =[NSString stringWithFormat:@"费用金额：￥%.2f",[self.listMOdel.feeAmt doubleValue]];
//    cell.saleCountLab.textColor =REDCOLOR;
    cell.typeLab.text =[self.listMOdel.payType boolValue]?@"在线支付":@"额度支付";
    cell.yunfeiLab.hidden =YES;
    cell.detailClickBlock = ^{
        self.detailModel = self.MsgListArr[indexPath.section];
        self.listMOdel =[ListModel mj_objectWithKeyValues:self.detailModel.list[indexPath.row]];
       
        DRDetailSelloutVC *sellOutVc =[[DRDetailSelloutVC alloc]init];
        
        sellOutVc.returnId =self.listMOdel.returnOrderId;
        [self.navigationController pushViewController:sellOutVc animated:YES];
    
        
    };
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.detailModel =self.MsgListArr[section];
    
    UIView*  headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HScale(30))];
    headView.backgroundColor=[UIColor whiteColor];
    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(15, HScale(5), WScale(50), HScale(20))];
    button.titleLabel.font =DR_FONT(16);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
    if ([self.detailModel.compType intValue]==0) {
        [button setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
        [button setTitle:@"自营" forState:UIControlStateNormal];
        
    }else if ([self.detailModel.compType intValue]==1)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"分类购买_08"] forState:UIControlStateNormal];
        [button setTitle:@"厂家" forState:UIControlStateNormal];
        
    }
    else if ([self.detailModel.compType intValue]==2)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"blue-bg"] forState:UIControlStateNormal];
        [button setTitle:@"批发商" forState:UIControlStateNormal];
        
    }
   
    [headView addSubview:button];
    UILabel *headLab =[[UILabel alloc]initWithFrame:CGRectMake(button.dc_right+15, 0, 2*ScreenW/3, HScale(30))];
    headLab.font =DR_FONT(16);
    headLab.textColor =BLACKCOLOR;
    headLab.textAlignment = 0;
    headLab.text=self.detailModel.sellerName;
    [headView addSubview:headLab];
    return headView;
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView*  sectionBackView=[[UIView alloc] initWithFrame:CGRectMake(0, WScale(0), ScreenW, WScale(50))];
    sectionBackView.backgroundColor=[UIColor whiteColor];
   
  
    UIButton*  button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(WScale(10), 0, ScreenW/3.5, WScale(50))];
    button.tag=100+section;
    [button setTitle:@"查看统计金额" forState:UIControlStateNormal];
    button.titleLabel.font =DR_FONT(14);
    [button setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ico_dingdanxiangqing_more"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ico_dingdanxiangqing_more"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(ClickSection:) forControlEvents:UIControlEventTouchUpInside];
    [button layoutButtonWithEdgeInsetsStyle:LXButtonEdgeInsetsStyleRight imageTitleSpace:0];
    [sectionBackView addSubview:button];
    UILabel*  numLabel=[[UILabel alloc] initWithFrame:CGRectMake(ScreenW/2, 0, ScreenW/2, WScale(50))];
     self.detailModel = self.MsgListArr[section];
      
    numLabel.text=[NSString stringWithFormat:@"支付金额：￥%.3f",self.detailModel.payAmt];
   
    [SNTool setTextColor:numLabel FontNumber:DR_FONT(18) AndRange:NSMakeRange(5, numLabel.text.length-5) AndColor:REDCOLOR];
    [sectionBackView addSubview:numLabel];
    
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, WScale(50), ScreenW, WScale(1))];
    lineView.backgroundColor =BACKGROUNDCOLOR;
    [sectionBackView addSubview:lineView];
 
    if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"open"]) {
        button.selected =YES;
        if (self.fatherStatus==0) {
            
            sectionBackView.frame =CGRectMake(0, WScale(0), ScreenW, WScale(240));
            UILabel *payNameLab =[UILabel labelWithText:[NSString stringWithFormat:@"您需支付金额\n￥%.2f",self.detailModel.payAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            payNameLab.frame =CGRectMake(0, WScale(50), ScreenW/2, WScale(38));
            [SNTool setTextColor:payNameLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(6, payNameLab.text.length-6) AndColor:BLACKCOLOR];
            
            UILabel *allLab =[UILabel labelWithText:[NSString stringWithFormat:@"账单总金额\n￥%.2f",self.detailModel.totalAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            allLab.frame =CGRectMake(ScreenW/2, WScale(50), ScreenW/2, WScale(38));
            [SNTool setTextColor:allLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(5, allLab.text.length-5) AndColor:BLACKCOLOR];
            
            UILabel *onlineLab =[UILabel labelWithText:[NSString stringWithFormat:@"在线支付金额\n￥%.2ld",(long)self.detailModel.onlineAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            onlineLab.frame =CGRectMake(0, WScale(103), ScreenW/2, WScale(38));
            [SNTool setTextColor:onlineLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(6, onlineLab.text.length-6) AndColor:BLACKCOLOR];
            
            UILabel *backLab =[UILabel labelWithText:[NSString stringWithFormat:@"在线支付退款\n￥%.2ld",(long)self.detailModel.onlineReturnAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            backLab.frame =CGRectMake(ScreenW/2, WScale(103), ScreenW/2, WScale(38));
            [SNTool setTextColor:backLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(6, backLab.text.length-6) AndColor:BLACKCOLOR];
            
            UILabel *eduPayLab =[UILabel labelWithText:[NSString stringWithFormat:@"额度支付金额\n￥%.2f",self.detailModel.lineAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            eduPayLab.frame =CGRectMake(0, WScale(156), ScreenW/2, WScale(38));
            [SNTool setTextColor:eduPayLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(6, eduPayLab.text.length-6) AndColor:BLACKCOLOR];
            
            UILabel *ebackLab =[UILabel labelWithText:[NSString stringWithFormat:@"额度支付退款\n￥%.2ld",(long)self.detailModel.lineReturnAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            ebackLab.frame =CGRectMake(ScreenW/2, WScale(156), ScreenW/2, WScale(38));
            [SNTool setTextColor:ebackLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(6, ebackLab.text.length-6) AndColor:BLACKCOLOR];
        }
        else
        {
            UILabel *onlineLab =[UILabel labelWithText:[NSString stringWithFormat:@"在线支付金额\n￥%.2ld",(long)self.detailModel.onlineAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            onlineLab.frame =CGRectMake(0, WScale(50), ScreenW/2, WScale(38));
            [SNTool setTextColor:onlineLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(6, onlineLab.text.length-6) AndColor:BLACKCOLOR];
            
            
            
            UILabel *eduPayLab =[UILabel labelWithText:[NSString stringWithFormat:@"额度支付金额\n￥%.2f",self.detailModel.lineAmt] font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
            eduPayLab.frame =CGRectMake(ScreenW/2, WScale(50), ScreenW/2, WScale(38));
            [SNTool setTextColor:eduPayLab FontNumber:DR_BoldFONT(18) AndRange:NSMakeRange(6, eduPayLab.text.length-6) AndColor:BLACKCOLOR];
        }
    }
    else if ([[_isOpenArr objectAtIndex:section] isEqualToString:@"close"]) {
        button.selected=NO;
        sectionBackView.frame =CGRectMake(0, WScale(5), ScreenW, WScale(50));
        
       
        
//        UILabel *payNameLab =[UILabel labelWithText:@"您需支付金额" font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
//               payNameLab.frame =CGRectMake(0, WScale(70), ScreenW/2, WScale(12));
//
//        UILabel *payNameLab =[UILabel labelWithText:@"您需支付金额" font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
//               payNameLab.frame =CGRectMake(0, WScale(70), ScreenW/2, WScale(12));
//
//        UILabel *payNameLab =[UILabel labelWithText:@"您需支付金额" font:DR_FONT(12) textColor:BLACKCOLOR backGroundColor:CLEARCOLOR textAlignment:1 superView:sectionBackView];
//               payNameLab.frame =CGRectMake(0, WScale(70), ScreenW/2, WScale(12));
        
        
        
        
        
    }
    
    return sectionBackView;
}
//区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return HScale(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSString*  state=[self.isOpenArr objectAtIndex:section];
    if ([state isEqualToString:@"open"]) {
        // NSString*  key=[self.dataDict.allKeys objectAtIndex:section];
        //   NSArray*  arr=[self.dataDict objectForKey:key];
        if (self.fatherStatus==0) {
            
            return WScale(220);
        }
        return WScale(118);

    }
    return WScale(50);
}

-(void)ClickSection:(UIButton*)sender
{
    NSString*  state=[self.isOpenArr objectAtIndex:sender.tag-100];
    if ([state isEqualToString:@"open"]) {
        state=@"close";
    }else
    {
        state=@"open";
    }
    self.isOpenArr[sender.tag-100]=state;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:sender.tag-100];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}
@end
