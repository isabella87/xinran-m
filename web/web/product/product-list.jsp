<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<style>
.ban_product_ul:after { content: ""; display: block; clear: both}
.ban_product_ul dd { float: left; text-align: center}
.ban_product_ul dd em { display: block; font-style: normal}
.ban_product_ul dd a { display: block;  padding: 10px 30px; text-decoration: none}
</style>

<body>
	<%@include file="../inc/head-page.jsp"%>
	<div class="bm_less_head bm_content_bottom" id="swipeDiv">
	   <%--  <div class="bm_less_head_tab">
			<ul class="ban_product_class_ul">
				<li class="ban_pc_li_chosse"><a href="javascript:;" class="ban_pc_a">借款项目</a></li>
				<li class="ban_pc_li"><a href="../creditassign/credit-assign-list.html" class="ban_pc_a">二级市场</a></li>
			</ul>
			<div class="ban_jiazai_num" style="display:none;"><div class="ban_circle_rate_hilite"><div class="ban_circle_rate_v"></div></div><!--加载中，请稍候...--></div>
		</div> --%>
	    
	    <div class="bm_content">
	        <div id="errMsg" style="display:none;"></div>
	        <div id="infoMsg" style="display:none;"></div>
	        <div class="mask" id="mask" style="display:none;"></div>
	        
			<!-- <div class="bm_wrapper" id="main-con">
				
			</div> -->
			<div class="bm_wrapper">
				<dl class="ban_product_ul" id="proListUl">
        
				</dl>  
			</div>
		</div>
        <div id="nextPageFlag" style="display:block; width:20px; height:2px; borde:none; background-color:#fff;">&nbsp;</div>
	    <div class="backtop" id="pro_roll_top" style="display:none;"><i></i>TOP</div>
	<%@include file="../inc/bottom-page.jsp"%>
	</div>

<script type="text/javascript">
"use strict";

var MAX_SHOW_NUM = 18;
g_showUserInfo = false;   // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
var g_pageIndex = 1;
var page = { pn: g_pageIndex };
var g_dataList = new Array();
var pageCount = 0;
$(function(){
	
	Sys.countDown(); 
		
	$(window).scroll(function() {
		
		if ($(window).scrollTop() > 300) {

			$('#pro_roll_top').fadeIn(400); //当滑动栏向下滑动时，按钮渐现的时间
		} else {
			$('#pro_roll_top').fadeOut(0); //当页面回到顶部第一屏时，按钮渐隐的时间
		}
	});
	
	$('#pro_roll_top').click(function () {
		$('html,body').animate({
			scrollTop : '0px'
		}, 300);//返回顶部所用的时间 返回顶部也可调用goto()函数
	});

	$("body").swipe({
		swipeUp: function(event, direction, distance, duration, fingerCount) {
			//console.log("滑动方向: "+ direction  + " 滑动距离： " +  distance  + "  速度： " + duration);	
			if (g_pageIndex <= pageCount) {
				// TOOD:判断 [控制加载下一页数据的nextPageFlag] 的位置是否在父级div内部显示出来,若可见就加载，否则就不加载下一页数据
				var viewport = {};//视口对象
				viewport.scrollTop = $(window).scrollTop(); // 滚动高度:获取滚动条到top的高度,滚动条在Y轴上的滚动距离
				viewport.clientHeight = $(window).height(); // 内容可视区域的高度
				viewport.scrollHeight = $(document).height(); // 内容可视区域的高度加上溢出（滚动）的距离
				viewport.bottom = viewport.scrollTop + viewport.clientHeight; //  viewport.scrollHeight = viewport.bottom 代表滚动到底部了
				
				var bounds = {}; 
				bounds.top = $('#nextPageFlag').offset().top; //距离顶部的偏移
				bounds.outerHeight = $('#nextPageFlag').outerHeight(); //nextPageFlag的外部高度
				bounds.bottom =  bounds.top + bounds.outerHeight;
				
				/* if ($('#nextPageFlag').is(':visible')){....} 不用是否可见show()来判断，用这个nextPageFlag是否在视口可见 判断*/ 
				if((bounds.top <= viewport.bottom - 80) && (bounds.bottom >= viewport.scrollTop)){
					// 若nextPageFlag的位置在父级div内部显示，则加载第二页数据
					$(".ban_jiazai_num").css("position", "absolute"); 
		            $(".ban_jiazai_num").css("top", 286); // $(".ban_jiazai_num").offset().top-100
		            $(".ban_jiazai_num").css("left", '20%'); // $(".ban_jiazai_num").offset().left + 80
					$('.ban_jiazai_num').fadeIn(400);
					
					$.extend(page,{pn : g_pageIndex});
					Sys.service.load('AllWorkerService', {}, true);
					
					$('.ban_jiazai_num').fadeOut(800);
					
				}
				
			} else {
				console.log('已经到最后一页!');
				return false;
			}
		}
	     ,preventDefaultEvents : false
	});
});


var accInfo = {};
Sys.service.on('Account', function(data) {
	$.extend(accInfo,data);
	if (accInfo.valid) {
		Sys.service.load('AllMajorProductService');
	} else {
		window.self.location.assign(Sys.evalUrl('/login.html'));
	}
});

