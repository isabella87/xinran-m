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
<title>班汇通</title>
<a:css />
<a:script />

<script>
var _hmt = _hmt || [];
var mobile = true;
var RootPath = '<%=rootPath%>';
var PortalPath = window.location.href.indexOf('banbank.com') >= 0 ? 'http://www.banbank.com/portal2/': '/portal2/';
</script>
<script type="text/javascript">
	Sys.config.baseSrvUrl = '';
	Sys.config.appSrvUrl = '/appsrv';

	var g_showUserInfo = true; // 定义全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮

	Sys.service.on('AppAccount', function(data, ctx) {
		if (g_showUserInfo) {
			if (data) {
				if (data.valid) {
					if (data.status > 0) {
						$(".bm_less_head").show();
						$(".bm_less_head_info_c").html(data.loginName);
					} else {
						notPass();
					}
				}
			}
		}
	});

	function notPass() {

		Sys.errorDlg('您的班汇通账户尚未通过审核，暂时无法进行账户操作！', null, function() {
			Sys.toUrl(Sys.evalUrl('/login.html'));
		});
	}

</script>
</head>