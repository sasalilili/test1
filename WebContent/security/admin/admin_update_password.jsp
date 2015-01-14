﻿<%@page import="com.zhicloud.op.common.util.StringUtil"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType    = Integer.valueOf(request.getParameter("userType"));
	String id           = (String)request.getAttribute("id");
%>
<!DOCTYPE html>
<!-- admin_update_password.jsp -->
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		
		<title>密码修改</title>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
		<style type="text/css">
		/************/
		.panel-header {
			border-top: 0px;
			border-bottom: 1px solid #dddddd;
		}
		.panel-header, 
		.panel-body {
			border-left: 0px;
			border-right: 0px;
		}
		.panel-body {
			border-bottom: 0px;
		}
		</style>
	</head>
	<body>
		<form id="admin_update_password" method="post">
		
			<div class="panel-header">
				<div class="panel-title">修改密码</div>
				<div class="panel-tool"></div>
			</div>
			
			<input type="hidden" id="admin_id" name="admin_id" value="<%=id%>" />
			
			<table style="margin: 10px 10px 10px 20px;">
				<tr>
					<td style="vertical-align:middle; text-align:right;">原密码：</td>
					<td style="padding:5px 0 5px 0">
						<input type="password" id="old_password"  name="old_password" value="" onblur="checkOldPassword()"/>
					</td>
					<td class="inputtip" id="admin-tip-oldPassword"></td>
				</tr>
				<tr>
					<td style="vertical-align:middle; text-align:right;">新密码：</td>
					<td style="padding:5px 0 5px 0">
						<input type="password" id="password" name="password" value="" onblur="checkPassword()"/>
					</td>
					<td><span id="admin-tip-password"></span></td>
				</tr>
				<tr>
					<td style="vertical-align:middle; text-align:right;">密码确认：</td>
					<td style="padding:5px 0 5px 0">
						<input type="password" id="confirm" name="confirm" value="" onblur="checkPasswordConf()"/>
					</td>
					<td><span id="admin-tip-confirm"></span></td>
				</tr>
				<tr>
					<td></td>
					<td align="right" style="padding:5px 0 5px 0">
						<a href="#" class="easyui-linkbutton" iconCls="icon-save" id="save_btn">提交修改 </a>
					</td>
				</tr>
			</table>
			
		</form>
	</body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ext.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	//=========================
	function checkOldPassword(){
		var oldPassword = new String($("#old_password").val()).trim();
		if(oldPassword==null || oldPassword==""){
			$("#admin-tip-oldPassword").html("<font color='red'>原密码不能为空</font>");
			return false;
		}
		else
		{	
			$("#admin-tip-oldPassword").html("");
			return true;
		}

	}	
	
	function checkPassword(){
		var myPassword = new String($("#password").val()).trim();
		var oldPassword = new String($("#old_password").val()).trim();
		if(myPassword==null || myPassword=="")
		{
			$("#admin-tip-password").html("<font color='red'>密码不能为空</font>");
			return false;
		}
		if(myPassword==oldPassword)
		{
			$("#admin-tip-password").html("<font color='red'>新密码和原密码一样</font>");
			return false;
		}
// 		if(/^\w{8,20}$/.test(myPassword))
// 		{
// 			$("#admin-tip-password").html("");
// 			return true;
// 		}
		if(myPassword.length>=6&&myPassword.length<=20)
		{
			$("#admin-tip-password").html("");
			return true;
		}
		$("#admin-tip-password").html("<font color='red'>密码长度为6-20个字符</font>");
			return false;
	}
	function checkPasswordConf(){
		var passwordOne = new String($("#password").val()).trim();
		var passwordTwo = new String($("#confirm").val()).trim();
		if(passwordTwo==null || passwordTwo==""){
			$("#admin-tip-confirm").html("<font color='red'>确认密码不能为空</font>");
			return false;
		}
		if(passwordOne!=passwordTwo){
			$("#admin-tip-confirm").html("<font color='red'>两次输入的密码不一致</font>");
			return false;
		}
		$("#admin-tip-confirm").html("");
		return true;
	}
	//=========================
	var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");
	ajax.async = false;

	var _admin_update_password_scope_ = new function(){
		
		var self = this;
		
		// 保存
		self.save = function() {
			var formData = $.formToBean(admin_update_password);
			ajax.remoteCall("bean://sysUserService:updatePasswordById",
				[ formData ], 
				function(reply) {
					if (reply.status == "exception") {
						top.$.messager.alert('警告',reply.exceptionMessage,'warning');
					} else if (reply.result.status == "success") {
						top.$.messager.alert('信息', '修改成功，请重新登录!', 'info', function(){
							window.parent.logout();
						});
					}else {
						top.$.messager.alert('警告',reply.result.message,'warning');
					}
				}
			);
		};

		//--------------------------
		$(document).ready(function(){
		    $("#save_btn").click(function() {
		    	if(checkPassword() & checkPasswordConf()){
		    		top.$.messager.alert("提示","确定提交？","info",function(){
	    				self.save();
	    			});
		    	}
			});
		}) ;
	};
	</script>
</html>