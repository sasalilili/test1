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
	init(2);
	if(userName!= ''){ 
		inituser(userName,0);
	}else{
		inituser();
	}
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
      <div class="box" style="height:450px; background:#fcfcfc">
        <div class="box" style="height:450px; background:url(image/server_1.gif) no-repeat center bottom;">&nbsp;</div>
      </div>
      <div class="box" style="width:980px">
        <div class="producttitle">产品功能</div>
        <div class="productfeature l" style="background:url(image/servericon1.png) no-repeat left top">
          <div class="title">向导式创建</div>
          云主机采用向导式创建方式，直观明了，可以根据您自身业务的需求选择不同的配置和操作系统。</div>
        <div class="productfeature r" style="background:url(image/servericon2.png) no-repeat left top">
          <div class="title">完全自我掌控</div>
          云主机允许用户任意添加、删除、修改任何组件，可根据您业务需求定制个性化的云主机。</div>
          <div class="productfeature l" style="background:url(image/servericon3.png) no-repeat left top">
          <div class="title">弹性伸缩</div>
          云主机可根据您业务需求，随时调整CPU、内存、磁盘、带宽配置。</div>
        <div class="productfeature r" style="background:url(image/servericon4.png) no-repeat left top">
          <div class="title">主机管理</div>
          您可通过“我的云端”实现云主机的开/关机、重启、停用/启用，配置更改；通过“致云客户端”或者RDP/SSH等方式进入云主机操作。</div>
          <div class="productfeature l" style="background:url(image/servericon5.png) no-repeat left top">
          <div class="title">全面监控</div>
          实时监控云主机的CPU、内存、磁盘等资源使用情况。</div>
          <div class="clear"></div>
          <div class="producttitle">产品优势</div>
        <div class="productfeature l" style="background:url(image/servericon6.png) no-repeat left top">
          <div class="title">稳定可靠</div>
          99.9%服务可用性，99.999%数据可靠性；<br />
会话级别原子操作，免同步业务集群，自愈数据架构，并自动进行智能恢复，保障服务质量。</div>
        <div class="productfeature r" style="background:url(image/servericon7.png) no-repeat left top">
          <div class="title">安全保障</div>
          采用自主沙盒技术隔绝工作网络和云主机，各主机资源相互隔离，防DDoS系统，防火墙安全组规则保护。</div>
          <div class="productfeature l" style="background:url(image/servericon8.png) no-repeat left top">
          <div class="title">优质网络</div>
          云服务平台提供BGP线路，以及三十万个公网独立IP。</div>
        <div class="productfeature r" style="background:url(image/servericon9.png) no-repeat left top">
          <div class="title">弹性计费</div>
          灵活的计费方式：支持按时/按量的弹性收费，也支持传统云主机产品组合式收费，还能基于实时资源监控系统指定更加个性化的计费策略。</div>
          <div class="productfeature l" style="background:url(image/servericon10.png) no-repeat left top">
          <div class="title">统一监控</div>
          实时高精度的统一资源监控，从每个cpu内核计算时间、瞬时的内存用量到io用量增幅。</div>
          <div class="productfeature r" style="background:url(image/servericon11.png) no-repeat left top">
          <div class="title">自助服务</div>
          一键式自助服务：用户申请1秒即可用，由平台统一完成对计算资源、存储资源、网络资源的创建和调配。</div>
          <div class="clear"></div>
      </div>
      <div class="box" style="height:575px; background:url(image/servergreenbg.png) repeat-x;margin:40px 0 0 0;">
      <div class="box" style="height:575px; background: url(image/servericon12.png) no-repeat center center;">
      <div class="servert1">应用场景</div>
      <div class="servert2">云主机适用于各种有服务器需求的用户</div>
      <div class="box" style="width:980px;">
      <div class="servert3">企业或个人门户网站</div>
      <div class="servert3">企业各种业务系统应用服务器</div>
      <div class="servert3">电商/游戏/移动APP等平台服务器</div>
      <div class="servert3">企业或个人开发环境部署托管</div></div>
      <div class="clear"></div>
      </div></div>
      <div class="box" style="height:100px; padding:52px 0 0 0;"> <a href="buy.do?flag=buy"><img src="image/button_buy.gif" width="424" height="72" alt="立即购买" /></a></div>
    </div>
    <div class="footer"> </div>
  </div>
  <div class="pageright">
    <iframe id="loginiframe" src="<%=request.getContextPath() %>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
    <iframe id="regiframe" src="<%=request.getContextPath() %>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
  </div>
</div>
</body>
</html>