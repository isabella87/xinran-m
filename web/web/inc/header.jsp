<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header class="bm_back_header"> 
  <div class="bm_back_top">
  	<a href="javascript:history.back();" class="bm_back_btn">&lt;</a><em class=" _app_title"></em>
  </div>
</header>

<script>
$(function(){
	var pageTitles = {
			'credit-assign-view.html' : '二级市场', 'project-view.html':'借款项目', 'project-gfg-view.html' : '借款项目',
			'to-pay.html':'借款项目', 'to-credit-pay.html' : '二级市场',
			'jxpay-info.html':'银行存管账户管理', 'withdraw.html' : '提现', 'recharge.html' : '充值',
			'account-info.html' : '个人概况', 'history-income.html' : '收支明细',
			'income-in.html' : '收入', 'income-out.html' : '支出',
			'about-us.html' : '公司基本情况', 'manager-team.html' : '董事、监事及高管情况', 'plat-form.htm' : '平台价值',
			'know-us.html' : '关注我们', 'contact-us.html' : '关于',
			'message-list.html' : '消息中心', 'message-view.html' : '消息中心',
			'apply-jxpay-info.html' : '银行开户','bind-card.html' : '绑定提现卡', 'unbind-card.html' : '提现卡解绑' ,
			'add-credit-assign.html' : '转让申请', 'repay-record.html' : '还款日历', 'invest-zhuce.html' : '注册协议'
			
	};
	
	var currUrl = window.location.href;
	currUrl = currUrl.indexOf('?') > 0 ? currUrl.substring(0, currUrl.indexOf('?')) : currUrl;
	for(var pagePre in pageTitles){
		if(currUrl.indexOf(pagePre) > 0){
			$(' ._app_title').html(pageTitles[pagePre]);
		}
	}
});
</script>