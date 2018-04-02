"use strict";
//取江西银行返回的账户余额和账户可用余额
//我的朋友圈-投标明细页面的账户可用余额  传auId也合并调用此服务
var JxPayAccBalance = function(jxPayAccInfo) {
	jxPayAccInfo = $.extend({ auId: 0 }, jxPayAccInfo);
	if (jxPayAccInfo.auId) {
		Sys.service.BaseService.call(this, Sys.config.accSrvUrl + '/trans/account-balance', {'au-id' : jxPayAccInfo.auId}, 'GET');
	} else {
		Sys.service.BaseService.call(this, Sys.config.accSrvUrl + '/trans/account-balance', null, 'GET');
	}
};
Object.extends(JxPayAccBalance, Sys.service.BaseService);
Sys.service.register('JxPayAccBalance', JxPayAccBalance);

//判断是否设置过密码
var JxPayPwdStatus = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+  '/trans/third-pwd','GET');
};
Object.extends(JxPayPwdStatus, Sys.service.BaseService);
Sys.service.register('JxPayPwdStatus', JxPayPwdStatus);

//取江西银行电子账户号和账户名称
var JxPayCardInfo = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+  '/trans/user-card-info','GET');
};
Object.extends(JxPayCardInfo, Sys.service.BaseService);
Sys.service.register('JxPayCardInfo', JxPayCardInfo);

//取江西银行绑定卡号的信息
var JxPaySignCardInfo = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+  '/trans/bind-card','GET');
};
Object.extends(JxPaySignCardInfo, Sys.service.BaseService);
Sys.service.register('JxPaySignCardInfo', JxPaySignCardInfo);

//取江西银行开户的信息(查询慢，改为前台取电子账户号和绑定卡号分开服务调用)
var JxPayInfo = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+  '/trans/user-info','GET');
};
Object.extends(JxPayInfo, Sys.service.BaseService);
Sys.service.register('JxPayInfo', JxPayInfo);

var RegJxPanSendMobileCode = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+'/trans/send-mobile-code',RegJxPanSendMobileCodeInfo,'PUT');
};
Object.extends(RegJxPanSendMobileCode, Sys.service.BaseService);
Sys.service.register('RegJxPanSendMobileCode', RegJxPanSendMobileCode);

var RegJxPayInfoService = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+RegJxPayInfo.action,RegJxPayInfo.param,RegJxPayInfo.method.toUpperCase());
};
Object.extends(RegJxPayInfoService, Sys.service.BaseService);
Sys.service.register('RegJxPayInfoService', RegJxPayInfoService);

//设置密码
var JxPayPwdSet = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+  '/trans/third-pwd',jxPayPwdSetInfo,'POST');
};
Object.extends(JxPayPwdSet, Sys.service.BaseService);
Sys.service.register('JxPayPwdSet', JxPayPwdSet);

var BindCardService = function(){
	Sys.service.BaseService.call(this,Sys.config.accSrvUrl + '/trans/bind-card',jxPayBindCardInfo,'POST');
}
Object.extends(BindCardService,Sys.service.BaseService);
Sys.service.register('BindCardService',BindCardService);

var UnbindCardService = function(){
	Sys.service.BaseService.call(this,Sys.config.accSrvUrl + '/trans/bind-card',jxPayUnbindCardInfo,'POST');
}
Object.extends(UnbindCardService,Sys.service.BaseService);
Sys.service.register('UnbindCardService',UnbindCardService);

/*var ChinaPayAuthService = function() {
    Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+  '/trans/pre-recharge',jxPayAuthInfo,'POST');
};
Object.extends(ChinaPayAuthService, Sys.service.BaseService);
Sys.service.register('ChinaPayAuthService', ChinaPayAuthService);

var DoRechargeService = function() {
    Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+  '/trans/call-back-recharge',jxPayDoRechargeInfo,'POST');
};
Object.extends(DoRechargeService, Sys.service.BaseService);
Sys.service.register('DoRechargeService', DoRechargeService);*/

var DirectRechargeService = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+  '/trans/direct-recharge',jxPayAuthInfo,'GET');
};
Object.extends(DirectRechargeService, Sys.service.BaseService);
Sys.service.register('DirectRechargeService', DirectRechargeService);

var WithdrawService = function() {
    Sys.service.BaseService.call(this,Sys.config.accSrvUrl+  '/trans/withdraw',jxPayWithdrawInfo,'GET');
};
Object.extends(WithdrawService, Sys.service.BaseService);
Sys.service.register('WithdrawService', WithdrawService);

var TenderService = function() {
    Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+  '/trans/tender', tsTender , 'POST');
};
Object.extends(TenderService, Sys.service.BaseService);
Sys.service.register('TenderService', TenderService);










