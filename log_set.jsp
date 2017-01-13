<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
		<title>日志-设置</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/index.css" />
		<style>

		</style>
	</head>

	<body class="bg-gray">
		<header class="header bg-log text-center" >
			<a style="color:#fff" href="${pageContext.request.contextPath }/log/index">
			<div class="header-left" >
				<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;"></span>
			</div>
			<span style="display: inline-block;margin-top: 6px;float:left;font-size:1.4rem;">返回</span>
			</a>
			<div class="header-center font-white" >设置</div>
			<div class="header-right text-right font-14" style="width: 40px;">
				
			</div>
		</header>
		<div id="list" class="container mt40">
			<c:if test="${adminNum==2}">
				<a style="color:#fff" href="${pageContext.request.contextPath}/log_set/chooseModel?setState=2">
					<div class="row bg-white pad15 mt20">
						<div class="font-16 col-xs-6" style="display: inline-block;color:#333">接收设置</div>
						<div class="col-xs-6"style="text-align: right;"><span class="glyphicon glyphicon-menu-right font-defalut " style="font-size: 2rem;color:#C0C0C0"></span> </div>
					</div>
				</a>
				<div class="row  pad15">
					<p class="font-13 font-tip"> 可设置不同模板下，接收日志时间、设置未发送人提醒。</p>
				</div>
			
				<a style="color:#fff" href="${pageContext.request.contextPath}/log_set/chooseModel?setState=1">
					<div class="row  bg-white pad15 mt20">
						<div class="font-16 col-xs-6" style="display: inline-block;color:#333">发送设置</div>
					<div class="col-xs-6"style="text-align: right;"><span class="glyphicon glyphicon-menu-right font-defalut " style="font-size: 2rem;color:#C0C0C0"></span> </div>
					</div>
				</a>
				<div class="row pad15">
					<p class="font-13 font-tip">可设置不同模板下，发送日报的时间、提醒时间及提醒方式。</p>
				</div>
			</c:if>
			<c:if test="${adminNum==1}">
				<a style="color:#fff" href="${pageContext.request.contextPath}/log_set/chooseModel?setState=2">
					<div class="row bg-white pad15 mt20">
						<div class="font-16 col-xs-6" style="display: inline-block;color:#333">接收设置</div>
						<div class="col-xs-6"style="text-align: right;"><span class="glyphicon glyphicon-menu-right font-defalut " style="font-size: 2rem;color:#C0C0C0"></span> </div>
					</div>
				</a>
				<div class="row  pad15">
					<p class="font-13 font-tip"> 可设置不同模板下，接收日志时间、设置未发送人提醒。</p>
				</div>
			</c:if>
			<c:if test="${adminNum==3}">
				<a style="color:#fff" href="${pageContext.request.contextPath}/log_set/chooseModel?setState=1">
					<div class="row  bg-white pad15 mt20">
						<div class="font-16 col-xs-6" style="display: inline-block;color:#333">发送设置</div>
					<div class="col-xs-6"style="text-align: right;"><span class="glyphicon glyphicon-menu-right font-defalut " style="font-size: 2rem;color:#C0C0C0"></span> </div>
					</div>
				</a>
				<div class="row pad15">
					<p class="font-13 font-tip">可设置不同模板下，发送日报的时间、提醒时间及提醒方式。</p>
				</div>
			</c:if>
		</div>
		
		<div id="tipMsg" class="log-tip">
					<p style="color: #fff;">消息发送成功</p>
				</div>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/bootstrap/js/bootstrap.min.js"></script>
		<script>
		$(document).ready(function() {
// 				$(".log-word").focus(function() {
// 					$(this).html("");
// 					//$(this).removeClass("font-gray-light");
// 				});
// 				$(".log-word").blur(function() {
// 					$(this).html("请输入文字");
// 					//$(this).addClass("font-gray-light");
// 				});

			//物理返回
			if (window.history && window.history.pushState) {
	            $(window).on('popstate', function () {
	            	
	                var hashLocation = location.hash;
	                var hashSplit = hashLocation.split("#!/");
	                var hashName = hashSplit[1];
	                if (hashName !== '') {
	                    var hash = window.location.hash;
	                    if (hash === '') {
	                    	window.location.href='${pageContext.request.contextPath }/log/index';
	                    }
	                }
	            });
	            window.history.pushState('forward', null, '#forward');
	        }
	});
	
</script>
	</body>
</html>