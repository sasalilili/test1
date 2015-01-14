<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.service.constant.AppConstant"%>
<%@page import="com.zhicloud.op.vo.CloudDiskVO"%>
<%@page import="com.zhicloud.op.common.util.CapacityUtil"%>
<%@page import="java.util.List"%>
<%@page import = "java.math.BigInteger "%>
<%@page import="com.zhicloud.op.exception.ErrorCode"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.zhicloud.op.common.util.StringUtil"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	Integer userType = Integer.valueOf(request.getParameter("userType"));
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request, AppConstant.SYS_USER_TYPE_TERMINAL_USER);
	List<CloudDiskVO> cloudDiskList = (List<CloudDiskVO>)request.getAttribute("cloudDiskList");
	String message = "";
	String newRegion = (String)request.getAttribute("region");
	if(cloudDiskList.isEmpty()){
		message = "没有相关记录";
	}else{
		message = "共找到"+cloudDiskList.size()+"条相关记录";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- cloud_disk_manage.jsp -->
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
		<title><%=AppConstant.PAGE_TITLE %></title>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/image/logo1.ico" type="image/x-icon" /> 
		
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/style/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/javascript/themes/bootstrap/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/javascript/themes/icon.css" />
<%--  <script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/jquery.ext.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/locale/easyui-lang-zh_CN.js"></script>
<%-- <script src="<%=request.getContextPath() %>/javascript/jquery.min.js"></script>  --%>
<script src="<%=request.getContextPath() %>/javascript/common.js"></script>
<script type="text/javascript">

window.name = "selfWin";

var a = '<%= request.getContextPath()%>';
var ajax = new RemoteCallUtil(a+"/bean/call.do?userType=4");
var userName = "<%=loginInfo.getAccount()%>";
ajax.async = false;

// 布局初始化
$("#uploaded_file_datagrid").height( $(document.body).height());

function getLoginInfo(name,message,userId){
	slideright();
	inituser(name,message);
	window.location.reload();
}

$(document).ready(function(){
	init(10,3);
	if(userName!= ''){ 
	   inituser(userName,0);
	}else{
		
	   inituser();
	}   
	initstep(1);
	//--------------
	var new_region = "<%=newRegion%>";
	if(new_region == "1"){
		$("#all_cloud_disk").removeClass("active");
		$("#guangzhou_cloud_disk").addClass("active");
	}else if(new_region == "4"){
		$("#all_cloud_disk").removeClass("active");
		$("#hongkang_cloud_disk").addClass("active");
	}else{
		
	}
	//鼠标移上获取ID
	var cloudDiskId = "";
	$("#one_cloud_disk .box").hover(function(evt){
		cloudDiskId = $(this).attr("cloudDiskId");
	});
	// 查询
	$("a[name='cloud_disk']").click(function(){
		var region = $(this).attr("region");
		window.location.href="<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=cloudDiskService&method=managePage&region="+encodeURIComponent(region);
		return;
	});	
	//创建云硬盘
	$("#create_cloud_disk").click(function(){
		window.location.href="<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=cloudDiskService&method=addPage";
	});
	//修改配置
	$("#one_cloud_disk .modify-allocation").click(function(){
		window.location.href="<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=cloudDiskService&method=modPage&diskId="+encodeURIComponent(cloudDiskId);
	});
	//监控资源
	$("#one_cloud_disk .my-cloud-disk-detail").click(function(){
		window.location.href="<%=request.getContextPath()%>/bean/page.do?userType=<%=userType%>&bean=cloudDiskService&method=cloudDiskDetailPage&cloudDiskId="+encodeURIComponent(cloudDiskId);
	});
	//申请停用云硬盘
	$("#one_cloud_disk .out-of-service").click(function(){
		if(cloudDiskId="undefined" || cloudDiskId=="" )
		{
			return;
		}
		top.$.messager.confirm("确认", "确定要停用该云硬盘吗？", function (r) { 
			if(r){
				ajax.remoteCall("bean://cloudDiskService:inactivateCloudDisk",
					[ cloudDiskId ], 
					function(reply) {
						if (reply.status=="exception")
						{
							if( reply.errorCode=="<%=ErrorCode.ERROR_CODE_FAIL_TO_CALL_BEFORE_LOGIN%>" )
							{
								top.$.messager.alert("警告", "会话超时，请重新登录", "warning", function(){
									window.location.reload();
								});
							}
							else 
							{
								top.$.messager.alert("警告", reply.exceptionMessage, "warning");
							}
						}
						else
						{
							top.$.messager.alert("信息", reply.result.message, "info",function(){
								window.location.reload();
							});
						}
					}
				);
			}
		});
	});
	//申请恢复云硬盘
	$("#one_cloud_disk .reactivate").click(function(){
		if(cloudDiskId="undefined" || cloudDiskId=="" )
		{
			return;
		}
		top.$.messager.confirm("确认", "确定要恢复该云硬盘吗？", function (r) { 
			if(r){
				ajax.remoteCall("bean://cloudDiskService:reactivateCloudDisk",
					[ cloudDiskId ], 
					function(reply) {
						if (reply.status=="exception")
						{
							if( reply.errorCode=="<%=ErrorCode.ERROR_CODE_FAIL_TO_CALL_BEFORE_LOGIN%>" )
							{
								top.$.messager.alert("警告", "会话超时，请重新登录", "warning", function(){
									window.location.reload();
								});
							}
							else 
							{
								top.$.messager.alert("警告", reply.exceptionMessage, "warning");
							}
						}
						else
						{
							top.$.messager.alert("信息", reply.result.message, "info",function(){
								window.location.reload();
							});
						}
					}
				);
			}
		});
	});
	//删除云硬盘
	$("#one_cloud_disk .delete-cloud-disk").click(function(){
		if(cloudDiskId="undefined" || cloudDiskId.trim()=="" )
		{
			return;
		}
		top.$.messager.confirm("确认", "确定删除?", function (r) {  
	        if (r) {  
				ajax.remoteCall("bean://cloudDiskService:deleteCloudDiskById",
					[ cloudDiskId ], 
					function(reply) {
						if (reply.status=="exception")
						{
							if( reply.errorCode=="<%=ErrorCode.ERROR_CODE_FAIL_TO_CALL_BEFORE_LOGIN%>" )
    						{
    							top.$.messager.alert("警告", "会话超时，请重新登录", "warning", function(){
    								window.location.reload();
    							});
    						}
    						else 
    						{
    							top.$.messager.alert("警告", reply.exceptionMessage, "warning",function(){});
    						}
						}
						else
						{
							top.$.messager.alert("提示", reply.result.message, "info",function(){
								window.location.reload();
							});
						}
					}
				);
	        }  
	    }); 
	});
	
});
function operateColumnFormatter(value, row, index)
{
	return "<div row_index='"+index+"'>\
				<a href='#' class='datagrid_row_linkbutton modify_btn'>修改</a>\
				<a href='#' class='datagrid_row_linkbutton del_btn'>删除</a>\
			</div>";
}
 
function dataFormatter(val)	{   
	return CapacityUtil.toCapacityLabel(val,0);
}  

function statusFormatter(val)	{   
	if(val == 1){
		return "关机";
	}else if(val == 2){
		return "使用中";
	}else if(val == 3){
		return "警告";
	}else if(val == 4){
		return "故障";
	}
}  

function onLoadSuccess()
{
	$("body").css({
		"visibility":"visible"
	});
}
</script>	
</head>
<body>
<div class="page">
  <div class="pageleft">
    <div class="header"></div>
    <div class="main">
      <div class="titlebar">
        <div class="tabbar l"><a id="all_cloud_disk" name="cloud_disk" region="0"  href="#" class="active">全部</a>　｜　<a id="guangzhou_cloud_disk" region="1" name="cloud_disk"  href="#">广州</a>　｜　<a id="hongkang_cloud_disk" region="4" name="cloud_disk" href="#">香港</a></div>
        <a id="create_cloud_disk" href="#" style="cursor:pointer;" class="greenbutton r">创建云硬盘</a></div>
       <div id="one_cloud_disk" style="width:720px;padding: 10px 0 0 0; margin:0 auto;">
			<table id="cloud_disk_datagrid" class="easyui-datagrid" data-options="border:false,showHeader:false,singleSelect:true,scrollbarSize:0,fitColumns:true">
			<thead>
            <tr>
              <th data-options="field:'data',width:720"><%=message %></th>
            </tr>
          	</thead>
			<tbody>
		 <%
		 	if(cloudDiskList.isEmpty()){
		 %>
		 	<center>没有相关记录</center>
		 <%
		 	}
          	for(CloudDiskVO cloudDiskVO : cloudDiskList){
          %>
         <tr>
              <td><div class="box" cloudDiskId="<%=cloudDiskVO.getId()%>">
                  <div class="listleft l" style="width:492px">
                    <div class="div1 l">
                      <div class="listicon"> <a href="javascript:void(0);" class="btn storage">&nbsp;</a>
                        <div class="text">
                          <input id="t1<%=cloudDiskVO.getId()%>" name="" type="text" value="<%=cloudDiskVO.getName()%>"/>
                          <label for="t1<%=cloudDiskVO.getId()%>" class="smalllabel l"   style="cursor:pinter; background:url(<%=request.getContextPath()%>/image/icon_edit.png) no-repeat center right" title="<%=cloudDiskVO.getName()%>"></label>
                        </div>
                      </div>
                    </div>
                    <div class="div2 l" style="width:389px;">
                      <div class="listicon l" style="width:120px">
                        <div class="btn btn101">&nbsp;</div>
                        <div class="text"><%=CapacityUtil.toGBValue(cloudDiskVO.getDisk(),0)%></div>
                      </div>
                      <div class="listicon l" style="width:149px">
                        <div class="btn btn102">&nbsp;</div>
                        <div class="text">IP:<%=cloudDiskVO.getInnerIp()==null?"无":cloudDiskVO.getInnerIp()%></div>
                      </div>
                      <div class="listicon l" style="width:120px">
                        <div class="btn btn103">&nbsp;</div>
                        <div class="text">端口:<%=cloudDiskVO.getInnerPort()==null?"无":cloudDiskVO.getInnerPort()%></div>
                      </div>
                    </div>
                    <%if("关机".equals(cloudDiskVO.getSummarizedStatusText())){ %>
                    <div class="div3 l"><strong class="gray">已关机</strong></div>
                    <%}else if("运行".equals(cloudDiskVO.getSummarizedStatusText())){ %>
                    <div class="div3 l">运行中</div>
                    <%}else if("创建中".equals(cloudDiskVO.getSummarizedStatusText())){ %>
                    <div class="div3 l"><strong class="gray">创建中</strong></div>
                    <%}else if("创建失败".equals(cloudDiskVO.getSummarizedStatusText())){ %>
                    <div class="div3 l"><strong class="gray">创建失败</strong></div>
                    <%}else if("告警".equals(cloudDiskVO.getSummarizedStatusText())){ %>
                    <div class="div3 l"><strong class="orange">告警</strong></div>
                    <%}else if("故障".equals(cloudDiskVO.getSummarizedStatusText())){ %>
                    <div class="div3 l"><strong class="red">故障</strong></div>
                    <%} %>
                    <div class="div4 l" style="width:341px;">iqn:2010-06.iscsiraid:raid-2718000358:default-target
                    </div>
                  </div>
                  <%if("创建失败".equals(cloudDiskVO.getSummarizedStatusText())){ %>
                  	<div class="listright l" style="width:208px; padding:23px 0 0 0" name="a<%=cloudDiskVO.getId()%>">
		                <input name="" type="button" class="btn btn5 l delete-cloud-disk" title="删除"/>
	                    <input name="" type="button" class="btn btn7  l modify-allocation" title="修改配置"/>
	                    <input name="" type="button" class="btn btn12 l my-cloud-disk-detail" title="资源监控"/>
                    </div>
                  <%} else if("停机".equals(cloudDiskVO.getSummarizedStatusText())){%>
                  	<div class="listright l">
		                <div class="listinfo">您的云硬盘已停用，我们将为您保存数据至 
		                    <%
		                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		                    Date date = StringUtil.stringToDate(cloudDiskVO.getInactiveTime(),"yyyyMMddHHmmssSSS");
		                    Calendar calendar = Calendar.getInstance();
		                    calendar.setTime(date);
		                    calendar.add(Calendar.DAY_OF_MONTH,7);
		                    %>
		                    <%=sdf.format(calendar.getTime())%>
		                   	 ，<br />到期数据将会删除。</div>
		                    <a href="#" class="graybutton r reactivate">恢复服务<div class="btn11 l">&nbsp;</div></a>
	           			</div>
                  <%}else{ %>
                  	<div class="listright l" style="width:208px; padding:23px 0 0 0" name="a<%=cloudDiskVO.getId()%>">
		                <input name="" type="button" class="btn btn5 l out-of-service" title="停用"/>
	                    <input name="" type="button" class="btn btn7  l modify-allocation" title="修改配置"/>
	                    <input name="" type="button" class="btn btn12 l my-cloud-disk-detail" title="资源监控"/>
                    </div>	
                <%} %>
                </div></td>
            </tr>
            <%
          	}
            %>
            </tbody>
            </table>
            </div>
            </div>
            <div class="clear"></div>
		    <div class="footer"></div>
		  </div>
		  <div class="pageright">
		    <iframe id="loginiframe" src="<%=request.getContextPath() %>/public/user/login.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
		    <iframe id="regiframe" src="<%=request.getContextPath() %>/public/user/register.jsp" frameborder="0" hspace="0" vspace="0" scrolling="no"></iframe>
		  </div>
            </div>
</body>
</html>