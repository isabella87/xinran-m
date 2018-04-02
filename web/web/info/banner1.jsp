<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<style type="text/css">
    html{overflow:hidden;}//隐藏整个页面的滚动条；
</style>

<html>
<body>
	<%@include file="../inc/head-page.jsp"%>
	<div class="bm_less_head">
    	<div class="bm_wrapper" id="mainCon">
			<iframe onload="changeFrameHeight();" frameborder="0" width="100%" ID="weixinFrame" SRC="" allowTransparency="true"  ></iframe> 	
			<div class="ban_jiazai_num" style="display:none;"><div class="ban_circle_rate_hilite"><div class="ban_circle_rate_v"></div></div><!--加载中，请稍候...--></div>		
    	</div> 
<%@include file="../inc/bottom-page.jsp"%>
	</div>

	<script type="text/javascript">
	
		g_showUserInfo = false;   // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
		
	
		$(".ban_jiazai_num").css("position", "absolute"); 
        $(".ban_jiazai_num").css("top", 286); // $(".ban_jiazai_num").offset().top-100
        $(".ban_jiazai_num").css("left", '20%'); // $(".ban_jiazai_num").offset().left + 80
		$('.ban_jiazai_num').fadeIn(100);

		
		function changeFrameHeight(){
		    var ifm= document.getElementById("weixinFrame"); 
		    ifm.height=document.documentElement.clientHeight-120;
		} 
		window.onresize=function(){  
		     changeFrameHeight();  
		}  
		
		 $.ajaxPrefilter( function (options) {
	         if (options.crossDomain && jQuery.support.cors) {
	           var http = (window.location.protocol === 'http:' ? 'http:' : 'https:');
	           options.url = http + '//cors-anywhere.herokuapp.com/' + options.url;
	         }
	       });
	    
	    var banner1_link="http://mp.weixin.qq.com/s?__biz=MzA5NTQ2NDc4Mw==&mid=2650325307&idx=1&sn=460d6c8abe30299105a917eff59d1099&chksm=88b29d1bbfc5140dee990fe2a22c6896114e04170e1d43fe168dd84022a199ef419a9842f73d#rd";//微信文章地址
	    $.get(
	    		banner1_link,
	       function (response) {
	           //console.log("> ", response); 
	           var html = response;
	           html= html.replace(/data-src/g, "src"); 
	           var html_src = 'data:text/html;charset=utf-8,' + html;
	           $("iframe").attr("src" , html_src);
	           
	           $('.ban_jiazai_num').fadeOut(0);
	   }); 
	      
      
	</script>
</body>
</html>
