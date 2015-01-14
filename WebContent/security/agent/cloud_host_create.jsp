<%@page import="com.zhicloud.op.app.helper.RegionHelper.RegionData"%>
<%@page import="com.zhicloud.op.app.helper.RegionHelper"%>
<%@page import="com.zhicloud.op.vo.SysDiskImageVO"%>
<%@page import="com.zhicloud.op.common.util.FlowUtil"%>
<%@page import="com.zhicloud.op.vo.BandwidthPackageOptionVO"%>
<%@page import="com.zhicloud.op.vo.DiskPackageOptionVO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.zhicloud.op.common.util.CapacityUtil"%>
<%@page import="com.zhicloud.op.vo.MemoryPackageOptionVO"%>
<%@page import="com.zhicloud.op.vo.CpuPackageOptionVO"%>
<%@page import="java.util.List"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.vo.AgentVO" %>
<%@page import="com.zhicloud.op.vo.PackagePriceVO"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
LoginInfo loginInfo = LoginHelper.getLoginInfo(request);
List<CpuPackageOptionVO> cpuOptions = (List<CpuPackageOptionVO>)request.getAttribute("cpuOptions");
List<MemoryPackageOptionVO> memoryOptions = (List<MemoryPackageOptionVO>)request.getAttribute("memoryOptions");
List<SysDiskImageVO> sysDiskImageOptions = (List<SysDiskImageVO>)request.getAttribute("sysDiskImageOptions");
DiskPackageOptionVO diskOption = (DiskPackageOptionVO)request.getAttribute("diskOption");
String userId = (String)request.getAttribute("userId");
String hostName = (String)request.getAttribute("hostName");
AgentVO agent = (AgentVO)request.getAttribute("agent");
 
List<PackagePriceVO> cpuRegion1  = (List<PackagePriceVO>)request.getAttribute("cpuRegion1");
List<PackagePriceVO> cpuRegion4  = (List<PackagePriceVO>)request.getAttribute("cpuRegion4");
List<PackagePriceVO> memoryRegion1  = (List<PackagePriceVO>)request.getAttribute("memoryRegion1");
List<PackagePriceVO> memoryRegion4  = (List<PackagePriceVO>)request.getAttribute("memoryRegion4");
List<PackagePriceVO> diskRegion1  = (List<PackagePriceVO>)request.getAttribute("diskRegion1");
List<PackagePriceVO> diskRegion4  = (List<PackagePriceVO>)request.getAttribute("diskRegion4");
List<PackagePriceVO> bandwidthRegion1  = (List<PackagePriceVO>)request.getAttribute("bandwidthRegion1");
List<PackagePriceVO> bandwidthRegion4  = (List<PackagePriceVO>)request.getAttribute("bandwidthRegion4");
List<PackagePriceVO> package1  = (List<PackagePriceVO>)request.getAttribute("package1");
List<PackagePriceVO> package4  = (List<PackagePriceVO>)request.getAttribute("package4");
%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/popup.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/metro/easyui.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/javascript/user/refreshprice.js"></script>

