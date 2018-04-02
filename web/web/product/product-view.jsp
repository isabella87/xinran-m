<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<style>
<!--
	.ui-dialog-body {padding: 0px;}
	.ui-popup-show  {top:15% !important;}
-->
</style>

<body>
    <%@include file="../inc/header.jsp" %>


	 <div class="bm_less_head ban_less_top"   style="padding-top: 0rem;margin-top: 3.5rem;">
        <div id="errMsg" style="display:none; top:3rem"></div>
	    <div id="infoMsg" style="display:none; top:3rem"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
		<div class="ban_name_line " id="title">
      	
      </div>
      
      <ul class="ban_detail_info" id="header">
      	
      </ul>
      
      <div class="bm_wrapper bm_content_bottom">
      	<div class="ban_detailed_label" id="prj-bottom">
      	
            <div class="ban_circle_rate ban_circle_rate_abs"  id="prj-bottom3"></div>
            
            <div class="ban_detail_xx">
            	<!-- 起息日：从借款人收款当日开始计息<br>还款方式：放款后每30天还息 -->
            </div>
            
        </div>
        <ul class="ban_detail_table">
        	<li class="ban_d_tab_hui" id="tjdy-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">项目介绍</span><span class="ban_jianyi_wifi">(建议wifi环境下查看)</span></li>
            <li class="ban_tab_info"  style="display: none;" id="tjdy">
            </li>
            
            <li class="ban_d_tab_hui" id="jkr-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">借款人</span></li>
            <li class="ban_tab_info"  style="display: none;" id="jkr">
            </li>
            
            <li class="ban_d_tab_hui" id="gcgk-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">工程概况</span></li>
            <li class="ban_tab_info" style="display: none;" id="gcgk">
            </li>
            
            <li class="ban_d_tab_hui" id="xmyz-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">项目业主</span></li>
            <li class="ban_tab_info"  style="display: none;" id="xmyz">
            </li>
            
            <li class="ban_d_tab_hui" id="sgdw-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">总包单位</span></li>
            <li class="ban_tab_info"  style="display: none;" id="sgdw">
            </li>
            
            <li class="ban_d_tab_hui" id="xmjl-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">项目经理</span></li>
            <li class="ban_tab_info"  style="display: none;" id="xmjl">
            </li>
            
            <li class="ban_d_tab_hui" id="jkdb-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">保障措施</span></li>
            <li class="ban_tab_info2"  style="display: none;" id="jkdb">
            </li>
            
            <li class="ban_d_tab_hui" id="xmpj-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">项目评级</span></li>
            <li class="ban_tab_info"  style="display: none;" id="xmpj">
            </li>
            
            <li class="ban_d_tab_hui" id="hkjh-title"><a href="javascript:void 0;" class="ban_detail_table_a">+&nbsp;展开</a><span class="ban_detail_table_span">还款计划</span></li>
            <li class="ban_tab_info"  style="display: none;" id="hkjh">
            </li>

        </ul>
        
        
      </div>
      
      <div class="ban_liji_touzi_btn" id="investDiv"></div>
      
	</div>
      
     <form id="tenderForm" action="" method="POST" target="_self">
		    <input type="hidden" name="amt" />
			<input type="hidden" name="pId" />
	</form>
	  <%@include file="../inc/bottom-page.jsp"%>   
<script type="text/javascript">
var prj={};
var id = Sys.getParam('id');
var hash = Sys.getParam('hash');
var balanceAmt = 0;
g_showUserInfo = false;  // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
//加载 项目介绍 信息
var sugInfo = {}; // 项目介绍
var prjBorrowerInfo = {pId : 0}; // 借款人、借款机构
var prjEngInfo = {pId : 0}; // 工程概况 、 项目经理合并了
var prjOwnerInfo = {pId : 0}; //项目业主
var prjCtorInfo = {}; // 施工单位
var prjGuaraInfo = {pId : 0}; // 借款担保
var prjRatingInfo = {pId : 0}; // 项目评级
var prjRepayPlanInfo = {};  // 还款计划
var prjRemarkInfo = {};  // 备注

var g_prjBorrowOrg = {};// 全局借款机构数据
var g_prjGuaranOrg = {}; // 全局担保措施-机构数据

$(function(){
	initTab();
	Sys.countDown();
});

//加载账户余额（账户可用余额）
Sys.service.on("JxPayAccBalance",function(data){
	if(data){
		balanceAmt = data.available;
	}
},false);

//加载 项目详细 信息
var dInfo = {pId:id,hash:hash};

var accInfo = {};
Sys.service.on('Account',function(data){
	$.extend(accInfo,data);
	if(accInfo.valid){
		Sys.service.load('EntProjectDetailService');
		
		Sys.service.load('JxPayAccBalance');
	}else{
		window.self.location.assign(Sys.evalUrl('/login.html'));
	}
});

Sys.service.on('EntProjectDetailService',function(d,ctx){
	if(d){
		$.extend(prj,d);
		prj.isInner = (d.flags & 0x0008)!==0;
		
		//投资
		initInvestBtn();
		
		renderTitle();
		renderHeader();
		
		//加载 项目介绍 信息
		$.extend(sugInfo,{objectId : d.pId,fileType:6});
		Sys.service.load('SuggestionService');
		
		//加载借款机构 信息;在借款机构中调用借款人服务
		prjBorrowerInfo.pId = d.pId;
		Sys.service.load('PrjBorrowerOrgService');
		
		//加载 工程概况 信息
		prjEngInfo.pId = d.pId;
		Sys.service.load('PrjEngService');
		

		//加载 项目业主 信息
		prjOwnerInfo.pId = d.pId;
		Sys.service.load('PrjOwnerService');
		
		//加载总包单位
		prjCtorInfo.pId = d.pId;
		Sys.service.load('PrjCtorService'); 
		
		//加载保障措施 -机构 信息，个人数据的在机构调用完调
		prjGuaraInfo.pId = d.pId;
		Sys.service.load('PrjGuaraOrgService');
		
		//加载 项目评级 信息
		prjRatingInfo.pId = d.pId;
		Sys.service.load('PrjRatingService');
		
		//加载 还款计划 信息
		prjRepayPlanInfo.pId = d.pId;
		Sys.service.load('PrjRepayPlanService');
		
		//加载备注
		prjRemarkInfo.pId = d.pId;
		Sys.service.load('PrjRemarkService');
		
		var bonusPeriod = d.bonusPeriod; //还款方式
		var bonusDay = d.bonusDay; //服务返回的指定日
		var ways = Sys.getRepayWays(bonusPeriod,bonusDay); //还款方式
		
		var htmlFee = [];
		htmlFee.push('<span class="ban_gc_class_info" id="span_fee">[<a href="javascript:void(0);" onclick="feeTableView()" style="color: #169bd5;">详见居间服务费用</a>]');
		htmlFee.push('  <div class="ban_gc_detail_bg"  style="display: none;" id="feeInfo">');
	    //加载 居间服务费用表格
	    htmlFee.push('     <table align="center" border="0" cellpadding="0" cellspacing="1" style="width: 100%"  class="ban_gc_detail_table">');
	    htmlFee.push('             <tr> ');
	    htmlFee.push('               <th>服务项目</th><th>收费标准</th><th>收费对象</th> ');
	    htmlFee.push('             </tr>  ');
	    htmlFee.push('             <tr> ');
	    htmlFee.push('               <td>充值</td><td>暂不收费</td><td>/</td>');
	    htmlFee.push('             </tr>  ');
	    htmlFee.push('             <tr> ');
	    htmlFee.push('               <td>出借</td><td>按照出借资金获得利息的6%收取</td><td>出借人</td>');
	    htmlFee.push('             </tr>  ');
	    htmlFee.push('             <tr> ');
	    htmlFee.push('               <td>提现</td><td>暂不收费</td><td>/</td>');
	    htmlFee.push('             </tr>  ');
	    htmlFee.push('             <tr> ');
	    htmlFee.push('               <td>债权转让</td><td>按照成交金额的0.5%收取</td><td>转让人</td>');
	    htmlFee.push('             </tr>  ');
	    htmlFee.push('             <tr> ');
	    htmlFee.push('               <td>数字证书</td><td>暂不收费</td><td>/</td>');
	    htmlFee.push('             </tr>  ');
	    htmlFee.push('     </table>  ');
	    htmlFee.push('  </div>  ');
	    htmlFee.push('</span>');
	    
		$('.ban_detail_xx').html('起息日：从借款人收款当日开始计息<br/>还款方式：'+ ways.showRepayInfo + '<br/>第一还款来源：工程项目回款<br/>第二还款来源：实现担保措施<br/>居间费：'+htmlFee.join(''));
		
		var html3 = [];
		var finishRate = Math.floor(d.investedAmt*100/d.amt);//完成率
        html3.push('<strong class="ui-progressbar-mid ui-progressbar-mid-' + finishRate + '"><em>' +(parseInt(d.investedAmt) >= parseInt(d.amt) ? '100' : finishRate)+ '</em>%</strong>');
        $('#prj-bottom3').html(html3.join(''));
		
	}
},false);

