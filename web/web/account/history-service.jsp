<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>

	<header class="bm_back_header"> 
	  <div class="bm_back_top">
	  	<a href="../account/accountment.html" class="bm_back_btn">&lt;</a><em>我的服务</em>
	  </div>
	</header>
	<div class="bm_less_head bm_change_page" style="padding-top: 7rem"  id="swipeDiv">
	    <div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
	    <div class="bm_wrapper" id="label_switch">
		      <div class="bm_less_head_tab">
		        <ul class="ban_product_class_ul">
		          <li class="ban_pc_li_chosse"><a href="javascript:void(0);" class="ban_pc_a">历史服务</a></li>
		          <li class=ban_pc_li><a href="../account/serving.html" class="ban_pc_a">待支付服务</a></li>
		        </ul>
		        <div class="ban_jiazai_num" style="display:none;"><div class="ban_circle_rate_hilite"><div class="ban_circle_rate_v"></div></div><!--加载中，请稍候...--></div>
		      </div>
		      
		       <div class="ban_product_list">
		        
		      </div>
	         
	    </div> 
	    <div id="nextPageFlag" style="display:block; width:20px; height:2px; borde:none; background-color:#fff;">&nbsp;</div>
		<div class="backtop" id="invest_roll_top" style="display:none;"><i></i>TOP</div>
	</div>
		 <%@include file="../inc/bottom-page.jsp"%>
	
	<script type="text/javascript">
	   'use stricts';
		g_showUserInfo = false;   // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
		var g_pageIndex = 1;
		var serviceInfo = {status : '65535', pn : g_pageIndex};
		var pageCount = 0;
		$(function(){
			
			$(window).scroll(function(){
				
				//console.log("scrollTop "+$(window).scrollTop());
				if($(window).scrollTop() > 1400){
					
					$('#invest_roll_top').fadeIn(400);
				}else{
					$('#invest_roll_top').fadeOut(0);
				}
				
			});
			
			$('#invest_roll_top').click(function(){
				$('html,body').animate({
					scrollTop : '0px'
				},1400);
			});
			
			
			$('body').swipe({
				swipeUp : function(event, direction, distance, duration, fingerCount){
					if(g_pageIndex <= pageCount){
						
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
						
						/* if ($('#nextPageFlag').is(':visible')){....} 不用是否可见判断，用这个nextPageFlag是否在视口可见 判断*/ 
						if((bounds.top <= viewport.bottom) && (bounds.bottom >= viewport.scrollTop)){
							// 若nextPageFlag的位置在父级div内部显示，则加载第二页数据
							$(".ban_jiazai_num").css("position", "absolute"); 
				            $(".ban_jiazai_num").css("top", 286); // $(".ban_jiazai_num").offset().top-100
				            $(".ban_jiazai_num").css("left", '20%'); // $(".ban_jiazai_num").offset().left + 80
							$('.ban_jiazai_num').fadeIn(400);
							
							serviceInfo['pn'] = g_pageIndex;
							Sys.service.load('InvestmentService', {}, true);
							
							$('.ban_jiazai_num').fadeOut(800);
							
						}
						
					}else{
						console.log('已经到最后一页！');
						return false;
					}
				}
			     ,preventDefaultEvents : false
			});
			
			
		});
		
		Sys.service.on('MajorServiceService',function(data){
			if(data.items){
				var html = new Array();
				
				pageCount = data.pc;
				g_pageIndex = g_pageIndex + 1;
				
				$.each(data.items,function(i,d){
					var showTitle = Sys.encode(d.serviceName);
					var MAX_TITLE_LEN=17;
					var showTitle = showTitle.length > MAX_TITLE_LEN ? showTitle.substring(0,MAX_TITLE_LEN) : showTitle;
					
					var isCredit = d.sType === 2;
					var proType = Sys.ProTypeMapping(d.pType || d.oriType, d.flags, isCredit); // 项目类型及样式
					
					html.push('<div class="ban_product_list_box">');
					html.push(' <div class="ban_p_name_line">  ');
					html.push('  	<div class="ban_p_name">  ');
					html.push('          <div class="ban_case_class ban_gong_color">服</div>  ');
					html.push('          <div class="bm_change_num">  ');
					html.push('          	<em>'+ d.serviceNo +'</em><a href="javascript:void(0);" target="_blank">'+ showTitle +'</a>  ');
					html.push('          </div>  ');
					html.push('      </div>  ');
					html.push('  </div>  ');
					html.push('  <ul class="ban_case_info">  ');
					html.push('      <li class="ban_shouyi_box"><span class="ban_sy_span"><em class="ban_sy_num">'+  Sys.formatNumber(d.fee,true,2) +'元</em></span><span class="ban_sy_span2">服务费用</span></li>   ');
					html.push('      <li class="ban_shouyi_box ban_shouyi_box2"><span class="ban_sy_span"><em class="ban_sy_num ban_sy_num2">'+Sys.formatDate(d.dueTime,'yyyy-MM-dd')+'</em></span><span class="ban_sy_span2">预约日期</span></li>');
					html.push('      <li class="ban_shouyi_box"><span class="ban_sy_span"><em class="ban_sy_num">'+d.type +'</em></span><span class="ban_sy_span2">服务类型</span></li>  ');
					html.push('      <li class="ban_shouyi_box ban_shouyi_box2"><span class="ban_sy_span"><em class="ban_sy_num ban_sy_num2">'+d.tracker +'</em></span><span class="ban_sy_span2">服务将士</span></li> ');
					html.push('  </ul> ');
					html.push('</div>');
				});

				$(".ban_product_list").append(html.join(''));
				
			}
		});
		
		////////////////////////
		//All private functions
		///////////////////////
		
		
	</script>
</body>
</html>