<div id="cloud_host_add_dlg_container">

	<div id="cloud_host_add_dlg" class="easyui-dialog" title="创建云主机"
		style="width:700px; height:560px; padding:10px;"
		data-options="
			iconCls: 'icon-add',
			buttons: '#cloud_host_add_dlg_buttons',
			modal: true,
			onMove: onMove,
			onClose: function(){
				$(this).dialog('destroy');
			},
			onDestroy: function(){
				delete _cloud_host_add_dlg_scope_;
			}
		">
		<form id="cloud_host_add_dlg_form" method="post">
			
			<input type="hidden" id="userId" name="userId" value="<%=userId%>" />
		
			<table border="0" style="height: auto; margin: auto;">
			
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />主机名：</td>
					<td class="inputcont"><input type="text" id="host_name"   name="displayName" value="<%=hostName %>" style="width:300px;" onblur="checkLength()"/></td>
					<td class="inputtip" id="tip-host-name"><i>请输入云主机名称</i></td>
				</tr>
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />地域：</td>
					<td style="padding:5px 0 5px 0;">
						<select id="region" name="region" >
							<%
								for( RegionData regionData : RegionHelper.singleton.getAllResions() )
								{
							%>
							<option value="<%=regionData.getId()%>"><%=regionData.getName()%></option>
							<%
								}
							%>
						</select>
					</td>
					<td class="inputtip" id="tip-region"><i>请选择地域</i></td>
				</tr>
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />推荐配置：</td>
					<td style="padding:5px 0 5px 0;"> 
					    <div id="package1">
				            <%
				              int i = 1;
				              for(PackagePriceVO vo : package1){
				            	  if(vo.getPrice().compareTo(BigDecimal.ZERO)==0){
				            		  continue;
				            	  }
				          	  %>
				          	    <label for="item1_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="item1_<%=i %>"  name="item"  onclick="notForDIY(this);"   value="<%=vo.getId() %>" price="<%=vo.getPrice()%>"/>
									<%=vo.getDescription() %>
								</label>  <br/>
				          	  <%
				          	    i++;
				              }
				            %>            
			            </div>
			            <div id="package4" style="display:none;">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : package4){
				            	  if(vo.getPrice().compareTo(BigDecimal.ZERO)==0){
				            		  continue;
				            	  }
				          	  %>
				              <label for="item4_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="item4_<%=i %>"  name="item"   onclick="notForDIY(this);" value="<%=vo.getId() %>" price="<%=vo.getPrice()%>" />
									<%=vo.getDescription() %>
								</label> <br/>
				          	  <%
				          	    i++;
				              }
				            %>             
			            </div>
						 
			          	    <label for="item" style="padding:0 10px 0 0;">
								<input type="radio" id="item"  name="item"   onclick="forDIY()" value="" />
								自定义
							</label>  
					</td>
					<td class="inputtip" id="tip-cpu_core"><i> </i></td>
				</tr> 
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />CPU：</td>
					<td style="padding:5px 0 5px 0;"> 
					    <div id="cpuPackage1">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : cpuRegion1){ 
				          	  %>
				          	  <label for="cpuRegion1_<%=i %>" style="padding:0 10px 0 0;">
								<input type="radio" id="cpuRegion1_<%=i %>"  name="cpu"   onclick="checkCPUCore(),updatePrice()" value="<%=vo.getCpuCore() %>" />
								<%=vo.getCpuCore() %>核
							 </label>  
				          	  
				          	  <%
				          	    i++;
				              }
				            %>            
			            </div>
			            <div id="cpuPackage4" style="display:none;">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : cpuRegion4){
				          	  %>
				              <label for="cpuRegion4_<%=i %>" style="padding:0 10px 0 0;">
								<input type="radio" id="cpuRegion4_<%=i %>"  name="cpu"   onclick="checkCPUCore(),updatePrice()" value="<%=vo.getCpuCore() %>" />
								<%=vo.getCpuCore() %>核
							 </label> 
				          	  <%
				          	    i++;
				              }
				            %>             
			            </div>
						 
					</td>
					<td class="inputtip" id="tip-cpu_core"><i> </i></td>
				</tr>
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />内存：</td>
					<td style="padding:5px 0 5px 0;">
					    <div id="memoryPackage1">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : memoryRegion1){ 
				          	  %>
				              <label for="memoryRegion1_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="memoryRegion1_<%=i %>" name="memory"   onclick="checkMemory(),updatePrice()"  value="<%=CapacityUtil.toGBValue(vo.getMemory(), 0) %>" />
		 						<%=CapacityUtil.toGBValue(vo.getMemory(), 0) %>G
		 					  </label>
				          	  <%
				          	    i++;
				              }
				            %>            
			            </div>
			            <div id="memoryPackage4" style="display:none;">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : memoryRegion4){
				          	  %>
				               
				          	  <label for="memoryRegion4_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="memoryRegion4_<%=i %>" name="memory"   onclick="checkMemory(),updatePrice()"  value="<%=CapacityUtil.toGBValue(vo.getMemory(), 0) %>" />
		 						<%=CapacityUtil.toGBValue(vo.getMemory(), 0) %>G
		 					  </label>
				          	  <%
				          	    i++;
				              }
				            %>             
			            </div> 
						 
						 
						 
					</td>
					<td class="inputtip" id="tip-host-memory"><i> </i></td>
				</tr>
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />数据磁盘：</td>
					<td style="padding:5px 0 5px 0;">
					    <div id="diskPackage1">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : diskRegion1){ 
				          	  %>
				              <label for="diskRegion1_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="diskRegion1_<%=i %>" name="dataDisk"   onclick="addDisabled('dataDiskDIY'),updatePrice()" value="<%=CapacityUtil.toGBValue(vo.getDataDisk(), 0) %>" />
		 						<%=CapacityUtil.toGBValue(vo.getDataDisk(), 0) %>G
		 					  </label>
				          	  <%
				          	    i++;
				              }
				            %>            
			            </div>
			            <div id="diskPackage4" style="display:none;">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : diskRegion4){
				          	  %>
				               
				          	  <label for="diskRegion4_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="diskRegion4_<%=i %>" name="dataDisk"   onclick="addDisabled('dataDiskDIY'),updatePrice()"  value="<%=CapacityUtil.toGBValue(vo.getDataDisk(), 0) %>" />
		 						<%=CapacityUtil.toGBValue(vo.getDataDisk(), 0) %>G
		 					  </label>
				          	  <%
				          	    i++;
				              }
				            %>             
			            </div> 
						 <label for="dataDisk" style="padding:0 10px 0 0;">
									<input type="radio" id="dataDisk" name="dataDisk"    onclick="getFocus('dataDiskDIY');"  value="" />
		 						自定义
		 				<input  onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" maxlength="5" id="dataDiskDIY" name="dataDiskDIY" onblur="diyOnblur('diskRegion','dataDiskDIY'),updatePrice()" type="text" style="width:50px;" />G
		 				</label>
		 				
						 
						 
					</td>
					<td class="inputtip" id="tip-host-memory"><i> </i></td>
				</tr>
				
				
				
				 
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />带宽：</td>
					<td style="padding:5px 0 5px 0;">
					     <div id="bandwidthPackage1">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : bandwidthRegion1){ 
				          	  %>
				              <label for="bandwidthRegion1_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="bandwidthRegion1_<%=i %>" name="bandwidth"   onclick="addDisabled('bandwidthDIY'),updatePrice()" value="<%=FlowUtil.toMbpsValue(vo.getBandwidth(), 0)%>" />
		 						<%=FlowUtil.toMbpsValue(vo.getBandwidth(), 0)%>M
		 					  </label>
				          	  <%
				          	    i++;
				              }
				            %>            
			            </div>
			            <div id="bandwidthPackage4" style="display:none;">
				            <%
				              i = 1;
				              for(PackagePriceVO vo : bandwidthRegion4){
				          	  %>
				               
				          	  <label for="bandwidthRegion4_<%=i %>" style="padding:0 10px 0 0;">
									<input type="radio" id="bandwidthRegion4_<%=i %>" name="bandwidth"    onclick="addDisabled('bandwidthDIY'),updatePrice()"  value="<%=FlowUtil.toMbpsValue(vo.getBandwidth(), 0)%>" />
		 						<%=FlowUtil.toMbpsValue(vo.getBandwidth(), 0)%>M
		 					  </label>
				          	  <%
				          	    i++;
				              }
				            %>             
			            </div> 
				          	  <label for="bandwidth" style="padding:0 10px 0 0;">
									<input type="radio" id="bandwidth" name="bandwidth"   onclick="getFocus('bandwidthDIY');"  value="" />
		 						自定义
		 					  <input onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}" maxlength="5" id="bandwidthDIY" name="bandwidthDIY" onblur="diyOnblur('bandwidthRegion','bandwidthDIY');"  type="text"  value="" style="width:50px;" />M
		 					  </label>
						 
 					</td>
					<td class="inputtip" id="tip-bandwidth"><i></i></td>
				</tr> 
				
				
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"><img src="<%=request.getContextPath() %>/images/button_required_red_16_16.gif" width="12" height="12" alt="必填" />系统磁盘：</td>
 					<td style="padding:5px 0 5px 0;">
						 
						<select id="sys_image_id" name="sysImageId" onblur="checkSys()" style="width:270px" class="easyui-radio">
							<option value="">请选择</option>
						</select>
					</td>
					<td class="inputtip" id="tip-host-sys"><i>请选择系统磁盘</i></td>
				</tr>
				
				<tr style="display:none">
					<td></td> 
								<td style="padding:10px 20px 15px 30px ">
									<input id="sys_disk_slider" class="easyui-slider" style="width:300px" name="sys_disk"
										data-options="
											showTip:true, 
											min: <%=diskOption.getMin()%>,
											max: <%=diskOption.getMax()%>,
											rule: ['<%=CapacityUtil.toGB(diskOption.getMin(), 0)%>', '<%=CapacityUtil.toGB(diskOption.getMax(), 0)%>'],
											tipFormatter:function(value){
								                return CapacityUtil.toGB(value, 0);
								            },
										" />
								</td>  
				</tr>
				<tr>
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;"> 每月费用：</td>
					<td style="padding:5px 0 5px 0;">
					   
						 
						 <input id="price" name="price"  readonly="readonly" maxlength="3"  style="width:50px"/>元(折扣之后)
					</td>
					<td class="inputtip" id="tip-bandwidth"> </td>
				</tr>
				
				<tr style="display:none">
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;">其他：</td>
					<td style="padding:5px 0 5px 0;">
						<label for="is_auto_startup">
							<input type="checkbox" id="is_auto_startup" name="is_auto_startup" value="yes" style="position:relative; top:2px;" />
							自动启动
						</label>
					</td>
				</tr>
				<tr style="display:none">
					<td style="vertical-align:middle; white-space: nowrap; text-align:right;">开放端口：</td>
					<td>
						<div>
							<select id="protocol">
								<option value="0">所有协议</option>
								<option value="1">TCP</option>
								<option value="2">UDP</option>
							</select>
							
							<input id="port" name="port" maxlength="5" style="width:50px"/>
								 
							<a href="#" class="easyui-linkbutton" id="add_port">添加</a> 
						</div>
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

	<div id="cloud_host_add_dlg_buttons">
		<a href="javascript:" class="easyui-linkbutton" id="cloud_host_add_dlg_save_btn"> &nbsp;创&nbsp;建&nbsp; </a> 
		<a href="javascript:" class="easyui-linkbutton" id="cloud_host_add_dlg_close_btn"> &nbsp;取&nbsp;消&nbsp; </a>
	</div>
	
	<div style="display:none;">
		<select id="sys_image_id_template" name="sys_image_id_template">
			<%
				for( SysDiskImageVO sysDiskImageOption : sysDiskImageOptions )
				{
			%>
			<option value="<%=sysDiskImageOption.getId()%>" region="<%=sysDiskImageOption.getRegion()%>"><%=sysDiskImageOption.getName()%></option>
			<%
				}
			%>
		</select>
	</div>
