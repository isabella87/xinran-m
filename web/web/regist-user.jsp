<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="inc/common.jsp"%>

<body>
	<%@include file="inc/head-page.jsp"%>
	<div class="bm_less_head">
		<div class="bm_less_head_tab">
			<ul class="bm_less_head_tab_ul" id="titleUl">
				<li id="titleLi1" class="bm_less_head_tab_li_current"><a
					href="javascript:void(0)" class="bm_less_head_tab_a">1.查看协议</a></li>
				<li id="titleLi2" class="bm_less_head_tab_li"><a
					href="javascript:void(0)" class="bm_less_head_tab_a">2.账号信息</a></li>
				<li id="titleLi3" class="bm_less_head_tab_li"><a
					href="javascript:void(0)" class="bm_less_head_tab_a">3.完成注册</a></li>
			</ul>
		</div>
	</div>
	
	<div id="errMsg"  style="display:none;"></div>
    <div id="infoMsg" style="display:none;"></div>
    <div class="mask" id="mask" style="display:none;"></div>
        	
	<div class="bm_content bm_content_bottom">
		<div class="bm_wrapper">
			<h2 class="bm_less_head_title">注册</h2>
			<form  name="regForm1" method="POST" action="">
				<%-- <div class="bm_box">
					<!-- <div class="bm_boxlabel">手机号</div> -->
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="mobile"
								class="bm_intext bm_intext_phone _required _phone" placeholder="请输入11位手机号"  /></label>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite"></p>
					</div>
				</div>
				<div class="bm_box">
					<!-- <div class="bm_boxlabel">验证码</div> -->
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="captcha-code"
								class="bm_intext _required _removeBlank"  placeholder="验证码"/></label>
						</div>
						<div class="bm_boxtool" style="width: 160px;">
							<img src="" id="yzmImg" title="点击切换验证码"
								style="cursor: pointer; border: none; margin: 0; padding: 0; height: 48px; width: 100%;">
						</div>
					</div>
					<div class="bm_box_cue" style="display: block;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" >请输入验证码的计算结果</p>
					</div>
				</div>
				<div>&nbsp;</div>
				<div class="bm_box">
					<!-- <div class="bm_boxlabel">激活码</div> -->
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="mobile-code"
								class="bm_intext _required" placeholder="激活码"/></label>
						</div>
						<div class="bm_boxtool">
							<a href="javascript:void(0);" id="sendMobileCodeBtn"
								class="bm_button_hilite">获取激活码</a>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
					<div class="bm_box_cue_per">短信激活码仅能使用一次,30分钟内有效。</div>
				</div> --%>


				<div class="bm_box">
					<input name="agree" type="checkbox" class=" radio" value="">我同意<a href="info/invest-zhuce.html" style="color: #d9272e;">《注册协议》</a>
				</div>
				
				<div class="bm_button">
					<a href="javascript: void(0);" class="bm_button_hilite submitBtn">下一步</a><a
						href="./login.html" class="bm_button_check ">已有账号</a>
				</div>
			</form>

			

		</div>
	</div>

	<div class="bm_content bm_content_bottom" style="display: none;" >
		<div class="bm_wrapper">

			<form  name="regForm2"   method="put" action="/reg/register-person">
				<div class="bm_box">
					<div class="bm_boxlabel">真实姓名</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="real-name" 
								class="bm_intext _required _length _blank" min="2" max="20" placeholder="必须实名，后续将银行实名认证" /></label>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
				</div>
				
				<div class="bm_box">
					<div class="bm_boxlabel">用户名</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="login-name" 
								class="bm_intext  _required _length _blank _username" min="4" max="15" placeholder="4-15个字符，支持中文" /></label>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
				</div>
				<div class="bm_box">
					<div class="bm_boxlabel">密码</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label>
							  <input type="password" onselectstart="return false;" onpaste="return false;" name="pwd"
								id="pwd" class="bm_intext _required _length _pwd" min="6" max="18" placeholder="8-18个字符" />
							</label>
						</div>
						<div class="bm_boxtool bm_cipher_on_w">
							<div class="bm_cipher_on">
								<input type="checkbox" value="1" id="bm_cipher_on"	class="bm_cipher_on_checkbox" name="" />
								<label id="pwdShowStyleLable" for="bm_cipher_on" class="bm_cipher_on_label"></label>
							</div>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" ></p>
					</div>
				</div>
				<div class="bm_box" id="pwdSetDiv">
					<div class="bm_boxlabel">你最喜欢谁（密保问题）</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="pwd-security"
								id="pwd-security" class="bm_intext  _required _removeBlank" placeholder="必填" /></label>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite"></p>
					</div>
				</div>
				
				<div class="bm_box" id="recomMobileDiv">
					<div class="bm_boxlabel">推荐码</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="recommend-mobile"
								id="recommend-mobile" class="bm_intext  _recommendCode _removeBlank" placeholder="推荐人手机号码" /></label>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite"
							></p>
					</div>
				</div>
				
				<div class="bm_box">
					<!-- <div class="bm_boxlabel">手机号</div> -->
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="mobile"
								class="bm_intext bm_intext_phone _required _phone" placeholder="请输入11位手机号"  /></label>
						</div>
					</div>
					<div class="bm_box_cue">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite"></p>
					</div>
				</div>
				<div class="bm_box">
					<!-- <div class="bm_boxlabel">验证码</div> -->
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="captcha-code"
								class="bm_intext _required _removeBlank"  placeholder="验证码"/></label>
						</div>
						<div class="bm_boxtool" style="width: 160px;">
							<img src="" id="yzmImg" title="点击切换验证码"
								style="cursor: pointer; border: none; margin: 0; padding: 0; height: 48px; width: 100%;">
						</div>
					</div>
					<div class="bm_box_cue" style="display: block;">
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p bm_box_cue_hilite" >请输入验证码的计算结果</p>
					</div>
				</div>
				
				<div class="bm_button">
					<a href="javascript:void(0);" class="bm_button_hilite submitBtn">确认</a>
				</div>
			</form>

			

		</div>
	</div>

	<div class="bm_content bm_content_bottom" style="display: none;" >
		<div class="bm_wrapper">
			<form action="" name="regForm3">
				<div class="bm_box bm_regok">
					<a:img src="regok.png" /><br> 您已成功完成班汇通平台账户注册！<br>
					用户名：<span id="loginNameSpan"></span> <br> 
					绑定手机：<span id="mobileSpan"></span> 
				</div>
				<div class="bm_button">
					<a href="./login.html" class="bm_button_check">登录</a>
				</div>
			</form>
		</div>
	</div>
	<%@include file="inc/bottom-page.jsp"%>

