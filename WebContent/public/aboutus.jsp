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
	init(6);
	if(userName!= ''){ 
		inituser(userName,0);
	}else{
		inituser();
	}
	$(".page6").css("height",$(".page6").width()/1198*264);
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
    <div class="header pageheader"></div>
    <div class="pagemain">
      <div class="box page5" style="height:540px;">
        <div class="titlebar" style="padding-top:24px">
          <div class="l">关于我们</div>
          <div class="r"><a href="aboutus.do" class="active">公司简介</a>　|　<a href="job.do">加入我们</a></div>
          <div class="clear"></div>
        </div>
        <div style="margin:0 auto; width:619px; height:245px; padding:120px 0 0 0"><img src="image/about_banner.png" width="619" height="245" /></div>
        <div class="r" style="width:212px; height:16px; padding:80px 16px 0 0"><img src="image/about_script.png" width="212" height="16" /></div>
        <div class="clear"></div>
      </div>
      <div class="abouttext"><img src="image/about_1.png" width="189" height="51" /><br />
        <br />
        致云科技有限公司是一家专注于云计算领域的创新型高科技企业，拥有在云计算领域具备丰富经验的资深技术和运营团队，总部及研发中心设在成都高新区，目前在成都、北京、上海、广州和深圳设立全资子公司。<br />
        致云科技始终以技术创新为企业核心竞争力，已拥有几十项自主研发、自有知识产权的云计算核心专利技术；结合商业模式创新，以“市场主导、技术先行、自主创新、服务为本”为经营理念，打造一个共生、共赢、共进、共享的云计算产业链，致力成为全球领先的云计算解决方案提供商和服务商。 </div>
      <div class="abouttext" style="border-bottom:none;"><img src="image/about_2.png" width="188" height="52" /><br />
        <br />
        <strong>企业文化</strong><br />
        激情、创新、智慧、责任<br />
        <strong>企业愿景</strong><br />
        打造一个共生、共赢、共进、共享的云计算产业链<br />
        <strong>企业使命</strong><br />
        打造极致之云、引领服务变革<br />
        <strong>企业目标</strong><br />
        致力成为国内外领先的云计算解决方案提供商及服务商</div>
         <div class="box page6"></div>
      <div class="abouttext"><img src="image/about_3.png" width="209" height="52" /><br />
        <br />
        自主研发——运营商级云计算运营支撑平台<br />
        自主研发——各产品线均可按需满足客户的定制化、个性化需求。<br />
        拥有几十项云计算领域相关的技术专利<br />
        领先的云平台、云存储、云桌面技术，提供完整的端到端解决方案<br />
        经验丰富的技术研发和运营团队</div>
      <div class="abouttext" style="border-bottom:none"><img src="image/about_4.png" width="202" height="52" /><br />
        <br />
       致云科技总部<br />
        地址：成都市天府软件园C区12栋15层<br />
        座机：028-69189999<br />
        传真：028-61291999<br />
        <br />
        致云科技广州公司<br />
        地址：广州市天河区黄埔大道西100号富力盈泰广场A塔1011<br />
        座机：020-38260999<br />
        传真：020-38260988<br />
        <br />
        致云科技上海公司<br />
        地址：上海市普陀区真北路915号1505<br />
        座机：021-62868099<br />
        传真：021-62869177</div>
    </div>
    <div class="footer"> </div>
  </div>
</div>
<div class="pageright">
  <iframe id="loginiframe" src="<%=request.getContextPath() %>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
  <iframe id="regiframe" src="<%=request.getContextPath() %>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
</div> 
</body>
</html>