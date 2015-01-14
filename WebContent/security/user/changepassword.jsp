﻿﻿<%@page import="com.zhicloud.op.service.constant.AppConstant"%>
<%@page import="com.zhicloud.op.common.util.StringUtil"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.vo.TerminalUserVO" %>
<%@page import="com.zhicloud.op.exception.ErrorCode"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Integer userType = AppConstant.SYS_USER_TYPE_TERMINAL_USER;
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
// 	TerminalUserVO terminalUser = (TerminalUserVO)request.getAttribute("terminalUser");
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
<%-- <script src="<%=request.getContextPath() %>/javascript/jquery.min.js"></script>  --%>
<script src="<%=request.getContextPath() %>/javascript/common.js"></script>
<script type="text/javascript">
var a = '<%= request.getContextPath()%>';
var ajax = new RemoteCallUtil(a+"/bean/call.do?userType=4");
$(document).ready(function(){
	init(10,4);
	inituser('<%=loginInfo.getAccount()%>');
	$("#save_change_btn").click(function() {
    	if(checkOldPassword()& checkPassword() & checkPasswordConf()){
				self.save();
    	}
	});
	// 回车
	$("#old_password, #password,#confirm").keypress(function(evt){
		if( evt.keyCode==13 ){
			self.save();
		}
	});
});
function getLoginInfo(name,message,userId){
	slideright();
	inituser(name,message);
	window.location.reload();
}
function getLoginInfo(name,message,userId){
	slideright();
	inituser(name,message);
	window.location.reload();
}
function checkOldPassword(){
	var oldPassword = new String($("#old_password").val()).trim();
	if(oldPassword==null || oldPassword==""){
		$("#tip-oldPassword").html("<font color='red'>原密码不能为空</font>");
		return false;
	}
	else
	{	
		$("#tip-oldPassword").html("");
		return true;
	}

}
function checkPassword(){
	var myPassword = new String($("#password").val()).trim();
	var oldPassword = new String($("#old_password").val()).trim();
	if(myPassword==null || myPassword==""){
		$("#tip-password").html("<font color='red'>新密码不能为空</font>");
		return false;
	}
	if(myPassword==oldPassword)
	{
		$("#tip-password").html("<font color='red'>新密码和原密码一样</font>");
		return false;
	}
	if(myPassword.length>=6&&myPassword.length<=20){
		$("#tip-password").html("");
		return true;
	}
	else
	{
		$("#tip-password").html("<font color='red'>密码长度为6-20个字符</font>");
		return false;
	}
}
function checkPasswordConf(){
	var passwordOne = new String($("#password").val()).trim();
	var passwordTwo = new String($("#confirm").val()).trim();
	var oldPassword = new String($("#old_password").val()).trim();
	if(passwordTwo==null || passwordTwo=="")
	{
		$("#tip-confirm").html("<font color='red'>确认密码不能为空</font>");
		return false;
	}
	if(passwordOne.length<6||passwordOne.length>20){ 
		$("#tip-confirm").html("<font color='red'>密码长度在6-20之间</font>");
		return false;
	}
	if(passwordOne!=passwordTwo)
	{
		$("#tip-confirm").html("<font color='red'>两次输入的密码不一致</font>");
		return false;
	}else if(passwordOne==oldPassword)
	{
		$("#tip-confirm").html("<font color='red'>新密码和原密码一样</font>");
		return false;
	}
	else{
		$("#tip-confirm").html("");
		return true;
	}
}

	var self = this;
	// 保存
	self.save =function (){ 
		var formData = $.formToBean(terminal_user_change_password);
		ajax.remoteCall("bean://terminalUserService:changePasswordById",
			[ formData ], 
			function(reply) {
				if (reply.status == "exception") 
				{
					if(reply.errorCode=="<%=ErrorCode.ERROR_CODE_FAIL_TO_CALL_BEFORE_LOGIN%>"){
						top.$.messager.alert("警告","会话超时，请重新登录","warning",function(){
							window.location.reload();
						});
					}
					else{
						top.$.messager.alert("警告",reply.exceptionMessage,"warning",function(){
							window.location.reload();
						});
					} 
				} else if (reply.result.status == "success") 
				{
					// 注册成功
					$("<div class=\"datagrid-mask\"></div>").css({
						display:"block",
						width:"100%",
						height:"100%"
					}).appendTo("body"); 
					$("<div class=\"datagrid-mask-msg\"></div>").html("修改成功，正在退出，请重新登录...").appendTo("body").css({
						display:"block",
						left:($(document.body).outerWidth(true) - 190) / 2,
						top:($(window).height() - 45) / 2
					});
// 					top.$.messager.alert('提示','提示','info'); 
                     window.setTimeout(function(){
                    	 logout_1();
 					}, 1000);
					
				}
				else 
				{
					$("#tip-oldPassword").html(""+reply.result.message+"");
// 					top.$.messager.alert('提示',reply.result.message,'info');
//						top.$.messager.show({
//							title:'提示',
//							msg:reply.result.message,
//							timeout:10000,
//							showType:'slide'
//						});
				}
			}
		);
	};
	function logout_1()
	{ 
		ajax.remoteCall("bean://sysUserService:logout",
			[],
			function(reply)
			{
				if( reply.status=="exception" )
				{
					top.$.messager.alert('提示','会话超时，请重新登录','info',function(){
						window.location.href="<%=request.getContextPath()%>/user.do?flag=login";
						
					});
				} 
				else if( reply.result.status=="success" )
				{

					inituser();
					// 注销成功
					top.location.href=a+"/user.do?flag=login";
					// 跳转页面
					slideright();
				}
				else
				{
					top.$.messager.alert('警告',reply.result.message,'warning');
				}
			}
		);
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
      <div class="titlebar"><a href="javascript:void(0);" onclick="window.history.back()"><img src="<%=request.getContextPath()%>/image/button_back.png" width="22" height="30" alt="返回" /></a>
        <div class="r">修改密码</div>
      </div>
      <div style="width: 440px;padding: 15px 0;margin:20px auto 0 auto;line-height:30px;">
      <form id="terminal_user_change_password" method="post">
<%--       	<input type="hidden" id="terminalUser_id" name="terminalUser_id" value="<%=terminalUser.getId()%>" /> --%>
       		<table width="440" border="0" cellspacing="0">
          <tr>
            <td width="105" style="padding:5px">　当前密码</td>
            <td width="335" style="padding:5px"><input name="old_password" id="old_password" type="password" class="textbox" style="height:28px; width:333px" onblur="checkOldPassword()"/></td>
          </tr>
          <tr>
            <td style="padding:0; line-height:16px">&nbsp;</td>
            <td style="text-align:right; padding:0 5px; line-height:16px;color:#f06050" id="tip-oldPassword"></td>
          </tr>
          <tr>
            <td style="padding:5px">　新密码</td>
            <td style="padding:5px"><input name="password" id="password" type="password" class="textbox" style="height:28px; width:333px" onblur="checkPassword()"/></td>
          </tr>
          <tr>
          	<td style="padding:0; line-height:16px">&nbsp;</td>
            <td style="text-align:right; padding:0 5px; line-height:16px;color:#f06050" id="tip-password"></td>
          </tr>
          <tr>
            <td style="padding:5px">　确认密码</td>
            <td style="padding:5px"><input name="confirm" id="confirm" type="password" class="textbox" style="height:28px; width:333px" onblur="checkPasswordConf()"/></td>
          </tr>
          <tr>
            <td style="padding:0; line-height:16px">&nbsp;</td>
            <td style="text-align:right; padding:0 5px; line-height:16px;color:#f06050" id="tip-confirm"></td>
          </tr>
        </table><br/>
        </form>
        <a href="#" class="bluelinebutton r" style="margin-right:5px" id="save_change_btn">提交</a>
      </div>
    </div>
    <div class="clear"></div>
    <div class="footer"></div>
  </div>
  <div class="pageright">
	<iframe id="loginiframe" src="<%=request.getContextPath()%>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
    <iframe id="regiframe" src="<%=request.getContextPath()%>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
  </div>