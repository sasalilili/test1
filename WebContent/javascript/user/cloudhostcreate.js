/// 初始化
var id=''; 
$(document).ready(function(){ 
	// 
	$("#item6").click(function(){
		$("#diy").css("display","block");
	}); 
	$("#item0").click(function(){
		$("#diy").css("display","none");
	}); 
	$("#item1").click(function(){
		$("#diy").css("display","none");
	}); 
	$("#item2").click(function(){
		$("#diy").css("display","none");
	}); 
	$("#item3").click(function(){
		$("#diy").css("display","none");
	}); 
	$("#item4").click(function(){
		$("#diy").css("display","none");
	}); 
	$("input[name=item][id!=item6]").click(function(){
		$("#diy").css("display","none");
	}); 
	$("#item5").click(function(){
		$("#diy").css("display","none");
	});
	$("#region1").click(function(){
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
	});
	$("#region1").click();
	$("#region4").click(function(){
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
	});
	$(":radio").click(function(){
		if($("bandwidth").val()==""&&$("#bandwidth").attr("title")=='M'){ 
			
		} else{
			
			var region = document.getElementsByName("region"); 
			var region_val = " "; 
			for(var i=0;i<region.length;i++){
				if(region[i].checked){
					region_val = region[i].value;
					break;
				}
			} 
			if(region_val=="1"){ 
				if($("#bandwidth").val()>1000){
					$("#bandwidth").val("1000");
					$("#bandwidth").next("label").html("1000M");
					top.$.messager.alert('警告','广州带宽最大支持1000M','warning'); 
					$("#bandwidth").onblur();
				}
			}else if(region_val=="4"){ 
				if($("#bandwidth").val()>10){
					$("#bandwidth").val("10");
					$("#bandwidth").next("label").html("10M");
					top.$.messager.alert('警告','香港带宽最大支持10M','warning');  
				}
				
			}
		}
		getDescriptionAndPrice();
	});
	$("#goRechargeRightNow").click(function(){
		var html = '<form id="gift_form" action="'+a+'/bean/page.do" method="post">'+
		'<input type="hidden" name="bean" value="accountBalanceService">'+          
		'<input type="hidden" name="method" value="toRechargeGiftPage">'+          
		'<input type="hidden" name="userType" value="4">'+          
		'<input type="hidden" name="month" value="'+month+'">'+          
		'</form>';
		$("#month_form").html(html);
		$("#gift_form").submit();
  	});
	$("#finish").click(function(){
		window.location.href = a+"/bean/page.do?userType=4&bean=cloudUserService&method=myCloudHostPage";
	});
	$("input[name='month']").click(function(){ 
		$("#rh").next("label").html("自定义(月)");
		$("#rh").next("label").removeClass("checked");
		$(this).next("label").addClass("checked");
		var count = ($(this).val()-(parseInt($(this).val()/12))*2)*$("#monthlyPrice").val();
		$("#price").empty();
		$("#price").append(count.toFixed(2)+"元");
		month=$(this).val();
		 
		
	});
	$("#rh").click(function(){
		
		$("#rh1").next("label").removeClass("checked");
		$("#rh2").next("label").removeClass("checked");
		$("#rh3").next("label").removeClass("checked");
	});
	$("#rh").blur(function(){
		if($(this).val()!=''){			
			$("#rh1").next("label").removeClass("checked");
			$("#rh2").next("label").removeClass("checked");
			$("#rh3").next("label").removeClass("checked");  
			$("#rh").next("label").addClass("checked");
			var count = ($(this).val()-(parseInt($(this).val()/12))*2)*$("#monthlyPrice").val();
			$("#price").empty();
			$("#price").append(count.toFixed(2)+"元");
			month=$(this).val();
		}else{
			$("#rh3").click();
			$("#rh3").next("label").addClass("checked");
		}
		
	});
	$("#dataDisk").blur(function(){
        
		if($(this).val()==""&&($(this).attr("title"))=="G"){
			var region = document.getElementsByName("region"); 
			var region_val = " "; 
			for(var i=0;i<region.length;i++){
				if(region[i].checked){
					region_val = region[i].value;
					break;
				}
			}
			if(region_val=='1'){
				
				$("#diskRegion1_1").click();
				$("#diskRegion1_1").next("label").addClass("checked");
			}else{
				$("#diskRegion4_1").click();
				$("#diskRegion4_1").next("label").addClass("checked");
				
			} 
		}
		if($(this).val()!=""&&($(this).attr("title"))=="G"){			
			if($(this).val()>dataDiskMax){
				$(this).val(dataDiskMax);
				top.$.messager.alert('警告','最大支持'+dataDiskMax+'G','warning'); 
			}
			if($(this).val()<dataDiskMin){
				$(this).val(dataDiskMin);
				top.$.messager.alert('警告','最小支持'+dataDiskMin+'G','warning'); 
			} 
		}
		getDescriptionAndPrice();
	});
	$("#bandwidth").blur(function(){
		if($(this).val()==""&&$(this).attr("title")=='M'){
			
			var region = document.getElementsByName("region"); 
			var region_val = " "; 
			for(var i=0;i<region.length;i++){
				if(region[i].checked){
					region_val = region[i].value;
					break;
				}
			}
			if(region_val=='1'){				
				$("#bandwidthRegion1_1").click();
				$("#bandwidthRegion1_1").next("label").addClass("checked");
			}else{
				$("#bandwidthRegion4_1").click();				
				$("#bandwidthRegion4_1").next("label").addClass("checked");
			}  
			
		} 
		var region = document.getElementsByName("region"); 
	    var region_val = " "; 
	    for(var i=0;i<region.length;i++){
	        if(region[i].checked){
	        	region_val = region[i].value;
	            break;
	        }
	    } 
	    if(region_val=="1"){ 
	    	if($(this).val()>bandwidthMax_1){
	    		$(this).val(bandwidthMax_1);
	    		top.$.messager.alert('警告','广州带宽最大支持'+bandwidthMax_1+'M','warning'); 
	    	}
	    	if($(this).val()<bandwidthMin_1){
	    		$(this).val(bandwidthMin_1);
	    		top.$.messager.alert('警告','广州带宽最小支持'+bandwidthMin_1+'M','warning'); 
	    	}
	    }else if(region_val=="4"){ 
	    	if($(this).val()>bandwidthMax_4){
	    		$(this).val(bandwidthMax_4);
	    		top.$.messager.alert('警告','香港带宽最大支持'+bandwidthMax_4+'M','warning'); 
	    	}
	    	if($(this).val()<bandwidthMin_4){
	    		$(this).val(bandwidthMin_4);
	    		top.$.messager.alert('警告','香港带宽最小支持'+bandwidthMin_4+'M','warning'); 
	    	}
	    	
	    }
		getDescriptionAndPrice();
	}); 
	if(name!=''){		
		$("#goCreate").click(function(){
			goCreate(); 
		});
	}else{ 
		$("#goCreate").click(function(){ 
			slideleft(1);
			
			if (event.stopPropagation) { 
				// this code is for Mozilla and Opera 
				event.stopPropagation(); 
				} 
				else if (window.event) { 
				// this code is for IE 
				window.event.cancelBubble = true; 
				}
	//		event.stopPropagation();
			
		});
		
	}
	getDescriptionAndPrice();
}); 
/**
 * 显示确认信息
 */
