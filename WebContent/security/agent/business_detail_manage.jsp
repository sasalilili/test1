<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.exception.ErrorCode"%>
<%@page import="java.math.BigDecimal"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
	String userId = loginInfo.getUserId();
	BigDecimal incomeCount = (BigDecimal)request.getAttribute("incomeCount");
%>
<!DOCTYPE html>
<!-- business_detail_manage.jsp -->
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		
		<title>代理商 - 发票管理</title>
		
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
	
			<table id="agent_invoice_datagrid_agent" class="easyui-datagrid" title="业务明细"
				data-options="
					url: '<%=request.getContextPath()%>/bean/ajax.do?userType=<%=userType%>&bean=businessStatisticsService&method=queryBusinessByMonthly',
					queryParams: {},
					toolbar: '#toolbar',
					rownumbers: true,
					striped: true,
					remoteSort:false,
					fitColumns: true,
					pagination: true,
					pageList: [10, 20, 50, 100, 200],
					pageSize: 20,
					view:createView(),
					singleSelect:true,
					onLoadSuccess: onLoadSuccess,
					 onClickRow: function (rowIndex, rowData) {  toA(rowData.createTime); }
				">
				<thead>
					<tr>
						<th field="fee" width="70px" sortable=true>业务额</th>
						<th field="createTime" width="70px" formatter="formatSubmitTime">月份</th> 
					</tr>
				</thead>
			</table> 
			
			<div id="toolbar" style="padding: 3px;">
				<div style="display: table; width: 100%;">
					<div style="display: table-cell; text-align: right">
					    业务总额：<%=incomeCount==null?0:incomeCount%>
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
	$("#agent_invoice_datagrid_agent").height( $(document.body).height());

	function formatSubmitTime(val, row)
	{
		return $.formatDateString(val, "yyyyMM", "yyyy年MM月");
	}
	
	function formatStatus(val,row)
	{  
		if(val == 2 || val == 4){
			return "审核中";
		}else if(val == 3){
			return "已寄送";
		}
		else if(val == 5){
			return "寄送完成";
		}
	}  
	
	function toA(createTime){ 
		
		top.showSingleDialog({
			url: "<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=businessStatisticsService&method=agentMonthlyDetailPage&createTime="+createTime,
 			onClose: function(data){
				$('#terminal_user_datagrid_agent').datagrid('reload');
			}
		});
	}
	
	
	
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
	
	$(document).ready(function(){
		// 按 id 查询对应的代理商的发票
		var queryParams = {};
		queryParams.user_id = '<%=userId%>';
		$('#agent_invoice_datagrid_agent').datagrid({
			"queryParams": queryParams
		});
	});
	
	$(function(){
		
		// 索取发票
		$("#add_agent_invoice_btn").click(function(){
			top.showSingleDialog({
				url: "<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=invoiceService&method=addInvoicePageForAgent",
				onClose: function(data){
					$('#agent_invoice_datagrid_agent').datagrid('reload');
				}
			});
		});
	});
	
	</script>
</html>