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
	init(4);  
	if(userName!= ''){ 
		inituser(userName,0);
	}else{
		inituser();
	}
	$(window).scroll(function(){
		var s = $(window).scrollTop();
		if( s >= 643){
			$(".backtop").fadeIn(100);
		}else{
			$(".backtop").fadeOut(200);
		};
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
<div class="backtop"><img src="image/button_top.gif" width="64" height="64" alt="返回顶部"  onclick="scrollto(0);"/></div>
<div class="page">
  <div class="pagewhite" style="background:#f8f8f8">
    <div class="header pageheader"> </div>
    <div class="pagemain"  >
        <div class="box" style="background: #13bd9c url(image/solution.png) no-repeat center center; height:538px"><a style="width:100%;height:100%;display:block" href="javascript:void(0)" onclick="scrollto(628);"></a></div>      <div class="box" style="width: 1000px; background: url(image/solution_0.gif) no-repeat center center;height:239px;padding:500px 0 0 0;">
        <div class="l" style="width:300px; text-align:center;"><a href="javascript:void(0)" onclick="scrollto(1367);"><img src="image/more_1.png" width="121" height="45" /></a></div>
        <div class="l" style="width:385px; text-align:center;"><a href="javascript:void(0)" onclick="scrollto(1931);"><img src="image/more_1.png" width="121" height="45" /></a></div>
        <div class="l" style="width:315px; text-align:center;"><a href="javascript:void(0)" onclick="scrollto(2495);"><img src="image/more_1.png" width="121" height="45" /></a></div>
        <div class="clear"></div>
      </div>
      <div class="solution solution1" style="height:564px;">
        <div id="m1" class="solutionmenu" style="background:url(image/solution_1.png) no-repeat">
        <a href="javascript:void(0)" class="solutiontitle" onclick="gotosolution(1,1);">&nbsp;</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(1,2);">整 体 架 构</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(1,3);">产 品 功 能</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(1,4);">特 点 优 势</a>
        </div>
        <ul id="s1" class="anime" style="width:400%;">
          <li style="width:25%;background:#fafafa url(image/solution_1_1.gif) no-repeat center center"></li>
          <li style="width:25%;background:#fafafa url(image/solution_1_2.gif) no-repeat center center"></li>
          <li style="width:25%;background:#fafafa url(image/solution_1_3.gif) no-repeat center center"></li>
          <li style="width:25%;background:#fafafa url(image/solution_1_4.gif) no-repeat center center"></li>
        </ul>
      </div>
      <div class="solution solution2" style="height:564px;">
        <div id="m2" class="solutionmenu" style="background:url(image/solution_2.png) no-repeat">
        <a href="javascript:void(0)" class="solutiontitle" onclick="gotosolution(2,1);">&nbsp;</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(2,2);">整 体 架 构</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(2,3);">产 品 功 能</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(2,4);">特 点 优 势</a>
        </div>
        <ul id="s2" class="anime" style="width:400%;">
          <li style="width:25%;background:url(image/solution_2_1.gif) no-repeat center center"></li>
          <li style="width:25%;background:url(image/solution_2_2.gif) no-repeat center center"></li>
          <li style="width:25%;background:url(image/solution_2_3.gif) no-repeat center center"></li>
          <li style="width:25%;background:url(image/solution_2_4.gif) no-repeat center center"></li>
        </ul>
      </div>
      <div class="solution solution3" style="height:564px;">
        <div id="m3" class="solutionmenu" style="background:url(image/solution_3.png) no-repeat">
        <a href="javascript:void(0)" class="solutiontitle" onclick="gotosolution(3,1);">&nbsp;</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(3,2);">整 体 架 构</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(3,3);">产 品 功 能</a>
        <a href="javascript:void(0)" class="solutionlink" onclick="gotosolution(3,4);">特 点 优 势</a>
        </div>
        <ul id="s3" class="anime" style="width:400%;">
          <li style="width:25%;background:#fafafa url(image/solution_3_1.gif) no-repeat center center"></li>
          <li style="width:25%;background:#fafafa url(image/solution_3_2.gif) no-repeat center center"></li>
          <li style="width:25%;background:#fafafa url(image/solution_3_3.gif) no-repeat center center"></li>
          <li style="width:25%;background:#fafafa url(image/solution_3_4.gif) no-repeat center center"></li>
        </ul>
      </div>
    </div>
    <div class="footer"></div>
  </div>  
  <div class="pageright">
    <iframe id="loginiframe" src="<%=request.getContextPath() %>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
    <iframe id="regiframe" src="<%=request.getContextPath() %>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
  </div> 
</body>
</html>