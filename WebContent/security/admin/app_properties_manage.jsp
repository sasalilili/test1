<%@page import="com.zhicloud.op.common.util.StringUtil"%>
<%@page import="com.zhicloud.op.app.propeties.AppProperties"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.exception.ErrorCode"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
%>
<!DOCTYPE html>
<!-- app_properties_manage.jsp -->
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		
		<title>超级管理员-全局属性管理</title>
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
		<form id="big_form" method="post">
		
			<div class="panel-header">
				<div class="panel-title">全局属性管理</div>
				<div class="panel-tool"></div>
			</div>
		
			<div id="package_manage_dlg"    style="padding:0px;">
				
				<%-- ******************** --%>
				
				<table style="width:100%; margin:0 auto 0 auto;">
					<tr>
						<td width="140px" style="font-weight:bolder;">
							本系统的地址：
						</td>
						<td >
							<input id="address_of_this_system" name="address_of_this_system" type="text"
								style="width:400px"/>
						</td>
<!-- 						<td align="right" style="width:100px;"> -->
<!-- 							&nbsp;&nbsp; -->
<!-- 							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a> -->
<!-- 						</td> -->
					</tr>
					<tr>
						<td width="140px">
						</td>
						<td style="color:blue;">
							（此属性设置本系统即运营管理平台的地址，值为形如："http://clouduan.com/op/"的字符串）
						</td>
					</tr>
					<tr>
						<td colspan="95" style="padding: 10px 0 10px 0;">
							<hr />
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
				
				<table style="width:100%; margin:0 auto 0 auto;">
					<tr>
						<td width="140px" style="font-weight:bolder;">
							CPU套餐上限：
						</td>
						<td >
							最大
							<input id="cpu_package_option_upper_limit" type="text" name="cpu_upper"  value="" style="width:50px"/>核
						</td>
<!-- 						<td align="right" style="width:100px;"> -->
<!-- 							&nbsp;&nbsp; -->
<!-- 							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a> -->
<!-- 						</td> -->
					</tr>
					<tr>
						<td width="140px">
						</td>
						<td style="color:blue;">
							（此属性将会影响运营商在套餐项管理页可以设置的最大的CPU核数）
						</td>
					</tr>
					<tr>
						<td colspan="95" style="padding: 10px 0 10px 0;">
							<hr />
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
					
				<table style="width:100%; margin:0 auto 0 auto;">
					<tr>
						<td width="140px" style="font-weight:bolder;">
							内存套餐上限：
						</td>
						<td >
							最大
							<input id="memory_package_option_upper_limit" type="text" name="memory_upper"  value=""  style="width:50px"/>GB
						</td>
<!-- 						<td align="right" style="width:100px;"> -->
<!-- 							&nbsp;&nbsp; -->
<!-- 							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a> -->
<!-- 						</td> -->
					</tr>
					<tr>
						<td width="140px">
						</td>
						<td style="color:blue;">
							（此属性将会影响运营商在套餐项管理页可以设置的最大的内存容量）
						</td>
					</tr>
					<tr>
						<td colspan="95" style="padding: 10px 0 10px 0;">
							<hr />
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
					
				<table style="width:100%; margin:0 auto 0 auto;">
					<tr>
						<td width="140px" style="font-weight:bolder;">
							上传最大文件容量：
						</td>
						<td >
							最大
							<input id="upload_file_upper_limit" type="text" name="upload_file_upper"  value=""  style="width:50px"/>MB
						</td>
<!-- 						<td align="right" style="width:100px;"> -->
<!-- 							&nbsp;&nbsp; -->
<!-- 							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a> -->
<!-- 						</td> -->
					</tr>
					<tr>
						<td width="140px">
						</td>
						<td style="color:blue;">
							（此属性将会限定用户上传的单个文件大小）
						</td>
					</tr>
					<tr>
						<td colspan="95" style="padding: 10px 0 10px 0;">
							<hr />
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
					
				<table style="width:100%; margin:0 auto 0 auto;">
					<tr>
						<td width="140px" style="font-weight:bolder;">
							用户最大的可用空间：
						</td>
						<td >
							最大
							<input id="upload_total_file_upper_limit" type="text" name="upload_total_file_upper"  value=""  style="width:50px"/>MB
						</td>
<!-- 						<td align="right" style="width:100px;"> -->
<!-- 							&nbsp;&nbsp; -->
<!-- 							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a> -->
<!-- 						</td> -->
					</tr>
					<tr>
						<td width="140px">
						</td>
						<td style="color:blue;">
							（此属性将会限定用户最大的可用空间）
						</td>
					</tr>
					<tr>
						<td colspan="95" style="padding: 10px 0 10px 0;">
							<hr />
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
					
				<table style="width:100%; margin:0 auto 0 auto;">
					<tr>
						<td width="140px" style="font-weight:bolder;">
							现金券最大额度：
						</td>
						<td >
							最大
							<input id="cash_upper_limit" type="text" name="cash_upper"  value=""  style="width:50px"/>元
						</td>
<!-- 						<td align="right" style="width:100px;"> -->
<!-- 							&nbsp;&nbsp; -->
<!-- 							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a> -->
<!-- 						</td> -->
					</tr>
					<tr>
						<td width="140px">
						</td>
						<td style="color:blue;">
							（此属性将会限定现金券的最大额度）
						</td>
					</tr>
					<tr>
						<td colspan="95" style="padding: 10px 0 10px 0;">
							<hr />
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
				
				<table style="width:100%; margin:0 auto 0 auto;">
					<tr>
						<td width="140px" style="font-weight:bolder;">
							致云客户端版本：
						</td>
						<td >
							<input id="client_version_name" type="text" name="version_name"  value=""  style="width:400px"/>
						</td>
