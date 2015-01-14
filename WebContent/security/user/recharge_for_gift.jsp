<%@page import="java.util.List"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.vo.UserOrderVO"%>
<%@page import="com.zhicloud.op.vo.ShoppingCartVO"%>
<%@page import="com.zhicloud.op.common.util.CapacityUtil"%>
<%@page import="com.zhicloud.op.vo.DiskPackageOptionVO"%>
<%@page import="com.zhicloud.op.vo.BandwidthPackageOptionVO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.zhicloud.op.vo.SysDiskImageVO"%>
<%@page import="com.zhicloud.op.service.constant.AppConstant"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
    Integer userType = AppConstant.SYS_USER_TYPE_TERMINAL_USER;
    LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType); 
    String balance = (String)request.getAttribute("balance");
    Integer month = (Integer)request.getAttribute("month");
    BigDecimal amount = (BigDecimal)request.getAttribute("amount"); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=AppConstant.PAGE_TITLE %></title>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/image/logo1.ico" type="image/x-icon" /> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/javascript/themes/bootstrap/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/javascript/themes/icon.css" /> 
 
<%--  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.ext.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/common.js"></script>
<script type="text/javascript">
var a = '<%= request.getContextPath()%>';
var ajax = new RemoteCallUtil(a+"/bean/call.do?userType=4");
$(document).ready(function(){
	init(10,4);
	inituser('<%=loginInfo.getAccount()%>',0);
	$("#toPay").click(function(){
		gotoPay();
	});
	
	$("#base_info").click(function(){
		window.location.href="<%=request.getContextPath()%>/bean/page.do?userType=4&bean=accountBalanceService&method=toConsumptionRecordPage";
	});
	$("#recharge").click(function(){
		window.location.href="<%=request.getContextPath()%>/bean/page.do?userType=4&bean=accountBalanceService&method=toRechargePage";
	});
	$("#invoice_manage").click(function(){
		window.location.href="<%=request.getContextPath()%>/bean/page.do?userType=4&bean=invoiceService&method=managePage";
	});
});

 

var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");


 function gotoPay(){  
	 var val=$('input:radio[name="payType"]:checked').val();
	 if(val == null){
		 top.$.messager.alert('警告','请选择支付方式！','warning');
	 } else{ 
			 
	     $("#pay_form").submit(); 
	 }
	 
 }
 function getLoginInfo(name,message,userId){
		slideright();
		inituser(name,message);
		window.location.reload();
		
	}
</script>
<!--[if IE 6]>
<script src="javascript/DD_belatedPNG.js"></script>
<script type="text/javascript">
	DD_belatedPNG.fix("*");
</script>
<![endif]-->
</head>

<body>
<div class="page">
  <div class="pageleft">
    <div class="header"></div>
    <div class="main">
      <div class="titlebar">
        <div class="tabbar l"><a href="#" id="base_info">基本信息</a>　｜　<a href="#" class="active" id="recharge">账户充值</a>　｜　<a href="#">现金券</a>　｜　<a href="#" id="invoice_manage">发票管理</a></div>
      </div>
       
      <form id="pay_form" action="<%=request.getContextPath()%>/bean/page.do"  method="post">
      <div class="box" style="padding:60px 0;width:548px">
        <div class="l" style="width:198px; height:197px; margin-right:30px;"><img src="<%=request.getContextPath()%>/image/recharge2.png" width="198" height="197" alt=" " /></div>
        <div class="l" style="width:320px; height:197px;">
          <div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 25px 0">余额</span></div>
          <div class="l" style="width:140px; margin:0 0 25px 0; line-height:30px"><%=balance %></>元</div>
          <div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 25px 0">充值金额</span></div>
          <div class="l" style="width:140px; margin:0 0 25px 0; line-height:30px"><b><%=amount %></>元</b>  
           <input name="email" value="mali@zhicloud.com" type="hidden"/> 
          <input name="WIDsubject" value="云主机" type="hidden"/> 
          <input name="userId" value="<%=loginInfo.getUserId()%>" type="hidden"/> 
          <input name="userType" value="4" type="hidden"/>
          <input name="bean" value="paymentService" type="hidden"/>
          <input name="method" value="toAccountPage" type="hidden"/> 
          <input name="month" value="<%=month %>" type="hidden"/> 
          </div>
          <div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 27px 0">充值方式</span></div>
          <div class="l" style="width:200px; margin:0 0 25px 0; line-height:30px">
            <input checked="checked" id="pm1" name="payType" type="radio" value="1" style="vertical-align:middle" />
            <label for="pm1"><img src="<%=request.getContextPath()%>/image/alipay.png" width="70" height="30" alt="支付宝"  style="vertical-align:middle" /></label>
            <input id="pm2" name="payType" type="radio" value="2" style="vertical-align:middle" />
            <label for="pm2"><img src="<%=request.getContextPath()%>/image/yinlian.png" width="60" height="30" alt="银联"  style="vertical-align:middle" /></label>
          </div>
          <a href="#" class="bluelinebutton r" id="toPay">前往支付</a>
        </div>
      </div>
          </form>
      <div class="clear">&nbsp;</div>
    </div>
    <div class="footer"></div>
  </div>
  <div class="pageright">
  	<iframe id="loginiframe" src="<%=request.getContextPath()%>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
    <iframe id="regiframe" src="<%=request.getContextPath()%>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
  </div>
</div>
</body>
</html>