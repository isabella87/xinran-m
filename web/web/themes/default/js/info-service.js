"use strict";

var InfoService = function(type) {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/info/' + type + '/top');
};
Object.extends(InfoService, Sys.service.BaseService);

var Info4Service = function() {
    InfoService.call(this, 4);
};
Object.extends(Info4Service, InfoService);
Sys.service.register('Info4', Info4Service);


var InfoAllService = function(){
	Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+'/info/' + infoParam.type + '/all?pn='+infoParam.pn);
};
Object.extends(InfoAllService,Sys.service.BaseService);
Sys.service.register('InfoAll',InfoAllService);

var InfoViewService = function(){
	Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+'/info/'+ info.id + '/' + info.hash);
};
Object.extends(InfoViewService,Sys.service.BaseService);
Sys.service.register('InfoView',InfoViewService);

var IosAppUrlService = function(){
	Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+ '/app/ios-app-url');
}
Object.extends(IosAppUrlService,Sys.service.BaseService);
Sys.service.register('IosAppUrl',IosAppUrlService);