//加载项目介绍        
Sys.service.on('SuggestionService',function(data,ctx){
	if(data && data.length > 0){
		var str = data.reduce(function(p, d, i) {
        	var filePath = Sys.config.p2pSrvUrl+'/files/'+d.id+'/'+d.hash;
            return p + '<img width="100%" style="display: block; margin: 0 auto;" src="' + filePath + '"></img>';
        }, '');
		
		str += '<div class="ban_danbao_beizhu" id="HTML1"></div>';
		$('#tjdy').html(str);
	}else{
		$("#tjdy-title").hide();
		$("#tjdy").hide();
	}
},false); 

//加载 借款机构/project/prj-mgr-org/ 信息
Sys.service.on('PrjBorrowerOrgService',function(data){
	if(data && data.length > 0){
		
		$.extend(g_prjBorrowOrg, data);
		 var html = [];
		 
		$.each(data, function(i,d){
		
			html.push('<ul class="ban_gaikuang_ul">');
	        html.push('	    <li>');
	        html.push('    	   <span class="ban_gc_class_name">借款人：</span>');
	        html.push('        <span class="ban_gc_class_info">'+ d.showOrgName +'</span>');
	        html.push('   	</li> ');
	        html.push('     <li>');
	        html.push('    	   <span class="ban_gc_class_name">借款用途：</span>');
	        html.push('        <span class="ban_gc_class_info">'+ d.loanPurposes +'</span>');
	        html.push('   	</li> ');
	        html.push('     <li> ');
	        html.push('    	   <span class="ban_gc_class_name">法定代表人：</span>');
	        html.push('        <span class="ban_gc_class_info">'+ d.legalPersonShowName +'</span>');
	        html.push('   	</li> ');
	        html.push('    <li>  ');
	        html.push('        <span class="ban_gc_class_name">成立时间：</span>');
	        html.push('        <span class="ban_gc_class_info">'+ Sys.formatDate(d.registeredDate, 'yyyy年M月d日') +'</span>');
	        html.push('   	</li> ');
	        html.push('     <li>');
	        html.push('    	   <span class="ban_gc_class_name">注册资本：</span>');
	        html.push('        <span class="ban_gc_class_info">'+ ( !d.registeredShowFund ? '/' : Sys.formatNumber(d.registeredShowFund,true,2)+'万元') +'</span> ');
	        html.push('   	</li>');
	        html.push('     <li> ');
	        html.push('      <span class="ban_gc_class_name">核实列表：</span>  ');
	        html.push('        <span class="ban_gc_class_info" id="span_cert_borrow_org_'+ i +'">[<a href="javascript:void(0);" onclick="borrowOrgInfoCertList('+ i + ',' + d.bpmoId +')" style="color: #169bd5;">查看详情</a>]');
	        html.push('   	      <div class="ban_gc_detail_bg"  style="display: none;"  id="certBorrowOrgInfo_'+ i +'">');
	        //加载 核实列表 信息
	        html.push('           </div> ');
	        html.push('        </span> ');
	        html.push('    </li> ');

	        html.push('    <li> ');
	        html.push('    	<span class="ban_gc_class_name">借款人介绍：</span> ');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.loanIntro)+'</span>');
	        html.push('   	</li>');
	        html.push('</ul><br/> ');
	        
		});
		
		  
        $('#jkr').html(html.join(''));
		removeIfNoValue($('#jkr'));
		
		//加载 借款人/project/prj-mgr/信息
		prjBorrowerInfo.pId = prj.pId;
		Sys.service.load('PrjBorrowerService');
		
	}else{
		//加载 借款人信息
		prjBorrowerInfo.pId = prj.pId;
		Sys.service.load('PrjBorrowerService');
	}
	
},false);

