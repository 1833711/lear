<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
		<title>日志</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/log-linkme.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/mobiscroll.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/mobiscroll.frame.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/mobiscroll_date.css"/>
	</head>
	<style type="text/css">

	</style>
	<script>
	</script>

	<body class="bg-gray">
		<form id="setsubmit">
			<input type="hidden" id="pathName" value="${pageContext.request.contextPath}">
			<input type="hidden" id="dataNum"  value="0">
			<input type="hidden" id="modelId" name="modelId">
			<input type="hidden" id="remind" name="remind" >
			<input type="hidden" id="phones" name="modlies">
		</form>
		<header class="header bg-approval text-center">
			<a style="color:#fff" href="${pageContext.request.contextPath}/log/index">
				<div class="header-left">
					<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;"></span>
				</div>
				<span style="display: inline-block;margin-top: 6px;float: left;font-size:1.4rem">返回</span>
			</a>
			<div class="header-center font-white">
				<span class="selsct_title">日报</span><span class="glyphicon glyphicon-chevron-down av" style="top: 4px;color: #FFFFFF;margin-left: 5px;"></span>
			
			</div>
			<div class="header-right text-right font-14">
				<a href="javascript:void(0)"><label for="appDate" style="font-weight: 400;">日期</label>
			<input  class="" readonly="readonly" name="appDate" id="appDate" onchange="neirong(this)" type="text" style="position: absolute;left: 100%; top: 3px; background: transparent;width: 0px; border: none; color: transparent;">
		</a>
			</div>
			<div class="down_selsct bg-white" style="display: none;">
			<div class="border-b checkcl">日报</div>
			<input type="hidden" value="${dateinfo}" id="dateinfo" >
			<div class="border-b">周报</div>
			<input type="hidden" value="${weekinfo}" id="weekinfo" >
			<div>月报</div>
			<input type="hidden" value="${monthinfo}" id="monthinfo" >
		</div>
		</header>
		<form id="userlist" action="${pageContext.request.contextPath}/lot_set/userlist">
			<input type="hidden" name="timeinfo" id="timeinfo">
			<input type="hidden" name="modelId" id="modelId">
		</form>
		<div class="container mt40 ">
		
			<div class="row tab-read bg-white">
				<div id="sendPeople" class="col-xs-6 text-center tab-read-borr tab-sendPeople" onclick="sendlog(id,'');">
					<span class="font-16">已发送人</span>
				</div>
				<div id="unsendPeople" class="col-xs-6 text-center tab-read-borr " onclick="unsendlog(id,'');">
					<span class="font-16">未发送人</span>
					
				</div>
			</div>
				<div class="row font-14 font-tip">
				<p style="padding: 5px 0px 5px 20px;" id="nowtime" class="shijai"></p>
			</div>
			<div id="unsendContent" class="row" style="display: block;">
				<ul id="looker_list" class="verticalList  tb-boder" style="display: block;">
				</ul>
			</div>
			<!--未发送联系人-->
			<div id="sendContents" class="row" style="display:none;">
					<div id="checkAll" class="contact-checkall" >
						
					</div>
				<ul id="unlooker_list" class="col-xs-12 verticalList  b-boder " style="display: block;margin-bottom:50px;padding:0">
				
				</ul>
				
				
				<div class="unsendContent-footer ">
						<div id="dang" class="col-xs-12 text-center" style="color: #5ec9f7;line-height: 50px;">
							<span style="font-size: 1.8rem;">DANG一下</span>
						</div>
				</div>
			</div>
		</div>
		<!-- 提示信息 -->
		<div id="tipMsg" class="log-tip">
			<p style="color: #fff;">消息发送成功</p>
		</div>
		<div id="tipMsgError" class="log-tip">
			<p style="color: #fff;">消息发送失败</p>
		</div>
		<!--方式-->
		<div class="alert_mode" >
			<div class="approval-leave-bg" > </div>
			<div class="approval-leave-choice" style="top: 78%;">
			    <div class="font-16">
			    	应用内推送
			    </div>
			    <div class="font-16">
			    	短信
			    </div>
			    <!-- <div class="font-16">
			    	电话
			    </div> -->
			</div>
		</div>
		<!--下拉选项-->
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.lazyload.min.js"></script>
		<script src="${pageContext.request.contextPath}/resource/js/mobiscroll.frame.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/resource/js/mobiscroll_date.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/resource/js/mobiscroll.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/resource/js/log_set.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath}/resource/js/alert.js" type="text/javascript" charset="utf-8"></script>
		<script>
			$(document).ready(function() {
				var browser = {
					versions: function() {
						var u = navigator.userAgent,
							app = navigator.appVersion;
						return { //移动终端浏览器版本信息 
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
				} else if (browser.versions.android) {
					$("#appointed").val("android");
				}
				
			});
			 $(function () {
			var currYear = (new Date()).getFullYear();	
			var opt={};
			opt.date = {preset : 'date'};
			opt.datetime = {preset : 'datetime'};
			opt.time = {preset : 'time'};
			opt.default = {
				theme: 'android-ics light', //皮肤样式
		        display: 'modal', //显示方式 
		        mode: 'scroller', //日期选择模式
				dateFormat: 'yyyy-mm-dd',
				lang: 'zh',
				showNow: true,
				nowText: "今天",
		        startYear: currYear - 10, //开始年份
		        endYear: currYear + 10 //结束年份
			};
		  	$("#appDate").mobiscroll($.extend(opt['date'], opt['default']));
		  	var optDateTime = $.extend(opt['datetime'], opt['default']);
		  	var optTime = $.extend(opt['time'], opt['default']);
		    $("#appDateTime").mobiscroll(optDateTime).datetime(optDateTime);
		    $("#appTime").mobiscroll(optTime).time(optTime);
        });
		
		$(document).ready(function() {
			if (window.history && window.history.pushState) {
	            $(window).on('popstate', function () {
	                var hashLocation = location.hash;
	                var hashSplit = hashLocation.split("#!/");
	                var hashName = hashSplit[1];
	                if (hashName !== '') {
	                    var hash = window.location.hash;
	                    if (hash === '') {
	                    	window.location.href='${pageContext.request.contextPath}/log/index';
	                    }
	                }
	            });
	            window.history.pushState('forward', null, '#forward');
	        }
		});
		$(".approval-leave-bg").click(function(){
		$(".alert_mode").css("display","none");
		})
		</script>
	</body>

</html>