<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="../inc/common.jsp"%>

<body>
	<%@include file="../inc/head-page.jsp"%>
	<div class="bm_less_head">
		<div class="bm_wrapper">
		  <h2 class="bm_less_head_title">忘记密码</h2>
		</div>
	</div>

	<div class="bm_content_bottom">
	
	    <div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
	    
	    <div id="infoMsg" class="dealInfoMsg" style="display:none;"></div>
	    <div class="mask" id="dealMask" style="display:none;"></div>
	    
		<div class="bm_wrapper">

			<div class="bm_box">
				<!--<div class="bm_boxlabel">手机号</div>-->
				<div class="bm_boxrow">
					<div class="bm_boximport">
						<label><input type="text" name="login-name-or-mobile" id="login-name-or-mobile"
							class="bm_intext bm_intext_phone" placeholder="注册账号或石玖绑定手机" /></label>
					</div>
				</div>
				<div class="bm_box_cue" style="display: none;" id="loginNameOrMobileErrorTips">
					<div class="bm_box_cue_arrow"></div>
					<p class="bm_box_cue_p bm_box_cue_hilite">请输入正确的用户名或或手机号码</p>
			    </div>
			</div>
			
			<div class="bm_box">
				<div class="bm_boxrow">
					<div class="bm_boximport">
						<label><input type="text" name="login-name-or-mobile" id="pwd-question-answer"
							class="bm_intext _required" placeholder="密保问题:你最喜欢谁" /></label>
					</div>
				</div>
				<div class="bm_box_cue" style="display: none;" id="pwdQuestionAnswerErrorTips">
					<div class="bm_box_cue_arrow"></div>
					<p class="bm_box_cue_p bm_box_cue_hilite">请输入正确的密保问题答案</p>
			    </div>
			</div>
			
			<div class="bm_box">
				<!--<div class="bm_boxlabel">验证码</div>-->
				<div class="bm_boxrow">
					<div class="bm_boximport">
						<label><input type="text"  name="captcha-code" id="captcha-code"
							class="bm_intext  _required _removeBlank" placeholder="请输入验证码" /></label>
					</div>
					<div class="bm_boxtool" style="width: 160px;">
						<img id="yzmImg" src=""
							style="border: none; margin: 0; padding: 0; height: 48px; width: 100%;">
					</div>
				</div>
				<div class="bm_box_cue"  id="captchaCodeErrorTips">
					<div class="bm_box_cue_arrow"></div>
					<p class="bm_box_cue_p bm_box_cue_hilite" >请输入正确的验证码</p>
				</div>
			</div>
			<div class="bm_box">
					<div class="bm_boxlabel">密码</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label>
							  <input type="password" onselectstart="return false;" onpaste="return false;" name="pwd"
								id="pwd" class="bm_intext _required _length _pwd" min="8" max="18" placeholder="8-18个字符" />
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

			<div class="bm_button">
				<a href="javascript:void(0);" id="submitBtn" class="bm_button_check">找回密码</a>
			</div>

	    </div>
	    <%@include file="../inc/bottom-page.jsp"%>
	 </div>

<script type="text/javascript">
var yzmURL = Sys.config.xrSrvUrl + '/reg/captcha-image';

$(function(){

	$("#submitBtn").on("click",submitForm);
	$("#yzmImg").on("click", changeYZM);
	
    $('.dealInfoMsg').on('click',hideMask);
	
	$('#dealMask').on('click',hideMask);
	
});

Sys.service.on('Account', function(data) {
	// 等待200ms再显示验证码, 否则IE浏览器上无法获取正确的cookie
	setTimeout("changeYZM()", 200);
});


var ResetPwdInfo = {};
Sys.service.on('ResetPwd',function(data){
	if (data) {
		/* Sys.infoDlg('班汇通帐户密码重置成功。<p class="ban_result_additional">原密码已作废，重置后系统随机生成的临时密码已通过短信发送到您的绑定手机。<br />'
        			+'请尽快使用此临时密码登录网站，前往您的“个人账户中心”，在“班汇通账户信息”中将其修改为您的安全密码。<br /></p>',null,function(){
			window.location.assign(Sys.evalUrl('/login.html'));
		}); */
		$('.dealInfoMsg').html('石玖帐户密码重置成功。').show();
		$('#dealMask').show();
	}
},false);

////////////////////////////////////////
//All private functions
////////////////////////////////////////
function hideMask(){
	window.location.assign(Sys.evalUrl('/login.html'));
	$('.dealInfoMsg').hide();
	$('#dealMask').hide();
}


/**
 * 点击重置密码按钮提交
 */
function submitForm() {
	var pwd = $.trim($("#pwd").val());
	var pwd_question_answer = $.trim($("#pwd-question-answer").val());
	var captcha_code = $.trim($("#captcha-code").val());
	var login_name_or_mobile = $.trim($("#login-name-or-mobile").val());
	
	$.extend(ResetPwdInfo,{
		"login-name-or-mobile" : login_name_or_mobile,
		"pwd":pwd,
		"pwd-question-answer":pwd_question_answer,
		"captcha-code" : captcha_code
	});
	Sys.service.load('ResetPwd',{},true);
}

/**
 * 使用新的验证码
 */
function changeYZM() {
	$("#yzmImg").attr('src', yzmURL + '?_t=' + new Date().getTime());
}

</script>
</body>
</html>
