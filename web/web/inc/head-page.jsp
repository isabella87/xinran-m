<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>

<header> 
  <a href="javascript:toIndex();" class="ban_logo">
  	<a:img src="ban_logo.png"/>
  	<div class="ban_slogan">上海萌承电子科技有限公司</div>
  </a>
  <nav class="bm_nav_r"></nav>
  
</header>
<div class="bm_less_head2"  style="display: none;">
   <div class="bm_hao_name">
	    <a id="topMsgA" href="javascript:void(0);" class="ban_top_newsicon">
	    	
	    </a>
	  	  登录账号：<a href="../account/account-info.html" class="bm_less_head_info_c">Wangrb</a>
	</div>
</div>
<script type="text/javascript">
var currUBottom = {};

Sys.service.on('Account',function(data,ctx){
	if(data && data.valid){//如果已登录，则开启消息功能
		currUBottom = data;
		//Sys.service.load('PushInfo');
	}
});


//控制页面顶部用户信息处（不是所有页面都有，在common.jsp中定义的全局变量g_showUserInfo 为true的才有）的消息的提醒
Sys.service.on('PushInfo',function(data){
	if(g_showUserInfo){
		if(data&&data.count > 0){
			$('#topMsgA').attr('href',RootPath+'/message/message-list.html')
			.html('<img  src="'+ Sys.evalImageUrl('/ban_news_noread.png') +'"  style="width:22px;height:20px" /><p class="ban_account_msg"><span class="ban_account_msg_t"></span></p>');
		}else{
			$('#topMsgA').attr('href',RootPath+'/message/message-list.html')
			.html('<img src="'+ Sys.evalImageUrl('/ban_news_read.png') +'" style="width:22px;height:20px" />');
		}
	}
	
},false);


</script>
 