<%@page import="java.util.List"%>
<%@page import="com.zhicloud.op.login.LoginInfo"%>
<%@page import="com.zhicloud.op.app.helper.LoginHelper"%>
<%@page import="com.zhicloud.op.vo.UserOrderVO"%>
<%@page import="com.zhicloud.op.vo.ShoppingCartVO"%>
<%@page import="com.zhicloud.op.common.util.CapacityUtil"%>
<%@page import="com.zhicloud.op.vo.DiskPackageOptionVO"%>
<%@page import="com.zhicloud.op.vo.BandwidthPackageOptionVO"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.math.BigInteger"%>
<%@page import="com.zhicloud.op.vo.SysDiskImageVO"%>
<%@page import="com.zhicloud.op.vo.MemoryPackageOptionVO"%>
<%@page import="com.zhicloud.op.vo.CpuPackageOptionVO"%>
<%@page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%
	List<ShoppingCartVO> detail = (List<ShoppingCartVO>)request.getAttribute("detail");
    ShoppingCartVO cart = (ShoppingCartVO)request.getAttribute("cart");
    List<CpuPackageOptionVO> cpuOptions = (List<CpuPackageOptionVO>)request.getAttribute("cpuOptions");
    List<MemoryPackageOptionVO> memoryOptions = (List<MemoryPackageOptionVO>)request.getAttribute("memoryOptions");
	LoginInfo loginInfo = LoginHelper.getLoginInfo(request,"4"); 
	DiskPackageOptionVO diskOption = (DiskPackageOptionVO)request.getAttribute("diskOption");
	BandwidthPackageOptionVO bandwidthOption = (BandwidthPackageOptionVO)request.getAttribute("bandwidthOption");
	List<SysDiskImageVO> sysDiskImageOptions = (List<SysDiskImageVO>)request.getAttribute("sysDiskImageOptions");
	BigDecimal i = new BigDecimal("1073741824");
	BigDecimal k = new BigDecimal("1000000");
	BigInteger j = new BigInteger("1073741824");
%>
<!DOCTYPE html>
<!-- payasquantity.jsp -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="textml; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=9;IE=8;IE=7;" />
<title>按量付费 - 云端在线</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/easyui/themes/icon.css">
</head>