//加载 借款人(即项目经理的服务/project/prj-mgr/) 信息
Sys.service.on('PrjBorrowerService',function(data){
	if(data && data.length > 0){
		var html = new Array();
		
		$(data).each(function(i,d){
			html.push('<ul class="ban_gaikuang_ul">');
	        html.push('	    <li>');
	        html.push('    	   <span class="ban_gc_class_name">借款人：</span>');
	        html.push('        <span class="ban_gc_class_info">'+ d.showName +'</span>');
	        html.push('   	</li> ');
	        html.push('     <li>');
	        html.push('    	   <span class="ban_gc_class_name">借款用途：</span>');
	        html.push('        <span class="ban_gc_class_info">'+ d.loanPurposes +'</span>');
	        html.push('   	</li> ');
	        
	        html.push('     <li> ');
	        html.push('      <span class="ban_gc_class_name">核实列表：</span>  ');
	        html.push('        <span class="ban_gc_class_info" id="span_cert_borrow_'+ i +'">[<a href="javascript:void(0);" onclick="borrowInfoCertList('+ i + ',' + d.bpmpId +')" style="color: #169bd5;">查看详情</a>]');
	        html.push('   	      <div class="ban_gc_detail_bg"  style="display: none;" id="certBorrowInfo_'+ i +'">');
	         //加载 核实列表 信息
	        html.push('           </div> ');
	        html.push('        </span> ');
	        html.push('    </li> ');
	    	
	        html.push('    <li> ');
	        html.push('    	<span class="ban_gc_class_name">借款人介绍：</span> ');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.loanIntro)+'</span>');
	        html.push('   	</li>');
	        html.push('</ul> ');
		});
		$("#jkr").append(html.join(''));
		removeIfNoValue($("#jkr"));
		
		
	}else if(!g_prjBorrowOrg[0]){
		$("#jkr-title").hide();
		$("#jkr").hide();
	}
},false);

  
//加载工程概况
Sys.service.on('PrjEngService',function(d,ctx){
	var html = [];
	if(d){
		html.push('<ul class="ban_gaikuang_ul"> ');
        html.push('	<li>');
        html.push('   <span class="ban_gc_class_name">工程名称：</span>  ');
        html.push('   <span class="ban_gc_class_info">'+ Sys.encode(d.engShowName) +'</span>   ');
        html.push(' </li>  ');
        
        html.push(' <li> ');
        html.push('    <span class="ban_gc_class_name">项目业主：</span>  ');
        html.push('    <span class="ban_gc_class_info"><span id="ownerName"/></span>');
        html.push('  </li> ');
        
        html.push(' <li> ');
        html.push('    <span class="ban_gc_class_name">总包单位：</span>  ');
        html.push('    <span class="ban_gc_class_info"><span id="ctorName"/></span>');
        html.push('  </li> ');
        
        html.push('  <li> ');
        html.push('    <span class="ban_gc_class_name">项目经理：</span>  ');
        html.push('    <span class="ban_gc_class_info">'+ d.mgrShowName +'</span>');
        html.push('  </li> ');
        // 加载项目经理 信息 -也从工程概况的服务/project/prj-engineer/中获取-开始
        var htmlMgr = new Array();
        var parName = "\'manager\'";

	   	htmlMgr.push('<ul class="ban_gaikuang_ul">');
	   	htmlMgr.push(' <li> ');
        htmlMgr.push('    <span class="ban_gc_class_name">性别：</span>  ');
        htmlMgr.push('    <span class="ban_gc_class_info">'+ Sys.getSexNameByType(parseFloat(d.mgrGender)) +'</span>');
        htmlMgr.push('  </li> ');
        
        htmlMgr.push(' <li> ');
        htmlMgr.push('    <span class="ban_gc_class_name">年龄：</span>  ');
        htmlMgr.push('    <span class="ban_gc_class_info">'+ d.mgrShowAge +'</span>');
        htmlMgr.push('  </li> ');
        
        htmlMgr.push(' <li> ');
        htmlMgr.push('    <span class="ban_gc_class_name">资格/职称：</span>  ');
        htmlMgr.push('    <span class="ban_gc_class_info">'+ d.qualification +'</span>');
        htmlMgr.push('  </li> ');
        
        htmlMgr.push('  <li> ');
        htmlMgr.push('        <span class="ban_gc_class_name">核实列表：</span>  ');
        htmlMgr.push('        <span class="ban_gc_class_info" id="span_cert_mgr">[<a href="javascript:void(0);" onclick="mgrInfoCertList('+ d.bpeId + ',' + parName +')" style="color: #169bd5;">查看详情</a>]');
        htmlMgr.push('   	      <div class="ban_gc_detail_bg"  style="display: none;"  id="certMgrInfo">');
         //加载 核实列表 信息
        htmlMgr.push('           </div> ');
        htmlMgr.push('        </span> ');
        htmlMgr.push('  </li> ');
        
        htmlMgr.push(' <li> ');
        htmlMgr.push('    <span class="ban_gc_class_name">项目经理介绍：</span>  ');
        htmlMgr.push('    <span class="ban_gc_class_info">'+ Sys.encode(d.mgrIntro) +'</span>');
        htmlMgr.push('  </li> ');
        htmlMgr.push('</ul> ');
        
        $('#xmjl').html(htmlMgr.join(''));
        removeIfNoValue($('#xmjl'));
        
        //  -- 加载项目经理 信息 结束 --
        html.push('  <li> ');
        html.push('    <span class="ban_gc_class_name">监理单位：</span> ');
        html.push('    <span class="ban_gc_class_info">'+Sys.encode(d.showMgrOrg)+ '(' + d.mgrOrgLevel + ')' + '</span>  ');
        html.push('  </li> ');
        html.push('  <li> ');
        html.push('    <span class="ban_gc_class_name">设计单位：</span> ');
        html.push('    <span class="ban_gc_class_info">'+Sys.encode(d.showDesignOrg)+ '(' + d.designOrgLevel + ')' +'</span> ');
        html.push('  </li>  ');
        html.push('  <li>');
        html.push('   <span class="ban_gc_class_name">开工日期：</span> ');
        html.push('   <span class="ban_gc_class_info">'+Sys.formatDate(d.prjStartTime, 'yyyy年M月d日')+'</span>  ');
        html.push('  </li> ');
        html.push('  <li>');
        html.push('    	<span class="ban_gc_class_name">竣工日期：</span> ');
        html.push('     <span class="ban_gc_class_info">'+Sys.formatDate(d.prjEndTime, 'yyyy年M月d日')+'</span> ');
        html.push('  </li> ');
        
        html.push('  <li> ');
        html.push('        <span class="ban_gc_class_name">核实列表：</span>  ');
        html.push('        <span class="ban_gc_class_info" id="span_cert_eng">[<a href="javascript:void(0);" onclick="engInfoCertList('+ d.bpeId +')" style="color: #169bd5;">查看详情</a>]');
        html.push('   	      <div class="ban_gc_detail_bg"  style="display: none;"  id="certEngInfo">');
         //加载 核实列表 信息
        html.push('           </div> ');
        html.push('        </span> ');
        html.push('  </li> ');
        
        html.push('  <li> ');
        html.push('    <span class="ban_gc_class_name">工程介绍：</span>');
        html.push('    <span class="ban_gc_class_info">'+Sys.encode(d.proIntro)+'</span> ');
        html.push('  </li> ');
        html.push('</ul> ');
        
        $('#gcgk').html(html.join(''));
		removeIfNoValue($('#gcgk'));
		
	}else{
		$("#gcgk-title").hide();
		$("#gcgk").hide();
		
		$("#xmjl-title").hide();
		$("#xmjl").hide();
	}
},false);

//加载项目业主
Sys.service.on('PrjOwnerService',function(d,ctx){
	var html = [];
	if(d){
		$('#ownerName').html(d.ownerShowName);
		
		var regFunds = isNaN(d.showRegFunds); //若返回true 则说明不是数字
		
		html.push('<ul class="ban_gaikuang_ul">');
        html.push('	    <li>');
        html.push('    	   <span class="ban_gc_class_name">成立时间：</span>');
        html.push('        <span class="ban_gc_class_info">'+ Sys.formatDate(d.registeredDate, 'yyyy年M月d日') +'</span>');
        html.push('   	</li> ');
        html.push('     <li>');
        html.push('    	   <span class="ban_gc_class_name">注册资本：</span>');
        html.push('        <span class="ban_gc_class_info">'+(regFunds ? d.showRegFunds : (!d.showRegFunds || d.showRegFunds === '' || d.showRegFunds === '0' ? '/' : Sys.formatNumber(d.showRegFunds,true,0)+'万元'))+'</span>');
        html.push('   	</li> ');
        
        html.push('     <li> ');
        html.push('        <span class="ban_gc_class_name">核实列表：</span>  ');
        html.push('        <span class="ban_gc_class_info" id="span_cert_owner">[<a href="javascript:void(0);" onclick="ownerInfoCertList('+ d.boId +')" style="color: #169bd5;">查看详情</a>]');
        html.push('   	      <div class="ban_gc_detail_bg"  style="display: none;"  id="certOwnerInfo">');
        //加载 核实列表 信息
        html.push('           </div> ');
        html.push('        </span> ');
        html.push('    </li> ');
    	
        html.push('    <li> ');
        html.push('    	   <span class="ban_gc_class_name">企业介绍：</span> ');
        html.push('        <span class="ban_gc_class_info">'+ Sys.encode(d.intro) +'</span>');
        html.push('   	</li>');
        html.push('</ul> ');
        
        $('#xmyz').html(html.join(''));
		removeIfNoValue($('#xmyz'));

	}else{
		$('#xmyz').hide();
        $('#xmyz-title').hide();
	}
},false);

