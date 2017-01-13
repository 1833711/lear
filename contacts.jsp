<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
		<title>日志 - 选择联系人</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
		<style>
		
		</style>
	</head>
	<body class="bg-gray">
		<header class="header bg-white" style="border-bottom: 1px solid #e7e7e7;" >
			<div class="header-left" >
				
			</div>
			<div class="header-center font-default" >选择联系人</div>
			<div class="header-right text-right" >
				<a class="color-contact" style="color: #fd6162;" href="javascript: cancel();">取消</a>
			</div>
		</header>
		<div class="container mt40">
			<div class="row org-name" >
				<c:forEach var="dept" items="${navDept}" varStatus="status">
					<c:if test="${dept.deptId eq nowDept.deptId}">
						  <a class="font-gray font-15">${dept.deptName}</a>
					</c:if>
				
					<c:if test="${dept.deptId ne nowDept.deptId}">
						<a class="font-gray font-15" href="javascript: go('${dept.deptId}');">
						  ${dept.deptName} 
						</a>
						
						<c:if test="${status.index < fn:length(navDept) - 1}">
							>
						</c:if>
					</c:if>
				</c:forEach>
			</div>
		</div>
		
		<div class="container mb40">
		
			<div id="checkAll" class="row contact-checkall" >
				<div class="contact-left" >
					<div class="checkboxChoice">
					    <p class="checkboxChoice-p"></p>
						<input id="checkboxAllInput" class="hidden" type="checkbox" value="1" name="checkboxAllInput" />
					</div>
					<div class="clearfix"></div>
				</div>	
				<div class="pull-left">
					<p class="font-16 ml10" >全选${next}</p>
				</div>
				<div class="clearfix"></div>
			</div>
			
			<c:if test="${fn:length(deptList) > 0}">
				<div class="row contact-check-dept" >
					<ul>
						<c:forEach var="dept" items="${deptList}">     
							<li <c:if test="${dept.next == 1}"> onclick="javascript: go('${dept.deptId}');" </c:if> >
								<div class="pull-left contact-all" >
									<div class="contact-dept" >
										<div class="pull-left">
											<p class="font-15">
												${dept.deptName}
												<c:if test="${dept.number > 0}">
													<span class="font-gray">(${dept.number})</span>
												</c:if>
											</p>
										</div>
										<div class="pull-right" >
											<span class="font-gray-light">|</span>
											<img class="contact-dept-img" src="${pageContext.request.contextPath}/resource/img/dept.png" />
										</div>
									</div>
								</div>
								<div class="clearfix"></div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
			
			<c:if test="${fn:length(userList) > 0}">
				<div class="row contact-check-user" >
					<ul>
						<c:forEach var="_user" items="${userList}">
							<li>
									<div class="contact-left" >
										<div class="checkboxChoice choice-user">
										    <p class="checkboxChoice-p"></p>
							  				<input id="ids_${_user.userId}" class="hidden" type="checkbox" value="${_user.userId}" name="ids" />
										</div>
									</div>	
									<div class="pull-left contact-user" >
										<div class="contact-user-icon" >
											<c:if test="${_user.userAvatar != null && _user.userAvatar != ''}">
												<p style="background: url(${_user.userAvatar});background-size: 30px 30px;"></p>
											</c:if>
											<c:if test="${_user.userAvatar == null || _user.userAvatar == ''}">
												<p style="background: ${_user.color};">
													<c:if test="${fn:length(_user.userNick) > 2}">
														${fn:substring(_user.userNick, 1, 3)}
													</c:if>
													<c:if test="${fn:length(_user.userNick) <= 2}">
														${_user.userNick}
													</c:if>
												</p>
											</c:if>
										</div>
									</div>
									<div class="pull-left contact-user-right" >
										<div >
											<p>
												<span class="font-16">${_user.userNick}</span>
												<!--
													<span class="contact-user-identity" style="background: #F0AD4E;">负责人</span>
													<span class="contact-user-identity" style="background: #31B0D5;">管理员</span>
												-->
											</p>
										</div>
									</div>
									<div class="clearfix"></div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>
		</div>	
		<div class="contact-footer" >
			<div id="userIcon">
				<p class="font-16 font-gray">请选择联系人</p>
			</div>
			<div class="pull-right">
				<form id="choiceSendUser" action="${pageContext.request.contextPath}/log/list" method="post">
					<button class="btn btn-contact" type="button" onclick="getSendUser()" >确定</button>
				</form>
			</div>
		</div>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js" ></script>
		
		<script>
			$(document).ready(function(){
				 
				$(".contact-check-user ul li").click(function(){
					var current=$(this).children(".contact-left").children(".checkboxChoice").children("input:checked");
					var ids=$(this).children(".contact-left").children(".checkboxChoice").children("input").val();
					if(current.length==0){
						$(this).children(".contact-left").children(".checkboxChoice").children("p").addClass("checkboxChoice-p-active");
						$(this).children(".contact-left").children(".checkboxChoice").children("input").prop("checked",true);
						var html='<input id="user_' + ids + '" type="hidden" name="senders" value="' + ids + '" />'
						$("#choiceSendUser").append(html);
						
					}else if(current.length==1){
						$(this).children(".contact-left").children(".checkboxChoice").children("p").removeClass("checkboxChoice-p-active");
						$(this).children(".contact-left").children(".checkboxChoice").children("input").prop("checked",false);
						$("#user_" + ids).remove();
					}
					
					var allChoice=$(".contact-check-user ul li").children(".contact-left").children(".checkboxChoice").children("input:checked");
					var all=$(".contact-check-user ul li").children(".contact-left").children(".checkboxChoice").find("input");
					
					if(allChoice.length==all.length){
						$("#checkAll").children(".contact-left").children(".checkboxChoice").children("p").addClass("checkboxChoice-p-active");
						$("#checkAll").children(".contact-left").children(".checkboxChoice").children("input").prop("checked",true);
					}else{
						$("#checkAll").children(".contact-left").children(".checkboxChoice").children("p").removeClass("checkboxChoice-p-active");
						$("#checkAll").children(".contact-left").children(".checkboxChoice").children("input").prop("checked",false);
					}
					
				});
				
				//全选
				$("#checkAll").click(function(){
					var count=$(this).children(".contact-left").children(".checkboxChoice").children("input:checked");
					var cur=$(this).children(".contact-left").children(".checkboxChoice").children("input").val();
					if(count.length==0){
						$(this).children(".contact-left").children(".checkboxChoice").children("p").addClass("checkboxChoice-p-active");
						$(this).children(".contact-left").children(".checkboxChoice").children("input").prop("checked",true);
						var leng=$(".contact-check-user").children("ul").children("li").children(".contact-left").children(".checkboxChoice").find("input");
						$.each(leng,function(i,v){
							$(v).prop("checked",true);
							$(v).siblings("p").addClass("checkboxChoice-p-active");
							var ids=$(v).val();
							var html='<input id="user_' + ids + '" type="hidden" name="senders" value="' + ids + '" />'
							$("#choiceSendUser").append(html);
							$("#user_" + cur).remove();
						});
					}else if(count.length==1){
						$(this).children(".contact-left").children(".checkboxChoice").children("p").removeClass("checkboxChoice-p-active");
						$(this).children(".contact-left").children(".checkboxChoice").children("input").prop("checked",false);
						var leng=$(".contact-check-user").children("ul").children("li").children(".contact-left").children(".checkboxChoice").find("input");
						$.each(leng,function(i,v){
							$(v).prop("checked",false);
							$(v).siblings("p").removeClass("checkboxChoice-p-active");
							var ids=$(v).val();
							$("#user_" + ids).remove();
							$("#user_" + cur).remove();
						});
					}
				});
				
			});
			
			function cancel(){
				if(window.confirm("确认退出此操作吗？")){
					window.location.href="${pageContext.request.contextPath}/log/list";
	             	return true;
	           	}else{
	            	return false;
	        	}
			}
			
			function go(id){
				window.location.href="${pageContext.request.contextPath}/log/contacts?did="+id;
			}
			
			function getSendUser(){
				var user=$(".contact-check-user ul li").children(".contact-left").children(".checkboxChoice").children("input:checked");
				if(user.length>0){
					$("#choiceSendUser").submit();
				}else{
					alert("请选择联系人");
				}
				
			}
			
		</script>
	</body>
</html>