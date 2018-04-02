<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>
<body>

<%@include file="../inc/head-page.jsp"%>
<div  id="mainDiv">
   <div id="errMsg" style="display:none;"></div>
   <div id="infoMsg" style="display:none;"></div>
   <div class="mask" id="mask" style="display:none;"></div>
    
    <div id="infoMsg" class="dealInfoMsg" style="display:none;"></div>
	<div class="mask" id="dealMask" style="display:none;"></div>
	
	<div class="bm_content" style="margin:0px 0 0;">
		<ul class="bm_chujie_ul">
	    	<li><a href="../account/serving.html"><em class="bm_btn_right">&gt;</em><i class="ban_m_gong_color">一</i>我的服务</a></li>
	        <li><a href="../account/order.html"><em class="bm_btn_right">&gt;</em><i class="ban_m_zhuan_color">二</i>我的订单</a></li>
	    	<li><a href="../product/product-list.html"><em class="bm_btn_right">&gt;</em><i class="ban_m_zhuan_color">三</i>商品</a></li>
	    </ul>
	</div>
	
    <%-- <ul class="bm_zhang_meory">
    	<li><strong>账户余额（元）：</strong><em  id="availableBlc">--</em></li>
        <li>总资产（元）：<dfn id="totalAssets">--</dfn></li>
        <li>当前待收本金（元）：<dfn id="receivingPrincipal">--</dfn></li>
        <li>预计待收利息（元）：<dfn id="receivingInterest">--</dfn></li>
        <li>募集中资金（元）：<dfn id="frozenBlc">--</dfn></li>
    </ul>
    <div class="bm_zhang_btn">
    	<a href="../account/recharge.html" class="ban_button_hilite">充值</a>
    	<a href="../account/withdraw.html" class="ban_button_check">提现</a>
    </div>
    <ul class="bm_zhang_time">
        <li><a href="../account/invest-manager.html"><div class="bm_z_img_1"></div>出借管理</a></li>
        <li><a href="../account/repay-record.html"><div class="bm_z_img_2"></div>还款日历</a></li>
        <li><a href="../account/history-income.html"><div class="bm_z_img_3"></div>收支明细</a></li>
        <li><a href="../account/jxpay-info.html"><div class="bm_z_img_4"></div>银行开户</a></li>
    </ul> --%>
</div>
    <%@include file="../inc/bottom-page.jsp"%>	

<script type="text/javascript">
var g_receivingPrincipal = null; // 全局-预计待收本金
var g_currUser = {};
$(function(){

	$('.dealInfoMsg').on('click',hideMask);
	
	$('#dealMask').on('click',hideMask);

});

Sys.service.on('Account',function(data,ctx){
	if(data.valid){
		$.extend(g_currUser,data);
		Sys.service.load('Accountment');

	}else{
		toLogin();
	}
	
});

//加载账户余额（账户可用余额）
//var amt1 = "0",amt2 = ".00";
Sys.service.on("JxPayAccBalance", function(data,eCode,eMsg){
	if(eCode === 20){
		$('.dealInfoMsg').html('请先注册银行存管账户！<a href="/m/account/apply-jxpay-info.html" class="msgBtn">立即开通</a>').show();
		$('#dealMask').show();
		return true;
	}else if (eCode === 2) {
		Sys.infoDlg('暂时无法联机获取银行数据,请您稍后再刷新页面尝试！');
		return true;
	}else if (eCode === 3) {
		Sys.infoDlg('网络异常，请稍后再试!');
		return true;
	}
	
	if (data) {
		var visibleBal = Sys.money2Array(data.visible);  //账户余额
		var frozenBlcTemp = data.visible - data.available; //募集中资金 = 账户余额-账户可用余额
		
		// 总资产 = 账户余额 + 当前待收本金
		var totalAssetsTemp = 0.00;
		if(g_receivingPrincipal){
			totalAssetsTemp = Sys.formatNumber(parseFloat(data.visible) + parseFloat(g_receivingPrincipal), true, 2); 
			$('#totalAssets').html('<i>￥</i>' + totalAssetsTemp);
		}
		
		$("#availableBlc").html('<i>￥</i>'+Sys.formatNumber(data.available, true, 2));   //账户可用余额
		$("#frozenBlc").html('<i>￥</i>'+ Sys.formatNumber(frozenBlcTemp, true, 2)); //募集中资金(冻结资金)
	}
},false);

Sys.service.on('Accountment',function(data,ctx){
	if(data){
		var receivingPrincipalTemp = Sys.formatNumber(data.receivingPrincipal, true, 0);  // 预计待收本金
		var receivingInterestTemp = Sys.formatNumber(data.receivingInterest, true, 2); // 预计待收利息
		
		$('#receivingPrincipal').html('<i>￥</i>' + receivingPrincipalTemp);
		$('#receivingInterest').html('<i>￥</i>' + receivingInterestTemp);
		
		g_receivingPrincipal = data.receivingPrincipal; // 全局变量-预计待收本金
		Sys.service.load('JxPayAccBalance',{},true);
		
		if(g_currUser.userType === 1 || g_currUser.userType === 2){
			// 对于个人用户, 首先判断是否已开户
			if (g_currUser.status !== 3) { //未开户
				// 不显示充值、提现、下面一排按钮
				$('.bm_zhang_btn').hide();
				$('.bm_zhang_time').hide();
			} else {
				// 显示充值、提现、下面一排按钮
				$('.bm_zhang_btn').show();
				$('.bm_zhang_time').show();
			}
		}
		
	}
},false);

////////////////////////
//All private functions
///////////////////////
function hideMask(){
	$('.dealInfoMsg').hide();
	$('#dealMask').hide();
}

</script>
</body>
</html>