Sys.service.on('AllMajorProductService', function(data,ctx) {
	var html = new Array();
	if(data && data.items && data.items.length > 0){
		g_dataList = data.items;
		
		$.each(data.items,function(i){ 
			
			var d = data.items[i];
			html.push('    <a href="product-detail.html?mpid='+d.mpId+'" title="立即订购">                                     ');
            html.push('<dd>                                                                  ');
            //html.push('    <img src="/image/product/'+d.mpId+'.png " width="300" height="225" alt="product" /> ');
            html.push('    <img src="'+Sys.config.xrSrvUrl+'/major-product/'+d.mpId+'/file"'+' " width="300" height="225" alt="product" /> ');
            //html.push('    <em>商品</em>                                                     ');
           
            html.push('<p>商品价格：'+d.price + '元</p>  ');
            html.push('<p>商品名称：'+d.proName+'</p>  ');
			html.push('<p>商品编号：'+d.proNo+'</p>  ');
            
			html.push('<hr style=" height:2px;border:none;border-top:2px dotted #87CEEB;"/>             ');
            html.push('</dd>                                                                 ');
            html.push('    </a>                                       ');
		});
		
		//$("#proListUl").html(html.join('')); 
		
		//Sys.createPage(document.getElementById('pager'), data.pc,1);
		
	}
	$("#proListUl").html(html.join('')); 
	//$('#main-con').append(html.join(''));
},false);

	/* var html = [];
	if(data && data.items){
		
		pageCount = data.pc;
		g_pageIndex = g_pageIndex + 1; // 获取当页数据成功，页数+1,到下一页
		
		g_dataList = data.items;
		 
		for(var i = 0; i < data.items.length; i++){
			var d = data.items[i];
			var tl = d.itemShowName;//,stl = tl.length>MAX_SHOW_NUM?tl.substring(0,MAX_SHOW_NUM)+'...':tl;
			var st = Sys.getStatusNameById(d.status, null, d.financingEndTime);
			var ptm = Sys.ProTypeMapping(d.type,d.flags);

			//flags=16为班乐宝 ，用16的十六进制0x0010与判断； 只要是班乐宝就为优选标的图标的class  ;  若服务返回水印图片，则切换为推荐图片的class; 若flags=1为新手标，只要是新手标就为新手标的图标的class
			var waterMark = d.waterMark; //新手标图章加了判断，若勾选了新手标，有选了水印图片，优先显示水印图片
			
			html.push('<div class="ban_product_list_box">  ');
			html.push('	<div class="ban_p_name_line">  ');
			// 若是type为 (7，供应贷；8，分销贷；9，个人贷 ，10，小微企业贷)跳转到 project-gfg-view.jsp; 否则默认type为( 1，工程贷；)跳转到 project-view.jsp;这里不能用gotoInvite(_index,_type)统一写跳转，因为滑动加载下一页后_index需要处理，否则pid会乱
			html.push('<div class="ban_p_name"><div class="ban_project_pingji_a">'+ d.prjRating +'</div>'+ d.itemNo +'<a href="'+((d.type === 7 || d.type === 8 || d.type === 9 || d.type === 10) ? Sys.evalUrl('/project/project-gfg-view.html?id=' + d.pId + '&hash=' + d.hash) : Sys.evalUrl('/project/project-view.html?id='+ d.pId + '&hash=' + d.hash))+'"  title="'+tl+'">'+tl+'</a></div>');
			html.push('	</div>  ');
			html.push('	<ul class="ban_case_info">  ');
			html.push('    <li class="ban_case_class '+ptm.cls+'" title="'+ptm.name+'">'+(ptm.firstWord || ptm.name.substring(0,1))+'</li>  ');
			html.push('		<li class="ban_shouyi_box"><span class="ban_sy_span"><em                                     ');
			html.push('				class="ban_sy_num">'+d.rate+'</em>%</span><span class="ban_sy_span2">借款利率</span></li>    ');
			html.push('		<li class="ban_shouyi_box"><span class="ban_sy_span"><i                                      ');
			html.push('				class="ban_sy_i">'+(d.amt/10000)+'</i>万元</span><span class="ban_sy_span2">借款金额</span></li>   ');
			html.push('		<li class="ban_shouyi_box"><span class="ban_sy_span">'+d.borrowDays+'天</span><span ');
			html.push('			class="ban_sy_span2">借款天数</span></li>  ');
			html.push('	</ul> ');
			
			html.push('<div class="ban_touzi_time">'+((d.flags & 0x0010) !== 0 ? '<div class="ban_youxuan_biao"></div> '  : (d.flags & 0x0001) !== 0  ? ( waterMark ? '<div class="ban_'+ waterMark +'"></div> ' : '<div class="ban_m_xinbiao"></div>')  : (( waterMark ? '<div class="ban_'+ waterMark +'"></div> ' : ''))));
			// 若是type为 (7，供应贷；8，分销贷；9，个人贷，10，小微企业贷 )跳转到 project-gfg-view.jsp; 否则默认type为( 1，工程贷；)跳转到 project-view.jsp
			html.push('		<a href="'+((d.type === 7 || d.type === 8 || d.type === 9 || d.type === 10) ? Sys.evalUrl('/project/project-gfg-view.html?id=' + d.pId + '&hash=' + d.hash) : Sys.evalUrl('/project/project-view.html?id='+ d.pId + '&hash=' + d.hash))+'" class="ban_tz_btn '+st.bClassName+'">'+st.statusTxt+'</a><span  ');
			
			html.push('			class="ban_tz_span _refreshDate" name="'+d.financingEndTime+'" extra="'+st.showCountDown+'">'+(st.showCountDown === 'show' ? (Sys.countDownTime(d.financingEndTime) <= 0 ? '已截止' : Sys.formatTime(Sys.countDownTime(d.financingEndTime))) : (st.showCountDown === 'end' ? '已截止' : ''))+'</span>  ');
			html.push('	</div>   ');
			html.push('</div>');
			
		}
	}
	$('#main-con').append(html.join(''));
}, false);
 */

</script>
</body>
</html>
