"use strict";

var WyjkReg1Service = function() {
    Sys.service.BaseService.call(this,Sys.config.p2pSrvUrl+'/wyjk/create-finacier', wyjkParam, 'PUT');
};
Object.extends(WyjkReg1Service, Sys.service.BaseService);
Sys.service.register('WyjkReg1', WyjkReg1Service);

var WyjkReg2Service = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/wyjk/update-fina-pro-info/'+wyjkParam.fid, wyjkParam, 'POST');
};
Object.extends(WyjkReg2Service, Sys.service.BaseService);
Sys.service.register('WyjkReg2', WyjkReg2Service);

var WyjkReg3Service = function() {
    Sys.service.BaseService.call(this, Sys.config.p2pSrvUrl+'/wyjk/update-fina-info/'+wyjkParam.fid, wyjkParam, 'POST');
};
Object.extends(WyjkReg3Service, Sys.service.BaseService);
Sys.service.register('WyjkReg3', WyjkReg3Service);