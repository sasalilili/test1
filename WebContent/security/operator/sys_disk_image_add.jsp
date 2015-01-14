<%@page import="com.zhicloud.op.vo.CloudHostVO"%>
<%@page import="com.zhicloud.op.vo.SysDiskImageVO"%>
<%@page import="java.util.List"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%

List<CloudHostVO> cloudHostList = (List<CloudHostVO>)request.getAttribute("cloudHostList");
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/popup.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/metro/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/icon.css" /> 

<div id="sysDiskImage_add_dlg_container">

	<div id="sysDiskImage_add_dlg" class="easyui-dialog" title="制作系统镜像"
		style="width:580px; height:440px; padding:10px;"
		data-options="
			iconCls: 'icon-add',
			buttons: '#sysDiskImage_add_dlg_buttons',
			modal: true,
			onMove: _sysDiskImage_add_dlg_scope_.onMove,
			onClose: function(){
				$(this).dialog('destroy');
			},
			onDestroy: function(){
				delete _sysDiskImage_add_dlg_scope_;
			}
		">
		
		<form id="sysDiskImage_add_dlg_form" method="post">
		
			<table border="0" style="margin:0 auto 0 auto;">
				<tr>
					<td class="inputtitle"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />镜像名称：</td>
					<td class="inputcont">
						<input  type="text" id="name" name="name" class="textbox inputtext" onblur="checkName()"/>
					 
					</td>
					<td class="inputtip" id="operator-tip-name"><i>请输入2-50个字符的镜像名称</i></td>
					
				</tr>
				<tr>
					<td class="inputtitle"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />显示名称：</td>
					<td class="inputcont">
						<input  type="text" id="display_name" name="display_name" class="textbox inputtext" onblur="checkDisplayName()"/>
					 
					</td>
					<td class="inputtip" id="operator-tip-display_name"><i>请输入2-50个字符的显示名称</i></td>
					
				</tr>
				<tr>
					<td class="inputtitle" style="width:100px"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />来自云主机：</td>
					<td class="inputcont">
						<select id="from_host_id" name="from_host_id" class="inputselect" onblur="checkImage()">
							<option value="">请选择</option>
							<%
								for( CloudHostVO cloudHost : cloudHostList )
								{
							%>
							<option value="<%=cloudHost.getId()%>"><%=cloudHost.getHostName()%></option>
							<%
								}
							%>
						</select> 
					<td class="inputtip" id="operator-tip-image"><i>请选择一个云主机</i></td>
					</td>
				</tr>
				<tr>
					<td class="inputtitle"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />序号：</td>
					<td class="inputcont">
						<input type="text" id="sort" name="sort"  onblur="checkSort();" class="textbox inputtext"/>
					</td>
					<td class="inputtip" id="operator-tip-sort"><i>请输入长度不超过11位的整数</i></td>
				</tr>
				<tr>
					<td class="inputtitle"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />标签：</td>
					<td class="inputcont">
						<label for="tag1_windows" style="padding:0 10px 0 0;">
							<input type="radio" id="tag1_windows" name="tag1" value="Windows" checked="checked" />Windows
						</label>
						<label for="tag1_linux" style="padding:0 10px 0 0;">
							<input type="radio" id="tag1_linux" name="tag1" value="Linux" />Linux
						</label>
						<label for="tag1_unix" style="padding:0 10px 0 0;">
							<input type="radio" id="tag1_unix" name="tag1" value="Unix" />Unix
						</label>
					</td>
					<td class="inputtip" id="operator-tip-tag1"></td>
				</tr>
				<tr>
					<td class="inputtitle"></td>
					<td class="inputcont">
						<label for="tag2_32bit" style="padding:0 10px 0 0;">
							<input type="radio" id="tag2_32bit" name="tag2" value="32bit" checked="checked" />32bit
						</label>
						<label for="tag2_64bit" style="padding:0 10px 0 0;">
							<input type="radio" id="tag2_64bit" name="tag2" value="64bit" />64bit
						</label>
					</td>
					<td class="inputtip" id="operator-tip-tag2"></td>
				</tr>
				<tr>
					<td class="inputtitle">描述：</td>
					<td class="inputcont">
						<textarea name="description" id="description" onblur="checkDescription();" rows="6" cols="30" style="resize:none;"></textarea>
                    </td>
					<td class="inputtip" id="operator-tip-description"><i>最多输入100个字符</i></td>
				</tr>
			</table>
		</form>
		
	</div>
	
	<div id="sysDiskImage_add_dlg_buttons">
		<a href="javascript:" class="easyui-linkbutton" id="sysDiskImage_add_dlg_save_btn">&nbsp;保&nbsp;存&nbsp;</a> 
		<a href="javascript:" class="easyui-linkbutton" id="sysDiskImage_add_dlg_close_btn">&nbsp;关&nbsp;闭&nbsp;</a>
	</div>
	
