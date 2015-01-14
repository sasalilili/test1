<%@page import="com.zhicloud.op.vo.SysRoleVO"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request);
	SysRoleVO sysRole = (SysRoleVO)request.getAttribute("sysRole");
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/popup.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/js/easyui/themes/metro/easyui.css" />
<div id="sys_role_mod_dlg_container">
	<div id="sys_role_mod_dlg" class="easyui-dialog" title="修改角色" 
			style="
				width:435px; 
				height:150px; 
				padding:10px;
			"
			data-options="
				iconCls: 'icon-edit',
				buttons: '#sys_role_mod_dlg_buttons',
				modal: true,
				onMove:_sys_role_mod_dlg_scope_.onMove,
				onClose: function(){
					$(this).dialog('destroy');
				},
				onDestroy: function(){
					delete _sys_role_mod_dlg_scope_;
				}
			">
		<form id="sys_role_mod_dlg_form" method="post">
			
			<input type="hidden" id="role_id" name="role_id" value="<%=sysRole.getId()%>" />
			<table border="0" cellpadding="0" cellspacing="0">
			    <tr>
			      <td class="inputtitle"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />角色名：</td>
			      <td class="inputcont"><input class="textbox inputtext" type="text" id="role_name" name="role_name" onblur="checkRoleName()" value="<%=sysRole.getRoleName()%>"/></td>
			      <td class="inputtip" id="admin-tip-rolename"><i>请输入新的角色名</i></td>
			    </tr>
			</table>
		</form>
	</div>
	
	<div id="sys_role_mod_dlg_buttons">
		<a href="javascript:" class="easyui-linkbutton" id="sys_role_mod_dlg_save_btn">
			&nbsp;保&nbsp;存&nbsp;
		</a>
		<a href="javascript:" class="easyui-linkbutton" id="sys_role_mod_dlg_close_btn">
			&nbsp;关&nbsp;闭&nbsp;
		</a>
	</div>
</div>

<script type="text/javascript">
function checkRoleName(){
	var RoleName = new String($("#role_name").val()).trim();
	if(RoleName == null || RoleName == ""){
		$("#admin-tip-rolename").html("<b>角色名不能为空</b>");
		return false;
	}
	if(RoleName.length<2 || RoleName.length>16){
		$("#admin-tip-rolename").html("<b>角色名长度为2-16个字符</b>");
		return false;
	}
	$("#admin-tip-rolename").html("<img src='<%=request.getContextPath()%>/images/button_validated_green_16_16.gif' width='16' height='16' alt='正确'/>");
	return true;
}

//=============================
var _sys_role_mod_dlg_scope_ = {};		// 作用域
_sys_role_mod_dlg_scope_.onMove = function(){
	var thisId = "#sys_role_mod_dlg";
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
_sys_role_mod_dlg_scope_.save = function()
{
	var formData = $.formToBean(sys_role_mod_dlg_form);
	ajax.remoteCall("bean://sysRoleService:updateSysRoleById",
		[formData],
		function(reply)
		{
			if( reply.status=="exception" )
			{
				top.$.messager.alert('警告',reply.exceptionMessage,'warning');
			} 
			else if( reply.result.status=="success" )
			{
				var data = $("#sys_role_mod_dlg_container").parent().prop("_data_");
				$("#sys_role_mod_dlg").dialog("close");
				data.onClose(reply.result);
			}
			else
			{
				$("#admin-tip-rolename").html("<b>"+reply.result.message+"</b>");
			}
		}
	);
};

// 关闭
_sys_role_mod_dlg_scope_.close = function()
{
	$("#sys_role_mod_dlg").dialog("close");
};

//--------------------------

// 保存
$("#sys_role_mod_dlg_save_btn").click(function(){
	if(checkRoleName()){
		_sys_role_mod_dlg_scope_.save();
	}
});

// 关闭
$("#sys_role_mod_dlg_close_btn").click(function(){
	_sys_role_mod_dlg_scope_.close();
});

</script>