<!-- 						<td align="right" style="width:100px;"> -->
<!-- 							&nbsp;&nbsp; -->
<!-- 							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a> -->
<!-- 						</td> -->
					</tr>
					<tr>
						<td width="140px">
						</td>
						<td style="color:blue;">
							（此属性将限定下载路径显示）
						</td>
					</tr>
					<tr>
						<td colspan="95" style="padding: 10px 0 10px 0;">
							<hr />
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
				
				<table style="width:90%; margin:0 auto 0 auto;">
					<tr>
						<td align="right" style="width:100px;">
							&nbsp;&nbsp;
							<a href="javascript:" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'" > &nbsp;保存&nbsp; </a>
						</td>
					</tr>
				</table>
				
				<%-- ******************** --%>
				
			</div>
		
		</form>
	</body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ext.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/big.min.js"></script>
	
	<script type="text/javascript">
	
	var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");
	ajax.async = false;
	
	var _package_option_upper_dlg_scope_ = new function(){
		
		var upper_obj = this;
		
		$("#address_of_this_system").val("<%=AppProperties.getValue("address_of_this_system", "")%>");
		$("#cpu_package_option_upper_limit").val("<%=AppProperties.getValue("cpu_package_option_upper_limit", "")%>");
		$("#memory_package_option_upper_limit").val("<%=AppProperties.getValue("memory_package_option_upper_limit", "")%>");
		$("#upload_file_upper_limit").val("<%=AppProperties.getValue("upload_file_upper_limit", "")%>");
		$("#upload_total_file_upper_limit").val("<%=AppProperties.getValue("upload_total_file_upper_limit", "")%>");
		$("#cash_upper_limit").val("<%=AppProperties.getValue("cash_upper_limit", "")%>");
		$("#client_version_name").val("<%=AppProperties.getValue("client_version_name", "")%>");
		
		// 更新CPU核心数、内存上限、网关配置
		upper_obj.saveCpuUpper = function() {
			var   r = /^[0-9]*[1-9][0-9]*$/;
// 			var   r =/^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/;
			var core = $("#cpu_package_option_upper_limit").val().trim();
			if( core=="" || !(r.test(core)))
			{
				top.$.messager.alert("警告","CPU套餐上限必须为正整数",'warning',function(){
					window.location.reload();
				});
				return ;
			}
			var memory = $("#memory_package_option_upper_limit").val().trim(); 
			if( memory=="" || !(r.test(memory)))
			{
				top.$.messager.alert("警告","内存套餐上限必须为正整数",'warning',function(){
					window.location.reload();
				});
				return ;
			}
			var upload_file_upper = $("#upload_file_upper_limit").val().trim(); 
			if( upload_file_upper=="" || !(r.test(upload_file_upper)))
			{
				top.$.messager.alert("警告","单个上传文件大小上限必须为正整数",'warning',function(){
					window.location.reload();
				});
				return ;
			}
			var cash_upper = $("#cash_upper_limit").val().trim(); 
			if( cash_upper=="" || !(r.test(cash_upper)) || cash_upper > 2000)
			{
				top.$.messager.alert("警告","现金券的最大额度必须为不大于2000的正整数",'warning',function(){
					window.location.reload();
				});
				return ;
			}
			var version_name = $("#client_version_name").val().trim(); 
			if(version_name==""||version_name==null)
			{
				top.$.messager.alert("警告","客户端版本不能为空",'warning',function(){
					window.location.reload();
				});
				return ;
			}
			var upload_total_file_upper = $("#upload_total_file_upper_limit").val().trim(); 
			if( upload_total_file_upper=="" || !(r.test(upload_total_file_upper)))
			{
				top.$.messager.alert("警告","最大的可用空间必须为正整数",'warning',function(){
					window.location.reload();
				});
				return ;
			}
			var formData = $.formToBean(big_form);
			ajax.remoteCall("bean://appPropertyService:updateAppPropertyService", 
				[ formData ],
				function(reply) {
					if (reply.status == "exception") {
						if(reply.errorCode=="<%=ErrorCode.ERROR_CODE_FAIL_TO_CALL_BEFORE_LOGIN%>"){
							top.$.messager.alert("警告","会话超时，请重新登录","warning");
						}else{
							top.$.messager.alert("警告",reply.exceptionMessage,"warning",function(){
								top.location.reload();
							});
						}
					} else if (reply.result.status == "success") {
						top.$.messager.alert("提示","保存成功",'info',function() {
							window.location.reload();
						});
					} 
				}
			);
		};
	
		// 
		$(document).ready(function(){
			$(".save-btn").click(function(){
				if($("#cpu_package_option_upper_limit").val() < <%=request.getAttribute("cpu")%>){
					top.$.messager.alert('警告',"CPU核心数小于当前套餐项中的最大值，请联系运营商删除",'warning',function(){
						window.location.reload();
					});
					return;
				}
				if($("#memory_package_option_upper_limit").val() < <%=request.getAttribute("memory")%>){
					top.$.messager.alert('警告',"内存大小心数小于当前套餐项中的最大值，请联系运营商删除",'warning',function(){
						window.location.reload();
					});
					return;
				}
				upper_obj.saveCpuUpper();
			});
		});
		
	};
	</script>
</html>