function getComfirmInfo(){
	$("#comfirm").empty();
	var iteminfo="";
	var sysImageName="";
	var ports = "";
	var chkObjs = document.getElementsByName("item");
    var item = "";
    var bandwidth = "";
    var memory = "";
    var cpu = "";
    var dataDisk = "";
    var flag = true;
    
    for(var i=0;i<chkObjs.length;i++){
        if(chkObjs[i].checked){
        	if(chkObjs[i].value==""){
        		break;
        	}
        	item = chkObjs[i];       	 
        	cpu = $(item).attr("cpu");
        	memory = $(item).attr("memory");
        	dataDisk = $(item).attr("disk");
        	bandwidth = $(item).attr("bandwidth");    	 
        	monthlyprice = $(item).attr("price");  
        	flag = false;
            break;
        }
    }
    if(flag){  
    	chkObjs = document.getElementsByName("cpu");
    	for(var i=0;i<chkObjs.length;i++){
    		if(chkObjs[i].checked){
    			cpu = chkObjs[i].value;
    			break;
    		}
    	}
    	chkObjs = document.getElementsByName("memory");
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
    			diy = "false";
    			break;
    		}
    	} 
    	if(diy=="true"){
    		dataDisk = $("#dataDisk").val().replace("G","");
    	}
    	diy = "true";
    	chkObjs = document.getElementsByName("bandwidth");
    	for(var i=0;i<chkObjs.length;i++){
    		if(chkObjs[i].checked){
    			bandwidth = chkObjs[i].value;
    			diy = "false";
    			break;
    		}
    	}
    	if(diy=="true"){
    		bandwidth = $("#bandwidth").val().replace("M","");
    	}
    }
    iteminfo = "CPU:"+cpu+"核    内存:"+memory+"G  硬盘:"+dataDisk+"G  带宽:"+bandwidth+"M";
    
    var chkObjs = document.getElementsByName("sysImageId"); 
    for(var i=0;i<chkObjs.length;i++){
        if(chkObjs[i].checked==true){  
        	sysImageName = $(chkObjs[i]).next().html();
        	break;
        }
    }
