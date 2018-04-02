var TopCaProjectService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/project/top-credit-assigns');
};
Object.extends(TopCaProjectService, Sys.service.BaseService);
Sys.service.register('TopCaProjectService', TopCaProjectService);

var AllCaService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/creditassign/all?pn='+caPageInfo.curr);
};
Object.extends(AllCaService, Sys.service.BaseService);
Sys.service.register('AllCaService', AllCaService);

var CaDetailService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/creditassign/'+caDetailInfo.id+'/'+caDetailInfo.hash);
};
Object.extends(CaDetailService, Sys.service.BaseService);
Sys.service.register('CaDetailService', CaDetailService);

var CaRepayPlan = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/creditassign/prj-repay-plan/'+caRepayPlan.pId);
};
Object.extends(CaRepayPlan, Sys.service.BaseService);
Sys.service.register('CaRepayPlan', CaRepayPlan);

var TsCreditAssignService = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/trans/credit-in',tsCreditAssInfo,'POST');
};
Object.extends(TsCreditAssignService, Sys.service.BaseService);
Sys.service.register('TsCreditAssignService', TsCreditAssignService);

