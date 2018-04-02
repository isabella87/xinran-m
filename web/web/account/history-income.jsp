<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>
<body>
	<%@include file="../inc/header.jsp"%>
	<div class="bm_content">
		<ul class="bm_chujie_ul">
	    	<li><a href="../account/income-in.html"><em class="bm_btn_right">&gt;</em><em>收入</em></a></li>
			<li><a href="../account/income-out.html"><em class="bm_btn_right">&gt;</em><em>支出</em></a></li>
	
	    </ul>
 <%@include file="../inc/bottom-page.jsp"%>
	</div>
	<script type="text/javascript">
		g_showUserInfo = false;   // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
	</script>
</body>
</html>
