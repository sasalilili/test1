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
	init(1);  
	if(userName!= ''){ 
		inituser(userName,0);
	}else{
		inituser();
	}
	initfeature(1,7);
	si = setInterval(nextfeature,3000);
	$(".feature").hover(function(event){
		$(".nextfeature").css("opacity","1");
		$(".prevfeature").css("opacity","1");
		clearInterval(si);
	},
	function(event){
		$(".nextfeature").css("opacity","0");
		$(".prevfeature").css("opacity","0");
		si = setInterval(nextfeature,3000);
	});
	$(".iproduct").hover(function(event){
		$(this).find(".iproducthover").css("top","0");
	},
	function(event){
		$(this).find(".iproducthover").css("top","-225px");
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
      <div class="feature" style="height:450px;">
        <ul style="width:700%;">
          <li style="width:14.2907%;height:450px;background:#f4f4f4 url(image/bannera.png) no-repeat center center"></li>
          <li style="width:14.2907%;height:450px;background:#3188fa url(image/bannerb.png) no-repeat center center"><a href="cloudsever.do" style="display:block; width:100%; height:100%; text-align:center">&nbsp;</a></li>
          <li style="width:14.2907%;height:450px;background:#cee6ff url(image/banner_2_bg.png)">
            <div style="width:100%; height:100%;background:url(image/banner_2.png) no-repeat center center"><a href="cloudstorage.do" style="display:block; width:100%; height:100%; text-align:center"></a></div>
          </li>
          <li style="width:14.2907%;height:450px;background:#13bd9c url(image/bannerc.png) no-repeat center center"><a href="solution.do" style="display:block; width:100%; height:100%; text-align:center">&nbsp;</a></li>
          <li class="index4" style="width:14.2958%;height:450px; text-align:center"><img src="image/banner_4.png" width="1000" height="450" /></li>
          <li class="index5" style="width:14.2557%;height:450px; text-align:center"><img src="image/banner_5.png" width="1000" height="450" /></li>
          <li style="width:14.28%;height:450px;background:#f4f4f4 url(image/bannera.png) no-repeat center center"></li>
        </ul>
        <a href="javascript:void(0)" class="prevfeature" onclick="prevfeature()"><img src="image/banner_prev.png" width="66" height="122" alt=" " /></a> <a href="javascript:void(0)" class="nextfeature" onclick="nextfeature()"><img src="image/banner_next.png" width="66" height="122" alt=" " /></a> </div>
      <div class="box" style="width:980px;padding:70px 0 0 0;position:relative;"> <a class="iproduct" style="background:url(image/index_product_a1.png) no-repeat;margin-right:25px;" href="buy.do?flag=buy">
        <div class="iproducthover" style="background:url(image/index_product_a2.png) no-repeat">立即购买</div>
        推广版：1核/1G/20G/1M</a> <a class="iproduct" style="background:url(image/index_product_b1.png) no-repeat;margin-right:25px;" href="<%=request.getContextPath() %>/bean/page.do?userType=4&bean=cloudDiskService&method=addPage">
        <div class="iproducthover" style="background:url(image/index_product_b2.png) no-repeat">立即购买</div>
        暂时免费：需要邀请码开通服务</a> <a class="iproduct" style="background:url(image/index_product_c1.png) no-repeat" href="solution.do">
        <div class="iproducthover" style="background:url(image/index_product_c2.png) no-repeat">了解详情</div>
        云管理平台、云存储、云桌面</a>
        <div class="clear"></div>
      </div>
      <div class="box" style="width:980px;padding:20px 0 20px 0;position:relative;">
        <div class="iproductinfo" style="margin-right:25px;">
          <div class="title">云主机</div>
          <p>云主机是全新云服务器租用服务，能够帮助您快速上线业务，降低IT运维成本，提高IT管理效率具有快速部署安全可靠、弹性伸缩等特性。</p>
          <a href="cloudsever.do">了解更多</a>
          <div class="clear"></div>
        </div>
        <div class="iproductinfo" style="margin-right:25px;">
          <div class="title">云硬盘</div>
          <p>自主研发的分布式云存储，高吞吐、高并发、高可用，可直接代替原有传统存储设备，且应用无需重新开发帮助传统信息系统无缝升级到云计算时代。</p>
          <a href="cloudstorage.do">了解更多</a>
          <div class="clear"></div>
        </div>
        <div class="iproductinfo">
          <div class="title">解决方案</div>
          <p>依托自主研发的大规模、高可靠、高弹性、高性能的云管理平台、云存储、云桌面提供整体的云融合解决方案。</p>
          <a href="solution.do">了解更多</a>
          <div class="clear"></div>
        </div>
        <div class="clear"></div>
      </div>
    </div>
    <div class="footer"></div>
  </div>
  <div class="pageright">
    <div style="display:none">
    <img id="verification_code"  src="<%=request.getContextPath()%>/public/verificationCode/new.do?userType=<%=userType%>" width="100" height="40" alt="验证码" class="code"/>
    </div>
  
    <iframe id="loginiframe" src="<%=request.getContextPath() %>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
    <iframe id="regiframe" src="<%=request.getContextPath() %>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
  </div>
</div>
</body>
</html>