</div>

<script type="text/javascript">
//----------------------------
function checkName(){
	var myName = new String($("#name").val());
	if(myName==null || myName==""){
		$("#operator-tip-name").html("<b>镜像名称不能为空</b>");
		return false;
	}
	if(/^\w{2,50}$/.test(myName)){
		$("#operator-tip-name").html("<img src='<%=request.getContextPath()%>/images/button_validated_green_16_16.gif' width='16' height='16' alt='正确' />");
	
		return true;
	}else{
		$("#operator-tip-name").html("<b>镜像名称由字母、数字和下划线组成,长度为2-50字符</b>");
		return false;
		
	}
}
function checkDisplayName(){
	var name = new String($("#display_name").val());
	if(name==null || name==""){
		$("#operator-tip-display_name").html("<b>显示名称不能为空</b>");
		return false;
	}
	if(name.length>=2&&name.length<=50){
		$("#operator-tip-display_name").html("<img src='<%=request.getContextPath()%>/images/button_validated_green_16_16.gif' width='16' height='16' alt='正确' />");
	
		return true;
	}else{
		$("#operator-tip-display_name").html("<b>显示名称长度为2-50字符</b>");
		return false;
		
	}
}
function checkImage(){
	var myImage = new String($("#from_host_id").val());
	if(myImage==null || myImage==""){
		$("#operator-tip-image").html("<b>请选择一个云主机</b>");
		 
		return false;
	}
	$("#operator-tip-image").html("<img src='<%=request.getContextPath()%>/images/button_validated_green_16_16.gif' width='16' height='16' alt='正确' />");
	 
	return true;
}
function checkDescription(){
	var description = new String($("#description").val()); 
	if(description.length>100){
		$("#operator-tip-description").html("<b>最多输入100个字符</b>");
		 
		return false;
	}
	$("#operator-tip-description").html("<img src='<%=request.getContextPath()%>/images/button_validated_green_16_16.gif' width='16' height='16' alt='正确' />");

	return true;
}
function checkSort(){
	var sort = new String($("#sort").val()); 
	if(sort.length==0){
		$("#operator-tip-sort").html("<b>序号不能为空</b>");
		 
		return false;
		
	}
	if(/^[1-9]*[1-9][0-9]*$/.test(sort)){
		if(sort.length>11){
			$("#operator-tip-sort").html("<b>最大长度为11位</b>");
			 
			return false;
			
		}
		$("#operator-tip-sort").html("<img src='<%=request.getContextPath()%>/images/button_validated_green_16_16.gif' width='16' height='16' alt='正确' />");
	
		return true;
	}else{
		$("#operator-tip-sort").html("<b>请输入整数</b>");
		 
		return false;
		
	}
}


//----------------------------

var _sysDiskImage_add_dlg_scope_ = new function(){
	
	var self = this;
	self.onMove = function(){
		var thisId = "#sysDiskImage_add_dlg";
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
	// 保存
	self.save = function() {
		var formData = $.formToBean(sysDiskImage_add_dlg_form);
		ajax.remoteCall("bean://sysDiskImageService:addSysDiskImage", 
			[ formData ],
			function(reply) {
				if (reply.status == "exception")
				{
					top.$.messager.alert('警告',reply.exceptionMessage,'warning');
				}
				else if (reply.result.status == "success")
				{
					var data = $("#sysDiskImage_add_dlg_container").parent().prop("_data_");
					$("#sysDiskImage_add_dlg").dialog("close");
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
		$("#sysDiskImage_add_dlg").dialog("close");
	};

	//--------------------------

	$(document).ready(function(){
		// 保存
		$("#sysDiskImage_add_dlg_save_btn").click(function() {
			if(checkName() && checkDisplayName() && checkImage() && checkDescription() && checkSort()){
				self.save();
			}
		});
		// 关闭
		$("#sysDiskImage_add_dlg_close_btn").click(function() {
			self.close();
		});
	});
};
</script>