//    chkObjs = document.getElementsByName("ports");   
//       for(var i=0;i<chkObjs.length;i++){
//           if(chkObjs[i].checked==true){ 
//        		   
//        	   ports = ports+chkObjs[i].id+", "; 
//           } 
//    	
//    } 
    
    var region = document.getElementsByName("region"); 
    var region_val = " "; 
    for(var i=0;i<region.length;i++){
        if(region[i].checked){
        	region_val = region[i].value;
            break;
        }
    }
    var region_info; 
    if(region_val=="1"){
    	region_info = "广州";
    }else if(region_val=="4"){
    	region_info = "香港";
    	
    } 
    ports = ports.substr(0, ports.length-2); 
    var info ='<div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 15px 0">主机名称</span></div>'+
            '<div class="l" style="width:538px;height:30px;margin:0 0 15px 0;font-size:14px;line-height:30px; position:relative;">'+
            '<input id="t1" name="displayName" type="text" value="'+hostName+'" class="einput"/> <label for="t1" class="ebutton"> <div class="l" id="displayName_">'+hostName+'</div> <div class="l"><img src="'+a+'/image/icon_edit.png" width="20" height="20" /></div></label></div>'+
//		    '<div class="l" style="width:538px;margin:0 0 15px 0;font-size:14px;line-height:30px;">'+hostName+'</div>'+
		    '<div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 15px 0">地域</span></div>'+
		    '<div class="l" style="width:538px;margin:0 0 15px 0;font-size:14px;line-height:30px;">'+region_info+'</div>'+
		    '<div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 15px 0">基本配置</span></div>'+
		    '<div class="l" style="width:538px;margin:0 0 15px 0;font-size:14px;line-height:30px;">'+iteminfo+'</div>'+
		    '<div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 15px 0">镜像</span></div>'+
		    '<div class="l" style="width:538px;margin:0 0 15px 0;font-size:14px;line-height:30px;">'+sysImageName+'</div>'+
		    '<div class="l" style="width:120px;"><span class="bluebutton" style="width:105px;margin:0 15px 15px 0">独立 IP</span></div>'+
		    '<div class="l" style="width:538px;margin:0 0 15px 0;font-size:14px;line-height:30px;">我们将为您的云主机免费提供一个独立 IP</div>'+
		    '<div class="clear"></div>';
              
	$("#comfirm").append(info);
	$(".einput").focus(function(){
		$(".ebutton").css("left","-99999px");
		$(".einput").css("left","0");
		
	});
	$(".einput").blur(function(){
		$(".ebutton").css("left","0");
		$(".einput").css("left","-99999px");
		name = $("#t1").val();
		if(name==hostName){ 
			return;
		}
		if(name.length==0||name.length>30){
			top.$.messager.alert('警告','主机名长度为1-30个字符','warning'); 
			$("#displayName_").html(hostName);
			$("t1").val(hostName);
		}else{			
			$("#displayName_").html(name);
		}
		
	});
	
}
/**
 * 显示镜像描述
 * @param description
 */
