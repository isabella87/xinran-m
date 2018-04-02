"use strict";

var AccMsgListService = function() {
	Sys.service.BaseService.call(this, Sys.config.accSrvUrl+'/account/msg/list?pn='+accMsgListInfo.pn);
}
Object.extends(AccMsgListService, Sys.service.BaseService);

Sys.service.register('AccMsgList', AccMsgListService);

var AccMsgDetailService = function() {
	Sys.service.BaseService.call(this, Sys.config.accSrvUrl+'/account/msg/detail',accMsgDetailInfo);
}
Object.extends(AccMsgDetailService, Sys.service.BaseService);

Sys.service.register('AccMsgDetail', AccMsgDetailService);

var AccMsgService = function() {
	Sys.service.BaseService.call(this, Sys.config.accSrvUrl+'/account/msg',accMsgDetailInfo,'POST');
}
Object.extends(AccMsgService, Sys.service.BaseService);

Sys.service.register('AccMsgService', AccMsgService);

var PushInfoService = function() {
    Sys.service.BaseService.call(this, Sys.config.accSrvUrl+'/account/msg/push-info');
};
Object.extends(PushInfoService, Sys.service.BaseService);
Sys.service.register('PushInfo', PushInfoService);