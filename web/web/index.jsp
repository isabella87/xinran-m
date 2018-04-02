<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="inc/common.jsp"%>

<style>
.ban_product_ul:after { content: ""; display: block; clear: both}
.ban_product_ul dd { float: left; text-align: center}
.ban_product_ul dd em { display: block; font-style: normal}
.ban_product_ul dd a { display: block;  padding: 10px 30px; text-decoration: none}
</style>

<body>
   <%@include file="inc/head-page.jsp"%>
	<!-- 多张 banner 代码-->
	 <%-- <div class="ban_m_banner">
	   <div id="slider4">
	    	<a href="./info/info-view.html?id=7642&hash=BEzfyc&type=2">
	    		<a:img src="banner/ban_banner13.jpg"/>
	    	</a>
	    	<a href="./info/info-view.html?id=3781&hash=mWfgeO&type=2">
	    		<a:img src="banner/ban_banner3.jpg"/>
	    	</a>
    	</div>
    	<div class="ban_m_banner_box">
	        <a href="javascript:void(0);" class="ban_m_banner_a ban_m_banner_sel"></a>
	        <a href="javascript:void(0);" class="ban_m_banner_a"></a>
        </div>
    </div>  --%>
    
    <!-- 一张banner 代码-->
    <div class="ban_m_banner">
	   <div>
	    	<a href="./service/apply-service.html">
	    		<a:img src="banner/ban_banner3.jpg"/>
	    	</a>
    	</div>
    </div>
    
    <div class="ban_preinfo">
  <div class="ban_wrapper" >
	<marquee behavior = "scroll" direction = "up" id="mcUserUl" >
        
	</marquee>  
  <%-- <div style="text-align:center;display: block;  padding: 20px 60px; text-decoration: none"> <a href="product/product-list.html" >查看更多</a></div>
   --%>
   </div> 
   </div>
	<%@include file="inc/bottom-page.jsp"%>
<script type="text/javascript">
g_showUserInfo = false;  // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮

$(function(){
	$(".ban_m_index_bg").swipe({
		swipeUp : function(event, direction, distance, duration,fingerCount) {
			//$(this).text("你用" + fingerCount + "个手指以" + duration+ "秒的速度向" + direction + "滑动了"+ distance + "像素 ");
			//console.log("你用" + fingerCount + "个手指以" + duration+ "秒的速度向" + direction + "滑动了"+ distance + "像素 ");
			
		},preventDefaultEvents : false // 默认是true，阻止默认的滚动条设置为false后，默认的滚动条上下就不受影响了
		/*, threshold:10,
		  maxTimeThreshold:1000,
		  fingers:'all' */
	});
	Sys.service.load('MajorTopTenService');
});

Sys.service.on('MajorTopTenService',function(data,ctx){
	if(data && data.length > 0){
		var html = new Array();
		$.each(data,function(i){ 
			var d = data[i];
			html.push('<p style="background-color:#87CEEB;text-align:center;color:yellow;font-size:20px;">'+d.name +'于'+Sys.formatDate(d.createTime,'yyyy-MM-dd hh-mm-ss')+'申请了 '+d.type+'服务......</p> ');
		});
		$("#mcUserUl").html(html.join('')); 
		
	}
},false);

/* var g_rCode = '';
Sys.service.on('RcodeService',function(data){
	if(data){
		g_rCode = data;
	}
}); */

function showShare() {
	if(typeof myLogin !== 'undefined'){
		myLogin.showShares(g_rCode);
	}
}

var as = $('.ban_m_banner_box > a');
for(var i=0;i<as.length;i++){
	(function(){
		 var j = i;
		 as[i].onclick = function(){
			ts4.slide(j);
			return false;
		 } 
	})();
}
var ts4 = new TouchSlider('slider4',{speed:200, direction:'left', timeout:4000, fullsize:true, before:function(m,n){
	 $(".ban_m_banner_box > a").removeClass("ban_m_banner_sel").eq(m).addClass("ban_m_banner_sel");
}});  



</script>
</body>
</html>
