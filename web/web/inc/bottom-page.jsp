<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<ul class="ban_index_bottom_nav">
   	<li class="ban_index_bottom_nav_li ban_m_select_red_color"><div class="ban_m_img_center"><a:img  src="ban_m_home_img.png" /><a:img src="ban_m_home_img_hover.png" style="display: none;" /></div>首页</li>
   
   	<li class="ban_index_bottom_nav_li" ><div class="ban_m_img_center"><a:img src="ban_m_touzi_img.png" /><a:img style="display: none" src="ban_m_touzi_img_hover.png" /></div>点兵点将
       	<%-- <div class="ban_index_bottom_nav_li_a" id="touzi" style="display: none;">
           	<div class="ban_index_bottom_nav_li_spoint"></div>
               <a href="/project/project-list.html" id="prjAbottom" >借款项目</a>
               <a href="/creditassign/credit-assign-list.html" id="creditAboottom" style="border: none">二级市场</a>
       	</div> --%>
       </li>
       
       <li class="ban_index_bottom_nav_li" ><div class="ban_m_img_center"><a:img src="ban_m_zhanghu_img.png" /><a:img style="display: none;" src="ban_m_zhanghu_img_hover.png" /></div>账户中心
       	<div class="ban_zhanghu_img" id="bottomMsgDiv" style="display: none;"><p class="ban_account_msg"><span class="ban_account_msg_t"></span></p></div>
       	<%-- <div class="ban_index_bottom_nav_li_a" id="zhanghu" style="display: none;">
           	<div class="ban_index_bottom_nav_li_spoint"></div>
               <a href="http://mp.weixin.qq.com/mp/video?__biz=MzAwNjAwMDEwOA==&mid=400056852&sn=208dd7ef5adeb247b136b6059ac6fc43&vid=q1300f6gfnn&idx=1&scene=18&pass_ticket=WIt9Z4MMubPEewBKfd7YWx%2FuM1bhFXKzTQspSzw3HQgG3qHJn%2BvL3TKVEvKLmH%2FY" target="_blank" >注册视频</a>
               <a href="/regist-user.html" >注册账户</a>
               <a href="/login.html"  style="border: none">登录账户</a>
           </div> --%>
       </li>
       
       <li class="ban_index_bottom_nav_li" ><div class="ban_m_img_center"><a:img src="ban_m_aboutus_img.png" /><a:img style="display: none;" src="ban_m_aboutus_img_hover.png" /></div>更多
       	<%-- <div class="ban_index_bottom_nav_li_a ban_index_bottom_nav_li_a2" id="women" style="display: none;top:-210px">
           	<div class="ban_index_bottom_nav_li_spoint"></div>
               <a href="/info/about-us.html" >公司简介</a>
               <a href="http://mp.weixin.qq.com/s?__biz=MzAwNjAwMDEwOA==&mid=200315944&idx=1&sn=23b2205687cba08e3a828748f2e42acf&scene=18#rd" >平台价值</a>
               <a href="/info/manager-team.html" >管理团队</a>
               <a href="/info/contact-us.html" style="border: none;color:red">关于</a>
           </div> --%>
       </li>
</ul>
<script type="text/javascript">
var currUBottom = {};

$(function(){
	$('.ban_index_bottom_nav_li').on('click',tabClicked);
	
	$('ul.ban_index_bottom_nav a').each(function(){
		var h = $.trim($(this).attr('href'));
		
		if(h !== '' && h.indexOf('http://') !== 0){
			$(this).attr('href',RootPath + h);
		} 
	});
	
	//控制底部标签的高亮
	initCursor();
	
	//消息功能
	//initMessage();
	
	
});

Sys.service.on('Account',function(data,ctx){
	if(data && data.valid){//如果已登录，则开启消息功能
		currUBottom = data;
		//Sys.service.load('PushInfo');
	}
});

//控制页面底部新消息的提醒
Sys.service.on('PushInfo',function(data,ctx){
	if(data&&data.count > 0){
		$('#bottomMsgDiv').show();
	}else{
		$('#bottomMsgDiv').hide();
	}
},false);