function showDescription(description){
	if(description!=''){		
		$("#isotitle").empty();
		$("#isotitle").append("版本信息："+description);
	}else{
		var chkObjs = document.getElementsByName("sysImageId"); 
	    for(var i=0;i<chkObjs.length;i++){
	        if(chkObjs[i].checked==true){  
	        	$("#isotitle").empty();
	        	$("#isotitle").append("版本信息："+$(chkObjs[i]).attr("imgdescription"));
	        	break;
	        }
	    } 
	}
}
function getDescriptionAndPrice(){
	var iteminfo="";
	var sysImageName="";
	var ports = "";
	var chkObjs = document.getElementsByName("item");
    var item = "";
    var bandwidth = "";
    var memory = "";
    var cpu = "";
    var dataDisk = "";
    var monthlyprice = 0;
    var hourprice = "";
    var flag = true;  
    var free = "";
    var region = document.getElementsByName("region"); 
    var region_val = " "; 
    for(var i=0;i<region.length;i++){
    	if(region[i].checked){
    		region_val = region[i].value;
    		break;
    	}
    } 
    var region_info; 
    if(region_val=="1"){
    	region_info = "广州";
    }else if(region_val=="4"){
    	region_info = "香港";
    	
    } 
    for(var i=0;i<chkObjs.length;i++){
        if(chkObjs[i].checked){
        	if(chkObjs[i].value==""){
        		break;
        	}
        	item = chkObjs[i];       	 
        	cpu = $(item).attr("cpu");
        	memory = $(item).attr("memory");
        	dataDisk = $(item).attr("disk");
        	bandwidth = $(item).attr("bandwidth");    	 
        	monthlyprice = $(item).attr("price");  
        	flag = false;
            break;
        }
    }
    if(flag){  
    	chkObjs = document.getElementsByName("cpu");
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
    			diy = "false";
    			break;
    		}
    	} 
    	if(diy=="true"){
    		dataDisk = $("#dataDisk").val().replace("G","");
    	}
    	diy = "true";
    	chkObjs = document.getElementsByName("bandwidth");
    	for(var i=0;i<chkObjs.length;i++){
    		if(chkObjs[i].checked){
    			bandwidth = chkObjs[i].value;
    			diy = "false";
    			break;
    		}
    	}
    	if(diy=="true"){
    		bandwidth = $("#bandwidth").val().replace("M","");
    	}
    }
    iteminfo = "CPU:"+cpu+"核     内存:"+memory+"G   硬盘:"+dataDisk+"G   带宽:"+bandwidth+"M"; 
    var chkObjs = document.getElementsByName("sysImageId"); 
    for(var i=0;i<chkObjs.length;i++){
        if(chkObjs[i].checked==true){  
        	sysImageName = chkObjs[i].id;
        	break;
        }
    } 
    
    
    iteminfo = "地域:"+region_info+"  "+iteminfo;  
    if(monthlyprice==0){  
    	ajax.async = false; 	
    	monthlyprice = refreshPrice(region_val,cpu,memory,dataDisk,bandwidth); 
    	ajax.async = true; 
    	if(flag==false){
    		free = "(推广期免费，2015-03-31止)";
    	}
    } 
	hourprice = (monthlyprice/30/24).toFixed(3);  
	var info = "<i>单价:<strong>"+hourprice+"元/小时</strong> 约合:<strong>"+monthlyprice+"元/月</strong>"+free+"</i><br/>"+iteminfo
	
	$("#description_1").empty();
	$("#description_1").append(info);
	$("#description_2").empty();
	$("#description_2").append(info);
	$("#description_3").empty();
	$("#description_3").append('<i style="line-height:40px;">单价：<strong>'+hourprice+'元/小时</strong>　约合：<strong>'+monthlyprice+'元/月</strong></i>');
     var allPrice = ((+totalPrice)+(+monthlyprice)).toFixed(2); 
    $("#description_4").empty();
    $("#description_4").append('当前余额：<strong>'+balance+'元</strong>，您的主机还可使用：<strong style="color:#4cda64">'+getDays(balance,allPrice)+'</strong>');
    $("#monthlyPrice").val(allPrice);
    
}

 
function refreshProgress(){ 
	if(id!=''){
		ajax.remoteCall("bean://cloudHostService:getCloudHostCreationResult", 
				[ id ],
				function(reply) {
					if( reply.status == "exception" ) 
					{ 
					} 
					else if(reply.result.status == "success") 
					{  
						$('#progressbar').progressbar('setValue', parseInt(reply.result.properties.progress));
						if( self.refreshProgress==null )
						{
							return ;
						}
						if( reply.result.properties.creation_status==null )
						{
							window.setTimeout(self.refreshProgress, 1000);
						}
						else if( reply.result.properties.creation_status==false )
						{ 								
							$("#cloudhostcreateprogress").html("创建失败");
							$("#progressbar_id").hide(); 
						}
						else if( reply.result.properties.creation_status==true )
						{
							$("#cloudhostcreateprogress").html("创建成功");
							$("#progressbar_id").hide();
						}
					} 
					else 
					{ 
						// 云主机尚未开始创建，继续获取信息
						window.setTimeout(self.refreshProgress, 1000);
					}
				}
			); 
		
	}else{
		 window.setTimeout(self.refreshProgress, 1000);
		
	}
}

