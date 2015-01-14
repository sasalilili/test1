<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.exception.ErrorCode"%>
<%@page import="java.math.BigDecimal"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
	String userId = loginInfo.getUserId(); 
%>
<!DOCTYPE html>
<!-- rechargelog.jsp -->
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		
		<title>代理商 - 充值记录</title>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
		<style type="text/css">
		#agent_datagrid {
			border: 0px solid red;
		}
		.panel-header {
			border-top: 0px;
			border-bottom: 1px solid #dddddd;
		}
		.panel-header,.panel-body {
			border-left: 0px;
			border-right: 0px;
		}
		.panel-body {
			border-bottom: 0px;
		}
		</style>
	</head>
	<body style="visibility:hidden;">
		<form id="big_form"  method="post">
	
			<table id="agent_recharge_detail" class="easyui-datagrid" title="充值记录"
				data-options="
					url: '<%=request.getContextPath()%>/bean/ajax.do?userType=<%=userType%>&bean=accountBalanceService&method=queryRechargeRecord',
					queryParams: {},
					toolbar: '#toolbar', 
					striped: true,
					remoteSort:false,
					fitColumns: true, 
					pagination:true,
					pageList: [10, 20, 50, 100, 200],
					pageSize: 20,
					view:createView(),
					singleSelect:true,
					onLoadSuccess: onLoadSuccess
				">
				<thead>
					<tr>
						<th field="changeTime" width="70px" formatter="timeFormatter"  >充值时间</th> 
						<th field="payType" width="70px" formatter="typeFormatter" sortable=true>充值方式</th>  
						<th field="amount" width="70px" sortable=true>充值金额(元)</th>  
					</tr>
				</thead>
			</table> 
			
			
			<div id="toolbar" style="padding: 3px;">
				<div style="display: table; width: 100%;">
				 
					<div style="display: table-cell; text-align: right"> 
						<input id="start_time" type="text"  class="easyui-datebox"  >到
						<input id="end_time" type="text" class="easyui-datebox"  >
						<a href="#" class="easyui-linkbutton" iconCls="icon-search" id="query_recharge_log_btn">查询</a>
<!-- 						<a href="#" class="easyui-linkbutton" iconCls="icon-print" plain="true" id="export_btn">导出excel</a>  -->
 					</div>
					 
				</div>
			</div>
			 
		</form>
	</body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ext.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	window.name = "selfWin";
	
	var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");
	ajax.async = false;
	

	// 布局初始化
	$("#agent_recharge_detail").height( $(document.body).height());
   
	
	
	
	//查询结果为空
	function createView(){
		return $.extend({},$.fn.datagrid.defaults.view,{
		    onAfterRender:function(target){
		        $.fn.datagrid.defaults.view.onAfterRender.call(this,target);
		        var opts = $(target).datagrid('options');
		        var vc = $(target).datagrid('getPanel').children('div.datagrid-view');
		        vc.children('div.datagrid-empty').remove();
		        if (!$(target).datagrid('getRows').length){
		            var d = $('<div class="datagrid-empty"></div>').html( '没有相关记录').appendTo(vc);
		            d.css({
		                position:'absolute',
		                left:0,
		                top:50,
		                width:'100%',
		                textAlign:'center'
		            });
		        }
		    }
	    });
	}
	
	function onLoadSuccess()
	{
		$("body").css({
			"visibility":"visible"
		});
		
	}  
	
	function typeFormatter(val, row)
	{  
		if(val == 1){  
		    return "支付宝";  
		}else if(val == 2) {
		    return "银联";  
		}else if(val == 3){
			return "系统赠送";
		}else if(val == 5){
			return "兑换现金券";
		}else{
		 	return "系统扣费";
		}
	}
	function timeFormatter(val, row)
	{ 
		if(val==null||val==''){
			return "";
		}
		return $.formatDateString(val, "yyyyMMddHHmmssSSS", "yyyy-MM-dd HH:mm:ss");
	}
	
	
	$(function(){
		// 查询
		$("#query_recharge_log_btn").click(function(){
			var queryParams = {};
			queryParams.startTime = $("#start_time").datebox('getValue').trim();
			queryParams.endTime = $("#end_time").datebox('getValue').trim();
			$('#agent_recharge_detail').datagrid({
				"queryParams": queryParams
			});
		});  
		$('#start_time').datebox({
			onSelect: function(date){
				var startTime = $("#start_time").datebox('getValue').trim();
				var endTime = $("#end_time").datebox('getValue').trim();
				if(endTime==null){
					return;
				}else{
					var endTime = endTime.split("-");
					var endDate = new Date(endTime[0], endTime[1]-1, endTime[2]);
					if(date>endDate){
						$('#start_time').datebox('setValue', '');
						top.$.messager.alert('警告','开始时间大于结束时间','warning');
					}
				}
			}
		});
		$('#end_time').datebox({
			onSelect: function(date){
				var startTime = $("#start_time").datebox('getValue').trim();
				var endTime = $("#end_time").datebox('getValue').trim();
				if(startTime==null){
					return;
				}else{ 
					var startTime = startTime.split("-");
					var startDate = new Date(startTime[0], startTime[1]-1, startTime[2]); 
					if(date<startDate){
						$('#end_time').datebox('setValue', '');
						top.$.messager.alert('警告','开始时间大于结束时间','warning');
					}
				}
			}
		});
	});
	</script>
</html>