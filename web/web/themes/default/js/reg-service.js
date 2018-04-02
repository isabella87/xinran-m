"use strict";
/*var RcodeService = function(){
	Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+"/reg/rcode","GET");
};
Object.extends(RcodeService,Sys.service.BaseService);
Sys.service.register('RcodeService',RcodeService);*/

var SendMobileCodeService = function(){
	Sys.service.BaseService.call(this,Sys.config.accSrvUrl+"/reg/send-user-mobile-code",userParam,"PUT");
};
Object.extends(SendMobileCodeService,Sys.service.BaseService);
Sys.service.register('SendMobileCodeService',SendMobileCodeService);

var RegisterStep1Service = function(){
	Sys.service.BaseService.call(this,Sys.config.accSrvUrl+'/reg/validate-mobile-code',regParam,'POST');
};
Object.extends(RegisterStep1Service,Sys.service.BaseService);
Sys.service.register('RegisterStep1',RegisterStep1Service);

var RegisterStep2Service = function(){
	Sys.service.BaseService.call(this,Sys.config.accSrvUrl+'/reg/register-person',regParam,'PUT');
};
Object.extends(RegisterStep2Service,Sys.service.BaseService);
Sys.service.register('RegisterStep2',RegisterStep2Service);