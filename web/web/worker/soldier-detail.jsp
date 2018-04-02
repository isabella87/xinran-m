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

var g_prj ;
var mmId = Sys.getParam('mmid');

if(!mmId){
	Sys.errorDlg('参数错误！',null,function(){
		window.open("about:blank","_top").close();
	});
}

var WorkerDetailInfo = {mmId : mmId };
Sys.service.on('WorkerDetail',function(data){
	if (data) {
		g_prj = data;
		showWorkerDetails();
	}
});

/**
 * 调用服务取到数据后渲染html，将数据展示出来
 */
function showWorkerDetails(){
	
	var d = g_prj;

	var html = new Array();
	html.push('<div class="bm_boximport">                                                                                                     ');
	
	html.push('<input type="hidden" name="fee" value="" /> ');
	html.push('<input type="hidden" name="mm-id" value='+ mmId + '/> ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield" class="ban_infobox_label" style="color:#87CEEB;">将士照片：</label>                                                              ');
	html.push('	<div class="bm_boxrow">                                                                                             ');
	html.push('		<div class="bm_boximport">                                                                                          ');
	html.push('			<img style="display: block; margin: 10 auto;" src="'+Sys.config.xrSrvUrl+'/files/'+d.fileId+'/single"></img>');
	html.push('		</div>                                                                                                                     ');
	html.push('	</div>                                                                                                                         ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield1" class="ban_infobox_label" style="color:#87CEEB;">将士姓名：'+Sys.encode(d.mmName)+'</label>                                                             ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield2" class="ban_infobox_label" style="color:#87CEEB;">将士工号：'+Sys.encode(d.mmNo)+'</label>                                                                 ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield3" class="ban_infobox_label" style="color:red;font-size:20px;">将士电话：'+Sys.encode(d.mmMobile)+'</label>                                                             ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield3" class="ban_infobox_label" style="color:#87CEEB;">将士级别：'+Sys.encode(d.mmLevel)+'</label>                                                             ');
	html.push('</div>                                                                                                                          ');
	
	html.push('<div class="bm_wrapper">                                                                                                       ');
	html.push('	<label for="textfield3" class="ban_infobox_label" style="color:#87CEEB;">将士简介：'+Sys.encode(d.mmIntro)+'</label>                                                             ');
	html.push('</div>                                                                                                                          ');
	
	
	html.push('</div> ');
	
	html.push('	<div class="bm_button">');
	html.push('		<a href="javascript:void(0);" id="submitBtn" class="bm_button_hilite" onclick="submitService()">立即预定</a>');
	html.push('	</div>');
	
	$("#docContent").html(html.join(''));
	$('#_cursor').html(Sys.encode(d.mmName)+"&nbsp;"+d.mmNo);
}

function submitService(){
	var url = Sys.evalUrl('/service/apply-service.html');
	Sys.toUrl(url);
}
</script>
</body>
</html>