//加载总包单位
Sys.service.on('PrjCtorService',function(d,ctx){
	var html = [];
	if(d){
		$('#ctorName').html(d.showName);
		
		var regFunds = isNaN(d.showRegFunds); //若返回true 则说明不是数字
		
		html.push('<ul class="ban_gaikuang_ul">');
        html.push('	   <li>  ');
        html.push('    	   <span class="ban_gc_class_name">成立时间：</span> ');
        html.push('        <span class="ban_gc_class_info">'+ Sys.formatDate(d.registeredDate, 'yyyy年M月d日') +'</span>  ');
        html.push('    </li> ');
        html.push('    <li>  ');
        html.push('    	   <span class="ban_gc_class_name">注册资本：</span>');
        html.push('        <span class="ban_gc_class_info">'+(regFunds ? d.showRegFunds : (!d.showRegFunds || d.showRegFunds==='0' || d.showRegFunds === '' ? '/' : Sys.formatNumber(d.showRegFunds,true,0)+'万元')) +'</span> ');
        html.push('    </li>   ');
        html.push('    <li>  ');
        html.push('    	   <span class="ban_gc_class_name">行业资质：</span> ');
        html.push('        <span class="ban_gc_class_info">'+ Sys.encode(d.qualification) +'</span> ');
        html.push('    </li>');
        if(d.lastedOutput > 0){
        	 html.push('    <li>  ');
             html.push('    	<span class="ban_gc_class_name">上一年度产值：</span> ');
             html.push('        <span class="ban_gc_class_info">'+ d.lastedOutput +'亿元</span> ');
             html.push('   	</li>');
		}
        html.push('    <li> ');
        html.push('    	<span class="ban_gc_class_name">所获奖项：</span>');
        var gcjArr = [];
		if(d.nationPrizeCount&&d.nationPrizeCount>0){
			gcjArr.push('全国性工程奖'+Sys.encode(d.nationPrizeCount)+'次');
		}
		if(d.provinPrizeCount&&d.provinPrizeCount>0){
			gcjArr.push('省（市）级工程奖'+Sys.encode(d.provinPrizeCount)+'次');
		}
		html.push('	    <span class="ban_gc_class_info">'+gcjArr.join(',')+'</span> ');

        html.push('    </li> ');
        
        html.push('     <li> ');
        html.push('        <span class="ban_gc_class_name">核实列表：</span>  ');
        html.push('        <span class="ban_gc_class_info" id="span_cert_ctor">[<a href="javascript:void(0);" onclick="ctorInfoCertList('+ d.bcoId +')" style="color: #169bd5;">查看详情</a>]');
        html.push('   	      <div class="ban_gc_detail_bg"  style="display: none;"  id="certCtorInfo">');
        //加载 核实列表 信息
        html.push('           </div> ');
        html.push('        </span> ');
        html.push('    </li> ');
        
        html.push('    <li> ');
        html.push('    	   <span class="ban_gc_class_name">企业介绍：</span>  ');
        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.intro)+'</span>');
        html.push('   	</li> ');
        html.push('</ul> ');
        
        $('#sgdw').html(html.join(''));
		removeIfNoValue($('#sgdw'));
	}else{
		$('#sgdw-title').hide();
		$('#sgdw').hide();
	}
	
},false);

//加载保障措施-机构
Sys.service.on('PrjGuaraOrgService',function(data,ctx){
	var html = [];
	var names = new Array();//所有担保人的名称
	if(data && data.length > 0){
		
		$.extend(g_prjGuaranOrg, data);
		
		// 按照pgId 先排序后再显示到页面
		data.sort(function(a,b){
			var ai = parseFloat($(a).attr('bgoId'),10);
			var bi = parseFloat($(b).attr('bgoId'),10);
			if(ai > bi){
				return 1;
			} else if(ai < bi){
				return -1;
			} else{
				return 0;
			}
		});
		
		$(data).each(function(i,d){
			html.push('<ul class="ban_gaikuang_ul">');
	        html.push('	    <li>');
	        html.push('    	   <span class="ban_gc_class_name">担保人：</span>');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.showName)+'</span>');
	        html.push('   	</li> ');
	        html.push('     <li>');
	        html.push('    	   <span class="ban_gc_class_name">担保方式：</span>');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.form)+'</span>');
	        html.push('   	</li> ');
	        html.push('	    <li>');
	        html.push('    	   <span class="ban_gc_class_name">与借款人关系：</span>');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.relationship)+'</span>');
	        html.push('   	</li> ');
	        
	        html.push('     <li> ');
	        html.push('        <span class="ban_gc_class_name">核实列表：</span>  ');
	        html.push('        <span class="ban_gc_class_info" id="span_cert_guara_org_'+ i +'">[<a href="javascript:void(0);" onclick="guaraOrgInfoCertList('+ i + ',' + d.bgoId +')" style="color: #169bd5;">查看详情</a>]');
	        html.push('   	      <div class="ban_gc_detail_bg"  style="display: none;"  id="certGuaraOrgInfo_'+ i +'">');
	        //加载 核实列表 信息
	        html.push('           </div> ');
	        html.push('        </span> ');
	        html.push('    </li> ');
	    	
	        html.push('    <li> ');
	        html.push('    	   <span class="ban_gc_class_name">担保范围：</span> ');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.range)+'</span>');
	        html.push('   	</li>');
	        html.push('    <li> ');
	        html.push('    	   <span class="ban_gc_class_name">担保期限：</span> ');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.limit)+'</span>');
	        html.push('   	</li>');
	        html.push('    <li> ');
	        html.push('    	   <span class="ban_gc_class_name">担保基本情况：</span> ');
	        html.push('        <span class="ban_gc_class_info">详见担保协议</span>');
	        html.push('   	</li>');
	        html.push('</ul><br/>');
        });
		//html.push('<div class="ban_danbao_beizhu" id="HTML2"></div>');
		$('#jkdb').html(html.join(''));
		
		//加载保障措施-个人数据
		prjGuaraInfo.pId = prj.pId;
		Sys.service.load('PrjGuaraService');
		
	}else{
		//加载保障措施-个人数据
		prjGuaraInfo.pId = prj.pId;
		Sys.service.load('PrjGuaraService');
	}
	
},false);

//加载保障措施-个人
Sys.service.on('PrjGuaraService',function(data,ctx){
	var html = [];
	var names = new Array();//所有担保人的名称
	if(data && data.length > 0){
		
		// 按照pgId 先排序后再显示到页面
		data.sort(function(a,b){
			var ai = parseFloat($(a).attr('bgpId'),10);
			var bi = parseFloat($(b).attr('bgpId'),10);
			if(ai > bi){
				return 1;
			} else if(ai < bi){
				return -1;
			} else{
				return 0;
			}
		});
		
		$(data).each(function(i,d){
			html.push('<ul class="ban_gaikuang_ul">');
	        html.push('	    <li>');
	        html.push('    	   <span class="ban_gc_class_name">担保人：</span>');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.showName)+'</span>');
	        html.push('   	</li> ');
	        html.push('     <li>');
	        html.push('    	   <span class="ban_gc_class_name">担保方式：</span>');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.form)+'</span>');
	        html.push('   	</li> ');
	        html.push('	    <li>');
	        html.push('    	   <span class="ban_gc_class_name">与借款人关系：</span>');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.relationship)+'</span>');
	        html.push('   	</li> ');
	        
	        html.push('     <li> ');
	        html.push('        <span class="ban_gc_class_name">核实列表：</span>  ');
	        html.push('        <span class="ban_gc_class_info" id="span_cert_guara_'+ i +'">[<a href="javascript:void(0);" onclick="guaraInfoCertList('+ i + ',' + d.bgpId +')" style="color: #169bd5;">查看详情</a>]');
	        html.push('   	      <div class="ban_gc_detail_bg"  style="display: none;"  id="certGuaraInfo_'+ i +'">');
	        //加载 核实列表 信息
	        html.push('           </div> ');
	        html.push('        </span> ');
	        html.push('    </li> ');
	    	
	        html.push('    <li> ');
	        html.push('    	   <span class="ban_gc_class_name">担保范围：</span> ');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.range)+'</span>');
	        html.push('   	</li>');
	        html.push('    <li> ');
	        html.push('    	   <span class="ban_gc_class_name">担保期限：</span> ');
	        html.push('        <span class="ban_gc_class_info">'+Sys.encode(d.limit)+'</span>');
	        html.push('   	</li>');
	        html.push('    <li> ');
	        html.push('    	   <span class="ban_gc_class_name">担保基本情况：</span> ');
	        html.push('        <span class="ban_gc_class_info">详见担保协议</span>');
	        html.push('   	</li>');
	        html.push('</ul><br/>');
        });
		//html.push('<div class="ban_danbao_beizhu" id="HTML2"></div>');
		$('#jkdb').append(html.join(''));
		
	}else if(!g_prjGuaranOrg[0]){
		$('#jkdb-title').hide();
		$('#jkdb').hide();
	}
	
},false);

