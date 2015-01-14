<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.common.util.StringUtil"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
%>
<!DOCTYPE html>
<!-- suggestion_manage.jsp -->
<html>
	<head> 
		<meta charset="UTF-8" />
	    <meta http-equiv="Content-Type" content="textml; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		
		<title>用户 - 意见反馈</title>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
		<style type="text/css">
		#sys_role_datagrid {
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
	
			<table id="suggestion_list" class="easyui-datagrid" title="意见反馈"
				data-options="
					url: '<%=request.getContextPath()%>/bean/ajax.do?userType=<%=userType%>&bean=suggestionService&method=querySuggestion',
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
					onLoadSuccess: onLoadSuccess
				">
				<thead>
					<tr>  
						<th field="account"  width="10px">用户名</th>
						<!-- <th field="type" formatter="typeFormatter" width="5px">类别</th> -->
						<th field="content"   width="10px">内容</th> 
						<th field="submitTime"  formatter="timeFormatter" width="10px" >提交时间</th> 
						<th field="status"  formatter="statusFormatter" width="10px">状态</th> 
						<th field="suggestion" formatter="operateColumnFormatter" width="10px">操作</th>
					</tr>
				</thead>
			</table> 
			<div id="toolbar" style="padding: 3px;">
				<div style="display: table; width: 100%;"> 
					<div style="display: table-cell; text-align: right;">
						<!-- <span style="position: relative; top: 2px;">类别</span> 
						<select class="shortselect" name="type" id="type">
								<option value="">全部</option>
								<option value="1">页面风格</option> 
								<option value="2">产品功能</option>
								<option value="3">其他</option>
							</select> -->
						<span style="position: relative; top: 2px;">状态</span> 
						<select class="shortselect" name="status" id="status">
								<option value="">全部</option>
								<option value="1">未答复</option> 
								<option value="2">已答复</option> 
							</select>
						<a href="#" class="easyui-linkbutton" iconCls="icon-search" id="query_suggestion_btn">查询</a>
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
		$("#suggestion_list").height( $(document.body).height());

		function typeFormatter(val, row)
		{  
			if(val == 1){  
			    return "页面风格";  
			}else if(val == 2) {
			    return "产品功能";  
			}else{
			 	return "其他";
			}
		}
		function statusFormatter(val, row)
		{  
			if(val == 1){  
			    return "未答复";  
			}else if(val == 2) {
			    return "已答复";  
			}
		}
		function timeFormatter(val, row){ 
			
			if(val!=null&&val.length>0){ 
			    return val.substring(0,4)+"-"+val.substring(4,6)+"-"+val.substring(6,8);
			}else{
				return "";
			}
		}
		function operateColumnFormatter(value, row, index)
		{ 
			return "<div row_index='"+index+"'>\
						  <a href='#' class='datagrid_row_linkbutton view-reply'>答复</a>\
					</div>"; 
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
			// 每一行的'查看详情列表'按钮
			$("a.view-detail").click(function(){
				$this = $(this);
				rowIndex = $this.parent().attr("row_index");
				var data = $("#suggestion_list").datagrid("getData");
				var id = data.rows[rowIndex].id; 
				top.showSingleDialog({
					url: "<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=suggestionService&method=suggestionDetailPage",
					params: {
						"suggestionId" : id
					},
					onClose : function(data) {
						$('#agent_datagrid').datagrid('reload');
					}
				});
			});
			// 每一行的'答复'按钮
			$("a.view-reply").click(function(){
				$this = $(this);
				rowIndex = $this.parent().attr("row_index");
				var data = $("#suggestion_list").datagrid("getData");
				var id = data.rows[rowIndex].id;
				var type = "reply";
				top.showSingleDialog({
					url: "<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=suggestionService&method=suggestionDetailPage",
					params: {
						"suggestionId" : id,
						"type" : type
					},
					onClose : function(data) {
						$('#suggestion_list').datagrid('reload'); 
					}
				});
			});
			 
		}
		$(function(){
			// 查询
			$("#query_suggestion_btn").click(function(){
				var queryParams = {};
				queryParams.type = $("#type").val().trim();
				queryParams.status = $("#status").val().trim();
				$('#suggestion_list').datagrid({
					"queryParams": queryParams
				});
			});
			// 添加代理商
			$("#add_suggestion_btn").click(function(){
				top.showSingleDialog({
					url: "<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=suggestionService&method=addSuggestionPage",
					onClose: function(data){
						$('#suggestion_list').datagrid('reload');
					}
				});
			});
			 
			 $('#type').bind('keypress',function(event){
		        if(event.keyCode == "13")    
		        {
		        	$("#query_suggestion_btn").click();
		        }
		    });
		});
		
	</script>
</html>