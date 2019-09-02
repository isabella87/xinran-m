<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%
	String rootPath = request.getContextPath();
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<link rel="icon" href="<%=rootPath%>/web/favicon.png" />
<link rel="shortcut icon" href="<%=rootPath%>/web/favicon.png" />
<title>石玖科技</title>
<style type="text/css">
  .msgBtn {background-color: #48a3e5;color: #f7f7f7;text-decoration: none;border-radius: 5px;padding: 5px 10px;}
  /*提示或错误信息弹出时的灰色遮罩层*/
  .mask {
	    width:100%;
	    height:100%;
	    background:rgba(0, 0, 0, 0.5);
	    position: fixed;
	    left: 0;
	    top: 0;
	    /* z-index: 1; 这个值放小，就会在最下面 ;当你定义的CSS中有position属性值为absolute、relative或fixed，用z-index此取值方可生效。此属性参数值越大，则被层叠在最上面。*/
      }
</style>
<a:css />
<a:script />
<script>
var mobile = true;
var RootPath = '<%=rootPath%>';
var PortalPath = window.location.href.indexOf('19shijiu.com') >= 0 ? 'http://www.19shijiu.com/xinran/': '/xinran/';
</script>
<script type="text/javascript">
	Sys.config.baseSrvUrl = '';
	Sys.config.xrSrvUrl = '/xrsrv';

	var g_showUserInfo = true; // 定义全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
	
	//==百度统计 ==代码开始=====
	var _hmt = _hmt || [];
	$(function() {
		  var hm = document.createElement("script");
		  hm.src = "//hm.baidu.com/hm.js?4e784b28212f48516f10abdafc40dd1c";
		  var bd = document.getElementsByTagName("body")[0]; 
		  bd.appendChild(hm);
	});
	//====百度统计 结束===

	Sys.service.on('Account', function(data, ctx) {
		if (g_showUserInfo) {
			if (data) {
				if (data.valid) {
					if (data.status >= 0 && data.status !== 99) {
						$(".bm_less_head2").show();
						$(".bm_less_head_info_c").html(data.loginName);
					} else {
						notPass();
					}
				}
			}
		}
	});

	Sys.service.on('SignOut', function(data) {
		window.location.assign(Sys.evalUrl("/login.html"));
	}, false);

	////////////////////////////////////////
	//All private functions
	////////////////////////////////////////

	function logout() {
		if(typeof myLogin !== 'undefined'){
			
			myLogin.logouts();
		}
		Sys.service.load('SignOut');
	}

	function toLogin() {
        window.location.assign(Sys.evalUrl('/login.html'));
	}

	function notPass() {
		window.location.assign(Sys.evalUrl('/login.html'));
	}

	function toIndex() {
		window.location.assign(Sys.evalUrl('/index.html'));
	}

	function toRegJX() {
		window.self.location.assign(Sys.evalUrl('/account/apply-jxpay-info.html'));
	}
</script>

</head>