//加载还款计划
Sys.service.on('PrjRepayPlanService',function(data,ctx){
	var html = [],totalNo = 0;
	if(data && data.length > 0){
		
		$(data).each(function(i,d){
			totalNo = Math.max(totalNo,d.tranNo);
		});
		html.push('<ul class="ban_df_all"> ');
        html.push('	  <li class="ban_table_tr"> ');
        html.push('    	   <span class="ban_table_tr_span">期次</span>  ');
        html.push('        <span class="ban_table_tr_span">类型</span>');
        html.push('        <span class="ban_table_tr_span">状态</span>  ');
        html.push('    </li> ');
        
        $(data).each(function(i,d){
        	html.push('    <li class="ban_table_th hk-show" > ');
	        html.push('    	   <span class="ban_table_tr_span">'+d.tranNo+'/'+totalNo+'</span> ');
	        html.push('        <span class="ban_table_tr_span">'+(d.tranType==0?'利息':'本金')+'</span>  ');
	        html.push('        <span class="ban_table_tr_span">'+Sys.UserBonusMapping[d.status]+'</span> ');
	        html.push('        <div class="ban_table_spoint_top" style="cursor:pointer">∨</div> ');
	        html.push('    </li>');
	        html.push('    <li class="ban_table_th_info "  style="display:none">');
	        html.push('    	<ul class="ban_tab_ul">');
	        html.push('        	<li class="ban_table_tr">');
	        html.push('            	   <span class="ban_tab_ul_span">计划还款</span>');
	        html.push('                <span class="ban_tab_ul_span">实际还款</span>');
	        html.push('            </li> ');
	        html.push('            <li> ');
	        html.push('            	   <span class="ban_tab_ul_span">'+Sys.formatDate(d.dueTime, 'yyyy年MM月dd日')+'<i class="ban_tab_ul_span_i">'+(d.amt === '0'? '</i></span>' :Sys.formatNumber(d.amt,true,2)+'元</i></span>' ));
	        html.push('                <span class="ban_tab_ul_span">'+(d.paidTime&&d.status===1 ?Sys.formatDate(d.paidTime, 'yyyy年MM月dd日'):'')+'<i class="ban_tab_ul_span_i">'+(d.paidAmt === '0'? '</i></span>' :Sys.formatNumber(d.paidAmt,true,2)+'元</i></span>' ));
	        html.push('           	</li> ');
	        html.push('        </ul>');
	        html.push('    </li>');
        });
        
        html.push('</ul><br/> ');
        
        html.push('<div class="ban_danbao_beizhu" id="HTML4">  </div>');
		$('#hkjh').html(html.join(''));
		
		$('.hk-show').on('click',function(){
			var next = $(this).next();
			if(next.is(':hidden')){
				$(this).children('.ban_table_spoint_top').html('>');
				next.show();
			}else{
				$(this).children('.ban_table_spoint_top').html('∨');
				next.hide();
			}
		});
        
	}else{
		$('#hkjh-title').hide();
		$('#hkjh').hide();
	}
	
},false);

//加载项目评级
Sys.service.on('PrjRatingService',function(d,ctx){
	var html = [];
	if(d){
		html.push('<div class="ban_pj_box"> ');
        html.push('	<div class="ban_pj_right">借贷项目总分：<i>'+d.sAll+'</i>分</div>借贷项目评级：<i>'+d.prjRating+'</i> ');
        html.push('</div> ');
        html.push('<ul class="ban_df_all"> ');
        html.push('	<li class="ban_all_num_hui"> ');
        html.push('    	<span class="ban_class_name_span">工程概况得分</span><span class="ban_all_num_hui_span"><i>'+d.sEngineering+'</i>分</span></li>');
        html.push('    <li><span class="ban_class_name_span">项目经理得分</span><span class="ban_all_num_hui_span"><i>'+d.sProjMgr+'</i>分</span></li>');
        html.push('    <li class="ban_all_num_hui"><span class="ban_class_name_span">施工单位得分</span><span class="ban_all_num_hui_span"><i>'+d.sCtor+'</i>分</span></li> ');
        html.push('    <li><span class="ban_class_name_span">项目业主得分</span><span class="ban_all_num_hui_span"><i>'+d.sOwner+'</i>分</span></li> ');
        html.push('    <li class="ban_all_num_hui"><span class="ban_class_name_span">借款担保得分</span><span class="ban_all_num_hui_span"><i>'+d.sGuarantee+'</i>分</span></li> ');
        html.push('</ul> ');
        html.push('<div class="ban_danbao_beizhu" id="HTML3">');
        html.push('</div> ');
        
        $('#xmpj').html(html.join(''));
        
        if(d.prjRating === '-1'){
        	$('#xmpj-title').hide();
			$('#xmpj').hide();
        }
        
	}else{
		$('#xmpj-title').hide();
		$('#xmpj').hide();
	}
},false);

//加载项目备注
Sys.service.on('PrjRemarkService',function(data,ctx){
	$(data).each(function(i,d){
		//1-项目介绍  2-项目担保备注  3-项目评级备注  4-还款计划备注    10-个人借款概况   11- 企业借款概况
		var k = d.type;
		var v= d.content;
		var con = $("#HTML"+k);
		if(k === 1){
			con.html(v);
		}else{
			if(v === null && v === ""){
				con.html();
			}else{
				con.html("备注："+v);
			}
		}
		
	});
    
},false);

////核实列表-start////////////

var certsInfo = {}; // 核实列表
var mgrCertsInfo = {}; // 核实列表-项目经理
var g_cert_list = {};

var eCertArray = new Array();
var dataArray = new Array();

var eMgrCertArray = new Array();
var dataMgrArray = new Array();

