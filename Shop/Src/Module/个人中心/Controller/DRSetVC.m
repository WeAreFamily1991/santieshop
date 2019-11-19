//
//  DRSetVC.m
//  Shop
//
//  Created by BWJ on 2019/7/22.
//  Copyright © 2019 SanTie. All rights reserved.
//

#import "DRSetVC.h"
#import "SDImageCache.h"

@interface DRSetVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain)UIView *customBackView;
@property (nonatomic,retain) UIButton *sureBtn;
@end

@implementation DRSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"设置";
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
   
    // Do any additional setup after loading the view from its nib.
    [self addFooterView];
   
}
-(void)addFooterView
{
    UIView *backView =[[UIView alloc]initWithFrame:CGRectMake(0, 1, ScreenW, HScale(100))];
    backView.backgroundColor =CLEARCOLOR;
    UIButton *footerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    footerBtn.frame =CGRectMake(2*DCMargin,3*DCMargin, ScreenW-4*DCMargin, HScale(40));
    [footerBtn setTitle:@"申请注销账号" forState:UIControlStateNormal];
    [footerBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    footerBtn.backgroundColor =REDCOLOR;
    footerBtn.layer.cornerRadius =HScale(20);
    footerBtn.layer.masksToBounds =HScale(20);
    footerBtn.titleLabel.font =DR_FONT(15);
    [footerBtn addTarget:self action:@selector(footerClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:footerBtn];
    self.tableView.tableFooterView=backView;
    
}
-(void)addCustomBackView
{
    self.customBackView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.customBackView.backgroundColor =BLACKCOLOR;
    [self.customBackView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backCustom"]]];
    UIView *titleView =[[UIView alloc]initWithFrame:CGRectMake(15, ScreenH/4-64, ScreenW-30, ScreenH/2-64)];
    titleView.backgroundColor =WHITECOLOR;
    titleView.layer.cornerRadius =5;
    titleView.layer.masksToBounds =5;
    [self.customBackView addSubview:titleView];
    UIImageView *titleIMG =[[UIImageView alloc]initWithFrame:CGRectMake(titleView.dc_width/2-10, 10, 20, 20)];
    titleIMG.image =[UIImage imageNamed:@""];
    [titleView addSubview:titleIMG];
    
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(DCMargin, titleIMG.dc_bottom+10, titleView.dc_width-4*DCMargin, 30)];
    titleLab.text =@"三块神铁平台将对以下信息进行审核";
    titleLab.font =DR_BoldFONT(18);
//    titleLab.textAlignment =1;
    titleLab.textColor =BLACKCOLOR;
    [titleView addSubview:titleLab];
    
    
    UILabel *contenLab =[[UILabel alloc]initWithFrame:CGRectMake(DCMargin, titleLab.dc_bottom+10, titleView.dc_width-30, 100)];
    contenLab.text =@" 1.账号当前为有效状态\n 2.账户内无未完成状态订单\n 3.未开通激活店铺\n 4.账户无任何纠纷\n 5.已完成所有金额服务注销或关闭";
    contenLab.font =DR_FONT(13);
    contenLab.numberOfLines =0;
    contenLab.textColor =BLACKCOLOR;
    [titleView addSubview:contenLab];
    
    UIButton *agreeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame =CGRectMake(DCMargin,contenLab.dc_bottom+10, titleView.dc_width-2*DCMargin, HScale(40));
    [agreeBtn setTitle:@"同意放弃账号内所有虚拟资产以及后期任何纠纷和三铁平台无关" forState:UIControlStateNormal];
    agreeBtn.titleLabel.numberOfLines =0;
    [agreeBtn setImage:[UIImage imageNamed:@"Unchecked"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"checked"] forState:UIControlStateSelected];
    [agreeBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    agreeBtn.titleLabel.font =DR_FONT(14);
    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:agreeBtn];
    
    _sureBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame =CGRectMake(2*DCMargin,agreeBtn.dc_bottom+10, (titleView.dc_width-5*DCMargin)/2, HScale(40));
    [_sureBtn setTitle:@"确定申请注销" forState:UIControlStateNormal];
    _sureBtn.titleLabel.numberOfLines =0;
    _sureBtn.backgroundColor =RGBHex(0XFFB3C3);
    [_sureBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    _sureBtn.titleLabel.font =DR_FONT(14);
    [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:_sureBtn];
    
    UIButton *cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame =CGRectMake(titleView.dc_width/2+DCMargin/2,agreeBtn.dc_bottom+10, (titleView.dc_width-5*DCMargin)/2, HScale(40));
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.numberOfLines =0;
    cancelBtn.layer.borderColor =BLACKCOLOR.CGColor;
    cancelBtn.layer.borderWidth =1;
    cancelBtn.backgroundColor =WHITECOLOR;
    [cancelBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    cancelBtn.titleLabel.font =DR_FONT(14);
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cancelBtn];    
    [self.view addSubview:self.customBackView];
}
-(void)agreeBtnClick:(UIButton *)sender
{
    sender.selected =!sender.selected;
    if (sender.selected) {
        _sureBtn.backgroundColor =REDCOLOR;
        _sureBtn.selected =YES;
    }
    else
    {
        _sureBtn.backgroundColor =RGBHex(0XFFB3C3);
        _sureBtn.selected =NO;
    }
}
-(void)sureBtnClick:(UIButton *)sender
{
    if (_sureBtn.selected) {
        NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[[DRUserInfoModel sharedManager].buyerid] forKeys:@[@"buyerId"]];
        [SNAPI postWithURL:@"buyer/cancelBuyer" parameters:dic success:^(SNResult *result) {
            [MBProgressHUD showSuccess:@"申请成功，请等待审核"];
            [self performSelector:@selector(later) withObject:self afterDelay:1];
            [self.customBackView removeFromSuperview];
        } failure:^(NSError *error) {
            [MBProgressHUD showError:error.domain];
        }];
    }
}
-(void)later
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [DRAppManager showLoginView];
}
-(void)cancelBtnClick:(UIButton *)sender
{
    [self.customBackView removeFromSuperview];
}
-(void)footerClick
{
     [self addCustomBackView];
}
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
//                                                                             message:@"确定注销账号吗？"
//                                                                      preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定"
//                                                      style:UIAlertActionStyleDefault
//                                                    handler:^(UIAlertAction * _Nonnull action)
//                              {
//
//                                  NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithObjects:@[[DRUserInfoModel sharedManager].buyerid] forKeys:@[@"buyerId"]];
//                                  [SNAPI postWithURL:@"buyer/cancelBuyer" parameters:dic success:^(SNResult *result) {
//                                      [self.tableView.mj_header beginRefreshing];
//                                  } failure:^(NSError *error) {
//                                      [MBProgressHUD showError:error.domain];
//                                  }];
//                              }];
//    [alertController addAction:action1];
//
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消"
//                                                      style:UIAlertActionStyleCancel
//                                                    handler:nil];
//    //            [action2 setValue:HQColorRGB(0xFF8010) forKey:@"titleTextColor"];
//    [alertController addAction:action2];
//
//    dispatch_async(dispatch_get_main_queue(),^{
//        [self presentViewController:alertController animated:YES completion:nil];
//    });
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellID = @"SNMeViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row==2) {
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else
    {
        cell.accessoryType =UITableViewCellAccessoryNone;
    }
    
    NSArray *titleArr = @[SNStandardString(@"清理缓存"), SNStandardString(@"版本信息"), SNStandardString(@"关于我们")];
    NSArray *imageArr = @[@"icon_fxsb", @"IOCN-cjwt", @"icon_yjfk"];
    
    cell.textLabel.text = titleArr[indexPath.row];
    if (indexPath.row==0) {
//        float size = [[SDImageCache sharedImageCache] getSize];
//        long long kkk = [[DRCacheDataManager sharedManager] cacheDataLength];
//        size = (size + kkk) / 1024 / 1024;
//         cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",size];
    }
  
    cell.imageView.image = [UIImage imageNamed:imageArr[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
    
//        float size = [[SDImageCache sharedImageCache] getSize];
//        long long kkk = [[DRCacheDataManager sharedManager] cacheDataLength];
//        size = (size + kkk) / 1024 / 1024;
//        [self performSelector:@selector(SettingClearDisk:) withObject:[NSString stringWithFormat:@"%.1fM",size] afterDelay:1.0f];
//        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
//        [[SDImageCache sharedImageCache] clearMemory];
//        NSHTTPCookie *cookie;
//        NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        for (cookie in [storage cookies]) {
//            [storage deleteCookie:cookie];
//        }
//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSURL *downloadURL = [fileManager URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        downloadURL = [downloadURL URLByAppendingPathComponent:@"mp4"];
//        [fileManager removeItemAtPath:downloadURL.path error:nil];
//        [MBProgressHUD showMessage:@"请稍候"];
    }
//    [self pushViewControllerWithRow:indexPath.row+1];
}
/** 清除缓存 */
-(void)SettingClearDisk:(NSString *)string {
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:[NSString stringWithFormat:@"成功清除缓存%@",string]];
    [self.tableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
