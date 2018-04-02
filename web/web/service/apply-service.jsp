<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>

  <%@include file="../inc/head-page.jsp"%>
  <div class="bm_less_head bm_content_bottom">
  <div class="bm_less_head_tab">
		<h2 class="bm_less_head_title" style="color: #d70c18;margin-top:10px;">服务申请</h2>
	</div>
	<div class="bm_content">
	    <div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
	    
	    <div id="infoMsg" class="dealInfoMsg" style="display:none;"></div>
	    <div class="mask" id="dealMask" style="display:none;"></div>
	    
	    <div class="bm_wrapper">
		    <h2 class="bm_less_head_title">填写服务申请信息</h2>
			<form id="applyServiceForm" method="put" action="">
			<div class="bm_box">
				<div class="bm_boxlabel">申请人姓名</div>
				<div class="bm_boxrow">
					<div class="bm_boximport">
						<label>
							<input type="text" name="name" class="bm_intext _required _length" min="1" max="30" placeholder="身份证姓名"></label>
					</div>
				</div>
				<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>
			<div class="bm_box">
				<div class="bm_boxlabel">手机号</div>
				<div class="bm_boxrow">
					<div class="bm_boximport">
						<label>
							<input type="text" name="mobile" class="bm_intext _required _phone" placeholder="请输入11位手机号"></label>
					</div>
				</div>
				<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>
			<div class="bm_box">
				<div class="bm_boxlabel">身份证号</div>
				<div class="bm_boxrow">
					<div class="bm_boximport">
						<label>
							<input type="text" name="id-card" class="bm_intext _idcard" placeholder="请输入身份证号"></label>
					</div>
				</div>
				<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>
			<div class="bm_box">
				<div class="bm_boxlabel">联系地址</div>
				<div class="bm_boxrow">
					<div class="bm_boximport">
						<label>
							<input type="text" name="address" 
											class="bm_intext _required _length" min="1" max="50" placeholder="" />
							</label>
					</div>
				</div>
				<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>
			
			<div class="bm_box">
				<div class="bm_boxlabel">预约时间</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<input type="text" class="bm_intext" name="due-time" placeholder="预约日期"  onfocus="WdatePicker({isShowWeek:true,dateFmt:'yyyy-MM-dd'})"/>
						</div>
					</div>
					<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>
			<div class="bm_box">
				<div class="bm_boxlabel">服务名称</div>
								<div class="bm_boxrow">
									<div class="bm_boximport">
										<input type="text" name="service-name" 
											class="bm_intext _required _length" min="1" max="30"  placeholder="" />
									</div>
								</div>
								<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>
			<div class="bm_box">
				<div class="bm_boxlabel">服务类型</div>
							<div class="bm_boxrow">
								<select class="bm_intext _required" name="service-type">
									<option selected="selected" value="">请选择</option>
						            <option value="台式机维修">台式机维修</option>
						            <option value="笔记本维修">笔记本维修</option>
						            <option value="空调维修">空调维修</option>
						            <option value="电视机维修">电视机维修</option>
						            <option value="其他电子类产品维修">其他电子类产品维修</option>
								</select>
							</div>
							<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>
			<div class="bm_box">
				<div class="bm_boxlabel">服务描述</div>
								<div class="bm_boxrow">
									<div class="bm_boximport">
										<textarea name="content" cols="" rows="" class="bm_intext _required _length" min="1" max="800"
											placeholder="400字以内"></textarea>
									</div>
								</div>
								<div class="bm_box_cue" style="display: none;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
			</div>

			<div class="bm_button" style="margin-bottom:220px">
				<a href="javascript:void(0);" id="submitBtn" class="bm_button_hilite">提交申请</a>
			</div>
			
			</form>
		</div>
	</div>
  </div>
		<%@include file="../inc/bottom-page.jsp"%>

	
<script type="text/javascript">
g_showUserInfo = false;  // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
var gCfg = {boxClass:'bm_box',eBoxClass:'bm_box_cue',errMsg:'<div class="bm_box_cue_arrow"></div><p class="bm_box_cue_p bm_box_cue_hilite" >#[msg]</p>'};

$(function(){
	
	$('#submitBtn').on('click',submitForm);
	
    $('.dealInfoMsg').on('click',hideMask);
	
	$('#dealMask').on('click',hideMask);
	
	
});

var ApplyServiceInfo = {};
Sys.service.on('ApplyService',function(data){
	if(data){
		$('.dealInfoMsg').html('恭喜你，提交申请成功！请至账户中心查询服务状态！').show();
		$('#dealMask').show();
	}
},false);


////////////////////////
//All private functions
///////////////////////
function hideMask(){
	window.location.assign(Sys.evalUrl('/index.html'));
	$('.dealInfoMsg').hide();
	$('#dealMask').hide();
}

function submitForm(){
	
	var form = $('#applyServiceForm'),params = form.serializeObject();
	if(form.validateForm(gCfg)){
		var url = form.attr('action');
		$.extend(ApplyServiceInfo, {m:form.attr('method'), u:url, p : params});
		Sys.service.load('ApplyService',{},true);
	}
}

</script>
</body>
</html>
