<%@page import="java.math.BigDecimal"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="java.util.*"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.exception.ErrorCode"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
%>
<!DOCTYPE html>
<!-- statement_manage.jsp -->
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		
		<title>代理商 - 业务图表</title>
		
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">
		<style type="text/css">

		</style>
	</head>
	<body>
		<div>
			<div data-options="region:'center',title:'统计报表',border:false" >
				<div style="margin:0px; padding:0px;">
					<form id="host_user_count" method="post">
					<table style="height:80px; padding:5px;">
						<tr style="height: 25px"></tr>
						<tr>
							<td style="width: 100px"></td>
							<td style="width: 850px">
							<select id="select_time" name="select_time" style="width: 100px" onchange="changeTime()">
							<option value="seven">最近七天</option>
							<option value="month">最近一月</option>
							<option value="year">最近一年</option>
							</select>
							</td>
							<td>新增用户数：</td><td id="new_users_count"></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td>新增云主机：</td><td id="new_hosts_count"></td>
						</tr>
<!-- 						<tr> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td>新增云硬盘：</td><td id="new_disks_count">0</td> -->
<!-- 						</tr> -->
					</table>
					</form>
				</div>
				
<!-- 				<hr style="width:99%;"/> -->
				
				<div style="height:440px;">
					<div id="main_pie_1" style="height:440px;margin-left: 0px;"></div>
				</div>
				
				<hr style="width:99%;"/>
				
				<div style="margin:0px; padding:0px;">
				<form id="volume_business" method="post">
					<table style="height:80px; padding:5px">
						<tr>
							<td style="width: 50px"></td>
							<td style="width: 50px;margin-left: 20px">
							<select id="select_time2" name="select_time2" style="width: 100px" onchange="changeTimeAndOthers()">
							<option value="seven">最近七天</option>
							<option value="month">最近一月</option>
							<option value="year">最近一年</option>
							</select>
							</td>
							<td style="width: 50px ;margin-left: 50px">
							<select id="select_region" name="select_region" style="width: 100px" onchange="changeTimeAndOthers()">
							<option value="0">所有地域</option>
							<option value="1">广州</option>
<!-- 							<option value="2">成都</option> -->
<!-- 							<option value="3">北京</option> -->
							<option value="4">香港</option>
							</select>
							</td>
							<td style="width: 50px">
							<select id="select_goods" name="select_gonds" style="width: 100px" onchange="changeTimeAndOthers()">
							<option value="0">所有产品</option>
							</select>
							</td>
							<td style="width: 550px"></td>
							<td>新增业务额：</td>
							<td id="business_money"></td>
							<td>元</td>
						</tr>
					</table>
				</form>
				</div>
				
<!-- 				<hr style="width:99%;"/> -->
				
				<div style="height:440px;">
					<div id="main_pie_2" style="height:440px; with: border-right: 1px solid #ccc;"></div> 
				</div>
			</div>
		</div> 
	</body>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ext.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/big.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/esl.js"></script>
	<script type="text/javascript">
	window.name = "selfWin";
	var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");
	ajax.async = false;
	$(document).ready(function(){
		changeTime();
		changeTimeAndOthers();
	});