<body>
	<div class="page" >
		<div class="pagebox">
			<div class="header">
				<div class="headerbox">
					<div class="headerlogo l">
						<a href="#"><img src="<%=request.getContextPath()%>/images/logo_green_light_145_29.gif" width="145" height="29" alt="云端在线" /></a>
					</div>
					<%
						if(loginInfo!=null){
					%>
					<div class="headerregister r">
						<a href="#" id="logout_link">注销</a>
					</div>
					<div class="headerlogin r">
						<a href="#"><%=loginInfo.getAccount()%></a>
					</div>
					<%
						} else{
					%>
					<div class="headerregister r">
						<a href="<%=request.getContextPath()%>/user/register.do">注册</a>
					</div>
					<div class="headerlogin r">
						<a href="<%=request.getContextPath()%>/user.do?url=<%=request.getContextPath()%>/user/buy.do">登录</a>
					</div>
					<%
						}
					%>
				</div>
			</div>
			<div class="nav">
				<div class="navbox">
					<div class="navbutton l">
						<a href="<%=request.getContextPath()%>/">首页</a>
					</div>
					<div class="navsplitter l">&nbsp;</div>
					<div class="navbutton l" id="navactive">
						<a href="#">定制云主机</a>
					</div>
					<div class="navsplitter l">&nbsp;</div>
					<div class="navbutton l">
						<a href="#">相关下载</a>
					</div>
					<div class="navbutton r">
						<a href="#" id="navcart"> 
						<%
 							if(detail!=null){
 										 		out.println(detail.size());						       
 										 	} else{ 
 										 		out.println("0");
 										 	}
 						%>
						</a>
					</div>
					<div class="navsplitter r">&nbsp;</div>
					<div class="navcontrol r">
						<a href="<%=request.getContextPath()%>/user.do"><span>我的云端</span></a>
						<input id="url" type="hidden" value="<%=request.getContextPath()%>"/>
					</div>
				</div>
			</div>
			<div class="main">
				<div class="container l">
					<div class="titlebar">
						<div class="tab">
							<a href="<%=request.getContextPath()%>/user/buy.do">试用</a> 
						</div>
						<div class="tab">
							<a href="<%=request.getContextPath()%>/user/buy.do?flag=monthly">包月使用</a>
						</div>
						<div class="tab tabactive">
							 按量付费
						</div>
					</div>
					<div class="content">
						<form action="" id="cart_form" method="post">
							<input name="type" type="hidden" value="2" /> 
							<input name="price" type="hidden" value="0" /> 
							<span  style="width: 80px; line-height: 40px">CPU</span> 
							<select class="shortselect" name="cpuCore">  
								<%
  									for( CpuPackageOptionVO cpuOption : cpuOptions )
  															{
  								%>
										<option value="<%=cpuOption.getCore()%>"><%=cpuOption.getCore()%>核</option>  
								<%
  									}
  								%>
							</select>
							<div class="clear">&nbsp;</div>
							<span>内存</span> <select class="shortselect" name="memory"> 
								<%
 									for( MemoryPackageOptionVO memoryOption : memoryOptions )
 															{
 								%>
										<option value="<%=memoryOption.getMemory().divide(j)%>"><%=memoryOption.getMemory().divide(j)%>G</option> 
								<%
 									}
 								%>
							</select>
							<div class="clear">&nbsp;</div>
							<span>系统磁盘</span>
							<div class="radio">
								<input name="sysdisk" type="radio" value="" checked="checked" /><label>从镜像选择</label>
							</div>
							<select id="sys_image_id" name="sys_image_id" style="width:270px" class="easyui-radio">
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

							<div class="clear">&nbsp;</div>
							<span>&nbsp;</span>
							<div class="radio">
								<input name="sysdisk" type="radio" value="" /><label>空白磁盘</label>
							</div>
							<div>
								<input id="sys_disk_slider" class="easyui-slider"
									style="width: 170px" name="sys_disk"
									data-options="
									showTip:true, 
									min: <%=diskOption.getMin()%>,
									max: <%=diskOption.getMax()%>,
									rule: ['<%=CapacityUtil.toGB(diskOption.getMin(), 0)%>', '<%=CapacityUtil.toGB(diskOption.getMax(), 0)%>'],
									tipFormatter:function(value){
									    $('#sysDisk').val(CapacityUtil.toGB(value, 0).replace('GB',''));
						                
						            },
								" />
							</div>
							<input class="tinyfield" name="sysDisk" id="sysDisk" type="text" />
							<div class="unit">GB</div>
							<br /> <br /> <br />
							<div class="clear">&nbsp;</div>
							<span>数据磁盘</span>
							<div>
								<input id="sys_disk_slider" class="easyui-slider"
									style="width: 300px" name="sys_disk"
									data-options="
									showTip:true, 
									min: <%=diskOption.getMin()%>,
									max: <%=diskOption.getMax()%>,
									rule: ['<%=CapacityUtil.toGB(diskOption.getMin(), 0)%>', '<%=CapacityUtil.toGB(diskOption.getMax(), 0)%>'],
									tipFormatter:function(value){
									    $('#dataDisk').val(CapacityUtil.toGB(value, 0).replace('GB',''));
						                
						            },
								" />
							</div>
							<input class="tinyfield" name="dataDisk" id="dataDisk" type="text" />
							<div class="unit">GB</div>
							<br /> <br /> <br />
							<div class="clear">&nbsp;</div>
							<span>网络带宽</span>
							<div>
								<input id="sys_disk_slider" class="easyui-slider"
									style="width: 300px" name="sys_disk"
									data-options="
									showTip:true,  
									min: <%=bandwidthOption.getMin()%>,
									max: <%=bandwidthOption.getMax()%>,
									rule: ['<%=CapacityUtil.toMB(bandwidthOption.getMin(), 0)%>', '<%=CapacityUtil.toMB(bandwidthOption.getMax(), 0)%>'],
									tipFormatter:function(value){
									    $('#bandwidth').val(CapacityUtil.toMB(value, 0).replace('MB',''));
						                
						            },
								" />
							</div>
							&nbsp;<input class="tinyfield" name="bandwidth" id="bandwidth" type="text" />
							<div class="unit">Mbps</div>
							<div class="clear">&nbsp;</div>
							<br/>
							<div ><span style="width:90px;">公网流量费用  </span>&nbsp;<div  class="price"><b>0.8</b>元/GB</div></div>
							<div class="clear">&nbsp;</div>
							<%
								if(loginInfo!=null){
							%>
							<input type="button" class="inputbutton" id="put_into_cart"
								value="加入购物车" />
							<%
								} else{
							%>
							<input type="button" class="inputbutton" id="toLogin"
								value="登录后选购" />
							<div class="inputsplitter r">&nbsp;</div>
							<div class="inputoption r">
								<a href="<%=request.getContextPath()%>/user/register.do">注册</a>
							</div>
							<%
								}
							%>
						</form>
						<%
							if(cart!=null) {
						%>
						<form action="" id="delete_form" method="post">
							<input name="cartId" type="hidden" value="<%=cart.getId()%>" />
							<input name="configId" id="configId" type="hidden" value="" /> 
							<input name="price" id="detailPrice" type="hidden" value="" />
						</form>
						<%
							}
						%>
						<div class="clear">&nbsp;</div>
					</div>
				</div>
				<div class="sidebar r">
					<%
						if(cart!=null) {
					%>
					<div class="sidebartitle">
						<div class="sidebarcartpay r">
							<a href="<%=request.getContextPath()%>/user/account.do?id=<%=cart.getId()%>">结算</a>
						</div>
						购物车
					</div>
					<%
						}
						             if(detail!=null){
						        	   for(ShoppingCartVO vo : detail){
					%>
					<div class="sidebarcart">

						<div class="sidebarcarttitle">
							<div class="l"></div>
							<a href="#" onclick="deleteDetail('<%=vo.getId()%>',<%=vo.getPrice()%>)">
							<img src="<%=request.getContextPath()%>/images/button_remove_gray_light_24_24.gif" width="24" height="24" alt="删除" class="sidebarcartremove" />
							</a>
						</div>
						<div class="sidebarcartproperty"><%=vo.getCpuCore()%>核
						</div>
						<div class="sidebarcartpropertyname">CPU</div>
						<div class="sidebarcartproperty"><%=vo.getMemory().divide(i)%>G
						</div>
						<div class="sidebarcartpropertyname">内存</div>
						<div class="sidebarcartproperty">
							<%
								if(vo.getSysImageId()!=null&&vo.getSysImageId().length()>0)
								{
									for( SysDiskImageVO sysDiskImageOption : sysDiskImageOptions )
									{
										if(vo.getSysImageId().equals(sysDiskImageOption.getId()))
										{
											out.println(sysDiskImageOption.getName());
											}
										}
									}else{ 
										out.println(vo.getSysDisk().divide(i));
										}
							%>G
						</div>
						<div class="sidebarcartpropertyname">系统磁盘</div>
						<div class="sidebarcartproperty">
							<% 
							    out.println(vo.getDataDisk().divide(i));
							%>G
						</div>
						<div class="sidebarcartpropertyname">数据磁盘</div>
						<div class="clear">&nbsp;</div>
							<%
								if(1==vo.getType()){
							%>
						<div class="sidebarcartprice">
							<div class="l">
								包月使用<%=vo.getDuration()%>个月
							</div>
							<div class="r">
								<b><%=vo.getPrice()%></b>元
							</div>
						</div>
							<%
								}else if(2==vo.getType()){
							%>
					<div class="sidebarcartprice">
						<div class="l">公网流量费用：</div>
						<div class="r">
							<b>0.8</b>元/GB
						</div>
					</div>
							<%
								}else if(3==vo.getType()){
							%>
					<div class="sidebarcartprice">
						<div class="l">试用 6个月</div>
						<div class="r">
							<b><%=vo.getPrice()%></b>元
						</div>
					</div>
							<%
								}
							%>
				    </div>
							<%
								} }
							%>
							<%
								if(cart!=null) {
							%>
				<div class="sidebartitle">
					<div class="sidebarcartpay r">
						<a href="<%=request.getContextPath()%>/user/account.do?id=<%=cart.getId()%>">结算</a>
					</div>
					总价：<b><%=cart.getTotalPrice()%></b>元
				</div>
				<%
					}
				%>
			</div>
			<div class="clear">&nbsp;</div>
		</div>
	</div>
	<div class="pagefooter">
		<div class="sitemap">
			<div class="sitemapbox">
				<div class="sitemapsocial">
					<div class="sitemaplogo l">
						<a href="#"><img src="<%=request.getContextPath()%>/images/logo_green_dark_40_29.gif" width="40" height="29" alt="云端在线" /></a>
					</div>
					<div class="sitemapweixin r">
						<a href="#">微信扫二维码<br /> 关注云端在线
						</a>
					</div>
					<div class="sitemapweibo r">
						<a href="#">新浪<br /> 微博
						</a>
					</div>
				</div>
				<ul>
					<li><a href="<%=request.getContextPath()%>/">首页</a></li>
				</ul>
				<ul>
					<li><a href="#">定制云主机</a></li>
					<li><a href="#">试用</a></li>
					<li><a href="#">包月试用</a></li>
					<li><a href="#">按量付费</a></li>
				</ul>
				<ul>
					<li><a href="#">相关下载</a></li>
				</ul>
				<ul>
					<li><a href="#">我的云端</a></li>
					<li><a href="#">我的云主机</a></li>
					<li><a href="#">财务中心</a></li>
					<li><a href="#">用户中心</a></li>
				</ul>
				<ul>
					<li><a href="#">账户注册</a></li>
					<li><a href="#">账户登录</a></li>
				</ul>
				<ul>
					<li><a href="#">关于我们</a></li>
					<li><a href="#">联系我们</a></li>
				</ul>
			</div>
		</div>
		<div class="footer">
			<div class="footerbox">
				<div class="footercopyright l">
					Copyright &copy; 2014 <a href="http://www.zhicloud.com"
						target="_blank">致云科技有限公司</a>, All rights reserved.
				</div>
				<div class="footercopyright r">蜀ICP备14004217号-1</div>
			</div>
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
<script type="text/javascript">
window.name = "selfWin";

