<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="a" uri="http://web.armory.xx.org"%>
<%@include file="inc/common.jsp"%>

<body>

	<%@include file="inc/head-page.jsp"%>
	<div class="bm_less_head">
		<div class="bm_wrapper">
			<h2 class="bm_less_head_title">登录</h2>
		</div>
	</div>
	
	<div>
	    <div id="errMsg" style="display:none;"></div>
	    <div id="infoMsg" style="display:none;"></div>
	    <div class="mask" id="mask" style="display:none;"></div>
		<div class="bm_wrapper">
			<form name="loginForm" method="post" action=""  >
				<div class="bm_box">
					<div class="bm_boxlabel">用户名</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="text" name="login-name-or-mobile" id="login-name-or-mobile"
								class="bm_intext bm_intext_id _required _length _blank _username" min="4" max="15" /></label>
						</div>
					</div>
					<div class="bm_box_cue" >
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p"></p>
					</div>
				</div>
				<div class="bm_box">
					<div class="bm_boxlabel">密码</div>
					<div class="bm_boxrow">
						<div class="bm_boximport">
							<label><input type="password" name="pwd"
								class="bm_intext bm_intext_pw _required _length _blank" min="6" max="18" /></label>
						</div>
					</div>
					<div class="bm_box_cue" >
						<div class="bm_box_cue_arrow"></div>
						<p class="bm_box_cue_p"></p>
					</div>
				</div>
	
				<div class="bm_button">
					<a href="javascript:void(0);"  class="bm_button_hilite submit">登录</a>
					<a href="./regist-user.html" class="bm_button_check">立即注册</a>
				</div>
				<div class="bm_jzname">
				  	<a href="account/lost-password.html" class="bm_jzname_a">忘记密码</a>
				  	<!-- <label for="jz_name"><input type="checkbox" name="jz_name" id="jz_name">记住用户名</label> -->
				</div>
			</form>
		</div>
	</div>
	<%@include file="inc/bottom-page.jsp"%>
	
<script type="text/javascript">

var gCfg = {
	boxClass : 'bm_box',
	eBoxClass : 'bm_box_cue',
	errMsg : '<div class="bm_box_cue_arrow"></div><p class="bm_box_cue_p bm_box_cue_hilite" >#[msg]</p>'
};
var loginParam = {};
accSigninInfo ={};

Sys.service.on('Account', function(data, ctx) {
	if (data.valid && data.status >= 0) {
		Sys.toUrl(Sys.evalUrl('/account/accountment.html'));
	}
});

$(function() {
	$('.submit').on('click', submitForm);
	
	$('form[name="loginForm"] input').on('keypress', catchEvent);

	function catchEvent(e) {
		e = EventUtil.getEvent(e);
		var charCode = EventUtil.getCharCode(e);
		if (charCode === 13) {
			$('.submit').click();
			EventUtil.preventDefault(e);
		}
	}
	
	if(Sys.getCookie("bht.loginname") !== null && Sys.getCookie("bht.loginname") !== ''){
		$('#login-name-or-mobile').val(Sys.getCookie("bht.loginname"));
		//$('#jz_name').prop('checked',true);
	}
	
});

Sys.service.on('AccSigin', function(data, ctx) {
	enableBtn();
	if(data.signResult.valid){  // data.valid = true 代表登录成功
		var retUrl = Sys.getParam('_retUrl');
		if (retUrl) {
			window.self.location.assign(retUrl);
		} else {
			window.self.location.assign(Sys.evalUrl('/account/accountment.html'));
		}
	
	}else{
		
		if(data.signResult.extraInput){ // true: 代表密码连续错误5次;账户已锁定,  false: 代表密码验证没有通过
			
			Sys.errorDlg('您的账户已锁定，请联系客服或者通过找回密码解锁账户！',null,function(){
				window.location.assign(Sys.evalUrl('/account/lost-password.html'));
			});
			
		}else{
			
			Sys.errorDlg('登录失败！用户名或密码错误！');
			return;
		}
		
	}

}, false);

function submitForm() {

	var btn = $(this);
	var form = $(this).parents('form');

	if (form.validateForm(gCfg)) {

		var reg = /\s+/g;
		var username = $.trim($("#login-name-or-mobile").val());
		var password = $.trim($('input[name="pwd"]').val());
		if (reg.test(username)) {
			Sys.errorDlg('用户名中不能含有空格！');
			return;
		}
		if (reg.test(password)) {
			Sys.errorDlg('密码中不能含有空格！');
			return;
		}
		
		Sys.setCookie('bht.loginname',username,30);
		
		/* if($('#jz_name').is(':checked')){
			Sys.setCookie('bht.loginname',username,30);
		}else{
			Sys.delCookie('bht.loginname');
		} */

		var params = form.serializeObject();
		disableBtn();
		
		if(typeof myLogin !== 'undefined'){
			myLogin.logins(username,password);
		}
		
		$.extend(accSigninInfo, params);
		Sys.service.load('AccSigin', {}, true);

	}

}

function disableBtn() {
	$('.submit').addClass('bm_button_default').removeClass('bm_button_hilite');
}

function enableBtn() {
	$('.submit').removeClass('bm_button_default').addClass('bm_button_hilite');
}
</script>
</body>
</html>
