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
<!-- business_detail_manage.jsp -->
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		
		<title>代理商 - 业务统计</title>
		
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
	
			<table id="agent_business_statistics" class="easyui-datagrid" title="业务明细"
				data-options="
					url: '<%=request.getContextPath()%>/bean/ajax.do?userType=<%=userType%>&bean=businessStatisticsService&method=queryBillDetailByTimeAndRegion',
					queryParams: {},
					toolbar: '#toolbar', 
					striped: true,
					remoteSort:false,
					fitColumns: true, 
					pageList: [10, 20, 50, 100, 200],
					pageSize: 20,
					view:createView(),
					singleSelect:true,
					onLoadSuccess: onLoadSuccess
				">
				<thead>
					<tr>
						<th field="type" width="70px" formatter="formatType"  ></th> 
						<th field="gzStatistics" width="70px" sortable=true>广州</th> 
<!-- 						<th field="cdStatistics" width="70px" sortable=true>成都</th>  -->
<!-- 						<th field="bjStatistics" width="70px" sortable=true>北京</th>  -->
						<th field="xgStatistics" width="70px" sortable=true>香港</th> 
						<th field="totalStatistics" width="70px" sortable=true>总计</th> 
					</tr>
				</thead>
			</table> 
			
			<div id="toolbar" style="padding: 3px;">
				<div style="display: table; width: 100%;">
				
				    <div style="display: table-cell; text-align: left">
						<select id="query_by_status" style="position: relative; top: 2px;">
						   <option  value="0">全部</option>
						   <option value="1">最近一年</option>
						   <option value="2">最近一月</option>
						   <option value="3">最近一周</option>
						</select>
					</div>
					<div style="display: table-cell; text-align: right"> 
						<a href="#" class="easyui-linkbutton" iconCls="icon-print" plain="true" id="export_btn">导出excel</a> 
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
	$("#agent_business_statistics").height( $(document.body).height());
 
	
	function formatType(val,row)
	{  
		if(val == 1){
			return "云主机";
		}else if(val == 2){
			return "云硬盘";
		}
		else if(val == 3){
			return "总计";
		}
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
		//下拉框值改变刷新
		$("#query_by_status").change(function(){
			var queryStatus = {};
			queryStatus.time = $("#query_by_status").val();
			$('#agent_business_statistics').datagrid({
				"queryParams": queryStatus
			});
		});
		
		$("#export_btn").click(function() {  
			top.$.messager.confirm("确认", "确定导出？", function (r) {  
		        if (r) {   
					window.location.href= "<%=request.getContextPath()%>/agentBusinessStatisticsExport.do?userType=<%=userType%>&time="+$("#query_by_status").val();
			        }  
		    });   
		});
		
	});
	
	$(function(){
		
		// 索取发票
		$("#add_agent_invoice_btn").click(function(){
			top.showSingleDialog({
				url: "<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=invoiceService&method=addInvoicePageForAgent",
				onClose: function(data){
					$('#agent_business_statistics').datagrid('reload');
				}
			});
		});
	});
	
	</script>
</html>