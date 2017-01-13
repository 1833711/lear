<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
		<title>日志 - 首页</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
	</head>
	<body class="bg-gray">
		<header class="header bg-log text-center" >
		<a id="goBack" class="font-white" onclick="closeWindow()" >
			<div class="header-left" >
					<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;"></span>
			</div>
			<span class="font-14" style="display: inline-block;margin-top: 6px;float:left">返回</span>
			</a>
			 <div class="header-center font-white" style="margin-left: -11px;">工作日志</div>
		 
				<div class="header-right text-right font-14"  ><a style="color:#fff" href="${pageContext.request.contextPath}/log_set/log_set">设置</a></div> 
			 
		</header>
		<div class="container mt40">
		<c:if test="${adminNum!=1}">
				<div class="row bg-log log-top" >
				<a href="${pageContext.request.contextPath}/log/list">
					<div class="col-xs-6" >
						<img class="center-block" src="${pageContext.request.contextPath}/resource/img/rizhi_ALL.png" />
						<p class="text-center" >所有日志</p>
					</div>
				</a>	
				<a href="${pageContext.request.contextPath}/log/view">
					<div class="col-xs-6" >
						<img class="center-block" src="${pageContext.request.contextPath}/resource/img/rizhi_biao.png" />
						<p class="text-center" >日志报表</p>
					</div>
				</a>
			</div>
		</c:if>
			 <c:if test="${adminNum==1}">
			<div class="row bg-log log-top" >
				<a href="${pageContext.request.contextPath}/log/list">
					<div class="col-xs-4" >
						<img class="center-block" src="${pageContext.request.contextPath}/resource/img/rizhi_ALL.png" />
						<p class="text-center" >所有日志</p>
					</div>
				</a>	
				<a href="${pageContext.request.contextPath}/log/view">
					<div class="col-xs-4" >
						<img class="center-block" src="${pageContext.request.contextPath}/resource/img/rizhi_biao.png" />
						<p class="text-center" >日志报表</p>
					</div>
				</a>
				
				<a href="${pageContext.request.contextPath}/log_set/log_me">
					<div class="col-xs-4" >
						<img class="center-block" src="${pageContext.request.contextPath}/resource/img/manage.png" />
						<p class="text-center" >管理日志</p>
					</div>
				</a>
			</div>
			</c:if>
			<div class="row">
				<p class="log-temp">
					有下列模板可以选择
				</p>
			</div>
			<div class="row bg-white rizhi-div" >
				<c:forEach var="model" items="${list}">
					<a href="${pageContext.request.contextPath}/log_items/go_log?modelId=${model.modelId}">
						<div class="col-xs-4 choice-temp" >
							<img class="center-block" src="${model.logo}" />
							<p class="text-center font-default font-14" >${model.modelName}</p>
						</div>
					</a>
				</c:forEach>	
<!-- 				<a href="#"> -->
<!-- 					<div class="col-xs-4 choice-temp" > -->
<%-- 						<img class="center-block" src="${pageContext.request.contextPath}/resource/img/rizhi_jia.png" /> --%>
<!-- 						<p class="text-center font-default font-16" >添加模板</p> -->
<!-- 					</div> -->
<!-- 				</a> -->
			</div>
		</div>
		
		<input id="appointed" type="hidden" value="" />
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js" ></script>
		<script type="text/javascript">
			$(document).ready(function(){
				
				var browser = {
					versions: function() {
					var u = navigator.userAgent, app = navigator.appVersion;
					return {//移动终端浏览器版本信息 
						trident: u.indexOf('Trident') > -1, //IE内核
						presto: u.indexOf('Presto') > -1, //opera内核
						webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
						gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
						mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), //是否为移动终端
						ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
						android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
						iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
						iPad: u.indexOf('iPad') > -1, //是否iPad
						webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
					};
					}(),
					language: (navigator.browserLanguage || navigator.language).toLowerCase()
					}
				 
				if (browser.versions.ios || browser.versions.iPhone || browser.versions.iPad) {
					$("#appointed").val("ios");
				}
				else if (browser.versions.android) {
					$("#appointed").val("android");
				}
				
				if (window.history && window.history.pushState) {
		            $(window).on('popstate', function () {
		                var hashLocation = location.hash;
		                var hashSplit = hashLocation.split("#!/");
		                var hashName = hashSplit[1];
		                if (hashName !== '') {
		                    var hash = window.location.hash;
		                    if (hash === '') {
		                    	/* if (browser.versions.ios || browser.versions.iPhone || browser.versions.iPad) {
									$("#appointed").val("ios");
								}
								else if (browser.versions.android) {
									$("#appointed").val("android");
								} */
								closeWindow();
		                    }
		                }
		            });
		            window.history.pushState('forward', null, '#forward');
		        }
				
				
			});
			
			function closeWindow(){
				if($("#appointed").val()=="android"){
					window.callAndroid.JsCallandroid();
					
				}else if($("#appointed").val()=="ios"){
					self.close();
				}
				
				window.location.href = "${pageContext.request.contextPath}/logout";
			}
			
		</script>
	</body>
</html>