<script type="text/javascript">
var g_Cfg = {boxClass:'bm_box',eBoxClass:'bm_box_cue',errMsg:'<div class="bm_box_cue_arrow"></div><p class="bm_box_cue_p bm_box_cue_hilite" >#[msg]</p>'};
var g_seeMW = false;
var g_isMW = false;
g_showUserInfo = false;  // 在common.jsp中定义的全局变量g_showUserInfo;来判断是否显示用户名及安全退出按钮
var userParam = {rcode:Sys.getParam('rcode')};
var g_yzmURL = Sys.config.xrSrvUrl + '/reg/captcha-image';

$(function() {
	$("#yzmImg").on("click", changeYZM);  // 若直接加载页面就要验证码做一次click时间，则应写为$('#yzmImg').on('click',changeYZM).onclick();
	$("#sendMobileCodeBtn").on("click", sendMobileCode);
	$(".submitBtn").on('click',submitForm);
	$("#pwdShowStyleLable").on('click',doSeeMW);
	
	// 获取参数rcode，得到推荐码
	if(userParam.rcode){
		alert(userParam.rcode);
		$('input[name=recommend-mobile]').val(userParam.rcode);
		$('#recomMobileDiv').hide();
	}
});

Sys.service.on("Account",function(data,ctx){
	if(data.valid && data.status>=0){
		Sys.toUrl(Sys.evalUrl('/account/accountment.html'));
	}
	// 等待200ms再显示验证码, 否则IE浏览器上无法获取正确的cookie
	//setTimeout("changeYZM()",200);
});

Sys.service.on("SendMobileCodeService",function(data,eCode,eMsg){
	if (data) {
		$("#sendMobileCodeBtn").parents('.'+g_Cfg.boxClass).find('.'+g_Cfg.eBoxClass).html('手机激活码已发送到手机【'+Sys.formatMobile(userParam.mobile)+'】上，请注意查收').showInline();
		Sys.vCodeCountDown($("#sendMobileCodeBtn"));
		
	}else{
		//处理错误日志
		if(eCode === 57){
			setTimeout("changeYZM()", 200);
			Sys.errorDlg('验证码错误!');
		}else{
			Sys.errorDlg(eMsg);
		}
	}
	
	return true;
	
},false);

