<%@page import="com.zhicloud.op.service.constant.AppConstant"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%> 
<%@page import="java.math.BigDecimal"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = AppConstant.SYS_USER_TYPE_TERMINAL_USER;
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
	String userName = "";
	if(loginInfo!=null){
		userName = loginInfo.getAccount();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=AppConstant.PAGE_TITLE %></title>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/image/logo1.ico" type="image/x-icon" /> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/javascript/themes/bootstrap/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/javascript/themes/icon.css" />
<%--  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.ext.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/locale/easyui-lang-zh_CN.js"></script>


<script src="javascript/page.js"></script>
<script type="text/javascript">
var a = '<%= request.getContextPath()%>';
var ajax = new RemoteCallUtil(a+"/bean/call.do?userType=4"); 
var userName = '<%=userName%>';
$(document).ready(function(){
	init(5);
	if(userName!= ''){ 
		inituser(userName,0);
	}else{
		inituser();
	}
	$("#helpnav .h2").click(function(){
		$("#helpnav a").removeClass("active");
		$(this).addClass("active");
	});
	$("#helpnav .h1:eq(0)").click(function(){
		$("#helpnav a").removeClass("active");
		$(this).addClass("active");
	});
	$("#helpnav .h1:eq(1)").click(function(){
		$("#helpnav a").removeClass("active");
		$(this).next(".h2").addClass("active");
	});
	$("#helpnav .h1:eq(2)").click(function(){
		$("#helpnav a").removeClass("active");
		$(this).next(".h2").addClass("active");
	});
});
$(function(){ 
$("#iframehelp").load(function(){
$(this).height($(this).contents().find(".help").height()); 
}); 
}); 
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
  <div class="pagewhite">
    <div class="header"> </div>
    <div class="pagemain">
      <div class="box" style="width:980px; padding:60px 0 0 0">
        <div id="helpnav" class="l" style="width:210px; border-right:solid 1px #e1e1e1;"> <a href="public/help_1_1.jsp" target="iframehelp" class="h1 active" style="background:url(image/help_faq.png) no-repeat left center;margin-top:0">常见问题</a> <a href="public/help_2_1.jsp" target="iframehelp" class="h1" style="background:url(image/help_account.png) no-repeat left center">账户相关</a> <a href="public/help_2_1.jsp" target="iframehelp" class="h2">新用户注册</a> <a href="public/help_2_2.jsp" target="iframehelp" class="h2">账户充值</a> <a href="public/help_2_3.jsp" target="iframehelp" class="h2">获取发票</a> <a href="public/help_2_4.jsp" target="iframehelp" class="h2">现金券兑换</a> <a href="public/help_2_5.jsp" target="iframehelp" class="h2">修改邮箱</a> <a href="public/help_2_6.jsp" target="iframehelp" class="h2">修改手机</a> <a href="public/help_2_7.jsp" target="iframehelp" class="h2">修改密码</a> <a href="public/help_3_1.jsp" target="iframehelp" class="h1" style="background:url(image/help_server.png) no-repeat left center">云主机</a> <a href="public/help_3_1.jsp" target="iframehelp" class="h2">创建云主机</a> <a href="public/help_3_2.jsp" target="iframehelp" class="h2">连接云主机</a> <a href="public/help_3_3.jsp" target="iframehelp" class="h2">使用数据盘</a> <a href="public/help_3_4.jsp" target="iframehelp" class="h2">相关初始密码</a> <a href="public/help_3_5.jsp" target="iframehelp" class="h2">修改密码</a> <a href="public/help_3_6.jsp" target="iframehelp" class="h2">上传文件</a> <a href="public/help_3_7.jsp" target="iframehelp" class="h2">更改配置</a> <a href="public/help_3_8.jsp" target="iframehelp" class="h2">停用/启用</a> <a href="public/help_3_9.jsp" target="iframehelp" class="h2">资源监控</a> <a href="icp.do" target="iframehelp" class="h2">ICP备案</a> </div>
        <div class="r" style="width:649px; padding:0 60px;">
        <iframe name="iframehelp" src="public/help_1_1.jsp" id="iframehelp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
        </div>
        <div class="clear"></div>
      </div>
    </div>
    <div class="footer"></div>
  </div>
  <div class="pageright">
    <iframe id="loginiframe" src="<%=request.getContextPath() %>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
    <iframe id="regiframe" src="<%=request.getContextPath() %>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe> 
  </div>
</div>
</body>
</html>