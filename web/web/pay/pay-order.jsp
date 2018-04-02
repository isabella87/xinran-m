<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>

	<header class="bm_back_header"> 
	  <div class="bm_back_top">
	  	<a href="../account/accountment.html" class="bm_back_btn">&lt;</a><em>订单支付</em>
	  </div>
	</header>
	<div class="bm_less_head" style="padding-top: 4rem">
	    <div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
	    <div class="bm_wrapper" id="mainInfo">
	    </div> 
	    
	    <div id="payDiv" style="display:none;"></div>
	    
		<hr style=" height:2px;border:none;border-top:2px dotted #87CEEB;"/> 
	    <div class="bm_wrapper">
		     <img src= "../themes/default/images/zfb-bz.png"  style="width:120px;height:45px" />
		     <input type="checkbox" checked="true" style="margin-left:80px; margin-top:0px" id="check1"/>
	    </div> 
	    
	    <div class="bm_button" id="submitButton">
	    </div>
	</div>
		 <%@include file="../inc/bottom-page.jsp"%>
	
	<script type="text/javascript">
	   'use stricts';

	   var g_service = {};
	   var poId = Sys.getParam('id');
	   
	   if(!poId){
			Sys.errorDlg('参数错误！',null,function(){
				window.open("about:blank","_top").close();
			});
		}
	   var orderDetailInfo = {poId : poId};
	   Sys.service.on('OrderDetail',function(data){
	   	if (data) {
	   		g_order = data;
	   		showOrderDetails();
	   	}
	   });
	   
	   function showOrderDetails(){
			var d = g_order;
			var html = new Array();                                                                                                                                               
			 
			html.push('<p style="color:#87CEEB;text-align:center; margin-top:0px" >');
			html.push('<span style="color:red;font-size:36px">'+Sys.formatNumber(d.price, true, 2)+'</span>元<br/>');
			html.push('<span>');
			html.push(d.proName+'</span></p>');
		
			$("#mainInfo").html(html.join(''));
			
			var buttomHtml = new Array();
			buttomHtml.push('<a href="javascript:void(0);" id="submitBtn" class="bm_button_hilite" onclick="submitPay()">');
			buttomHtml.push('确认支付￥'+Sys.formatNumber(d.price, true, 2)+'元</a>');
			 
			$("#submitButton").html(buttomHtml.join('')); 
			
	   	}
	   
	   function submitPay(){
		   if(!document.getElementById("check1").checked){
			   Sys.infoDlg("请选择支付方式！");
			}else{
				window.location.assign(Sys.evalUrl("/pay/to-pay.html?type=2&id="+poId));
				
	   		}
	   }
	   
	   
	</script>
</body>
</html>
