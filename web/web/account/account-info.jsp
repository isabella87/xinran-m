<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp" %>
<body>
<%@include file="../inc/header.jsp" %>
<div class="bm_content">
    <div id="errMsg" style="display:none;"></div>
	<div id="infoMsg" style="display:none;"></div>
	<div class="mask" id="mask" style="display:none;"></div>
	<ul class="bm_chujie_ul bm_geren_ul" id="accinfoUl">
        
    </ul>
	<div class="bm_button" style="width: 90%; margin: 0 auto"><a href="javascript:logout();" class="ban_btn_tixian">退出登录</a></div>
</div>
 <%@include file="../inc/bottom-page.jsp"%>

<script type="text/javascript">
Sys.service.on('AccInfo',function(data, eCode, eMsg){
	if(eCode === 1){
		toLogin();
		return true;
	}
	
	if(data){
		var html = new Array();
		html.push('<li><em>'+ data.loginName +'</em>登录账号</li>');
		html.push('<li><em>'+ data.realName +'</em>真实姓名</li>');
		//html.push('<li><em>'+ data.idCard +'</em>身份证号</li>');
		html.push('<li><em>'+ data.mobile +'</em>绑定手机</li>');
		
		$("#accinfoUl").html(html.join(''));
	}  
});

</script>
</body>
</html>