function changeTime(){
	var time= new Array();
	var userCount = new Array();
	var hostCount = new Array();
	var select_time=$("#select_time").val();
	ajax.remoteCall("bean://statementService:businessGraphicsByTime", 
			[select_time],
			function(reply){
			if( reply.status=="exception" )
			{
				if(reply.errorCode=="<%=ErrorCode.ERROR_CODE_FAIL_TO_CALL_BEFORE_LOGIN%>"){
					top.$.messager.alert("警告","会话超时，请重新登录","warning",function(){
					top.location.reload();
					});
				}
				else{
					top.$.messager.alert("警告","信息有误","warning",function(){
						top.location.reload();
					});
				} 
			}if(reply.status=="success"){
				userCount   =reply.result.properties.userCount;
				userCounts  =reply.result.properties.userCounts;
				hostCount   =reply.result.properties.hostCount;
				hostCounts  =reply.result.properties.hostCounts;
				time   =reply.result.properties.time;
				$("#new_users_count").html(userCounts); 
			    $("#new_hosts_count").html(hostCounts);
			}
		
	require.config({
	    paths:{
	    	'echarts':'<%=request.getContextPath()%>/js/echarts',
	        'echarts/chart/line': '<%=request.getContextPath()%>/js/echarts'
	    }
	});
	require(
	        [
				'echarts',
				'echarts/chart/line'
	        ],
	        function(ec) {
	            var mainChart1 = ec.init(document.getElementById('main_pie_1'));
	            option1 = {
	            		color:['#4FA6F6','#58CB81'],
// 	            		animation:false,
	            		title : {
	            	        text: ''
	            	    },
	            	    tooltip : {
	            	        trigger: 'axis'
	            	    },
	            	    legend: {
	            	        data:['用户数','云主机']
	            	    },
	            	    grid: {
//             		    	x:'30',
//             		    	y:'40',
//             	            width: '270',
            	            height: '330',
//             	            backgroundColor: 'rgba(0,0,0,0)',
//             	            borderWidth: 1,
//             	            borderColor: '#ccc'
            	        },
	            	    calculable : true,
	            	    xAxis : [
	            	        {
	            	            type : 'category',
	            	            boundaryGap : false,
	            	        	data:time,
	            	        	splitLine:{
	            	            	show:false
	            	            }
	            	        }
	            	    ],
	            	    yAxis : [
	            	        {
	            	            type : 'value',
	            	            axisLabel : {
	            	                formatter: '{value}'
	            	            }
	            	        }
	            	    ],
	            	    series : [
	            	        {
	            	            name:'用户数',
	            	            type:'line',
								data:userCount,
	            	        },
	            	        {
	            	            name:'云主机',
	            	            type:'line',
	            	            data:hostCount,
	            	        }
	            	    ]
	            	};
	          	mainChart1.setOption(option1,true); 
	       }
		);
  });
}

function changeTimeAndOthers(){
	var time= new Array();
	var incomeCount = new Array();
	var select_time=$("#select_time2").val();
	var select_region=$("#select_region").val();
	var select_goods=$("#select_goods").val();
	ajax.remoteCall("bean://statementService:businessGraphicsByTimeAndOthers", 
		[select_time,select_region,select_goods],
			function(reply){
			if( reply.status=="exception" )
			{
				if(reply.errorCode=="<%=ErrorCode.ERROR_CODE_FAIL_TO_CALL_BEFORE_LOGIN%>"){
					top.$.messager.alert("警告","会话超时，请重新登录","warning",function(){
					top.location.reload();
					});
				}
				else{
					top.$.messager.alert("警告","信息有误","warning",function(){
						top.location.reload();
					});
				} 
			}if(reply.status=="success"){
				incomeCount =reply.result.properties.incomeCount;
				incomeCounts=reply.result.properties.incomeCounts;
				time   =reply.result.properties.time;
				$("#business_money").html(incomeCounts); 
			}
	require.config({
	    paths:{
	    	'echarts':'<%=request.getContextPath()%>/js/echarts',
	        'echarts/chart/bar' : '<%=request.getContextPath()%>/js/echarts'
	    }
	});
	require(
	        [
				'echarts',
				'echarts/chart/bar'
	        ],
	        function(ec) {
	            var mainChart2 = ec.init(document.getElementById('main_pie_2'));
	            option2 = {
	            		title : {
	            	        text: '',
	            	    },
	            	    tooltip : {
	            	        trigger: 'axis'
	            	    },
	            	    legend: {
	            	        data:['业务额']
	            	    },
// 	            	    animation:false,
	            	    calculable : true,
	            	    grid: {
//             		    	x:'30',
//             		    	y:'40',
//             	            width: '270',
            	            height: '330',
//             	            backgroundColor: 'rgba(0,0,0,0)',
//             	            borderWidth: 1,
//             	            borderColor: '#ccc'
            	        },
	            	    xAxis : [
	            	        {
	            	            type : 'category',
	            	            data : time,
	            	            splitLine:{
	            	            	show:false
	            	            }
	            	        }
	            	    ],
	            	    yAxis : [
	            	        {
	            	            type : 'value'
	            	        }
	            	    ],
	            	    series : [
	            	        {
	            	            name:'业务额',
	            	            type:'bar',
	            	            data:incomeCount
	            	        }
	            	    ]
	            	};
	            
	          	mainChart2.setOption(option2,true); 
	       }
		);
  });
}
</script>
</html>