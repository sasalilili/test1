<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.exception.ErrorCode"%>
<%@page import="java.math.BigDecimal"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	String createTime = (String)request.getParameter("createTime");
	BigDecimal incomeCount = (BigDecimal)request.getAttribute("incomeCount");
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
	
%>
<div id="agent_bill_detail_view_item_dlg_container">
	<div id="agent_bill_detail_view_item_dlg" class="easyui-dialog" title="<%=createTime %>" 
			style="
				width:900px; 
				height:600px; " 
			data-options="
				buttons: '#agent_bill_detail_view_item_dlg_buttons',
				modal: true,
				onMove:_agent_bill_detail_view_item_dlg_scope_.onMove,
				onClose: function(){
					$(this).dialog('destroy');
				},
				onDestroy: function(){
					delete _agent_bill_detail_view_item_dlg_scope_;
				}
			">
			<table id="agent_invoice_datagrid_agent" class="easyui-datagrid"   style="height:550px;"
				data-options="
					url: '<%=request.getContextPath()%>/bean/ajax.do?userType=<%=userType%>&bean=businessStatisticsService&method=queryAgentMonthlyDetail&createTime=<%=createTime %>',
					queryParams: {},
					toolbar: '#toolbar',
					rownumbers: true,
					striped: true,
					remoteSort:false,
					fitColumns: true,
					pagination: true,
					pageList: [10, 20, 50, 100, 200],
					pageSize: 20,
					singleSelect:true,
					view:createView() 
				">
				<thead>
					<tr>
						<th field="userName" width="70px">用户</th> 
						<th field="hostName" width="70px">主机名</th> 
						<th field="region" formatter="formatRegion" width="70px">地域</th> 
						<th field="fee" width="70px" sortable=true>金额（元）</th>
					</tr>
				</thead>
			</table>
			
			<div id="toolbar" style="padding: 3px;">
				<div style="display: table; width: 100%;">
					<div style="display: table-cell; text-align: right">
					    业务总额：<%=incomeCount %>
						<a href="#" class="easyui-linkbutton" iconCls="icon-print" plain="true" id="export_btn">导出excel</a> 
 					</div>
					 
				</div>
			</div>
	</div>
</div>
	 
	<script type="text/javascript">
	window.name = "selfWin";
	
	var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");
	ajax.async = false; 	
	
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
	
	
	var _agent_bill_detail_view_item_dlg_scope_ = new function(){
		
		var self = this;
		
		self.onMove = function(){
			var thisId = "#agent_bill_detail_view_item_dlg";
			var topValue = $(thisId).offset().top;
			var leftValue = $(thisId).offset().left;
			if(topValue==0){
				topValue = 30;
			}
			if(topValue<30){
				$(thisId).dialog('move',{
					left:leftValue,
					top:30
				});
				return;
			}
			if(leftValue>1315){
				$(thisId).dialog('move',{
					left:1300,
					top:topValue
				});
				return;
			}
			if(topValue>600){
				$(thisId).dialog('move',{
					left:leftValue,
					top:570
				});
				return;
			}
		}; 
		
		// 关闭
		this.close = function()
		{
			$("#agent_bill_detail_view_item_dlg").dialog("close");
		};
		
		// 初始化
	};
	
	$("#agent_bill_detail_view_item_dlg").attr("title",$.formatDateString('<%=createTime%>', "yyyyMM", "yyyy年MM月"));
	// 批量导出
	  
	$("#export_btn").click(function() { 
		
		var grid = $('#agent_invoice_datagrid_agent');
		var options = grid.datagrid('getPager').data("pagination").options;
		var page = options.pageNumber;
		var rows = options.pageSize; 
		 
		top.$.messager.confirm("确认", "确定导出？", function (r) {  
	        if (r) {   
				window.location.href= "<%=request.getContextPath()%>/agentBillExport.do?userType=<%=userType%>&page="+page+"&rows="+rows+"&createTime=<%=createTime%>";
		        }  
	    });   
	}); 
	
	function formatRegion(val,row)
	{  
		if(val == 1){
			return "广州";
		}else if(val == 4){
			return "香港";
		}
	}  
	</script> 