<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
		<title>日志-选择模板</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/index.css" />
		<style>
		</style>
	</head>
	<body class="bg-gray">
		<header class="header bg-log text-center" >
			<a style="color:#fff" href="${pageContext.request.contextPath }/log_set/log_set">
			<div class="header-left" >
				<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;"></span>
			</div>
			<span style="display: inline-block;margin-top: 6px;float:left;font-size:1.4rem;">返回</span>
			</a>
			<div class="header-center font-white" >选择模板</div>
			<div class="header-right text-right font-14" style="width: 40px;">
			</div>
		</header>
		<div id="list" class="container mt40">
		<c:forEach var="model" items="${list}">
			<a href="${pageContext.request.contextPath}${setUrl}?modelId=${model.modelId}&&modelName=${model.modelName}&&setState=${setState}" style="color:#333">
			<div class="row  bg-white pad10  border-b" style="padding-left: 20px;">
				<div class="font-16 col-xs-12" style="display: inline-block;padding: 0;">
					<img src="${model.logo}" width="35px" height="35px" />
					<span class="ml10">${model.modelName}</span>
				</div>
				<%-- <div class="col-xs-1">
					<img src="${pageContext.request.contextPath }/resource/img/Line.png" width="20px" height="20px" style="margin-top: 12px;"/>
				</div> --%>
			</div>
			</a>
		</c:forEach>
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
	                    	window.location.href='${pageContext.request.contextPath }/log_set/log_set';
	                    }
	                }
	            });
	            window.history.pushState('forward', null, '#forward');
	        }
	});
	
</script>
	</body>
</html>