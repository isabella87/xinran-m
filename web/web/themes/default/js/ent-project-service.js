"use strict";

var AllEntProjectService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/all?pn=' + page.pn);
};
Object.extends(AllEntProjectService, Sys.service.BaseService);
Sys.service.register('AllEntProjectService', AllEntProjectService);

var EntProjectDetailService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/'+dInfo.pId+'/'+dInfo.hash);
};
Object.extends(EntProjectDetailService, Sys.service.BaseService);
Sys.service.register('EntProjectDetailService', EntProjectDetailService);

var EntProjectInvestsService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-invests/'+iInfo.pId);
};
Object.extends(EntProjectInvestsService, Sys.service.BaseService);
Sys.service.register('EntProjectInvestsService', EntProjectInvestsService);

//工程概况 信息 ； 项目经理 信息    也在此服务中获取
var PrjEngService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-engineer/'+prjEngInfo.pId);
};
Object.extends(PrjEngService, Sys.service.BaseService);
Sys.service.register('PrjEngService', PrjEngService);

// 借款人-机构信息
var PrjBorrowerOrgService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-mgr-org/'+prjBorrowerInfo.pId);
};
Object.extends(PrjBorrowerOrgService, Sys.service.BaseService);
Sys.service.register('PrjBorrowerOrgService', PrjBorrowerOrgService);

// 借款人-个人信息
var PrjBorrowerService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-mgr/'+prjBorrowerInfo.pId);
};
Object.extends(PrjBorrowerService, Sys.service.BaseService);
Sys.service.register('PrjBorrowerService', PrjBorrowerService);

//项目业主 信息
var PrjOwnerService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-owner/'+prjOwnerInfo.pId);
};
Object.extends(PrjOwnerService, Sys.service.BaseService);
Sys.service.register('PrjOwnerService', PrjOwnerService);

//担保措施 -机构 信息
var PrjGuaraOrgService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-guaran-org/'+prjGuaraInfo.pId);
};
Object.extends(PrjGuaraOrgService, Sys.service.BaseService);
Sys.service.register('PrjGuaraOrgService', PrjGuaraOrgService);

//担保措施 -个人 信息
var PrjGuaraService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-guaran-person/'+prjGuaraInfo.pId);
};
Object.extends(PrjGuaraService, Sys.service.BaseService);
Sys.service.register('PrjGuaraService', PrjGuaraService);

var PrjRatingService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-rating/'+prjRatingInfo.pId);
};
Object.extends(PrjRatingService, Sys.service.BaseService);
Sys.service.register('PrjRatingService', PrjRatingService);

var PrjRepayPlanService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-repay-plan/'+prjRepayPlanInfo.pId);
};
Object.extends(PrjRepayPlanService, Sys.service.BaseService);
Sys.service.register('PrjRepayPlanService', PrjRepayPlanService);

var PrjProcessService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-progress/'+prjProcessInfo.pId);
};
Object.extends(PrjProcessService, Sys.service.BaseService);
Sys.service.register('PrjProcessService', PrjProcessService);

var PrjRemarkService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-remark/'+prjRemarkInfo.pId);
};
Object.extends(PrjRemarkService, Sys.service.BaseService);
Sys.service.register('PrjRemarkService', PrjRemarkService);

//施工单位 信息
var PrjCtorService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-ctor-org/'+prjCtorInfo.pId);
};
Object.extends(PrjCtorService, Sys.service.BaseService);
Sys.service.register('PrjCtorService', PrjCtorService);


//借款人-个人平台信用记录
var PrjMgrCreditsService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-mgr-credits/'+mgrCaInfo.pId,{bpmid : mgrCaInfo.bpmid});
};
Object.extends(PrjMgrCreditsService, Sys.service.BaseService);
Sys.service.register('PrjMgrCreditsService', PrjMgrCreditsService);

//借款人-机构平台信用记录
var PrjMgrCreditsOrgService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/prj-mgr-org-credits/'+mgrCaInfo.pId,{bpmid : mgrCaInfo.bpmid});
};
Object.extends(PrjMgrCreditsOrgService, Sys.service.BaseService);
Sys.service.register('PrjMgrCreditsOrgService', PrjMgrCreditsOrgService);

//核实列表
var CertsListService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/files/list',certsInfo);
};
Object.extends(CertsListService, Sys.service.BaseService);
Sys.service.register('CertsListService', CertsListService);

//核实列表-项目经理
var PrjMgrCertsListService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/files/list',mgrCertsInfo);
};
Object.extends(PrjMgrCertsListService, Sys.service.BaseService);
Sys.service.register('PrjMgrCertsListService', PrjMgrCertsListService);

//旧核实列表服务-可去掉
/*var PrjMgrCertsService = function() {
	var url = mgrCertsInfo.type==28?'/project/prj-mgr-certs':'/project/prj-ctor-certs';
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+url,mgrCertsInfo);
};
Object.extends(PrjMgrCertsService, Sys.service.BaseService);
Sys.service.register('PrjMgrCertsService', PrjMgrCertsService);
*/

