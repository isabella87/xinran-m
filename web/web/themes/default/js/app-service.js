"use strict";

var AppAccountService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/account');
};
Object.extends(AppAccountService, Sys.service.BaseService);
Sys.service.register('AppAccount', AppAccountService);

var AppAccMsgListService = function() {
	Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/account/msg/list?pn='+accMsgListInfo.curr);
}
Object.extends(AppAccMsgListService, Sys.service.BaseService);
Sys.service.register('AppAccMsgList', AppAccMsgListService);

var AppAccMsgDetailService = function() {
	Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/account/msg/detail',accMsgDetailInfo);
}
Object.extends(AppAccMsgDetailService, Sys.service.BaseService);
Sys.service.register('AppAccMsgDetail', AppAccMsgDetailService);

var AppAccMsgService = function() {
	Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/account/msg',accMsgDetailInfo,'POST');
}
Object.extends(AppAccMsgService, Sys.service.BaseService);
Sys.service.register('AppAccMsgService', AppAccMsgService);

var AppJxPayInfo = function() {
    Sys.service.BaseService.call(this,Sys.config.appSrvUrl+  '/trans/user-info','GET');
};
Object.extends(AppJxPayInfo, Sys.service.BaseService);
Sys.service.register('AppJxPayInfo', AppJxPayInfo);

//判断是否设置过密码
var AppJxPayPwdStatus = function() {
    Sys.service.BaseService.call(this,Sys.config.appSrvUrl+  '/trans/third-pwd','GET');
};
Object.extends(AppJxPayPwdStatus, Sys.service.BaseService);
Sys.service.register('AppJxPayPwdStatus', AppJxPayPwdStatus);

//取江西银行返回的账户余额和账户可用余额
//我的朋友圈-投标明细页面的账户可用余额  传auId也合并调用此服务
var AppJxPayAccBalance = function(jxPayAccInfo) {
	jxPayAccInfo = $.extend({ auId: 0 }, jxPayAccInfo);
	if (jxPayAccInfo.auId) {
		Sys.service.BaseService.call(this, Sys.config.appSrvUrl + '/trans/account-balance', {'au-id' : jxPayAccInfo.auId}, 'GET');
	} else {
		Sys.service.BaseService.call(this, Sys.config.appSrvUrl + '/trans/account-balance', null, 'GET');
	}
};
Object.extends(AppJxPayAccBalance, Sys.service.BaseService);
Sys.service.register('AppJxPayAccBalance', AppJxPayAccBalance);

var AppDirectRechargeService = function() {
    Sys.service.BaseService.call(this,Sys.config.appSrvUrl+  '/trans/direct-recharge',jxPayAuthInfo,'GET');
};
Object.extends(AppDirectRechargeService, Sys.service.BaseService);
Sys.service.register('AppDirectRechargeService', AppDirectRechargeService);

var AppWithdrawService = function() {
    Sys.service.BaseService.call(this,Sys.config.appSrvUrl+  '/trans/withdraw',jxPayWithdrawInfo,'GET');
};
Object.extends(AppWithdrawService, Sys.service.BaseService);
Sys.service.register('AppWithdrawService', AppWithdrawService);

//设置密码
var AppJxPayPwdSet = function() {
    Sys.service.BaseService.call(this,Sys.config.appSrvUrl+  '/trans/third-pwd',jxPayPwdSetInfo,'POST');
};
Object.extends(AppJxPayPwdSet, Sys.service.BaseService);
Sys.service.register('AppJxPayPwdSet', AppJxPayPwdSet);

var AppTsCreditAssignService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/trans/credit-in',tsCreditAssInfo,'POST');
};
Object.extends(AppTsCreditAssignService, Sys.service.BaseService);
Sys.service.register('AppTsCreditAssignService', AppTsCreditAssignService);

var AppTenderService = function() {
    Sys.service.BaseService.call(this,Sys.config.appSrvUrl+  '/trans/tender', tsTender , 'POST');
};
Object.extends(AppTenderService, Sys.service.BaseService);
Sys.service.register('AppTenderService', AppTenderService);

var AppWyjkReg1Service = function() {
    Sys.service.BaseService.call(this,Sys.config.appSrvUrl+'/wyjk/create-finacier', wyjkParam, 'PUT');
};
Object.extends(AppWyjkReg1Service, Sys.service.BaseService);
Sys.service.register('AppWyjkReg1', AppWyjkReg1Service);

var AppWyjkReg2Service = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/wyjk/update-fina-pro-info/'+wyjkParam.fid, wyjkParam, 'POST');
};
Object.extends(AppWyjkReg2Service, Sys.service.BaseService);
Sys.service.register('AppWyjkReg2', AppWyjkReg2Service);