/* Sys.service.on("RegisterStep1",function(data,ctx){
	enableBtn();
	if(data){
		gotoStep(++regServiceInfo.index);
	}
},false); */
var regServiceInfo = {};
Sys.service.on("RegService",function(data,ctx){
	enableBtn();
	if(data){
		gotoStep(3);
		
		$("#loginNameSpan").html(regServiceInfo.loginName);
		$('#mobileSpan').html(regServiceInfo.mobile);
	}
},false);



////////////////////////////////////////
//All private functions
////////////////////////////////////////
/**
 * 明文密码 与 密文密码 切换
 */
function doSeeMW(){
	g_seeMW = true;
	g_isMW = !g_isMW;
	
	var pwdTxt = $('#pwd-text');
	var pwd = $('input[name="pwd"]');
	if(pwdTxt.length <= 0){
		pwdTxt = $('<input type="text" readonly="readonly" id="pwd-text" class="bm_intext " />');
		pwd.after(pwdTxt); // 在密文框pwd后面插入明文框pwdTxt
	}
	
	if(g_isMW){
		pwdTxt.val(pwd.val()).show();
		pwd.hide();
		
	}else{
		pwdTxt.hide();
		pwd.show();
		
	}
}

/**
 * 点击下一步及确认注册按钮提交
 */
function submitForm(){
	if($(this).hasClass('bm_button_default')){
		return;
	}
	
	var form = $(this).parents('form');
	var formId = form.attr('name');
	var index = formId.substring("regForm".length);
	
	if(index === "1" && !$('input[name=agree]').is(":checked")){
		// TODO:点击下一步，若没有勾选<<注册协议>>，提示用户勾选
		Sys.errorDlg('请先阅读并勾选《注册协议》！');
		return;
	}
	if(form.validateForm(g_Cfg)){
		if(g_isMW && !$('input[name="pwd"]').validateForm(g_Cfg)){
			return;
		}
		var params = form.serializeObject();
		var mobile = $.trim($('input[name="mobile"]').val());
		var loginName = $.trim($('input[name="login-name"]').val());
		
		if(index === "1"){
			enableBtn();
			gotoStep(++index);
			
			//document.location.reload();
			// 等待200ms再显示验证码, 否则IE浏览器上无法获取正确的cookie
			setTimeout("changeYZM()",200);
			
		}else if(index === "2"){
			params['mobile'] = mobile;
			params['loginName'] = loginName;
			
 			if(!g_seeMW){
				Sys.errorDlg('请至少查看一次明文密码！');
				return;
			}
 			disableBtn();
 			$.extend(regServiceInfo, {
 				method : (form.attr('method') || 'get'),
 				action : form.attr('action'),
 				params : params,
 			});
 			Sys.service.load('RegService',{},true);
		}
	}
}

/**
 * 禁用按钮
 */
function disableBtn(){
	$(".submitBtn").addClass('bm_button_default').removeClass('bm_button_hilite');
}

/**
 * 启用按钮
 */
function enableBtn(){
	$(".submitBtn").removeClass('bm_button_default').addClass('bm_button_hilite');
}

/**
 * 使用新的验证码
 */
function changeYZM() {
	$("#yzmImg").attr('src', g_yzmURL + '?_t=' + new Date().getTime());
}

/**
 * 调用后台服务发送手机短信激活码
 */
function sendMobileCode() {
	if($('#sendMobileCodeBtn').hasClass('bm_button_default')){
		return;
	}

	var form = $('#sendMobileCodeBtn').parents('form');
	var captchaCode = form.find('input[name="captcha-code"]');
	var mobile = form.find('input[name="mobile"]');
	
	$.extend(userParam,{
		"mobile" : $.trim(mobile.val()),
		"captcha-code" : $.trim(captchaCode.val())
	});
	
	if(mobile.validateForm(g_Cfg) && captchaCode.validateForm(g_Cfg)){
		Sys.service.load("SendMobileCodeService",{},true);
	}
}

/**
 * 跳转到指定步骤 @param 步骤序号(1-3)
 */
function gotoStep(step) {

	step = step < 1 ? 1 : step > 3 ? 3 : step;
	
	var form = $('form[name="regForm'+step+'"]');
	var div = form.parents('.bm_content');
	$('.bm_content').hide();
	div.show();
	
	$('#titleLi'+step).addClass('bm_less_head_tab_li_current').removeClass('bm_less_head_tab_li');
	$('#titleLi'+step).siblings().addClass('bm_less_head_tab_li').removeClass('bm_less_head_tab_li_current');
	
}


//-->
</script>
</body>
</html>
