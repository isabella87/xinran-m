<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>
	<%@include file="../inc/head-page.jsp"%>

<div class="bm_less_head bm_content_bottom">
    <div class="bm_less_head_tab">
		<h2 class="bm_less_head_title" style="color:#87CEEB;margin-top:10px;">详细信息</h2>
	</div>
	
  <div class="bm_content">
  		<div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
	    <div id="infoMsg" class="dealInfoMsg" style="display:none;"></div>
	    <div class="mask" id="dealMask" style="display:none;"></div>
	    
  <div class="bm_wrapper">
  <form name="orderForm" method="PUT" action="">
    <div class="bm_box" id="docContent">

	</div>
	</form>
  </div>
  </div>
</div>
 
<%@include file="../inc/bottom-page.jsp"%>

<script type="text/javascript">
g_showUserInfo = false;  // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
var gCfg = {boxClass:'bm_box',eBoxClass:'bm_box_cue',errMsg:'<div class="bm_box_cue_arrow"></div><p class="bm_box_cue_p bm_box_cue_hilite" >#[msg]</p>'};

var d_product ;
var mpId = Sys.getParam('mpid');

if(!mpId){
	Sys.errorDlg('参数错误！',null,function(){
		window.open("about:blank","_top").close();
	});
}

var productDetailInfo = {mpId : mpId };
Sys.service.on('ProductDetail',function(data){
	if (data) {
		d_product = data;
		showProductDetails();
	}
});

/**
 * 调用服务取到数据后渲染html，将数据展示出来
 */
function showProductDetails(){
	
	var d = d_product;

	var statusDesc = '未知状态';
	
	if(d.status==0){
		statusDesc = '未上架';
	}else if(d.status==1){
		statusDesc = '已上架';
	}
	
	var html = new Array();
	html.push('<div class="bm_boximport">                                                                                                     ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	//html.push('	<label for="textfield" class="ban_infobox_label">产品图片</label>                                                              ');
	html.push('	<div class="bm_boxrow">                                                                                             ');
	html.push('		<div class="bm_boximport">                                                                                          ');
	//html.push('			<img style="display: block; margin: 0 auto;" src="/image/product/'+d.mpId+'.png"></img>');
	html.push('			<img style="display: block; margin: 0 auto;" src="'+Sys.config.xrSrvUrl+'/major-product/'+d.mpId+'/file"></img>');
	html.push('		</div>                                                                                                                     ');
	html.push('	</div>                                                                                                                         ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield1" class="ban_infobox_label" style="color:#87CEEB;">产品名称:'+Sys.encode(d.proName)+'</label>                                                             ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield2" class="ban_infobox_label" style="color:red;font-size:20px;">价格:'+Sys.encode(d.price)+'   元</label>                                                                 ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield3" class="ban_infobox_label" style="color:#87CEEB;">商品类型:'+Sys.encode(d.type)+'</label>                                                             ');
	html.push('</div>                                                                                                                          ');
	
	html.push('</div> ');
	
	html.push('	<div class="bm_button">');
	html.push('		<a href="javascript:void(0);" id="submitBtn" class="bm_button_hilite" onclick="submitOrder()">立即预定</a>');
	html.push('	</div>');
	
	
	/* html.push('	<div class="ban_infobox_bottom">');
	html.push('		<input name="" type="button" class=" ban_button_hilite ban_confirm_order_b submitBtn" value="立即预定"  ');
	html.push('			onclick="submitService()" /> ');
	html.push('	</div>'); */
	
	$("#docContent").html(html.join(''));
	$('#_cursor').html(Sys.encode(d.proName)+"&nbsp;"+d.proNo);
}

var ProductDetailInfoForOrder ={};
Sys.service.on('CreateOrderService',function(data){
	if(data==true){
		Sys.infoDlg('请至账户中心支付订单！',null,function(){
			var url = Sys.evalUrl('/account/order.html');
			//window.open(url);
			Sys.toUrl(url);
    	});
		
	}
},false);

function submitOrder(){
	var form = $(this).parents('form');
	
	var url = form.attr('action');
	var params = form.serializeObject();
	params.mpId = mpId;
	
	$.extend(ProductDetailInfoForOrder, {m:form.attr('method'), u:url, p : params});
	Sys.service.load('CreateOrderService',{},true);
}

</script>
</body>
</html>