<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>
	<%@include file="../inc/head-page.jsp"%>
	<div class="bm_content bm_content_bottom">
	    <div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
		<ul class="bm_chujie_ul bm_fenxiang_ul">
	    	<li><a href="javascript:showShare();"><em class="bm_btn_right">&gt;</em><em style="color: #d24545; font-size: 1.5rem; font-weight: bold">分享石玖</em></a></li>
	    	<%-- <li><a href="../info/know-us.html"><em class="bm_btn_right">&gt;</em><em>关注我们</em></a></li> --%>
	    	<%-- <li><a href="javascript:void(0);" onclick="viewPrompt();"><em class="bm_btn_right">&gt;</em><em>信息披露</em></a></li>
			 --%><li><a href="../info/contact-us.html"><em class="bm_btn_right">&gt;</em><em>关于</em></a></li>
			<li class="bm_fenxiang_li" style="display: none;">
	        	<img src="">
	        </li>
	    </ul>
	</div>
<%@include file="../inc/bottom-page.jsp"%>
	<script type="text/javascript">
		g_showUserInfo = false;   // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
		
	    Sys.service.on('Account',function(data){
	    	if(data && data.valid){
	    		$('.bm_fenxiang_li').show();
	    		$('.bm_fenxiang_li > img').attr('src',Sys.config.xrSrvUrl +'/reg/rq-code-pic?disp-name=true?_t' + new Date().getTime()); //生成二维码图片
	    	}else{
	    		$('.bm_fenxiang_li').hide();
	    	}
	    },false);
		
	    var rCode_url = '';
	    Sys.service.on('RcodeService',function(data){
	    	if(data){
	    		rCode_url = data;
	    	}
	    }); 
		
		$(function(){
			Sys.service.load('Account',{},true);
		});
		
		function showShare() {
			if(typeof myLogin !== 'undefined'){
				myLogin.showShares(rCode_url);
			}
		}
		
		function viewPrompt(){
			Sys.infoDlg('因手机限制无法显示，请电脑登录后查看详细内容！');
		}
	</script>
</body>
</html>
