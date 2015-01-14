﻿<%@page import="com.zhicloud.op.vo.SysDiskImageVO"%>
<%@page import="com.zhicloud.op.common.util.FlowUtil"%>
<%@page import="com.zhicloud.op.vo.DiskPackageOptionVO"%>
<%@page import="com.zhicloud.op.vo.SysDiskImageVO"%>
<%@page import="com.zhicloud.op.vo.CloudHostWarehouseDefinitionVO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.zhicloud.op.common.util.CapacityUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
LoginInfo loginInfo = LoginHelper.getLoginInfo(request);
DiskPackageOptionVO diskOption = (DiskPackageOptionVO)request.getAttribute("diskOption");
//SysDiskImageVO sysDiskImage = (SysDiskImageVO)request.getAttribute("sysDiskImage");
List<SysDiskImageVO> sysDiskImageOptions = (List<SysDiskImageVO>)request.getAttribute("sysDiskImageOptions");
CloudHostWarehouseDefinitionVO warehouseVO = (CloudHostWarehouseDefinitionVO)request.getAttribute("warehouse");
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/popup.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/metro/easyui.css" />

<div id="warehouse_mod_dlg_container">

	<div id="warehouse_mod_dlg" class="easyui-dialog" title="修改库存类型"
		style="width:650px; height:400px; padding:10px;"
		data-options="
			iconCls: 'icon-add',
			buttons: '#warehouse_mod_dlg_buttons',
			modal: true,
			onMove: _warehouse_mod_dlg_scope_.onMove,
			onClose: function(){
				$(this).dialog('destroy');
			},
			onDestroy: function(){
				delete _warehouse_mod_dlg_scope_;
			}
		">
		<form id="warehouse_mod_dlg_form" method="post">
			
			<input type="hidden" id="warehouse_id" name="warehouse_id" value="<%=warehouseVO.getId()%>" />
			<input type="hidden" id="old_total_amount" name="old_total_amount" value="<%=warehouseVO.getTotalAmount()%>">
			<table border="0" style="height: auto; margin: auto;">
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;">系统磁盘：</td>
					<td style="padding:5px 0 5px 0;">
						<label for="create_from_img" style="padding:0 20px 0 0;">
							<input type="radio" id="create_from_img" name="sys_disk_type" value="from_sys_image" checked="checked" />从镜像创建
						</label>
						<select id="sys_image_id" name="sys_image_id" style="width:225px" class="easyui-radio">
							<option value="">请选择</option>
							<%
								for( SysDiskImageVO sysDiskImageOption : sysDiskImageOptions )
								{
							%>
									<option value="<%=sysDiskImageOption.getId()%>"><%=sysDiskImageOption.getName()%></option>
							<%
								}
							%>
						</select>
					</td>
				</tr>
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;">描述：</td>
					<td style="padding:5px 0 5px 0;">
						<textarea name="description" id="description" rows="6" cols="44" style="resize:none;" ><%=warehouseVO.getDescription() %></textarea>
                    </td>
					<td id="operator-tip-description"><i></i></td>
				</tr>
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;">库存总量：</td>
					<td style="padding:5px 0 5px 0;">
						<input type="text" id="total_amount" style="position:relative; top:2px;"
							name="total_amount" value="<%=warehouseVO.getTotalAmount()%>" />
						个
					</td>
				</tr>
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;">马上创建：</td>
					<td>
						<label for="is_create">
							<input type="checkbox" id="is_create" name="is_create" value="true" style="position:relative; top:2px;" />
							是
						</label>
					</td>
				</tr>
				
				<tr>
					<td></td>
					<td>
						<div id="port_box" style="width:450px;">
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div id="warehouse_mod_dlg_buttons">
		<a href="javascript:" class="easyui-linkbutton" id="warehouse_mod_dlg_save_btn"> &nbsp;保&nbsp;存&nbsp; </a> 
		<a href="javascript:" class="easyui-linkbutton" id="warehouse_mod_dlg_close_btn"> &nbsp;取&nbsp;消&nbsp; </a>
	</div>
</div>


<script type="text/javascript">
 
var _warehouse_mod_dlg_scope_ = new function(){
	
	var self = this;
	self.onMove = function(){
		var thisId = "#warehouse_mod_dlg";
		var topValue = $(thisId).offset().top;
		var leftValue = $(thisId).offset().left;
		if(topValue==0){
			topValue = 30;
		}
		if(topValue<30){
			$(thisId).dialog('move',{
				left:leftValue,
				top:1
			});
			return;
		}
	};
	
	// 保存
	self.save = function() {
		var formData = $.formToBean(warehouse_mod_dlg_form);
		ajax.remoteCall("bean://cloudHostWarehouseService:modWarehouse", 
			[ formData ],
			function(reply) {
				if (reply.status == "exception")
				{
					top.$.messager.alert('警告',reply.exceptionMessage,'warning');
				}
				else if (reply.result.status == "success")
				{
					var data = $("#warehouse_mod_dlg_container").parent().prop("_data_");
					$("#warehouse_mod_dlg").dialog("close");
					data.onClose(reply.result);
				}
				else
				{
					top.$.messager.alert('警告',reply.result.message,'warning');
				}
			}
		);
	};

	// 关闭
	self.close = function() {
		$("#warehouse_mod_dlg").dialog("close");
	};

	//--------------------------
	
	$(document).ready(function() {
		// 选择“从镜像创建”或“空白系统”
		$(":radio[name=sys_disk_type]").change(function(){
			if( this.id=="create_from_img" ) {
				$("#sys_image_id").attr("disabled", false);
			} else {
				$("#sys_image_id").attr("disabled", true).val("");
			}
		});
		// 保存
		$("#warehouse_mod_dlg_save_btn").click(function() {
			self.save();
		});
		// 关闭
		$("#warehouse_mod_dlg_close_btn").click(function() {
			self.close();
		});
		// 初始化
		$("#warehouse_mod_dlg_form #sys_image_id").val("<%=warehouseVO.getSysImageId()%>");
	});
	
};
</script>