/* //控制页面顶部用户信息处（不是所有页面都有，在common.jsp中定义的全局变量g_showUserInfo 为true的才有）的消息的提醒
Sys.service.on('PushInfo',function(data){
	if(g_showUserInfo){
		if(data&&data.count > 0){
			$('#topMsgA').attr('href',RootPath+'/message/message-list.html')
			.html('<img src="'+ Sys.evalImageUrl('/ban_news_noread.png') +'" style="width:22px;height:20px" /><p class="ban_account_msg"><span class="ban_account_msg_t"></span></p>');
		}else{
			$('#topMsgA').attr('href',RootPath+'/message/message-list.html')
			.html('<img src="'+ Sys.evalImageUrl('/ban_news_read.png') +'" style="width:22px;height:20px" />');
		}
	}
	
},false); */


////////////////////////////////////////
//All private functions
////////////////////////////////////////

function initCursor(){
	var pageNav = [
	               ['index.htm'],
	               ['soldier-list.htm','soldier-detail.htm','apply-service.htm','credit-assign-list.htm','credit-assign-view.htm','to-credit-pay.htm','wyjk.htm'],
	               ['withdraw.htm','recharge.htm','accountment.htm','login.htm','regist-user.htm','invest-zhuce.htm','lost-password.htm','message-list.htm','message-view.htm'
	                ,'account-info.htm','jxpay-info.htm','apply-jxpay-info.htm','bind-card.htm','unbind-card.htm','history-income.htm','income-in.htm','income-out.htm'
	                ,'invest-manager.htm','history-service.htm','serving.htm','history-order.htm','order.htm','credit-assign1.htm','credit-assign2.htm'
	                ,'credit-assign3.htm','add-credit-assign.htm','repay-record.htm'],
	               ['info-list.htm','info-view.htm','about-us.htm','contact-us.htm','manager-team.htm','more-info.htm','know-us.htm','plat-form.htm']];
	var currUrl = window.location.href;
	currUrl = currUrl.indexOf('?') >= 0 ? currUrl.substring(0,currUrl.indexOf('?')) : currUrl;
	for(var i = 0; i < pageNav.length; i++){
		var innerList = pageNav[i];
		for(var j = 0; j < innerList.length; j++){
			if(currUrl.indexOf(innerList[j]) >= 0){
				$('.ban_index_bottom_nav_li:nth-child('+(i+1)+')').find('img:nth-child(2)').show();
				$('.ban_index_bottom_nav_li:nth-child('+(i+1)+')').find('img:nth-child(1)').hide();
				$('.ban_index_bottom_nav_li').removeClass('ban_m_select_red_color');
				$('.ban_index_bottom_nav_li:nth-child('+(i+1)+')').addClass('ban_m_select_red_color');
			}
		}
	}
}

function tabClicked(){
	if($(this).is('.ban_index_bottom_nav_li:first-child')){
		window.location.assign(Sys.evalUrl('/index.html'));
	}
	
	if($(this).is('.ban_index_bottom_nav_li:nth-child(2)')){
		window.location.assign(Sys.evalUrl('/worker/soldier-list.html'));
	}
	
	if($(this).is('.ban_index_bottom_nav_li:nth-child(3)')){
		window.location.assign(Sys.evalUrl('/account/accountment.html'));
	}
	
	if($(this).is('.ban_index_bottom_nav_li:nth-child(4)')){
		window.location.assign(Sys.evalUrl('/info/more-info.html'));
	}
	
	var myDiv = $(this).find('.ban_index_bottom_nav_li_a');
	var isHidden = myDiv.length === 0 || myDiv.is(':hidden');
	
	$('.ban_index_bottom_nav_li').find('.ban_index_bottom_nav_li_a').hide();
	
	
	if(isHidden){
		myDiv.show();
	}else{
		myDiv.hide();
	}
}

/* (function() {
	  var hm = document.createElement("script");
	  hm.src = "//hm.baidu.com/hm.js?68fe9655cc5b1e235fbb091f4b4f7de8";
	  var s = document.getElementsByTagName("script")[0]; 
	  s.parentNode.insertBefore(hm, s);
	})(); */
	
	
</script>