function goCreate(){ 
    window.setTimeout(self.refreshProgress, 1000);
 	var formData = $.formToBean(cloud_host_config_form);
 	loadingbegin();
	ajax.remoteCall("bean://paymentService:getCloudHost", 
		[ formData ],
		function(reply) { 
		loadingend();
			if (reply.status == "exception") {
 				if(reply.errorCode=="RMC_1"){
						top.$.messager.alert("警告","登陆超时，请重新登录","warning",function(){
							slideleft(1);
					});
				}else{
					//走正常创建流程
					ajax.remoteCall("bean://paymentService:getCloudHostForNormal", 
							[ formData ],
							function(reply) {
							loadingend();
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
									// 刷新progress
									id = reply.result.status; 
									nextstep();
									$("#rh3").click();
								}
							}
						); 
				}
			} else if (reply.result.status == "fail") {
 				top.$.messager.alert('警告',reply.result.message,'warning'); 
// 				$("#cloudhostcreateprogress").html("创建失败");
// 				$("#progressbar_id").hide();
				
			} else {   
				// 刷新progress  
				id = reply.result.properties.cloudHostId; 
				nextstep();
				$("#rh3").click();
			}
		}
	);  
}
//获取剩余时间
function getDays(balance,totalPrice){
	var dayprice = totalPrice/30;
	var days = parseInt(balance/dayprice);
	if(days<30){
		if(days<1){
			return "不足一天";
		}
		return days+"天";
	}else if(days<365){
		return parseInt(days/30)+"个月"+days%30+"天";
	}else{
		var month=parseInt(parseInt(days%365)/30);
		if(month>0){
			month = month+"月";
		}else{
			month = "";
		}
		var day = parseInt(days%365)%30;
		if(day>0){
			day = day+"天";
		}else{
			day = "";
		}
		return parseInt(days/365)+"年"+month+day;
	}
	return "";
}

