<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
<title>日志 - 发起日志</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/autosize.js"></script>
<style>
a:focus, a:hover, a:active {
	color: #fff;
}
</style>
<script>
	$(document).ready(function() {
		var inputW = document.documentElement.clientWidth
				- $(".log-label").width() - 60;
		$(".log-input").width(inputW);
		autosize(document.querySelectorAll('textarea'));
		$(".log-word").focus(function() {
			$(this).html("");
			$(this).removeClass("font-gray-light");
		});
		$(".log-word").blur(function() {
			$(this).html("请输入文字");
			$(this).addClass("font-gray-light");
		});
	});
</script>

</head>
<body class="bg-gray">
	<header class="header bg-log">
		<div class="header-left">
			<a id="goBack" class="font-white"> 
				<span class="glyphicon glyphicon-menu-left"></span> 
				<span>发起日志</span>
			</a>
		</div>
		<div class="header-center font-white"></div>
		<div class="header-right text-right">
			<a href="">选择模板</a>
		</div>
	</header>
	<div class="container mt40">
		<div class="row">
			<p class="log-type" style=""></p>
		</div>
		<form>
			<div class="row bg-white pl20">
				<div class="log-work">
					<div class="pull-left log-label">
						<p>今日完成工作</p>
					</div>
					<div class="pull-left pl15">
						<textarea class="log-input font-gray-light log-word">请输入文字</textarea>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="row bg-white pl20">
				<div class="log-work">
					<div class="pull-left log-label">
						<p>未完成工作</p>
					</div>
					<div class="pull-left pl15">
						<textarea class="log-input font-gray-light log-word">请输入文字</textarea>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="row bg-white pl20">
				<div class="log-work">
					<div class="pull-left log-label">
						<p>需协调工作</p>
					</div>
					<div class="pull-left pl15">
						<textarea class="log-input font-gray-light log-word">请输入文字</textarea>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
			<div class="row bg-white pl20">
				<div class="log-work-mark">
					<div class="pull-left">
						<textarea class="log-remark font-gray-light log-mark">备注</textarea>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>

			<div class="row bg-white log-choice-img">
				<a href="javascript:;" class="file"> <input type="file" name="" id="">
				</a>
			</div>
			<div class="row bg-white log-rcv-user">
				<p>
					<span class="font-16">日志接收人</span> <span class="font-gray-light">(点击头像删除)</span>
				</p>
				<div class="add-rcv-user">
					<div>
						<img class="img-circle" src="${pageContext.request.contextPath}/resource/img/ceshi.png" />
					</div> 
					<a href="${pageContext.request.contextPath}/log/contacts?oid="> <img class="add-rcv-default"
						src="${pageContext.request.contextPath}/resource/img/rizhi_jia.png" />
					</a>
				</div>
			</div>
			<div class="row log-location">
				<p>
					<img src="${pageContext.request.contextPath}/resource/img/local_rizhi.png" /> <span class="ml10">所在位置</span>
				</p>
			</div>
		</form>
	</div>

	<div class="log-footer">
		<button class="btn log-submit">提交</button>
	</div>
	<script>
		$(document).ready(function() {
			var inputW = document.documentElement.clientWidth - 35;
			$(".log-remark").width(inputW);
			$(".log-remark").height(70);

			$(".log-remark").focus(function() {
				$(this).html("");
				$(this).removeClass("font-gray-light");
			});
			$(".log-remark").blur(function() {
				$(".log-remark").text("备注");
				$(this).addClass("font-gray-light");
			});
		});
	</script>

</body>
</html>