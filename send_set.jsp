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
		<title>日志-发送设置</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/index.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resource/css/mobiscroll.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resource/css/mobiscroll.frame.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resource/css/mobiscroll_date.css" />
		<style>
		.dwbc-p .dwbw{
		width:50%;
		}
		.dwb-n{
		display:none;
		}
		
		</style>
	</head>
	<body class="bg-gray">
		<input type="hidden" id="pathName" value="${pageContext.request.contextPath }">
		<input type="hidden" id="weekNum" value="0">
		<header class="header bg-log text-center" >
			<a style="color:#fff" href="${pageContext.request.contextPath }/log_set/chooseModel?setState=${bcakNum}">
			<div class="header-left" >
				<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;"></span>
			</div>
			<span style="display: inline-block;margin-top: 6px;float:left;font-size:1.4rem;">返回</span>
			</a>
			<div class="header-center font-white">${modelName}</div>
			<a href="javascript:addlogset('${bcakNum}')">
				<div class="header-right text-right font-14" style="width: 40px;color:#fff">
					完成
				</div>
			</a>
		</header>
		<div id="list" class="container mt40">
			<div class="row  bg-white pad15 border-b" style="line-height: 32px;">
				<div class="font-16 col-xs-10" style="display: inline-block;padding: 0;">发送提醒</div>
				<div class="col-xs-2" style="text-align: right;padding: 0;">
					<img id="Unsub" src="${pageContext.request.contextPath }/resource/img/sub.png" alt="${pageContext.request.contextPath }/resource/img/unsub.png" width="50px" onclick="openSend()" />
				</div>
			</div>
			<div class="row  bg-white pad15  border-b" id="approval_type">
				<div class="font-16 col-xs-11" style="display: inline-block;padding: 0;"><span>提醒周期 </span><span id="datashow" style="float:right;font-size: 1.6rem;color:#C0C0C0">请选择</span></div>
				<div class="col-xs-1"style="text-align: right;padding: 0;">
					<span class="glyphicon glyphicon-menu-right font-defalut " style="font-size: 2rem;color:#C0C0C0"></span> 
				</div>
			</div>
			<div class="row  bg-white pad15 border-b">
				<div class="font-16 col-xs-11" style="display: inline-block;padding: 0;">提醒时间
					<span class="apptime" style="float:right;font-size: 1.6rem;color:#C0C0C0">
		 				
		 			</span>
					<input onchange="app()" class="" readonly="readonly" name="appTime" value="请选择" id="appTime" type="text" >
				</div>
				<div class="col-xs-1"style="text-align: right;padding: 0;">
					<span class="glyphicon glyphicon-menu-right font-defalut jiantou" style="font-size: 2rem;color:#C0C0C0"></span> 
				</div>
			</div>
			<div class="row  bg-white pad15 " id="mode">
				<div class="font-16 col-xs-11" style="display: inline-block;padding: 0;">提醒方式<span class="alert_show" style="font-size: 1.6rem;color:#C0C0C0;float:right;">请选择</span></div>
				<div class="col-xs-1"style="text-align: right;padding: 0;">
					<span class="glyphicon glyphicon-menu-right font-defalut " style="font-size: 2rem;color:#C0C0C0"></span>
				</div>
			</div>
		</div>
		<form id="setsubmit">
			<input type="hidden" id="setWay"  value="1"  name="setWay">
			<input type="hidden" id="modelId"  name="modelId" value="${modelId}">
			<input type="hidden" id="setCycle" name="setCycle">
			<input type="hidden" id="setTime"  name="setTime" >
		</form>
		<!--星期-->
		<div class="approval-leave-type"  >
			<div class="approval-leave-bg" ></div>
			<div class="approval-leave-choice"  style="height: 67%;">
			    <div class="row" style="height: calc(100% - 50px);padding: 0 25px;border: none;overflow-y: auto;overflow-x: hidden;"></div>
			  <div class="row" id="submti_button" style="border:none;margin:0 ;border-top: 1px solid #e7e7e7;">
			    	<span id="queding" class="col-xs-6 text-center" style="border-right: 1px solid #e7e7e7;">
			    		确定
			    	</span>
			    	<span id="quxiao" class="col-xs-6 text-center">
			    		取消
			    	</span>
			    </div>
			</div>
		</div>
	
		<!--方式-->
		<div class="alert_mode" >
			<div class="approval-leave-bg" ></div>
			<div class="approval-leave-choice" style="top:62%">
			    <div class="font-16">
			    	应用内消息推送
			    </div>
			    <div class="font-16" style="border:none">
			    	短信
			    </div>
			    <!-- <div class="font-16">
			    	电话
			    </div> -->
			</div>
		</div>
		<div id="tipMsg" class="log-tip" style="top: 60%; display:none;width: 252px;left: 42.5%;">
			<p class="font-14" style="color: #fff;">没有进行模板设置，不能进行此操作</p>
		</div>
		<!-- 天 -->
			<div class="approval-tima" style="display: none;">
					<div class="approval-leave-bg"></div>
					<div class="approval-leave-choice text-center"style="margin-top:-50px;width:80%;margin-left:10%;border:none" >
					<div class="font-16"style="text-align:left;" id="approvaltime"></div>
					<div class="font-16" style="color:#fd6162;border:none;" id="yes">确定</div>
					</div>
			</div>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/jquery.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/resource/bootstrap/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath }/resource/js/mobiscroll.frame.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/resource/js/mobiscroll_date.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/resource/js/mobiscroll.js" type="text/javascript" charset="utf-8"></script>
		<script src="${pageContext.request.contextPath }/resource/js/send.js" type="text/javascript" charset="utf-8"></script>
		<script>
		
			$(document).ready(function(){
				$("#yes").click(function(){
					$(".approval-tima").css("display","none");
				})
			    var arr=["周一","周二","周三","周四","周五","周六","周日"]
				if($(".header-center").text()=="月报"){
				
						var op='<div class="border-b font-16 text-center bg-white" style="color:#5ec9f7;height:50px;line-height:50px; position: absolute; width: 95%;z-index:1;">请选择日期</div><div class="border-b" onclick="radio(this)" style="height:50px;line-height:50px;margin-top:50px"><span class="font-16">1日</span><div class="checkboxChoice pull-right" style="margin: 0;display:none"><p class="checkboxChoice-p" style="right:10px;top: 14px;" ></p><input type="radio"  class="hidden"  id="num_1" value="01" name="leave"></div></div>';
						for (var i=2;i<=31;i++) {
							var id="num_"+i;
							 var d;
							 if(i<10){
							 	d="0"+i;
							 }else{
							 	d=i;
							 }
							op +='<div class="border-b" onclick="radio(this)" style="height:50px;line-height:50px;"><span class="font-16">'+i+'日</span><div class="checkboxChoice pull-right" style="margin: 0;display:none"><p class="checkboxChoice-p" style="right:10px;top: 14px;" ></p><input type="radio"  class="hidden"  id="'+id+'" value="'+d+'" name="leave"></div></div>';
						}
						$(".approval-leave-choice .row").eq(0).prepend(op);
						$("#submti_button").hide();
						$(".approval-leave-choice .row").css("height","100%")
				}
				
				if($(".header-center").text()=="日报"){
						var op='<div class="border-b"  onclick="check(this)" style="height:50px;line-height:50px;" ><span class="font-16">周一</span><div class="checkboxChoice pull-right" style="margin: 0;"><p class="checkboxChoice-p" style="right:10px;top: 14px;"></p><input type="text"  class="hidden"  id="num_1" value="1" name="leave"></div></div>';
						for (var i=1;i<arr.length;i++) {
							var id="num_"+(i+1);
							var num=i+1;
							op+='<div class="border-b"  onclick="check(this)" style="height:50px;line-height:50px;"><span class="font-16">'+arr[i]+'</span><div class="checkboxChoice pull-right" style="margin: 0;"><p class="checkboxChoice-p" style="top: 14px;right:10px"></p><input type="text" class="hidden"  id="'+id+'" value="'+num+'" name="leave"></div></div>'
						}
					$(".approval-leave-choice").css("height","")
					$(".approval-leave-choice .row").eq(0).prepend(op);
				}
				if($(".header-center").text()=="周报"){
						var op='<div class="border-b" onclick="radioweek(this)" style="height:50px;line-height:50px;"><span class="font-16">周一</span><div class="checkboxChoice pull-right" style="margin: 0;display:none"><p class="checkboxChoice-p" style="right:10px;top: 14px;" ></p><input type="radio"  class="hidden"  id="num_1" value="1" name="leave"></div></div>';
						for (var i=1;i<arr.length;i++) {
							var id="num_"+(i+1);
							var num=i+1;
							op +='<div class="border-b" onclick="radioweek(this)" style="height:50px;line-height:50px;"><span class="font-16">'+arr[i]+'</span><div class="checkboxChoice pull-right" style="margin: 0;display:none"><p class="checkboxChoice-p" style="right:10px;top: 14px;"></p><input type="radio"  class="hidden"  id="'+id+'" value="'+num+'" name="leave"></div></div>';
						}
					$(".approval-leave-choice").css("height","")
					$("#submti_button").hide();
					$(".approval-leave-choice .row").eq(0).prepend(op);
				}
				$("#approval_type").click(function(){
					$(".approval-leave-type").show();
				});
				
				$("#mode").click(function(){
					$(".alert_mode").show();
				});
				$(".alert_mode .approval-leave-choice div").click(function(){
					var arr=$(this).text();
					$(".alert_show").text(arr);
					$(".alert_mode").hide();
				});
				$(".jiantou").click(function(){
				$("#appTime").focus();
				});
			});
			$(function() {
				var currYear = (new Date()).getFullYear();
				var opt = {};
				opt.date = {
					preset: 'date'
				};
				opt.datetime = {
					preset: 'datetime'
				};
				opt.time = {
					preset: 'time'
				};
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
				//物理返回
			if (window.history && window.history.pushState) {
	            $(window).on('popstate', function () {
	            	
	                var hashLocation = location.hash;
	                var hashSplit = hashLocation.split("#!/");
	                var hashName = hashSplit[1];
	                if (hashName !== '') {
	                    var hash = window.location.hash;
	                    if (hash === '') {
	                    	window.location.href='${pageContext.request.contextPath }/log_set/chooseModel?setState=${bcakNum}';
	                    }
	                }
	            });
	            window.history.pushState('forward', null, '#forward');
	        	}
			});
			function app(){
				$('.apptime').text($('#appTime').val());
				}
		</script>
	</body>
</html>