/**
* 核实列表-除项目经理之外的都调用此服务

* 借款机构核实列表文件	  23
* 工程项目核实列表文件	  24
* 担保机构核实列表文件	  25
* 项目业主核实列表文件          26
* 项目经理核实列表文件          27
* 借款人核实列表文件	  28
* 项目施工单位核实列表文件  29
* _parentName 只有项目经理核实列表才传此参数过来
*/
Sys.service.on('CertsListService', function(data){
    if(data && data.length > 0){
		
		var html = new Array();
		var n = 0;
		eCertArray.splice(0,eCertArray.length);
		
		html.push(' <table align="center" border="0" cellpadding="0" cellspacing="1" style="width: 100%">');
        html.push('    <tr>  ');
        html.push('      <td colspan="2"> ');
        html.push('         <table align="center" border="0" cellpadding="0" cellspacing="1" style="width: 100%"> ');
        html.push('             <tr> ');
        html.push('               <th  style="width:70px;">序号</th><th  style="width:150px;">项目</th><th  style="width:160px;">核实状态</th><th  style="width:190px;">操作</th> ');
        html.push('             </tr>  ');
        
		$.each(g_cert_list.info, function(i,da){
			
			$(data).each(function(j,d){
			
				if(d.name.indexOf('.') >= 0){
					d.name = d.name.split('.')[0];
				}
				
				if(da.certName === d.name){
					n = n + 1 ;
					
					var eImgInfo = {};
					eImgInfo.name = da.certName;
					eImgInfo.certImg = da.certImg;
					eCertArray.push(eImgInfo);
					
			        html.push('  <tr>  ');
			        html.push('    <td>'+ n +'</td><td>'+ da.certName +'</td><td style="color: #20ae1e; font-weight: bold">'+ da.certImg +'</td><td>[<a href="javascript:void(0);" onclick="viewPrompt();" style="color: #169bd5;">查看文件</a>]</td>  '); // √
			        html.push('  </tr> ');
			        
				}  
			
			});
		
		});
		
		// 将 文件名 不在预先指定的文件名中的文件 取出来排到核实列表后面
		// 将与certlist.info中不匹配的其他核实信息 排到 核实列表 后面
        var otherCertImg = g_cert_list.info[0].certImg; 
        dataArray.splice(0,dataArray.length);
        
		$.each(data, function(k,dd){
			if(dd.name.indexOf('.') >= 0){
				dd.name = dd.name.split('.')[0];
			}
			
			var dataInfo = {};
			dataInfo.name = dd.name;
			dataArray.push(dataInfo); //将json串转换为数组
		});
		
		//临时数组存放
		var tempArray1 = [];//临时数组1
		var otherImgArray = [];
		
		for(var i = 0; i < eCertArray.length; i++){
			
		    tempArray1[eCertArray[i].name] = true; // 将数组 eCertArray 中的元素值作为tempArray1 中的键，值为true；
		}

		for(var i = 0; i < dataArray.length; i++){
			
		    if(!tempArray1[dataArray[i].name]){
		    	
		    	otherImgArray.push(dataArray[i]); // 过滤 eCertArray 中与 dataArray 相同的元素,返回过滤后的 dataArray；
		    }
		}
		
		if(otherImgArray.length > 0){
			
			for(var j = 0; j < otherImgArray.length; j++){
				
				n = n + 1;
				
				html.push('  <tr>  ');
			    html.push('    <td>'+ n +'</td><td>'+ otherImgArray[j].name +'</td><td style="color: #20ae1e; font-weight: bold">'+ otherCertImg +'</td><td>[<a href="javascript:void(0);" onclick="viewPrompt();" style="color: #169bd5;">查看文件</a>]</td>  '); // √
			    html.push('  </tr> ');
				
			    $('#'+ certsInfo.divId).html(html.join(''));
			}
		}else{
			
			$('#'+ certsInfo.divId).html(html.join(''));
		}
		
		
		
		html.push('         </table>  ');
	    html.push('     </td> ');
	    html.push('   </tr> ');
	    html.push(' </table>  '); 
	}
},false);

/**
 * 项目经理单独调用此服务，因为这个要多传一个参数_parentName
 *  项目经理-核实列表文件          27
 * _parentName 只有项目经理核实列表才传此参数过来
 */
Sys.service.on('PrjMgrCertsListService', function(data){
    if(data && data.length > 0){
		
		var html = new Array();
		var n = 0;
		eMgrCertArray.splice(0,eMgrCertArray.length);
		
		html.push(' <table align="center" border="0" cellpadding="0" cellspacing="1" style="width: 100%">');
        html.push('    <tr>  ');
        html.push('      <td colspan="2"> ');
        html.push('         <table align="center" border="0" cellpadding="0" cellspacing="1" style="width: 100%"> ');
        html.push('             <tr> ');
        html.push('               <th  style="width:70px;">序号</th><th  style="width:150px;">项目</th><th  style="width:160px;">核实状态</th><th  style="width:190px;">操作</th> ');
        html.push('             </tr>  ');
        
		$.each(g_cert_list.info, function(i,da){
			
			$(data).each(function(j,d){
			
				if(d.name.indexOf('.') >= 0){
					d.name = d.name.split('.')[0];
				}
				
				if(da.certName === d.name){
					n = n + 1 ;
					
					var eImgInfo = {};
					eImgInfo.name = da.certName;
					eImgInfo.certImg = da.certImg;
					eMgrCertArray.push(eImgInfo);
					
			        html.push('  <tr>  ');
			        html.push('    <td>'+ n +'</td><td>'+ da.certName +'</td><td style="color: #20ae1e; font-weight: bold">'+ da.certImg +'</td><td>[<a href="javascript:void(0);" onclick="viewPrompt();" style="color: #169bd5;">查看文件</a>]</td>   '); // √
			        html.push('  </tr> ');
			        
				}  
			
			});
		
		});
		
		// 将 文件名 不在预先指定的文件名中的文件 取出来排到核实列表后面
		// 将与certlist.info中不匹配的其他核实信息 排到 核实列表 后面
        var otherCertImg = g_cert_list.info[0].certImg; 
        dataMgrArray.splice(0,dataMgrArray.length);
        
		$.each(data, function(k,dd){
			
			if(dd.name.indexOf('.') >= 0){
				dd.name = dd.name.split('.')[0];
			}
			
			var dataInfo = {};
			dataInfo.name = dd.name;
			dataMgrArray.push(dataInfo); //将json串转换为数组
		});
		
		//临时数组存放
		var tempArray1 = [];//临时数组1
		var otherImgArray = [];
		
		for(var i = 0; i < eMgrCertArray.length; i++){
			
		    tempArray1[eMgrCertArray[i].name] = true; // 将数组 eMgrCertArray 中的元素值作为tempArray1 中的键，值为true；
		}

		for(var i = 0; i < dataMgrArray.length; i++){
			
		    if(!tempArray1[dataMgrArray[i].name]){
		    	
		    	otherImgArray.push(dataMgrArray[i]); // 过滤 eMgrCertArray 中与 dataMgrArray 相同的元素,返回过滤后的 dataArray；
		    }
		}
		
		if(otherImgArray.length > 0){
			for(var j = 0; j < otherImgArray.length; j++){
				n = n + 1;
				
				html.push('  <tr>  ');
			    html.push('    <td>'+ n +'</td><td>'+ otherImgArray[j].name +'</td><td style="color: #20ae1e; font-weight: bold">'+ otherCertImg +'</td><td>[<a href="javascript:void(0);" onclick="viewPrompt();" style="color: #169bd5;">查看文件</a>]</td>  '); // √
			    html.push('  </tr> ');
				
				
			    $('#'+ mgrCertsInfo.divId).html(html.join(''));	
				
			}
		}else{
			$('#'+ mgrCertsInfo.divId).html(html.join(''));	
		}
		
		html.push('         </table>  ');
	    html.push('     </td> ');
	    html.push('   </tr> ');
	    html.push(' </table>  '); 
	}
},false);

////核实列表-end////////////

////////////////////////////////////////
//All private functions
////////////////////////////////////////

function initInvestBtn(){
	
	var st = Sys.getStatusNameById(prj.status, prj.isInner, prj.financingEndTime);

	$('#investDiv').html('<a href="javascript:;" id="investBtn" class="'+st.bClassName+'">'+st.statusTxt+'</a>');
	$('#investBtn').filter(function(){
		return $(this).hasClass('ban_tz_color');
	}).on('click',doInvest);
}

