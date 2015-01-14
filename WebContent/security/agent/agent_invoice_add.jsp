<%@page import="java.util.List"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.vo.InvoiceAddressVO"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request);
	String userId  = loginInfo.getUserId();
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	List<InvoiceAddressVO> invoiceAddressList = (List<InvoiceAddressVO>)request.getAttribute("invoice_address_list");
%>

<!--invoice_add.jsp -->

<div id="add_invoice_dlg_container">
	<div id="add_invoice_dlg" class="easyui-dialog" title="索取发票"
		style="width:650px; height:650px; padding:10px;"
		data-options="
			iconCls: 'icon-print', 
 			buttons: '#add_invoice_dlg_buttons', 
 			modal: true, 
 			onClose: function(){ 
 				$(this).dialog('destroy'); 
 			}, 
 			onDestroy: function(){ 
 				delete _add_invoice_dlg_scope_; 
 			}
		">
		<form id="invoice_add_dlg_form">
			<input id = "userId" name = "userId"  value = "<%=userId %>"type="hidden">
		<table id="invoice_datagrid" class="easyui-datagrid" title=""
				style="height: 300px; margin: 10px;"
				data-options="
						url: '<%=request.getContextPath()%>/bean/ajax.do?userType=<%=userType%>&bean=accountBalanceService&method=queryRechargeRecordForInvoiceForAgent',
						queryParams: {},
						rownumbers: true,
						striped: true,
						remoteSort:false,
						fitColumns: true,
 						pagination: true, 
						pageList: [10, 20, 50, 100, 200],
						pageSize: 10">
				<thead>
					<tr>
						<th data-options="checkbox:true"></th>
						<th field="amount" width="70px" sortable=true>充值金额（元）</th>
						<th field="payType"  formatter="typeFormatter" width="70px">充值方式</th>
						<th field="changeTime" formatter="formatChangeTime" width="70px" sortable=true>充值时间</th>
					</tr>
				</thead>
			</table>
			</form>
			<div id="addresses" class="easyui-tabs" style="width:auto;height:250px;">
			<%
				for(int i = 0; i < invoiceAddressList.size(); i++){
  					InvoiceAddressVO invoiceAddressVO = invoiceAddressList.get(i); 
 			%> 
			<div id =<%=i %> title="<%="地址"+(i+1) %>" style="padding:10px;">
						<input id = "id" name = "id" value = "<%=invoiceAddressVO.getId() %>" type="hidden">
		            <ul>
		                <li>发票抬头：<input id="invoiceTitle" name="invoiceTitle" value ="<%=invoiceAddressVO.getInvoiceTitle() %>" readonly="readonly"  disabled="disabled"  maxlength="100" style="width:300px"/></li>
		                <li>邮寄地址：<input id="address" name="address" value ="<%=invoiceAddressVO.getAddress() %>" readonly="readonly"  disabled="disabled"  maxlength="100" style="width:300px"/></li>
		                <li>收件人：&nbsp;&nbsp;&nbsp;<input id="recipients" name="recipients" value ="<%=invoiceAddressVO.getRecipients() %>" readonly="readonly"  disabled="disabled"  maxlength="100" style="width:300px"/></li>
		                <li>联系方式：<input id="phone" name="phone" value ="<%=invoiceAddressVO.getPhone() %>" readonly="readonly"  disabled="disabled"  maxlength="100" style="width:300px"/></li>
		            </ul>
            </div>
          	<%
				} 
 			%> 
            <div id="new" title="新增" style="padding:10px;"data-options="iconCls: 'icon-add'" >
						<input id = "id" name = "id" value = "" type="hidden">
		            <ul>
		                <li>发票抬头：<input id="invoiceTitle" name="invoiceTitle" value ="" maxlength="100" style="width:300px"/></li>
		                <li>邮寄地址：<input id="address" name="address" value ="" maxlength="100" style="width:300px"/></li>
		                <li>收件人：&nbsp;&nbsp;&nbsp;<input id="recipients" name="recipients" value ="" maxlength="100" style="width:300px"/></li>
		                <li>联系方式：<input id="phone" name="phone" value ="" maxlength="100" style="width:300px"/></li>
		            </ul>