var ajax = new RemoteCallUtil("<%=request.getContextPath()%>/bean/call.do?userType=<%=userType%>");
ajax.async = false;
var _terminal_user_add_dlg_scope_ = new function(){
	
	var self = this;
	 
	
	// 保存
	self.save = function() {
		var formData = $.formToBean(cart_form);
		ajax.remoteCall("bean://paymentService:addCart", 
			[ formData ],
			function(reply) {
				if (reply.status == "exception") {
					top.$.messager.alert('警告',reply.exceptionMessage,'warning');
				} else if (reply.result.status == "success") {
					// 注册成功
					$("<div class=\"datagrid-mask\"></div>").css({
						display:"block",
						width:"100%",
						height:"100%"
					}).appendTo("body"); 
					$("<div class=\"datagrid-mask-msg\"></div>").html("添加成功").appendTo("body").css({
						display:"block",
						left:($(document.body).outerWidth(true) - 190) / 2,
						top:($(window).height() - 45) / 2
					});
					// 跳转页面
					window.setTimeout(function(){
						window.location.href="<%=request.getContextPath()%>/user/buy.do?flag=asquantity"; 
					}, 500);
				} else {
					top.$.messager.alert('警告',reply.result.message,'warning');
				}
			}
		);
	};

	// 关闭
	self.close = function() {
		$("#terminal_user_add_dlg").dialog("close");
	};

	//--------------------------
	
	// 初始化
	$(document).ready(function(){
		// 保存
		$("#put_into_cart").click(function() {
			self.save();
		}); 
		$("#toLogin").click(function() { 
			var url = encodeURIComponent($("#url").val()+"/user/buy.do"); 
			window.location.href="<%=request.getContextPath()%>/user.do?url="+url;
		}); 
		// 注销
		$("#logout_link").click(function(){
			logout();
		});
	});
};

   function deleteDetail(id,price){ 
	   $("#configId").val(id);
	   $("#detailPrice").val(price);
		var formData = $.formToBean(delete_form);
	   ajax.remoteCall("bean://paymentService:deleteDetailAndConfig", 
				[ formData],
				function(reply) {
					if (reply.status == "exception") {
						top.$.messager.alert('警告',reply.exceptionMessage,'warning');
					} else if (reply.result.status == "success") { 
						window.location.href="<%=request.getContextPath()%>/user/buy.do?flag=asquantity";  						 
					} else {
						top.$.messager.alert('警告',reply.result.message,'warning');
					}
				}
			);
   } 
// 注销
   function logout(){
	ajax.remoteCall("bean://sysUserService:logout",
			[],
			function(reply)
			{
				if( reply.status=="exception" )
				{
					top.$.messager.alert('警告',reply.exceptionMessage,'warning');
				} 
				else if( reply.result.status=="success" )
				{
					// 登录成功
					$("<div class=\"datagrid-mask\"></div>").css({
						display:"block",
						width:"100%",
						height:"100%"
					}).appendTo("body"); 
					$("<div class=\"datagrid-mask-msg\"></div>").html("成功退出，正在跳转页面。。。").appendTo("body").css({
						display:"block",
						left:($(document.body).outerWidth(true) - 190) / 2,
						top:($(window).height() - 45) / 2
					});
					// 跳转页面
					window.setTimeout(function(){
						top.location.href = "<%=request.getContextPath()%>/user.do";
					}, 500);
				}
				else
				{
					top.$.messager.alert('警告',reply.result.message,'warning');
				}
			}
		);
	}
</script>
</html>