function doInvest(){
	 if(accInfo.valid){
			var html = [];
			html.push('<div class="ban_zhezhao_box" style="padding:0"> ');
			html.push('    <div class="ban_sprice_num"><div class="ban_ke_font">还需借：</div><div class="ban_ketou_num">'+Sys.formatNumber(prj.amt - prj.investedAmt,true,2)+'<i>元</i></div></div> ');
			html.push('    <div class="ban_sprice_num"><div class="ban_ke_font">账户可用余额：</div><div class="ban_ketou_num">'+Sys.formatNumber(balanceAmt,true,2)+'<i>元</i></div></div>');

			if(prj.contract&&prj.contract>=0){
				var cts = Sys.getContractsByNum(prj.contract);
				var ctsHtml = [];
				prj.xyName = [];
				for(var i=0;i<cts.length;i++){
					if(cts[i].name.indexOf('应收账款质押合同')>=0){
						continue;
					}
					prj.xyName.push('《'+cts[i].name+'》');
					ctsHtml.push('<a  href="javascript:void(0);" onclick="viewPrompt()" class="ban_detailed_agree_a">《'+cts[i].name+'》</a>');
				}
				html.push('    <div class="ban_detailed_agree"> ');
				html.push('      <input name="agree" id="agree" type="checkbox" value="" class="ban_detailed_agree_checkbox" />                                                                                                                                                                     ');
				html.push('      <span >我已阅读并同意'+ctsHtml.join('、')+'、<a href="javascript:;" onclick="viewPrompt()" class="ban_detailed_agree_a">《风险提示》</a>、<a  href="javascript:;"  onclick="viewPrompt()" class="ban_detailed_agree_a">《禁止性行为提示》</a></span>  </div>   ');
			}
			
			html.push('    <div class="ban_single_input_u_c"> ');
			html.push('      <input type="number" id="inviteNum" class="ban_infobox_input ban_single_input_c" placeholder="请输入出借额（'+(prj.perInvestAmt||1000)+'的整数倍）"> ');
			html.push('      <div class="ban_single_input_u">元</div>  ');
			html.push('    </div> ');
			html.push('    <div class="ban_quicky_touzi"><a id="innerInvestBtn" href="javascript:;">立即出借</a></div> ');
			html.push('</div> ');
			
			dialog({
			      title: '项目出借',
			      content: html.join(''),
			      width:'320',
			      height:'100%',
			      fixed: true,
			      zIndex:98,
			      lock:true,
			      quickClose: false
			    }).showModal();
			
			$('#innerInvestBtn').on('click',investAtOnce);
			$('#inviteNum').onEnter(investAtOnce);
	}else{
		toLogin();
	}
}

function investAtOnce(){
	$("#infoMsg").hide();
	
	var project = prj;
	if(prj.xyName && prj.xyName.length > 0){
		if(!$('#agree').is(':checked')){
			Sys.errorDlg('请勾选“我已阅读并同意' + prj.xyName.join('、') + '、《风险提示》、《禁止性行为提示》，再进行下一步操作！');
			return;
		}
	}
	
	if(!validateInviteNum()){
		return;
	}
	
	if(prj.financingEndTime - serverTime().getTime() <= 0){
		Sys.errorDlg('募集时间已经截止！');
		return;
	}
	
	submitTsTender();
	
	/* var inviteNum = $.trim($("#inviteNum").val()),kt = project.amt-project.investedAmt,maxMoney = Math.min(kt,project.investMaxAmt||project.amt);//最大出借额为 还需借金额与项目最大可投限额的最小值
	var perMoney = project.perInvestAmt||100,min = Math.max(perMoney,project.perInvestMinAmt);//每份投资金额默认100；最小出借额为“每份投资金额”与“数据库中最小出借额”的最大值
	
	if(kt>=min){//如果还需借金额大于等于最小出借额
		if(inviteNum<min){//如果投资金额小于最小投资限额
			$("#inviteNum").val(min); 
			Sys.confirmDlg('出借金额小于最小出借金额，系统自动将出借金额调整为，我们已将您的出借金额调整为<span style="font-size:26px;color:#d9272e;">&nbsp;'+Sys.formatNumber(min,true,0)+'&nbsp;</span>元，请确认是否继续！',"提示","是","否",function(){
				submitTsTender();
			},function(){
			});
		}else if(inviteNum > kt){ //若 输入的投资金额  大于  剩余可投金额;提示 当前仅还需借kt，我们已将您的出借金额调整为kt
			$("#inviteNum").val(kt); 
			Sys.confirmDlg('出借金额大于项目还需借金额，系统自动将出借金额调整为，我们已将您的出借金额调整为<span style="font-size:26px;color:#d9272e;">&nbsp;'+Sys.formatNumber(kt,true,0)+'&nbsp;</span>元，请确认是否继续！',"提示","是","否",function(){
				submitTsTender();
			},function(){
			});
		}else if(inviteNum%perMoney!=0){
			var v = Math.ceil(inviteNum/perMoney)*perMoney;
			$("#inviteNum").val(v);
			Sys.confirmDlg('出借金额必须是'+perMoney+'的倍数，系统自动将出借金额调整为<span style="font-size:26px;color:#d9272e;">&nbsp;'+Sys.formatNumber(v,true,0)+'&nbsp;</span>元，请确认是否继续！',"提示","是","否",function(){
				submitTsTender();
			},function(){
			});
			
		}else{
			submitTsTender();
		}
	}else{
		if(inviteNum!=kt){
			$("#inviteNum").val(kt); 
			Sys.confirmDlg('出借金额大于项目还需借金额，系统自动将出借金额调整为，我们已将您的出借金额调整为<span style="font-size:26px;color:#d9272e;">&nbsp;'+Sys.formatNumber(kt,true,0)+'&nbsp;</span>元，请确认是否继续！',"提示","是","否",function(){
				submitTsTender();
			},function(){
			});
		}else{
			submitTsTender();
		}
	} */

}

/**
 * 验证投资金额
 */
function validateInviteNum(){
	
	var inviteNum = $.trim($("#inviteNum").val());
	if(inviteNum==""){
		Sys.errorDlg('请输入出借金额！');
		return false;
	}else if(isNaN(inviteNum)){
		Sys.errorDlg('出借金额必须是数字！');
		return false;
	}else if(inviteNum.indexOf('.') >= 0){
		Sys.errorDlg('出借金额必须是整数！');
		return false;
	}else if(inviteNum === "0"){
		Sys.errorDlg('出借金额必须大于0！');
		return false;
	}
	return true;
}

function submitTsTender(){
	var form = $("#tenderForm");
	var amtField = $('input[name="amt"]',form);
	var pIdField = $('input[name="pId"]',form);
	
	form.attr('action', Sys.evalUrl('/project/to-pay.html'));
	amtField.val($.trim($("#inviteNum").val()));
	pIdField.val(prj.pId);
	
	//提交到to-pay.html
	form.submit();
}

function renderTitle(){
	var html = [];
	
	var isNewer = (prj.flags & 0x0001) !== 0;
	var st = Sys.getStatusNameById(prj.status, null, prj.financingEndTime);
	var ptm = Sys.ProTypeMapping(prj.type,prj.flags);

	html.push('<div class="ban_name_left">');
	html.push('<div class="ban_project_pingji_a2">'+ prj.prjRating +'</div>');
	html.push(' <div class="ban_case_class '+ptm.cls+' ban_detail_c" >'+(ptm.firstWord || ptm.name.substring(0,1))+'</div>  ');
	
	html.push('</div>  ');
	html.push('<div class="ban_name_right">');
	html.push('	<div class="ban_detail_name">'+prj.itemShowName+'</div>');
	html.push('    <div class="ban_det_box"> ');
	html.push('    	<div class="ban_p_bianhao">'+ prj.itemNo +'</div> ');
	html.push('        <div class="ban_p_time _refreshDate" extra="'+st.showCountDown+'" name="'+prj.financingEndTime+'">'+(st.showCountDown === 'show' ? (Sys.countDownTime(prj.financingEndTime) <= 0 ? '已截止' : Sys.formatTime(Sys.countDownTime(prj.financingEndTime))) : (st.showCountDown === 'end' ? '已截止' : ''))+'</div>           ');
	html.push('    </div> ');
	html.push('</div> ');
	
	$('#title').html(html.join(''));
}

