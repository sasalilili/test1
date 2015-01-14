<%@page import="com.zhicloud.op.common.util.StringUtil"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.vo.AgentVO" %>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, userType);
	AgentVO agent = (AgentVO)request.getAttribute("agent");
%>
<!DOCTYPE html>
<!-- agent_recharge.jsp -->
<html>
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		<title>代理商 -账户充值</title>
		
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
          <form id="pay_form" action="<%=request.getContextPath()%>/bean/page.do" method="post"  target="_blank">
		
			<div class="panel-header">
				<div class="panel-title">账户充值</div>
				<div class="panel-tool"></div>
			</div>
			 <input name="email" value="mali@zhicloud.com" type="hidden"/> 
	          <input name="WIDsubject" value="云主机" type="hidden"/> 
	          <input name="userId" value="<%=loginInfo.getUserId()%>" type="hidden"/> 
	          <input name="userType" value="3" type="hidden"/>
	          <input name="bean" value="paymentService" type="hidden"/>
	          <input name="method" value="toAccountPage" type="hidden"/> 
			 
			<table style="margin: 10px 10px 10px 20px;">
				<tr>
					<td style="vertical-align:middle; text-align:right;">账户余额：</td>
					<td style="padding:5px;">
						 <span><%=agent.getAccountBalance()==null?0:agent.getAccountBalance()%></span>
					</td>
					<td><span id="agent-tip-account"></span></td>
				</tr>
				<%-- <tr>
					<td style="vertical-align:middle; text-align:right;">姓名：</td>
					<td style="padding:5px;">
						<input type="text" id="name" name="name" style="width:300px;" 
							value="<%=StringUtil.trim(agent.getName())%>" disabled="disabled" onblur="checkName()"/>
					</td>
					<td><span id="agent-tip-name"></span></td>
				</tr> --%>
				<tr>
					<td style="vertical-align:middle; text-align:right;">充值金额：</td>
					<td style="padding:5px;">
						<input type="text" id="price" name="total_fee" style="width:50px;"   onblur="checkPrice()"/>
					</td>
					<td><span id="agent-tip-rechargeprice"></span></td>
				</tr>
				<tr>
					<td style="vertical-align:middle; text-align:right;">充值方式：</td>
					<td style="padding:5px;">
					<label for="type_1" style="padding:0 10px 0 0;">
						 
						<input type="radio"    id="type_1" name="payType"  checked="checked" value="1">支付宝
						</label>
					<label for="type_2" style="padding:0 10px 0 0;">
						 
						<input type="radio"    id="type_2" name="payType"    value="2">银联
						</label>
 					</td>
					<td><span id="agent-tip-phone"></span></td>
				</tr>
				<tr>
					<td></td>
					<td align="right" style="padding:5px;">
						<a href="#" class="easyui-linkbutton"  id="toPay">前往支付</a>
						&nbsp;
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
   	 function checkPrice(){ 
   		var patrn=/^\d+$/;
		if(!(patrn.test($("#price").val()))){
			    $("#agent-tip-rechargeprice").html("<font color='red'>请输入整数</font>");
 				return false;
			}else if($("#price").val()<10){
			    $("#agent-tip-rechargeprice").html("<font color='red'>充值金额应大于10</font>");
 				return false;
				
			}else if($("#price").val()>50000){
			    $("#agent-tip-rechargeprice").html("<font color='red'>充值金额应小于50000</font>");
 				return false;
			}else{
			    $("#agent-tip-rechargeprice").html("");
				return true;
			} 
   			 
  	}
   	//=============================
    
   	var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");
	ajax.async = false;
	
	var _operator_basic_information_scope_ = new function(){
		
		var self = this;
		
		 
		
		//--------------------------
		$(document).ready(function(){
		    $('#toPay').click(function () {   
		    	if(checkPrice()){
					 
		  		  $("#pay_form").submit();
		  		 }
			}); 
		}) ;
	};
	</script>
</html>