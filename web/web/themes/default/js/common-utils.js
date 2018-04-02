//var _JsCurrDate = new Date();
var EventUtil = {

    addHandler: function(element, type, handler){
        if (element.addEventListener){
            element.addEventListener(type, handler, false);
        } else if (element.attachEvent){
            element.attachEvent("on" + type, handler);
        } else {
            element["on" + type] = handler;
        }
    },
    
    getButton: function(event){
        if (document.implementation.hasFeature("MouseEvents", "2.0")){
            return event.button;
        } else {
            switch(event.button){
                case 0:
                case 1:
                case 3:
                case 5:
                case 7:
                    return 0;
                case 2:
                case 6:
                    return 2;
                case 4: return 1;
            }
        }
    },
    
    getCharCode: function(event){
        if (typeof event.charCode == "number"){
            return event.charCode;
        } else {
            return event.keyCode;
        }
    },
    
    getClipboardText: function(event){
        var clipboardData =  (event.clipboardData || window.clipboardData);
        return clipboardData.getData("text");
    },
    
    getEvent: function(event){
        return event ? event : window.event;
    },
    
    getRelatedTarget: function(event){
        if (event.relatedTarget){
            return event.relatedTarget;
        } else if (event.toElement){
            return event.toElement;
        } else if (event.fromElement){
            return event.fromElement;
        } else {
            return null;
        }
    
    },
    
    getTarget: function(event){
        return event.target || event.srcElement;
    },
    
    getWheelDelta: function(event){
        if (event.wheelDelta){
            return (client.engine.opera && client.engine.opera < 9.5 ? -event.wheelDelta : event.wheelDelta);
        } else {
            return -event.detail * 40;
        }
    },
    
    preventDefault: function(event){
        if (event.preventDefault){
            event.preventDefault();
        } else {
            event.returnValue = false;
        }
    },

    removeHandler: function(element, type, handler){
        if (element.removeEventListener){
            element.removeEventListener(type, handler, false);
        } else if (element.detachEvent){
            element.detachEvent("on" + type, handler);
        } else {
            element["on" + type] = null;
        }
    },
    
    setClipboardText: function(event, value){
        if (event.clipboardData){
            event.clipboardData.setData("text/plain", value);
        } else if (window.clipboardData){
            window.clipboardData.setData("text", value);
        }
    },
    
    stopPropagation: function(event){
        if (event.stopPropagation){
            event.stopPropagation();
        } else {
            event.cancelBubble = true;
        }
    }

};