function getLoginInfo(username,message,id){
	slideright();
	inituser(username,message); 
	getDescriptionAndPrice();
	$("#goCreate").unbind("click");
	$("#goCreate").click(function(){
		goCreate();
	});
	$("#goCreate").empty();
	$("#goCreate").append("确认生成");
	$("#my_clouduan").unbind("click");
	$("#my_clouduan").click(function(){
		window.location.href = a+"/user.do";
	});
	userId = id;
	getCreateInfo();
	getDescriptionAndPrice();
	showDescription();
	
}

function getCreateInfo(){  
	var region = document.getElementsByName("region"); 
    var region_val = " "; 
    for(var i=0;i<region.length;i++){
    	if(region[i].checked){
    		region_val = region[i].value;
    		break;
    	}
    } 
	ajax.remoteCall("bean://cloudHostService:getCreateInfo", 
		[userId,region_val],
		function(reply) {
			if (reply.status == "exception") {
				if(reply.errorCode=="RMC_1"){
//						top.$.messager.alert("警告","会话超时，请重新登录","warning",function(){
//							slideleft(1);
//					});
				}else{
					
					top.$.messager.alert('警告','获取信息失败','warning'); 
			  }
		    }
			else if (reply.result.status == "success") 
			{ 
				balance = reply.result.properties.balance;
				totalPrice = reply.result.properties.totalPrice;
				hostName = reply.result.properties.name;
				getComfirmInfo();
			} 
			else 
			{
				top.$.messager.alert('警告',reply.result.message,'warning');
				}
			}
		); 
}
// 通过地域选择显示不同镜像
function checkRegion(){
	var region = document.getElementsByName("region"); 
    var region_val = " "; 
    for(var i=0;i<region.length;i++){
    	if(region[i].checked){
    		region_val = region[i].value;
    		break;
    	}
    } 
    var region_info;  
    if(region_val=="1"){
    	$("#image_region_4").css("display","none");
    	$("#image_region_1").css("display","block");
    	var childNum = document.getElementById('image_region_1').children.length;
    	if(childNum==0){
    		$("#isotitle").html("系统暂无镜像");    		
    		$("#getImage").attr("class","disabledbutton r");    		
    		$("#getImage").removeAttr("onclick");    		
    	}else{    		
    		$("#image_region_1").find(":first-child").click(); 
    		$("#isotitle").html("版本信息："+$("#image_region_1").find(":first-child").attr("imgdescription"));
     		$("#getImage").attr("class","bluebutton r");    		
    		$("#getImage").attr("onclick","getCreateInfo();nextstep();getComfirmInfo();");    		
    	}
    }else if(region_val=="4"){
    	$("#image_region_1").css("display","none");
    	$("#image_region_4").css("display","block"); 
    	$("#image_region_4").find(":first-child").click(); 
    	$("#isotitle").html("版本信息："+$("#image_region_4").find(":first-child").attr("imgdescription"));
    	var childNum = document.getElementById('image_region_4').children.length;
    	 
    	
    	if(childNum==0){
    		$("#isotitle").html("系统暂无镜像");    		
    		$("#getImage").attr("class","disabledbutton r");    		
    		$("#getImage").removeAttr("onclick");    		
    	}else{    		
    		$("#image_region_4").find(":first-child").click(); 
    		$("#isotitle").html("版本信息："+$("#image_region_4").find(":first-child").attr("imgdescription"));
     		$("#getImage").attr("class","bluebutton r");    		
    		$("#getImage").attr("onclick","getCreateInfo();nextstep();getComfirmInfo();");    		
    	}
    	
    }  
}