function renderHeader(){
	var html = [];
	prj.rate = prj.rate+'';
	var rate = prj.rate.indexOf('.')>0?prj.rate.split('.'):[prj.rate,''];
    
    html.push('<li class="ban_detail_li_left">借款金额：<i>'+(prj.amt/10000)+'</i>万元</li>  ');
    html.push('<li class="ban_detail_li_right">借款利率：<i>'+rate[0]+'<em>'+(rate[1]==''?'':'.'+rate[1])+'</em></i>%</li>');
    html.push('<li class="ban_detail_li_left">借款天数：'+prj.borrowDays+'天</li> ');
    html.push((parseFloat(prj.timeOutRate) === 0) ? '' : '<li class="ban_detail_li_right">逾期利率：<i>'+prj.timeOutRate+'</i>%</li>');
    //html.push('<li class="ban_detail_li_left">允许展期：'+prj.extensionDays+'天</li> ');
    //html.push((parseFloat(prj.extensionRate) === 0) ? '' : '<li class="ban_detail_li_right">展期利率：<i>'+prj.extensionRate+'</i>%</li>  ');
    //html.push('<li class="ban_detail_li_left">预计放款日期：'+Sys.formatDate(prj.loanTime,'yyyy-MM-dd')+'</li>');
    
    $('#header').html(html.join(''));
}

function initTab(){
	$('.ban_d_tab_hui').on('click',function(){
		var next = $(this).next(),expand = next.is(':hidden');
		if(expand){
			next.show();
			$(this).children('a').html('-&nbsp;收起');
		}else{
			next.hide();
			$(this).children('a').html('+&nbsp;展开');
		}
		
	});
}

function viewPlatformCredit(pId,bpmId){
	var url = PortalPath+'/project/credit-list.html?pId='+id+'&bpmId='+bpmId;
	dialog({
	      title: '项目借款记录',
	      content: '<iframe frameborder="0" width="100%" height="480" src="'+url+'" />',
	      width:'100%',
	      height:'100%',
	      fixed: true,
	      lock:true,
	      zIndex:99999,
	      quickClose: false
	    }).showModal();
		
}

function removeIfNoValue(p){
	p.find('span.ban_gc_class_info').each(function(){
		if($.trim($(this).html()) === ''){
			$(this).parent().hide();
		}
	});
}

/**
 * 借款机构-核实列表
 */
function borrowOrgInfoCertList(index,bpmoId){
	//加载 核实列表 信息
    g_cert_list = Sys.getCertNameByType(23);
	$.extend(certsInfo, {'fileType' : 23, 'objectId' : bpmoId, 'divId' : 'certBorrowOrgInfo_'+ index});
	Sys.service.load('CertsListService',{},true);
	
	var certInfo = $('#certBorrowOrgInfo_'+ index);
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_borrow_org_'+ index).children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_borrow_org_'+ index).children('a').html('查看详情');
	}
}

/**
 * 借款人-核实列表
 */
function borrowInfoCertList(index,bpmId){
	//加载 核实列表 信息
	g_cert_list = Sys.getCertNameByType(28);
	$.extend(certsInfo, {'fileType' : 28, 'objectId' : bpmId, 'divId' : 'certBorrowInfo_'+ index});
	Sys.service.load('CertsListService',{},true);

	var certInfo = $('#certBorrowInfo_'+ index);
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_borrow_'+ index).children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_borrow_'+ index).children('a').html('查看详情');
	}

}

/**
 * 保障措施-核实列表-机构
 * bgoId
 */
function guaraOrgInfoCertList(index,bgoId){
	//加载 核实列表 信息
    g_cert_list = Sys.getCertNameByType(25);
	$.extend(certsInfo, {'fileType' : 25, 'objectId' : bgoId, 'divId' : 'certGuaraOrgInfo_'+ index});
	Sys.service.load('CertsListService',{},true);
	
	var certInfo = $('#certGuaraOrgInfo_'+ index);
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_guara_org_'+ index).children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_guara_org_'+ index).children('a').html('查看详情');
	}
}

/**
 * 保障措施-核实列表-个人
 * bgpId,以已快照表为主
 */
function guaraInfoCertList(index,bgpId){
	//加载 核实列表 信息
    g_cert_list = Sys.getCertNameByType(22);
	$.extend(certsInfo, {'fileType' : 22, 'objectId' : bgpId, 'divId' : 'certGuaraInfo_'+ index});
	Sys.service.load('CertsListService',{},true);
	
	var certInfo = $('#certGuaraInfo_'+ index);
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_guara_'+ index).children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_guara_'+ index).children('a').html('查看详情');
	}
}


/**
 * 工程概况-核实列表
 */
function engInfoCertList(bpeId){
	//加载 核实列表 信息
    g_cert_list = Sys.getCertNameByType(24);
	$.extend(certsInfo, {'fileType' : 24, 'objectId' : bpeId, 'divId' : 'certEngInfo'});
	Sys.service.load('CertsListService',{},true);
	
	var certInfo = $('#certEngInfo');
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_eng').children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_eng').children('a').html('查看详情');
	}
}

/**
 * 项目业主-核实列表
 */
function ownerInfoCertList(boId){
	//加载 核实列表 信息
    g_cert_list = Sys.getCertNameByType(26);
	$.extend(certsInfo, {'fileType' : 26, 'objectId' : boId, 'divId' : 'certOwnerInfo'});
	Sys.service.load('CertsListService',{},true);
	
	var certInfo = $('#certOwnerInfo');
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_owner').children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_owner').children('a').html('查看详情');
	}
}

/**
 * 总包单位-核实列表
 */
function ctorInfoCertList(bcoId){
	//加载 核实列表 信息
    g_cert_list = Sys.getCertNameByType(29);
	$.extend(certsInfo, {'fileType' : 29, 'objectId' : bcoId, 'divId' : 'certCtorInfo'});
	Sys.service.load('CertsListService',{},true);
	
	var certInfo = $('#certCtorInfo');
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_ctor').children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_ctor').children('a').html('查看详情');
	}
}

/**
 * 项目经理-核实列表
 */
function mgrInfoCertList(bpeId,parName){
	//加载 核实列表 信息
    g_cert_list = Sys.getCertNameByType(27);
	$.extend(mgrCertsInfo, {'fileType' : 27, 'objectId' : bpeId, 'divId' : 'certMgrInfo', 'parentName' : parName});
	Sys.service.load('PrjMgrCertsListService',{},true);
	
	var certInfo = $('#certMgrInfo');
	if(certInfo.is(':hidden')){
		certInfo.show();
		$('#span_cert_mgr').children('a').html('收起详情');
	}else{
		certInfo.hide();
		$('#span_cert_mgr').children('a').html('查看详情');
	}
}


function feeTableView(){
	var feeInfo = $("#feeInfo");
	if(feeInfo.is(":hidden")){
		feeInfo.show();
		$("#span_fee").children('a').html('收起居间服务费用');
	}else{
		feeInfo.hide();
		$("#span_fee").children('a').html('详见居间服务费用');
	}
	
}

function viewPrompt(){
	Sys.infoDlg('因手机限制无法显示，请电脑登录后查看详细内容！');
}
</script>
</body>
</html>