(function($) {
	
	$.fn.extend({
		onEnter:function(cb){
			var me = this;
			me.on('keypress',function(e){
				e = EventUtil.getEvent(e);
				var charCode = EventUtil.getCharCode(e);
				var target = EventUtil.getTarget(e);
				if(charCode === 13){
					//cb = cb.bind(EventUtil.getTarget(e));
					cb(target);
					EventUtil.preventDefault(e);
				}
			});
		},
		showInline : function() {
			if(typeof mobile!=undefined){
				$(this).show();
			}else{
				$(this).css({
					"display" : "inline"
				});
			}
			return $(this);
		},
		Scroll : function(opt, callback) {
			
			var line = opt.line||2,p = 1;
			var $this = $(this);
			var count = $this.children().size(),ap = count%line==0?count/line:(count-count%line)/line+1;
			
			var play = function(){
				$this.children().hide();
				
				for(var i = (p-1)*line;i<p*line;i++){
					
					if(p>ap){
						p = 1;i=0;
					}
					$this.children((opt.tagName||'li')+':nth-child('+(i+1)+')').show(opt.speed||100);
					
				}
				p++;
			}
			
			var s = setInterval(play, opt.timer||5000);
			
			$this.hover(function(){
				window.clearInterval(s)
			},function(){
				s = setInterval(play, opt.timer||5000);
			});
			
			if(typeof callback == 'function')
				eval('('+callback+')()');
		},
		validateForm:function(cfg){
			if(!cfg) cfg = {};
			var defaults = {
					boxClass : 'ban_box',
					eBoxClass : 'ban_box_cue',
					errMsg : '<div class="ban_box_cue_arrow"></div><p class="ban_box_cue_p">#[msg]</p>',
					reg : new RegExp("\\#\\[msg\\]","g")
			};
			for(var k in defaults){
				cfg[k] = cfg[k]||defaults[k];
			}
			
			if($(this).is('form')){
				return valForm($(this));
			}else if($(this).is('input')){
				return valField($(this));
			}
			
			function valForm(fObj){
				var inputs = fObj.find('input,textarea,select'),r = true,fErrObj;
				inputs.not(':hidden').each(function(i,d){
					r = valField($(d))&&r;
					if(!fErrObj&&!r){
						fErrObj = $(d);
					}
					if(!r ) {
						$(d).focus();
						return;
					}
				});
				if(!r){
					fErrObj.focus();
				}
				
				return r;
			}
			
			function valField($d){
				
				$d.on('click',function(){
					$(this).parents("."+cfg.boxClass).find('.'+cfg.eBoxClass).hide();
				});
				/*if($d.is('select')){
					$d.on('click',function(){
						$(this).parents("."+cfg.boxClass).find('.'+cfg.eBoxClass).hide();
					});
				}*/
				
				var r = true;
				if($d.prop('readonly')){
					return r;
				}
				if($d.hasClass('_required')&&!valRequired($d)) {r = false;return r;}
				if($d.hasClass('_int')&&!valInt($d)) {r = false;return r;}
				if($d.hasClass('_length')&&!valLength($d)) {r = false;return r;}
				if($d.hasClass('_phone')&&!valPhone($d)) {r = false;return r;}
				if($d.hasClass('_idcard')&&!valIdcard($d)) {r = false;return r;}
				if($d.hasClass('_email')&&!valEmail($d)) {r = false;return r;}
				if($d.hasClass('_same')&&!valSame($d)) {r = false;return r;}
				if($d.hasClass('_blank')&&!valBlank($d)) {r = false;return r;}
				if($d.hasClass('_removeBlank')&&!valRemoveBlank($d)) {r = false;return r;}
				if($d.hasClass('_year')&&!valYear($d)) {r = false;return r;}
				if($d.hasClass('_username')&&!valUserName($d)) {r = false;return r;}
				if($d.hasClass('_integer')&&!valInteger($d)) {r = false;return r;}
				if($d.hasClass('_size')&&!valSize($d)) {r = false;return r;}
				if($d.hasClass('_pwd')&&!valPwd($d)) {r = false;return r;}
				if($d.hasClass('_recommendCode')&&!valRecommendCode($d)) {r = false;return r;}
				if($d.hasClass('_num')&&!valNum($d)) {r = false;return r;}
				return r;
			}
			
			function valNum(obj){
				var val = obj.val(),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				
				//如果没有包含数字则给出提示  
				if(!/^\d\d{15,}$/g.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg, '该字段只能由数字组成,且至少16位数字！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
				
			}
			
			function valPwd(obj){
				var val = obj.val(),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				
				// 1 如果长度不对则给出长度提示(页面上直接加的min 和 max)
				
				// 2 如果没有包含数字则给出提示
				if(!/[0-9]/.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg, '密码必须包含数字')).showInline();
					return false;
				}
				// 3 如果没有包含特殊字符则给出提示
				if(!/[!@#$%\^&*\-+=?<>,./~`()_\\]/.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg, '密码必须包含特殊字符')).showInline();
					return false;
				}
				// 4 如果没有包含字母则给出提示
				if(!/[a-zA-Z]/.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg, '密码必须包含字母')).showInline();
					return false;
				}
				// 5 如果包含其它字符则给出提示
				var invalidChars = /[^0-9a-zA-Z!@#$%\^&*\-+=?<>,./~`()_\\]/.exec(val);
				if (invalidChars) {
					if(invalidChars[0] === " "){
						eBoxObj.html(cfg.errMsg.replace(cfg.reg, '密码不能含有 空格')).showInline();
					}else{
						eBoxObj.html(cfg.errMsg.replace(cfg.reg, '密码不能包含字符：' + invalidChars[0])).showInline();
					}
					return false;
					
				}
				// 6 如果没有以字母或者数字开头则给出提示
				if(!/^[0-9a-zA-Z]/.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg, '密码必须以字母或者数字开头')).showInline();
					return false;
				}
				
				// 7 如果仍然不满足条件则给通用提示，也就是目前的提示。
				if(!/^[0-9a-zA-Z][0-9a-zA-Z!@#$%\^&*\-+=?<>,./~`()_\\]{7,17}$/.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg, '密码必须包含数字、字母和特殊字符且不能含有空格,其中特殊字符包括!@#$%^&*-_\\+=?<>,./~`()')).showInline();
					return false;
				}
				
				eBoxObj.hide();
				return true;
				
			}
			
			function valRecommendCode(obj){
				var val = obj.val(),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				
				if(!/^[0-9a-zA-Z_]*$/g.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'该字段只能由字母、数字组成且不能含有空格！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valSize(obj){
				
				if(!valInteger(obj)){
					return false;
				}
				var val = parseFloat($.trim(obj.val())),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass),min = parseFloat(obj.attr('min')),max = parseFloat(obj.attr('max'));
				
				if(val<min||val>max){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'该字段必须大于'+min+'且小于'+max+'！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valInteger(obj){
				var val = $.trim(obj.val()),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				
				if(!/^[1-9]\d*$/.test(val)&&val!='0'){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'该字段必须是正整数或0！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valUserName(obj){
				var val = $.trim(obj.val()),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				
				if(!/^[\u4e00-\u9fa5a-z0-9_]*$/i.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'该字段必须由字母、数字、下划线或者汉字组成！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valYear(obj){
				
				var val = $.trim(obj.val()),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass),min=0,max=99;
				if(isNaN(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'该字段必须是数字！')).showInline();
					return false;
				}
				val = parseFloat(val);
				if(val<min||val>99){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'该字段必须大于'+min+'且小于'+max+'！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valRemoveBlank(obj){
				
				var val = $.trim(obj.val());
				
				if(val!=''){
					obj.val(val.replace(/\s+/g,''));
				}
				
				return true;
			}
			
			function valBlank(obj){
				
				var val = $.trim(obj.val()),reg = /\s+/g,eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				if(val!=''&&reg.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'该字段不能含有空格！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valSame(obj){
				
				var val = $.trim(obj.val()),label = obj.parents("."+cfg.boxClass).find('label').text(),target = obj.attr('target'),tObj = $("#"+target),tv = $.trim(tObj.val()),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				if(val!=tv){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,label+'不一致！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valEmail(obj){
				var val = $.trim(obj.val()),reg = /\w@\w*\.\w/,eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				if(val!=''&&!reg.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'电子邮箱格式不正确！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			function valIdcard(obj){
				var val = $.trim(obj.val()),reg = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/,eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				/*if(val!=''&&!reg.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'身份证号码格式不正确！')).showInline();
					return false;
				}*/
				if(val!=''&&!IdCardValidate(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'身份证号码格式不正确！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			//只要是 非0开头的11位数字 格式都格式正确
			function valPhone(obj){
				
				var val = $.trim(obj.val()),reg = /^[1-9]\d{10}$/,eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				if(val!=''&&!reg.test(val)){
					eBoxObj.html(cfg.errMsg.replace(cfg.reg,'手机号码格式不正确！')).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valRequired(obj){
				var v = $.trim(obj.val()),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass),tips = "该字段不能为空！";
				
				if(obj.attr('type')&&obj.attr('type').toUpperCase()=='CHECKBOX'){
					var form = obj.parents('form');
					v = $('input[name="'+obj.attr('name')+'"]:checked').length ;
					tips = "该项为必选项！";
				}
				if(!v||v == ''){
					var errMsg = cfg.errMsg.replace(cfg.reg,tips);
					eBoxObj.html(errMsg).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valInt(obj){
				var v = $.trim(obj.val()),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				if(v!=''&&isNaN(v)){
					var errMsg = cfg.errMsg.replace(cfg.reg,'该字段必须为数字！');
					eBoxObj.html(errMsg).showInline();
					return false;
				}
				eBoxObj.hide();
				return true;
			}
			
			function valLength(obj){
				var v = $.trim(obj.val()),eBoxObj = obj.parents("."+cfg.boxClass).find('.'+cfg.eBoxClass);
				if(v!=''&&obj.attr('min')&&obj.attr('max')){
//					if(obj.hasClass('_int')){
//						var max = obj.attr('max'),max = parseFloat(max),min = obj.attr('min'),min = parseFloat(min),v = parseFloat(v);
//						if(v>max || v<min){
//							var errMsg = cfg.errMsg.replace(cfg.reg,'该字段值必须在'+min+'与'+max+'之间！');
//							eBoxObj.html(errMsg).showInline();
//							return false;
//						}
//						
//					}else{
						var max = obj.attr('max'),max = parseFloat(max),min = obj.attr('min'),min = parseFloat(min),v = v.length;
						if(v>max || v<min){
							var errMsg = cfg.errMsg.replace(cfg.reg,'该字段长度必须在'+min+'与'+max+'之间！');
							eBoxObj.html(errMsg).showInline();
							return false;
						}
//					}
				}
				eBoxObj.hide();
				return true;
			}
			
			return false;
		}
	});
	
	var Wi = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1 ];    // 加权因子   
	var ValideCode = [ 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ];            // 身份证验证位值.10代表X   
	function IdCardValidate(idCard) { 
	    idCard = trim(idCard.replace(/ /g, ""));               //去掉字符串头尾空格                     
	    if (idCard.length == 15) {   
	        return isValidityBrithBy15IdCard(idCard);       //进行15位身份证的验证    
	    } else if (idCard.length == 18) {   
	        var a_idCard = idCard.split("");                // 得到身份证数组   
	        if(isValidityBrithBy18IdCard(idCard)&&isTrueValidateCodeBy18IdCard(a_idCard)){   //进行18位身份证的基本验证和第18位的验证
	            return true;   
	        }else {   
	            return false;   
	        }   
	    } else {   
	        return false;   
	    }   
	}   
	/**  
	 * 判断身份证号码为18位时最后的验证位是否正确  
	 * @param a_idCard 身份证号码数组  
	 * @return  
	 */  
	function isTrueValidateCodeBy18IdCard(a_idCard) {   
	    var sum = 0;                             // 声明加权求和变量   
	    if (a_idCard[17].toLowerCase() == 'x') {   
	        a_idCard[17] = 10;                    // 将最后位为x的验证码替换为10方便后续操作   
	    }   
	    for ( var i = 0; i < 17; i++) {   
	        sum += Wi[i] * a_idCard[i];            // 加权求和   
	    }   
	    valCodePosition = sum % 11;                // 得到验证码所位置   
	    if (a_idCard[17] == ValideCode[valCodePosition]) {   
	        return true;   
	    } else {   
	        return false;   
	    }   
	}   
	/**  
	  * 验证18位数身份证号码中的生日是否是有效生日  
	  * @param idCard 18位书身份证字符串  
	  * @return  
	  */  
	function isValidityBrithBy18IdCard(idCard18){   
	    var year =  idCard18.substring(6,10);   
	    var month = idCard18.substring(10,12);   
	    var day = idCard18.substring(12,14);   
	    var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
	    // 这里用getFullYear()获取年份，避免千年虫问题   
	    if(temp_date.getFullYear()!=parseFloat(year)   
	          ||temp_date.getMonth()!=parseFloat(month)-1   
	          ||temp_date.getDate()!=parseFloat(day)){   
	            return false;   
	    }else{   
	        return true;   
	    }   
	}   
	  /**  
	   * 验证15位数身份证号码中的生日是否是有效生日  
	   * @param idCard15 15位书身份证字符串  
	   * @return  
	   */  
	  function isValidityBrithBy15IdCard(idCard15){   
	      var year =  idCard15.substring(6,8);   
	      var month = idCard15.substring(8,10);   
	      var day = idCard15.substring(10,12);   
	      var temp_date = new Date(year,parseFloat(month)-1,parseFloat(day));   
	      // 对于老身份证中的你年龄则不需考虑千年虫问题而使用getYear()方法   
	      if(temp_date.getYear()!=parseFloat(year)   
	              ||temp_date.getMonth()!=parseFloat(month)-1   
	              ||temp_date.getDate()!=parseFloat(day)){   
	                return false;   
	        }else{   
	            return true;   
	        }   
	  }   
	//去掉字符串头尾空格   
	function trim(str) {   
	    return str.replace(/(^\s*)|(\s*$)/g, "");   
	}
	
})(jQuery);


Sys.getFlByType = function(type){
	
	var _GM = {
			1 : [5,6,7,8,9,10,11,13],
			2 : [1,2,3,4,12,14,15,16,17,18,19,20,21],
			3 : [22,23,24,25,26,27,28,29,30,31]
	}
	
	var _fl = null;
	for(var fl in _GM){
		
		$(_GM[fl]).each(function(i){
			if(type==_GM[fl][i]){
				_fl = fl;
			}
		});
	}
	
	return _fl;
}

Sys.getMtByPname = function(pName){
	
	var _GM = {
			//head-page selected class
			'a_portal' : ['/index.html','/index-guid.html?type=1','/index-guid.html?type=2','/index-guid.html?type=3'],
			'a_plist' : ['/worker/soldier-list.html','/worker/soldier-detail.html','/service/apply-service.html'],
			'a_bhb' : ['/bhb/bhb-list.html','/bhb/bhb-view.html'],
			'a_credit' : ['/creditassign/credit-assign-list.html','/creditassign/credit-assign-view.html','/creditassign/to-credit-pay.html'],
			'a_wyjk' : ['/wyjk/wyjk.html','/wyjk/wyjk1.html'],
			'a_tzgl' : ['/info/on-bbs-list.html'],
			'a_ljwm' : ['/info/on-bbs-view.html','/info/on-bbs-list.html?type=4','/info/on-bbs-list.html?type=2','/info/on-bbs-list.html?type=1',
			            '/info/on-bbs-list.html?type=3','/info/on-bbs-list.html?type=14','about15.html','about16.html','about17.html',
			            'about18.html','about19.html','about20.html','about21.html'],
	         
	        //portal   account-left selected class
			'a_accountment' : ['/account/accountment.html'],
			'a_recharge' : ['/account/recharge.html'],
			'a_withdraw' : ['/account/to-withdraw.html'],
			'a_income' : ['/account/income.html'],
			'a_invest' : ['/account/investment.html','/account/project-details.html'], 
			'a_treasure' : ['/account/bhb.html','/account/bhb-details.html','/account/bhb-add-credit-assign.html'],
			'a_credit_assign' : ['/account/credit-assign.html','/account/batch-add-credit-assign.html'],
			'a_account_info' : ['/account/show-org-info.html','/account/edit-account-info.html','/account/account-mobile.html','/account/account-password.html','/account/account-email.html'],
			'a_chpay_account_info' : ['/account/chinapay-info.html','/account/identity-auth.html'],
			'a_invite' : ['/account/invite.html'],
	
			 //vip  account-left selected class
			'a_vip_repayment' : ['/vip/account/repayment.html'],
			'a_vip_income' : ['/vip/account/income.html'],
			'a_vip_borow_pro' : ['/vip/account/borrow-project.html','/vip/account/borrow-details.html'],
			'a_vip_recharge' : ['/vip/account/recharge.html'],
			'a_vip_withdraw' : ['/vip/account/to-withdraw.html'],
			'a_vip_acc_info' : ['/vip/account/show-org-info.html','/vip/account/view-account-info.html','/vip/account/account-password.html'],
			'a_vip_chpay_acc_info' : ['/vip/account/chinapay-info.html'],
	
			 //bhb  account-left selected class
			'a_trade_bhb' : ['/bhb/account/bhb-trade-list.html'],
			'a_trade_password' : ['/bhb/account/account-password.html'],
			'a_bhb_chinpay_info' : ['/bhb/account/chinapay-info.html']
			
	}
	
	var _fl = null;
	for(var fl in _GM){
		
		$(_GM[fl]).each(function(i){
			if(pName&&pName.indexOf(_GM[fl][i])>=0){
				if(pName&&pName.indexOf('/info/on-bbs-view.html?type=22')>=0){
					_fl = '';
				}else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=23')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=24')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=25')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=26')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=27')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=28')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=29')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=30')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=31')>=0){
					_fl = '';
			    }else if(pName&&pName.indexOf('/info/on-bbs-list.html?type=13')>=0){
					_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-list.html?type=11')>=0){
					_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=13')>=0){
					_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=5')>=0){
			    	_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=6')>=0){
					_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=7')>=0){
			    	_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=8')>=0){
			    	_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=9')>=0){
					_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=10')>=0){
			    	_fl = 'a_tzgl';
			    }else if(pName&&pName.indexOf('/info/on-bbs-view.html?type=11')>=0){
			    	_fl = 'a_tzgl';
			    }else{
					_fl = fl;
				}
				
			}
		});
	}
	
	return _fl;
}

Sys.countDownTime = function(ed) {
	/*var currDate = _JsCurrDate;
	if(typeof serverTime === 'function'){
		currDate = serverTime();
	}*/
	//var diff = ed - (currDate.getTime() + new Date().getTime() - _JsCurrDate.getTime());
	var diff = ed - new Date().getTime();
	
	if(diff<=0) return diff;
	
	var days = 0; 
	var hours = 0;
	var minutes = 0;
	var seconds = 0;
	
	if(diff>0){
		days = Math.floor(diff/(24*3600*1000));
		diff = diff%(24*3600*1000)
	}
	
	if(diff>0){
		hours = Math.floor(diff/(3600*1000));
		diff = diff%(3600*1000)
	}
	
	if(diff>0){
		minutes = Math.floor(diff/(60*1000));
		diff = diff%(60*1000)
	}
	
	if(diff>0){
		seconds = Math.floor(diff/1000);
		diff = diff%1000
	}
	
	return { days: days, hours: hours, minutes: minutes, seconds: seconds };
};

/**
 * 剩余时间格式化输出
 */
Sys.formatTime = function(t) {
	
	if(t<=0) return '';
	var s = '';
	if (t.days > 0) {
		s = s + (t.days + '天');
		
		if(t.days>0){
			return s;
		}
	}
	if (t.hours >= 0) {
		if(s==''&&t.hours==0){
			s = '';
		}else{
			s += ((t.hours<10?'0'+t.hours:t.hours) + '时');
		}
	}
	
	if (t.minutes >= 0) {
		if(s==''&&t.minutes==0){
			s = '';
		}else{
			s += ((t.minutes<10?'0'+t.minutes:t.minutes) + '分');
			return s;
		}
	}
	
	if (t.seconds >= 0) {
		if(s==''&&t.seconds==0){
			s = '';
		}else{
			s += ((t.seconds<10?'0'+t.seconds:t.seconds) + '秒');
		}
	}
	
	return s;
	//return (t.days + '天')+(t.hours + '时')+(t.minutes + '分')+(t.seconds + '秒');
}


/**
 * 根据项目的状态ID查询状态显示名称以及按钮的class，返回对象形似：{statusTxt:'',bClassName:''}
 */
Sys.getStatusNameById = function(sId,isInner,fEndTime){
	
	if(isInner){
		return {
			statusTxt : '我要出借',
			bClassName : 'ban_hk_color',
			showCountDown : 'show'
		};
	}
	var o = {
		statusTxt : '',
		bClassName : 'ban_button_default'
	};
	if(sId>=1 && sId<=30){
		o = {
				statusTxt : '即将发布',
				bClassName : 'ban_fb_color',
				showCountDown : 'show'
			};
	}else if(sId==40){
		o = {
				statusTxt : '我要出借',
				bClassName : 'ban_tz_color',
				showCountDown : 'show'
			};
		if(Sys.countDownTime(fEndTime) <= 0){ // 若在募集中status=40但是没有募集满,则我要出借显示为灰色
			o = {
					statusTxt : '我要出借',
					bClassName : 'ban_hk_color',
					showCountDown : 'show'
				};
		}
		
	}else if(sId==50 || sId==60 || sId==70){
		o = {
				statusTxt : '满标',
				bClassName : 'ban_hk_color',
				showCountDown : 'end'
			};
	}else if(sId==80||sId==90){
		o = {
				statusTxt : '还款中',
				bClassName : 'ban_hk_color',
				showCountDown : 'no'
			};
	}else if(sId==999){
		o = {
				statusTxt : '已结清',
				bClassName : 'ban_hk_color',
				showCountDown : 'no'
			};
	}else if(sId==-1){
		o = {
				statusTxt : '流标',
				bClassName : 'ban_hk_color',
				showCountDown : 'no'
			};
	}
	
	return o;
}

Sys.countDown = function(){
	
	setInterval(function(){
		$("._refreshDate").each(function(){
			var extra = $(this).attr('extra');
			if(extra=='end'){
				$(this).html('已截止');
			}else if(extra=='no'){
				$(this).html('');
			}else{
				if(Sys.countDownTime($(this).attr('name')) <= 0){  // 若在募集中status=40但是没有募集满,则显示为已截止
					$(this).html('已截止');
				}else{
					$(this).html(Sys.formatTime(Sys.countDownTime($(this).attr('name'))));
				}
			}
		});
	}, 1000);
}

/**
 * 项目类型映射表
 * project.type 类型： 1，工程贷；2，银票贷；3，商票贷；4，债权转让；6，班汇宝；7，供应贷；8，分销贷；9，个人贷; 10,小微企业贷
 * project.flags 标志位: 1,新手标。8班汇宝专供，16班乐宝（工程贷），32，员工宝（工程贷）; 64 保险。
 */
Sys.ProTypeMapping = function(type,flags,isCredit){
	if(isCredit){
		return {
			name : '债权转让',
			cls : 'ban_zhuan_color',
			firstWord : '转'
		};
	}
	var s = {};
	switch (type) {
		//case 6: //之前服务于班汇宝,已去掉
		case 7 : 
			switch(true){
			case (flags & 0x0001) !== 0 : 
				s = {
					name : '新手标',
					cls :'ban_new_color'
				};
			    break;
			case (flags & 0x0040) !== 0 : 
				s = {
					name : '保险',
					cls :'ban_gong_color'
				};
			    break;
			 default :
				 s = {
					 name : '供应贷',
					 cls : 'ban_gong_color'
				  };
			}
			break;
		case 8 : 
			switch(true){
			case (flags & 0x0001) !== 0 : 
				s = {
					name : '新手标',
					cls :'ban_new_color'
				};
			    break;
			case (flags & 0x0040) !== 0 : 
				s = {
					name : '保险',
					cls :'ban_gong_color'
				};
			    break;
			 default :
				 s = {
						name : '分销贷',
						cls : 'ban_gong_color'
					};
			}
			break;
		case 9 :
			switch(true){
			case (flags & 0x0001) !== 0 : 
				s = {
					name : '新手标',
					cls :'ban_new_color'
				};
			    break;
			case (flags & 0x0040) !== 0 : 
				s = {
					name : '保险',
					cls :'ban_gong_color'
				};
			    break;
			 default :
				 s = {
					 name : '个人贷',
					 cls : 'ban_gong_color'
				 };
			}
			break;
		case 10 :
			switch(true){
			case (flags & 0x0001) !== 0 : 
				s = {
					name : '新手标',
					cls :'ban_new_color'
				};
			    break;
			case (flags & 0x0040) !== 0 : 
				s = {
					name : '保险',
					cls :'ban_gong_color'
				};
			    break;
			 default :
				 s = {
					 name : '小微企业贷',
					 cls : 'ban_gong_color',
					 firstWord : '企'
				 };
			}
			break;
		default:
			switch (true) {
			
			   case (flags & 0x0020) !== 0 : // flag 为32 就是 员工宝
					s = {
						name : '员工宝',
						cls :'ban_yuan_color'
					};
					break;
					
				case (flags & 0x0001) !== 0:
					s = {
						name : '新手标',
						cls :'ban_new_color'
					};
					break;
				case (flags & 0x0040) !== 0 :   // flag 为 64 就是保险
					s = {
						name : '保险',
						cls :'ban_gong_color'
					};
				    break;
				default:
					s = {
						name : '工程贷',
						cls :'ban_gong_color'
					};
			}
		
	}
	return s;
}

/**
 * 用户状态映射表
 */
Sys.UserStatusMapping = {
		0 : '未开户',
		4 : '未实名认证',
		5 : '已实名认证',
		6 : '已绑定提现卡'
}

/**
 * 还款情况状态映射表
 */
Sys.UserBonusMapping = {
		0 : '待还',
		1 : '已还',
		2 : '部分还',
		3 : '逾期',
		4 : '展期'
}

/**
 * 还款日历类型映射表
 */
Sys.BonusMapping = function(type){
	switch(type){
		case 0 :
			return '利息';
		case 1 : 
			return '本金';
		default :
			return '';	
	}
}

/***
 * 性别映射
 */
Sys.getSexNameByType = function(type){
	switch(type){
		case 1 : 
			return '男';
		case 2 : 
			return '女';
		default :
			return '';
	}
}

/**
 * 将long类型的money转换成数组，第一个元素是整数部分，第二个部分是小数部分
 */
Sys.money2Array = function(m){
	
	if(!m) return ['0','00'];
	
	m = Sys.formatNumber(m,true,2);
	m = m.split('.');
	
	return m;
}

/**
 * 跳转到指定页面
 * url 待跳转URL
 * exp 不需要跳转的页面 Array
 * inc 需要跳转的页面 Array，当此项不为null时忽视exp参数
 * **/
Sys.toUrl = function(url,exp,inc){
	var currUrl = window.location.href,toGo = true;
	exp = !!inc?null:exp;
	if(exp){
		$(exp).each(function(i,p){
			if(currUrl.indexOf(p)>=0){
				toGo = false;
			}
		});
	}
	if(inc){
		toGo = false;
		$(inc).each(function(i,p){
			toGo = toGo||currUrl.indexOf(p)>=0
		});
	}
	var currPath = currUrl.substring(0,currUrl.lastIndexOf("/")+1);
	if(currUrl!=Sys.mergeUrl(currPath,url)&&toGo){
		window.location.assign(url);
	}
}

Sys.mergeUrl = function(u1,u2){
	
	var len = 0;
	while(u2.indexOf('../')==0){
		len++;
		u2 = u2.replace('../','');
	}
	u1 = (u1.lastIndexOf('/')==u1.length-1)?u1.substring(0,u1.length-1):u1;
	while(len>0&&u1.indexOf('/')>=0){
		u1 = u1.substring(0,u1.lastIndexOf('/'));
		len--;
	}
	return u1+'/'+u2;
}


Sys.isIE = !+[1,];



Sys.params2JSON = function(){
	
	var r = {},ser = window.location.search,ser = decodeURI(ser);
	if(!ser||ser=='') return null;
	ser = ser.substring(1);
	
	var sArr = ser.split('&');
	$(sArr).each(function(i,str){
		if(str.indexOf('=')>0) {
			var strArr = str.split('=');
			r[strArr[0]] = strArr[1];
		}
	});
	return r;
}

/**
 * 获取剩余天数
 * et 结束时间
 * st 开始时间，为空则为当前时间
 */
Sys.getBorrowDays = function(et,st){
	var currDate = new Date();
	if(typeof serverTime === 'function'){
		currDate = serverTime();
	}
	
	var ct = st || currDate.getTime(),etd = Math.floor(et/(24*3600*1000)),ctd = Math.floor(ct/(24*3600*1000));
	return etd - ctd;
}

/**
 * 根据标价计算借款年利率
 * unpaidAmt 待收本息
 * bj 转让标价
 * daysRemaining 剩余借款天数
 * 转让后年化收益= (债权本金 - 转让标价 + 所有未结利息) ÷ 剩余借款期限×365（天）÷ 转让标价 ×100%，保留两位小数，小数第三位使用四舍五入。
 */
Sys.getLl = function(unpaidAmt,bj,daysRemaining){
	var moneyTemp = unpaidAmt - bj ;
    var v = daysRemaining*bj==0?0:(moneyTemp>=0?(moneyTemp*365*100/(daysRemaining*bj)).toFixed(2):0.00);
    return v;
}
/**
 * 根据折算借款年利率计算标价
 * unpaidAmt 待收本息
 * ll 折算借款年利率
 * daysRemaining 当前剩余还本天数(剩余借款天数)
 */
Sys.getBj = function(unpaidAmt,ll,daysRemaining){
	
	var v = (365*100*unpaidAmt/(daysRemaining*ll+365*100)).toFixed(2);
	return v;
}

/**
 * 根据数字返回协议数组
 */
Sys.getContractsByNum = function(num){
	
	var cts = [{
		name : '出借居间协议',
		//url : '/export/invest_jujian.pdf'
		url : '/portal2/info/invest-jujian.html'
	},{
		name : '借款协议',
		//url : '/export/loan.pdf'
		url : '/portal2/info/invest-loan.html'
	},{
		name : '应收账款质押合同',
		url : '#'
	}];
	
	var numArr = getArrIndex(num),objs = [];
	for(var i=0;i<numArr.length;i++){
		objs.push(cts[numArr[i]]||{});
	}
	return objs;
	
	function getArrIndex(num){
		
		var numArr=[],i=0;
		while(true){
			if(num%2==1) numArr.push(i);
			num = parseInt(num/2);
			i++;
			
			if(num==0){
				break;
			}
		}
		return numArr;
	}
}

function submitJXForm(formId,formParam){
	
	var form = $('#'+formId);
	if(!form||form.length==0){
		throw new Error('Cannot find form[id='+formId+']');
	}
	form.empty();
	if(formParam){
		for(var k in formParam){
			var v = formParam[k];
			if(k === 'FORM_ACTION'){
				form.attr('action',v);
			}else{
				var pIn = $('input[name="'+k+'"]',form);
				if(!pIn||pIn.length==0){
					pIn = $('<input name="'+k+'" type="hidden" />');
					pIn.appendTo(form);
				}
				pIn.val(v);
			}
		}
	}
	
	form.submit();
}

function showJXDialog(title,success,failure){
	dialog({
    	    id: "withdrawDialog",
    	    title: "转到存管银行平台-"+title, 
    	    content: "请您在新打开的存管银行页面进行"+ title +"，"+ title +"完成前请不要关闭该窗口。",
    	    skin: "facebook",
    	    lock: true, 
    	    button: [
    	        {
    	            value: title+"成功",
    	            callback: function(){
    	            	Sys.infoDlg('<span style="font-weight: bold;color: red;">请关闭刚才操作的存管银行支付界面，再进行下一步操作！</span>',null,function(){
    	            		if(success){
    	            			success();
    	            		}
    	            		window.open('','_new').close();
    	            	});
    	            },
    	            autofocus: true
    	        },
    	        {
    	            value: title+"失败",
    	            callback: function () {
    	            	Sys.infoDlg('<span style="font-weight: bold;color: red;">请关闭刚才操作的存管银行支付界面，再进行下一步操作！</span>',null,function(){
    	            		if(failure){
    	            			failure();
    	            		}
    	            		window.open('','_new').close();
    	            	});
    	            }
    	        }
    	    ]
    	}).showModal();
}

Sys.vCodeCountDown = function(btn,maxTime){
	var ct = maxTime||60;
	var t = setInterval(_ct, 1000);
	var btnText = btn.html();
	_ct();
	function _ct(){
		if(ct==0){
			btn.html(btnText).addClass('bm_button_hilite').removeClass('bm_button_default');
			clearInterval(t);
		}else{
			btn.html(ct+'秒后重试').addClass('bm_button_default').removeClass('bm_button_hilite');
		}
		ct--;
	}
}
Sys.formatRate = function(n){
	
	n = Sys.formatNumber(n,true,2);
	n = n.split('.');
	return n[1]=='00'?n[0]:n.join('.');
}

Sys.formatMobile = function(p){
	return p.substring(0,3)+'****'+p.substring(7,11);
}

Sys.isDateInDays = function(t,d){
	var dt = new Date(t);
	var dt2 = new Date(dt.getFullYear(),dt.getMonth(),dt.getDate()+d);
	
	var currDate = new Date();
	if(typeof serverTime === 'function'){
		currDate = serverTime();
	}
	var ct = currDate;
	var ct2 = new Date(ct.getFullYear(),ct.getMonth(),ct.getDate());
	
	return dt2.getTime() > ct2.getTime();
	
}

Sys.getPureDateTime = function(d){
	
	var y = d.getFullYear();
	var m = d.getMonth();
	var d = d.getDate();
	
	return new Date(y,m,d).getTime();
}

Sys.getJxpayResponseCode = function(code){
	switch (code) {
	case '0000':
		return '操作成功';
	case '0001':
		return '脱机认证已提交，请于3个工作日后查询结果';
	case '1111':
		return '未认证';
	case '2222':
		return '认证已提交，正在处理中';
	case '9999':
		return '认证失败,请稍后重试';
	case '9900':
		return '认证失败,请联系发卡行';
	case '9901':
		return '无效的发卡行';
	case '9902':
		return '无效交易';
	case '9903':
		return '无效金额';
	case '9904':
		return '无效卡号';
	case '9905':
		return '客户取消交易';
	case '9906':
		return '无效交易响应';
	case '9907':
		return '此卡已过期';
	case '9908':
		return '密码错误';
	case '9909':
		return '余额不足';
	case '9910':
		return '未开通此功能';
	case '9911':
		return '交易异常,请联系发卡行';
	case '9912':
		return '超出金额限制';
	case '9913':
		return '此卡受限制,请联系发卡行';
	case '9914':
		return '超出取款次数限制';
	case '9915':
		return '超出最大输入密码次数,请联系发卡行';
	case '9916':
		return '交易超时,请重试';
	case '9917':
		return '交易重复,请稍后查询结果';
	case '9918':
		return '密码格式错误';
	case '9919':
		return '银行卡与姓名不符';
	case '9920':
		return '银行卡与证件不符';

	default:
		return '';
	}
	
}

/**
 * 根据type获取资金类型展示名称 、资金字段 以及 描述
 * 0 未知类型，1 充值，2 提现，3 投标放款（放款），4 项目还本（还款），5 投标放款【放款（借款人）】，6 项目还本【还款（借款人）】，7 认购项目（债权转入），8 转让项目（债权转出），
 * 9 项目付息（还息），10 项目付息【还息（借款人）】，12 取消投标（流标），14 服务费（还息手续费),15 融资项目服务费（放款手续费)，18 债权转让手续费（债权转出手续费），21 红包（收到红包)
 */
Sys.getHistoryIncomeItem = function(arType){
	var item = {};
	var instruction = Sys.getDescByArType[arType] ? Sys.getDescByArType[arType] : '未知类型';
	if(arType===1 || arType===4 || arType===5 || arType===8 || arType===9 || arType===21 || arType===12){
		item = {
				name : '收入',
				field: arType===12 ? 'unfrzAmt' : 'creditAmt',
				desc : instruction
		}
	}else if(arType===2 || arType===3 || arType===11 || arType===6 || arType===10 || arType===7 || arType===14 || arType===15 || arType===18){
		item = {
				name : '支出',
				field: arType===11 ? 'frzAmt' : 'debitAmt',
				desc : instruction
		}
	}
	
	return item;
}

//根据arType返回描述
Sys.getDescByArType = {
		0 : '未知类型',
		1 : '充值',
		2 : '提现',
		3 : '投标放款',
		4 : '项目还本',
		5 : '投标放款',
		6 : '项目还本',
		7 : '认购项目',
		8 : '转让项目',
		9 : '项目付息',
		10 : '项目付息',
		11 : '出借项目',
		12 : '取消投标',
		14 : '服务费',
		15 : '融资项目服务费',
		18 : '债权转让手续费',
		21 : '红包'
}

/**
 * 根据不同的类型返回不同的核实列表的名称
 */
Sys.getCertNameByType = function(type){
    var s = {};
    var strImg = "<img src='"+Sys.evalImageUrl('/u301.png')+"' style='width:18px; height:18px' />";
	switch(type){
	   case 22:
			s = {
				type : 22,
				typeName : '保障措施',
				info:[{
	                certId : "1",
	                certName : "保险公司保单",
	                certImg : strImg
	            },{
	                certId : "2",
	                certName : "最高额保函",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "应收账款债权转让合同",
	                certImg : strImg
	            }]
			};
			break;
		case 23:
			s = {
				type : 23,
				typeName : '借款机构',
				info:[{
	                certId : "1",
	                certName : "营业执照",
	                certImg : strImg
	            },
	            {
	            	certId : "2",
	                certName : "税务登记证",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "组织机构代码证",
	                certImg : strImg
	            },
	            {
	            	certId : "4",
	                certName : "法人身份证",
	                certImg : strImg
	            }]
			};
			break;
			
		case 24:
			s = {
				type : 24,
				typeName : '工程概况',
				info:[{
	                certId : "1",
	                certName : "中标通知书",
	                certImg : strImg
	            },
	            {
	            	certId : "2",
	                certName : "项目施工合同",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "施工许可证",
	                certImg : strImg
	            },
	            {
	            	certId : "4",
	                certName : "建设用地规划许可证",
	                certImg : strImg
	            },
	            {
	            	certId : "5",
	                certName : "建设工程规划许可证",
	                certImg : strImg
	            },
	            {
	            	certId : "6",
	                certName : "国有土地使用者",
	                certImg : strImg
	            },
	            {
	            	certId : "7",
	                certName : "商品房销售（预售）许可证",
	                certImg : strImg
	            }]
			};
			break;
			
		case 25:
			s = {
				type : 25,
				typeName : '保障措施',
				info:[{
	                certId : "1",
	                certName : "保险公司保单",
	                certImg : strImg
	            },{
	                certId : "2",
	                certName : "最高额保函",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "应收账款债权转让合同",
	                certImg : strImg
	            }]
			};
			break;
			
		case 26:
			s = {
				type : 26,
				typeName : '项目业主',
				info:[{
	                certId : "1",
	                certName : "营业执照",
	                certImg : strImg
	            },
	            {
	            	certId : "2",
	                certName : "税务登记证",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "组织机构代码证",
	                certImg : strImg
	            },
	            {
	            	certId : "4",
	                certName : "法人身份证",
	                certImg : strImg
	            },
	            {
	            	certId : "5",
	                certName : "企业资质证明文件",
	                certImg : strImg
	            }]
			};
			break;	
	   
		case 27 : 
			s = {
				type : 27,
				typeName : '项目经理',
				info:[{
	                certId : "1",
	                certName : "身份证",
	                certImg : strImg
	            },
	            {
	            	certId : "2",
	                certName : "户籍证明",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "工作单位",
	                certImg : strImg
	            },
	            {
	            	certId : "4",
	                certName : "学历或学位证明",
	                certImg : strImg
	            },
	            {
	            	certId : "5",
	                certName : "从业资格证书",
	                certImg : strImg
	            },
	            {
	            	certId : "6",
	                certName : "企业任命文件",
	                certImg : strImg
	            },
	            {
	            	certId : "7",
	                certName : "项目承包协议",
	                certImg : strImg
	            },
	            {
	            	certId : "8",
	                certName : "人行征信报告",
	                certImg : strImg
	            }]
			};
			break;
			
		case 28:
			s = {
				type : 28,
				typeName : '借款人',
				info:[{
	                certId : "1",
	                certName : "身份证",
	                certImg : strImg
	            },
	            {
	            	certId : "2",
	                certName : "户籍证明",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "房产证",
	                certImg : strImg
	            },
	            {
	            	certId : "4",
	                certName : "结婚证",
	                certImg : strImg
	            },
	            {
	            	certId : "5",
	                certName : "收入证明",
	                certImg : strImg
	            },
	            {
	            	certId : "6",
	                certName : "人行征信报告",
	                certImg : strImg
	            }]
			};
			break;	
			
		case 29:
			s = {
				type : 29,
				typeName : '施工单位',
				info:[{
	                certId : "1",
	                certName : "营业执照",
	                certImg : strImg
	            },
	            {
	            	certId : "2",
	                certName : "组织机构代码证",
	                certImg : strImg
	            },
	            {
	            	certId : "3",
	                certName : "企业资质证明文件",
	                certImg : strImg
	            },
	            {
	            	certId : "4",
	                certName : "法人身份证",
	                certImg : strImg
	            },
	            {
	            	certId : "5",
	                certName : "税务登记证",
	                certImg : strImg
	            }]
			};
			break;	
	}
	
	return s;
	
}

/**
 *通过服务返回的还款方式，和日期，返回不同的显示语
 *repayWays还款方式 ; bonusDay选择的指定日
 */
Sys.getRepayWays = function(repayWays,bonusDay){
	var s = {};
	switch(repayWays){
		case 1:
			s = {
				repayWays : 1,
				showRepayInfo : '放款后第30天为首次还款日，之后每月该日还息'
			};
			break;
		case 2 :
			s = {
				repayWays : 2,
				showRepayInfo : '每月'+ bonusDay +'日还息'
			};
			break;
		default:
			s = {
				repayWays : 3,
				showRepayInfo : '放款后每'+ bonusDay +'天还息'
			};
	}
	return s;
}


