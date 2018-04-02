<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>

	<header class="bm_back_header"> 
	  <div class="bm_back_top">
	  	<a href="../account/accountment.html" class="bm_back_btn">&lt;</a><em>订单支付</em>
	  </div>
	</header>
	<div class="bm_less_head" style="padding-top: 4rem; color:#87CEEB">
	    <div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
	    <div class="bm_wrapper" id="mainInfo">
	    </div> 
	    
	    <div id="payDiv" style="display:none;"></div>
	    
	</div>
		 <%@include file="../inc/bottom-page.jsp"%>
	
	<script type="text/javascript">
	   'use stricts';

	   var id = Sys.getParam('id');
	   var type = Sys.getParam('type');
	   
	   if(!id){
			Sys.errorDlg('参数错误！',null,function(){
				window.open("about:blank","_top").close();
			});
		}
	   var zfbWappayDetailInfo = {id:id,type:type};
	   Sys.service.on('ZfbFormDetailService',function(data){
			if (data) {
				var form = data;
				$("#payDiv").html(form);
			}
		});
	   
	   
	</script>
</body>
</html>
