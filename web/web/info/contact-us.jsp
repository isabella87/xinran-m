<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>
	<%@include file="../inc/header.jsp"%>
	<div class="bm_content">
		<ul class="bm_chujie_ul bm_geren_ul">
	    	<li><em id="versionNum"><!-- 1.3.1 --></em>版本</li>
	        <li><em>微信号：mengchengkeji</em>官方微信</li>
	        <li><em>weibo.com/mengcheng</em>官方微博</li>
	        <li><em>mengcheng_kj@163.com</em>媒体合作</li>
	        <li style="padding: 1rem 1rem 1.5rem"><em>021-6546-1161<br><dfn>客服工作时间：9:00~21:00</dfn></em>客服电话</li>
	    </ul>
<%@include file="../inc/bottom-page.jsp"%>
	</div>
	<script type="text/javascript">
		g_showUserInfo = false;   // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
		
		$(function(){
			if(typeof myLogin !== 'undefined'){
				var versionN = myLogin.getVersionName();   
				$('#versionNum').html((versionN ? versionN : '1.3.1'));
			} 
		});
	</script>
</body>
</html>