var AppWyjkReg3Service = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/wyjk/update-fina-info/'+wyjkParam.fid, wyjkParam, 'POST');
};
Object.extends(AppWyjkReg3Service, Sys.service.BaseService);
Sys.service.register('AppWyjkReg3', AppWyjkReg3Service);

var AppInfoAllService = function(){
	Sys.service.BaseService.call(this,Sys.config.appSrvUrl+'/info/' + infoParam.type + '/all?pn='+infoParam.pn);
};
Object.extends(AppInfoAllService,Sys.service.BaseService);
Sys.service.register('AppInfoAll',AppInfoAllService);

var AppInfoViewService = function(){
	Sys.service.BaseService.call(this,Sys.config.appSrvUrl+'/info/'+ info.id + '/' + info.hash);
};
Object.extends(AppInfoViewService,Sys.service.BaseService);
Sys.service.register('AppInfoView',AppInfoViewService);

var AppEntProjectDetailService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/'+dInfo.pId+'/'+dInfo.hash);
};
Object.extends(AppEntProjectDetailService, Sys.service.BaseService);
Sys.service.register('AppEntProjectDetailService', AppEntProjectDetailService);

var AppPrjEngService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-engineer/'+prjEngInfo.pId);
};
Object.extends(AppPrjEngService, Sys.service.BaseService);
Sys.service.register('AppPrjEngService', AppPrjEngService);

var AppPrjMgrService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-mgr/'+prjMgrInfo.pId);
};
Object.extends(AppPrjMgrService, Sys.service.BaseService);
Sys.service.register('AppPrjMgrService', AppPrjMgrService);

var AppPrjOwnerService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-owner/'+prjOwnerInfo.pId);
};
Object.extends(AppPrjOwnerService, Sys.service.BaseService);
Sys.service.register('AppPrjOwnerService', AppPrjOwnerService);

var AppPrjGuaraService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-guaran-infos/'+prjGuaraInfo.pId);
};
Object.extends(AppPrjGuaraService, Sys.service.BaseService);
Sys.service.register('AppPrjGuaraService', AppPrjGuaraService);

var AppPrjRatingService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-rating/'+prjRatingInfo.pId);
};
Object.extends(AppPrjRatingService, Sys.service.BaseService);
Sys.service.register('AppPrjRatingService', AppPrjRatingService);

var AppPrjRepayPlanService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-repay-plan/'+prjRepayPlanInfo.pId);
};
Object.extends(AppPrjRepayPlanService, Sys.service.BaseService);
Sys.service.register('AppPrjRepayPlanService', AppPrjRepayPlanService);

var AppPrjProcessService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-progress/'+prjProcessInfo.pId);
};
Object.extends(AppPrjProcessService, Sys.service.BaseService);
Sys.service.register('AppPrjProcessService', AppPrjProcessService);

var AppPrjRemarkService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-remark/'+prjRemarkInfo.pId);
};
Object.extends(AppPrjRemarkService, Sys.service.BaseService);
Sys.service.register('AppPrjRemarkService', AppPrjRemarkService);

var AppPrjCtorService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/project/prj-ctor-org/'+prjCtorInfo.pId);
};
Object.extends(AppPrjCtorService, Sys.service.BaseService);
Sys.service.register('AppPrjCtorService', AppPrjCtorService);

var AppCaDetailService = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/creditassign/'+caDetailInfo.id+'/'+caDetailInfo.hash);
};
Object.extends(AppCaDetailService, Sys.service.BaseService);
Sys.service.register('AppCaDetailService', AppCaDetailService);

var AppCaRepayPlan = function() {
    Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/creditassign/prj-repay-plan/'+caRepayPlan.pId);
};
Object.extends(AppCaRepayPlan, Sys.service.BaseService);
Sys.service.register('AppCaRepayPlan', AppCaRepayPlan);

var AppFileService = function(){
	Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/files/list', fileInfo);
}
Object.extends(AppFileService, Sys.service.BaseService);
Sys.service.register('AppFileService', AppFileService);

var AppSuggestionService = function(){
	Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/files/list', sugInfo);
}
Object.extends(AppSuggestionService, Sys.service.BaseService);
Sys.service.register('AppSuggestionService', AppSuggestionService);

var AppPrjRelatedService = function(){
	Sys.service.BaseService.call(this, Sys.config.appSrvUrl+'/files/list', prjRelatedInfo);
}
Object.extends(AppPrjRelatedService, Sys.service.BaseService);
Sys.service.register('AppPrjRelatedService', AppPrjRelatedService);


