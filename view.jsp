<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
		<title>日志报表</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobiscroll.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/mobiscroll_date.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js" ></script>
		<style type="text/css">
			.table>thead>tr>td{
				vertical-align: inherit;
				word-wrap:break-word;
				word-break: break-all; 
			}
			.table-bordered>thead>tr>td{
			    border-bottom-width: 1px;
			}
			.wid{
			max-width: 770px;
			}
		</style>
		
		<script type="text/javascript">
			/* $(document).ready(function(){
				var windowW=document.body.clientWidth-(16*12)-12;
				$(".log-table-time").width(windowW*0.15);
				$(".log-table-user").width(windowW*0.13);
				$(".log-table-complete").width(windowW*0.19);
			}); */
		</script>
		
	</head>
	<body class="bg-gray">
		<header class="header bg-log" >
		<a href="${pageContext.request.contextPath}/log/index">
			<div class="header-left" >
				<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;color:white"></span>
				
			</div>
			<span class="ml5" style="color:white">${model.modelName}-日志报表</span>
			</a>
			<div class="header-center"></div>
			<div class="header-right text-right" >
				<p id="logOpenFilter" >筛选</p>
			</div>
		</header>
		<div class="container font-15 mt40" >
			<div class="row">
			   	<table class="table table-bordered" style="max-width: 770px">
			      	<thead class="table-top " style="max-width: 770px">
			         	<tr id="tableHead" style="max-width: 770px">
				            <td class="log-table-user text-center bg-gray" style="width:10%;min-width:48px">填报人</td>
				            <td class="log-table-time text-center bg-gray" style="width:10%;min-width:48px">填报时间</th>
				            
				            <c:forEach var="item" items="${items}" varStatus="status" >
								<c:if test="${!status.last}">
									 <td class="log-table-complete text-center bg-gray" style="width:20%;min-width:95px ">${item.itemLabel}</td>
								</c:if>
								<c:if test="${status.last}">
									 <td class="log-table-time text-center bg-gray" style="width:20%;min-width:95px">${item.itemLabel}</td>
								</c:if>
							</c:forEach>
			         	</tr>
			      	</thead>
			      	<tbody id="tableBody" style="max-width:770px;">
			      		<c:forEach var="log" items="${list}" varStatus="status">
				      		<tr class="wid">
					            <td class="log-table-user bg-white" style="width:10%;min-width:48px">
					            	<p>
					            	<c:if test="${fn:length(log.userNick) > 2}">
												${fn:substring(log.userNick, 1, 3)}
									</c:if>
										<c:if test="${fn:length(log.userNick) <= 2}">
													${log.userNick}
										</c:if>
					            	</p>
					            </td>
					            <td class="log-table-time bg-white" style="width:10%;min-width:48px">
					            	<p><fmt:formatDate value="${log.submitTime}" pattern="MM月dd日 HH:mm"/></p>
					            </td>
					            <c:forEach var="field" items="${log.fields}" varStatus="status">
					            	<c:if test="${!status.last}">
										 <td class="log-table-complete bg-white" style="width:20%;min-width:95px">
										 	<p>${field}</p>
										 </td>
									</c:if>
									<c:if test="${status.last}">
										 <td class="log-table-time bg-white" style="width:20%;min-width:95px">
										 	<p>${field}</p>
										 </td>
									</c:if>
					            </c:forEach>
				         	</tr>
			      		</c:forEach>
			      		
			
			      		
			      	</tbody>
			   	</table>
			</div>
			<!-- 筛选 -->
			<div id="logFilter" class="row">
				
				<div class="log-filter" >
					
					<form id="filterForm" action="${pageContext.request.contextPath}/log/view" method="post">
						<input id="modelId" type="hidden" name="modelId">
						<div class="log-filter-time" >
							<div class="log-choice-time" >
								<img src="${pageContext.request.contextPath}/resource/img/time-log-report.png" />
								<span >选择时间</span>
							</div>
							<div class="log-report-time" >
								<input id="startDate" class="log-start-time" name="startDate" value="${startDate}" />
								<div class="log-line" ></div>
								<input id="endDate" class="log-stop-time" name="endDate" value="${endDate}" />
							</div>
							<div class="clearfix"></div>
						</div>
						
						<div class="log-report-mouble" >
							<img src="${pageContext.request.contextPath}/resource/img/time-log-mould.png" />
							<span>选择模板</span>
						</div>
						
						<div class="log-choice-mouble" >
							<ul>
								<c:forEach var="m" items="${modelList}" varStatus="status">
									<li <c:if test="${m.modelId eq model.modelId}"> style="color: #fff;background: #32a2ee;"</c:if> >
										${m.modelName}
										<input id="modelId_${status.index}" type="hidden" value="${m.modelId}">
									</li>
								</c:forEach>
							</ul>
						</div>
						
						<div class="text-center mt20" >
							<button type="button" class="btn btn-close" onclick="colseFilter()">取消</button>
							<button type="button" class="btn btn-report ml20" onclick="checkTime()" >确定</button>
						</div>
					</form>
				</div>
				
				<!-- 提示信息 -->
				<div id="tipMsg" class="log-tip" >
					<p style="color: #fff;">结束时间不能小于开始时间</p>
				</div>
				
			</div>	
			
		</div>
		
		<!-- 导出 hidden 隐藏 -->
		<div class="log-export hidden" >
			<p>导出</p>
		</div>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/mobiscroll_date.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/mobiscroll.js" ></script>
		
		<script>

			$(document).ready(function(){
			         	 var h_1=$("#tableHead td").eq(0).height();
			         	$("#tableBody").css("margin-top",h_1); 
			         	var w_1=$(".table-top ").width();
			         	$("#tableBody").width(w_1);
				if (window.history && window.history.pushState) {
		            $(window).on('popstate', function () {
		                var hashLocation = location.hash;
		                var hashSplit = hashLocation.split("#!/");
		                var hashName = hashSplit[1];
		                if (hashName !== '') {
		                    var hash = window.location.hash;
		                    if (hash === '') {
		                    	window.location.href = '${pageContext.request.contextPath}/log/index';
		                    }
		                }
		            });
		            window.history.pushState('forward', null, '#forward');
		        }
				
				$("#logOpenFilter").show();
				$("#logOpenFilter").click(function(){
					$("#logFilter").show();
					$(this).hide();
				});
				
				//默认选中的类型值
				var modelType=$(".log-choice-mouble ul li").find("input");
				var modelLi=$(".log-choice-mouble ul").find("li");
				for(var i=0;i<modelLi.length;i++){
					if(modelLi[i].style.background=="rgb(50, 162, 238)"){
						$("#modelId").val(modelType[i].value);
					}
				}	
				
				//选择类型
				$(".log-choice-mouble ul li").click(function(){
				
					$(this).css("color","#fff");
					$(this).css("background","#32a2ee");
					$(this).siblings("li").css("background","#e7e7e7");
					$(this).siblings("li").css("color","#333333");
					
					$("#modelId").val($(this).children("input").val());
					
				});
				
				var currYear = (new Date()).getFullYear();	
				$('#startDate').scroller(
					$.extend(
						{preset : 'date'}, 
						{ theme: "android-ics light", 
							mode: "scroller", 
							display: 'modal', 
							lang: 'zh',
							dateFormat : "yy-mm-dd",
							showNow: true,
							nowText: "今天",
							startYear: currYear, //开始年份
							endYear: currYear //结束年份
						}
					)
				);
				
				$('#endDate').scroller(
					$.extend(
						{preset : 'date'}, 
						{ theme: "android-ics light", 
							mode: "scroller", 
							display: 'modal', 
							lang: 'zh',
							dateFormat : "yy-mm-dd",
							showNow: true,
							nowText: "今天",
							startYear: currYear, //开始年份
							endYear: currYear //结束年份
						}
					)
				);
			
			});
			
			function showTip(){
				$('#tipMsg').show();
				setTimeout("$('#tipMsg').hide();",3000);
			}
			
			function checkTime(){
				//判断前一个日期是否大于后一个日期，如果大于显示提示信息
				var start=$("#startDate").val();
				var end=$("#endDate").val();
				if(start > end){
					showTip();
				}else{
					$("#filterForm").submit();
				}
			}
			
			function colseFilter(){
				$("#logFilter").hide();
				$("#logOpenFilter").show();
			}
		
		</script>
	</body>
</html>