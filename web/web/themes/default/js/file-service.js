"use strict";

var FileService = function(){
	Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/files/list', fileInfo);
}
Object.extends(FileService, Sys.service.BaseService);
Sys.service.register('FileService', FileService);

var SuggestionService = function(){
	Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/files/list', sugInfo);
}
Object.extends(SuggestionService, Sys.service.BaseService);
Sys.service.register('SuggestionService', SuggestionService);

var PrjRelatedService = function(){
	Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/files/list', prjRelatedInfo);
}
Object.extends(PrjRelatedService, Sys.service.BaseService);
Sys.service.register('PrjRelatedService', PrjRelatedService);