<!-- 		       </form> -->
            </div>
		</div>
	</div>

	<div id="add_invoice_dlg_buttons">
		<a href="javascript:" class="easyui-linkbutton" id="add_invoice_dlg_submit_btn"> &nbsp;提&nbsp;交&nbsp; </a> 
		<a href="javascript:" class="easyui-linkbutton" id="add_invoice_dlg_close_btn"> &nbsp;取&nbsp;消&nbsp; </a>
	</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.ext.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.util.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">



	function typeFormatter(val)	{   
		if(val == 1){
			return "支付宝";
		}else if(val == 2){
			return "银联";
		}
	}
	
	function formatChangeTime(val, row)
	{
		return $.formatDateString(val, "yyyyMMddHHmmssSSS", "yyyy-MM-dd HH:mm:ss");
	}

var _add_invoice_dlg_scope_ = new function(){
	
	var self = this;
	
	
	// 提交
	self.save = function() {
		var rows = $('#invoice_datagrid').datagrid('getSelections');
		var formData = $.formToBean(invoice_add_dlg_form);
		if (rows == null || rows.length == 0)
		{
			top.$.messager.alert("警告","未选择需开据发票的记录","warning");
			return;
		}
		var ids = rows.joinProperty("id");
		var amounts = rows.joinProperty("amount");
		var amount = 0;
		for( i = 0; i<amounts.length; i++ ){
			amount += amounts[i]; 
		}
		//获取地址
		var p = $('#addresses').tabs("getSelected");
		var title = p.panel('options').id;
		var e = document.getElementById(title);
		var child = e.getElementsByTagName("input");
		formData.ids = ids;
		formData.amount = amount;
		formData.id = child[0].value;
		formData.invoiceTitle = child[1].value;
		formData.address = child[2].value;
		formData.recipients = child[3].value;
		formData.phone = child[4].value;
		if(child[1].value==null || child[1].value==""){
			top.$.messager.alert('警告','发票抬头不能为空','warning');
			return;
		}
		if(child[2].value==null || child[2].value==""){
			top.$.messager.alert('警告','邮寄地址不能为空','warning');
			return;
		}
		if(child[3].value==null || child[3].value==""){
			top.$.messager.alert('警告','收件人不能为空','warning');
			return;
		}
		if(child[4].value==null || child[4].value==""){
			top.$.messager.alert('警告','联系方式不能为空','warning');
			return;
		}
		if(!(/^1[3|4|5|8][0-9]\d{8,8}$/.test(child[4].value))){
			top.$.messager.alert('警告','请输入正确的手机号码','warning');
			return;
		}
		ajax.remoteCall("bean://invoiceService:addInvoice", 
			[ formData ],
			function(reply) {
				if (reply.status == "exception") {
					top.$.messager.alert('警告',reply.exceptionMessage,'warning');
				} else if (reply.result.status == "success") {
					top.$.messager.alert('提示','提交成功'	,'info',function(){
						var data = $("#add_invoice_dlg_container").parent().prop("_data_");
						$("#add_invoice_dlg").dialog("close");
						data.onClose(reply.result);
					});
				} else {
					top.$.messager.alert('警告',reply.result.message,'warning');
				}
			}
		);
	};
	
	
	// 关闭
	self.close = function() {
		$("#add_invoice_dlg").dialog("close");
	};

	//--------------------------
	
	$(document).ready(function() {
		
		// 提交
		$("#add_invoice_dlg_submit_btn").click(function() {
			self.save();
		});
		// 关闭
		$("#add_invoice_dlg_close_btn").click(function() {
			self.close();
		});
	});
	
};
	
	
</script>