</div>


<script type="text/javascript">
 
	function checkLength(){
		var hostName = $("#host_name").val().trim();
		if(hostName==null || hostName==""){
			$("#tip-host-name").html("<b>主机名不能为空</b>");
			return false;
		}
		if(hostName.length>30){
			$("#tip-host-name").html("<b>主机名长度不能超过30个字符</b>");
			return false;
		}
		$("#tip-host-name").html("");
//		updatePrice();
		return true;
	};
	
	function checkMemory(){ 
	};
     function checkSys(){
		var type = $("input[name='sys_disk_type']:checked").val(); 
		if(type=="from_empty"){
			$("#tip-host-sys").html("");
			updatePrice();
			return true;
		}else{
			var id = $("#sys_image_id").val();
			if(id==null || id==""){
			    $("#tip-host-sys").html("<b>请选择系统磁盘</b>");
				return false;
			}
			$("#tip-host-sys").html("");
//			updatePrice();
			return true;
			
		}
	};
     function checkBandWidth(){
		
		var bandwidth = $("#bandwidth").val(); 
		
		if(bandwidth==null || bandwidth==""){
		    $("#tip-bandwidth").html("<b>带宽不能为空</b>");		
		    return false;
		}
		if(!(/^[1-9]\d*|0$/.test(bandwidth))){ 
		    $("#tip-bandwidth").html("<b>请输入整数</b>");		 
			return false;
		}
		var  myselect=document.getElementById("region");         
	    var index=myselect.selectedIndex ; 
      
	    var region_val = myselect.options[index].value;
	    if(region_val=='1'){ 
	    	if(bandwidth>100){
	    		
			    $("#tip-bandwidth").html("<b>广州最大100M带宽</b>");	
			    return false;
	    	}
		    $("#tip-bandwidth").html("");	
		    updatePrice();
	    	return true;
	    }
	    if(region_val=='4'){ 
	    	if(bandwidth>10){
	    		
			    $("#tip-bandwidth").html("<b>香港最大10M带宽</b>");	
			    return false;
	    	}
		    $("#tip-bandwidth").html("");	
		    updatePrice();
	    	return true;
	    } 
	};
	 
	
	
   function updatePrice(){
		var  myselect=document.getElementById("region");         
	    var index=myselect.selectedIndex ; 
	    var region = myselect.options[index].value; 
	    var chkObjs = document.getElementsByName("cpu");
		var cpu = "";
		for(var i=0;i<chkObjs.length;i++){
			if(chkObjs[i].checked){
				cpu = chkObjs[i].value;
				break;
			}
		}
		chkObjs = document.getElementsByName("memory");
		var memory = "";
		for(var i=0;i<chkObjs.length;i++){
			if(chkObjs[i].checked){
				memory = chkObjs[i].value;
				break;
			}
		}
		var diy = "true";
		chkObjs = document.getElementsByName("dataDisk");
		for(var i=0;i<chkObjs.length;i++){
			if(chkObjs[i].checked){
				dataDisk = chkObjs[i].value;
				if(dataDisk==""){
					break;
				}
				diy = "false";
				break;
			}
		} 
		if(diy=="true"){
			dataDisk = $("#dataDiskDIY").val();
		}
		diy = "true";
		chkObjs = document.getElementsByName("bandwidth");
		for(var i=0;i<chkObjs.length;i++){
			if(chkObjs[i].checked){
				bandwidth = chkObjs[i].value; 
				if(bandwidth==""||bandwidth.length==0){
					break;
				}
				diy = "false";
				break;
			}
		}
		if(diy=="true"){
			bandwidth = $("#bandwidthDIY").val(); 
		} 
  		var newPrice = refreshPrice(region,cpu,memory,dataDisk,bandwidth);
  		var percent_off = 100-'<%=agent.getPercentOff()%>';
		$("#price").val((newPrice*percent_off*0.01).toFixed(2));
		return;
	};
	
	function onMove (){
		var thisId = "#cloud_host_add_dlg";
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
    function save() {
		var formData = $.formToBean(cloud_host_add_dlg_form); 
		formData.dataDisk = CapacityUtil.toCapacityLabel(formData.dataDisk, 0);
		//formData.ports = $("#port_box").find("span.port_text").joinAtstribute("port");
		ajax.remoteCall("bean://paymentService:getCloudHostFromAgent", 
				[ formData ],
				function(reply) { 
					if (reply.status == "exception") {
		 				if(reply.errorCode=="RMC_1"){
								top.$.messager.alert("警告","登陆超时，请重新登录","warning",function(){
									slideleft(1);
							});
						}else{
							top.$.messager.alert('警告','创建失败','warning');  
							 
						}
					} else if (reply.result.status == "fail") { 
		 				top.$.messager.alert('警告',reply.result.message,'warning');  
						
					} else {      
						top.$.messager.alert("提示","创建成功","warning",function(){
							var data = $("#cloud_host_add_dlg_container").parent().prop("_data_");
							$("#cloud_host_add_dlg").dialog("close");
							data.onClose(reply.result);
						});
					}
				}
			);  
	};
	
	function getHostName(){  
	    var  myselect=document.getElementById("region");         
	    var index=myselect.selectedIndex ; 
      
	    var region_val = myselect.options[index].value; 
	     
	    var userId = '<%=userId%>';  
		ajax.remoteCall("bean://cloudHostService:getCreateInfo", 
			[userId,region_val],
			function(reply) {
				if (reply.status == "exception") {
					if(reply.errorCode=="RMC_1"){
//							top.$.messager.alert("警告","会话超时，请重新登录","warning",function(){
//								slideleft(1);
//						});
					}else{
						
						top.$.messager.alert('警告','获取信息失败','warning'); 
				  }
			    }
				else if (reply.result.status == "success") 
				{  
					$("#host_name").val(reply.result.properties.name); 
				} 
				else 
				{
					top.$.messager.alert('警告',reply.result.message,'warning');
					}
				}
			); 
	};

	// 关闭
	function close() {
		$("#cloud_host_add_dlg").dialog("close");
	};

	//--------------------------
	
	$(document).ready(function() {
		// “地域”的onchange事件
		$("#region").change(function(){ 
			$("#sys_image_id").find("option:eq(0) ~ *").remove();													// 删除除第一个之外的option
			$("#sys_image_id_template").find("> option[region="+this.value+"]").clone().appendTo("#sys_image_id");	// 加入option
			self.getHostName();
			updatePrice();
			var  myselect=document.getElementById("region");         
		    var index=myselect.selectedIndex ; 
	      
		    var region_val = myselect.options[index].value;
		    if(region_val=='1'){
		    	$("#cpuPackage1").css("display","block");
				$("#cpuPackage4").css("display","none");
				$("#cpuRegion1_1").click();
				$("#memoryPackage1").css("display","block");
				$("#memoryPackage4").css("display","none");
				$("#memoryRegion1_1").click();
				$("#diskPackage1").css("display","block");
				$("#diskPackage4").css("display","none");
				$("#diskRegion1_1").click();
				$("#bandwidthPackage1").css("display","block");
				$("#bandwidthPackage4").css("display","none");
				$("#bandwidthRegion1_1").click();
				$("#package1").css("display","block");
				$("#package4").css("display","none");
				$("#item1_1").click(); 
		    }
		    if(region_val=='4'){
		    	$("#cpuPackage1").css("display","none");
				$("#cpuPackage4").css("display","block");
				$("#cpuRegion4_1").click();
				$("#memoryPackage1").css("display","none");
				$("#memoryPackage4").css("display","block");
				$("#memoryRegion4_1").click(); 
				$("#diskPackage1").css("display","none");
				$("#diskPackage4").css("display","block");
				$("#diskRegion4_1").click(); 
				$("#bandwidthPackage1").css("display","none");
				$("#bandwidthPackage4").css("display","block");
				$("#bandwidthRegion4_1").click(); 
				$("#package1").css("display","none");
				$("#package4").css("display","block");
				$("#item4_1").click();  
		    } 
			
		}); 
		// 保存
		$("#cloud_host_add_dlg_save_btn").click(function() {
			if(checkSys()) {
				save();
			}
		});
		// 关闭
		$("#cloud_host_add_dlg_close_btn").click(function() {
			self.close();
		});
		
		// 触发一次事件，进行sys_image_id > option的初始化
		$("#region").change();
		updatePrice(); 
	}); 

function notForDIY  (item){ 
	$("table tr:gt(0):eq(3)").hide();
	$("table tr:gt(0):eq(4)").hide();
	$("table tr:gt(0):eq(5)").hide();
	$("table tr:gt(0):eq(6)").hide(); 
	var percent_off = 100-'<%=agent.getPercentOff()%>';
	$("#price").val(($(item).attr("price")*percent_off*0.01).toFixed(2)); 
}
function forDIY (item) {
	$("table tr:gt(0):eq(3)").show();
	$("table tr:gt(0):eq(4)").show();
	$("table tr:gt(0):eq(5)").show();
	$("table tr:gt(0):eq(6)").show(); 
    updatePrice();
}

function getFocus(id){  
	$("#"+id).removeAttr("disabled"); 
	$("#"+id).focus(); 
}
function addDisabled(id){
	$("#"+id).val("");
	$("#"+id).attr("disabled","disabled");   
	
}
function diyOnblur(id1,id2){
	var  myselect=document.getElementById("region");         
    var index=myselect.selectedIndex ; 
    if($("#"+id2).val==""){   	
	    var region_val = myselect.options[index].value;
	    $("#"+id1+region_val+"_1").click();
    }
    updatePrice();
}
function  checkCPUCore (){ 
};
</script>



