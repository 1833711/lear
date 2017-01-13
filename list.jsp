<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
		<title>日志 - 所有日志</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
	</head>
	<body class="bg-gray">
		<header class="header bg-log" >
			<div class="header-left-list " >
				<c:if test="${fn:length(senders) == 1}">
						<a href="${pageContext.request.contextPath}/log/list">
					<div class="header-left">
						<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 3px; color:white"></span>
					</div>
					
					<c:if test="${sendUser != null}">
					<span style="display: inline-block;margin-top: 4px;color:white">
						<c:if test="${fn:length(sendUser.userNick) >= 5}">
							${fn:substring(sendUser.userNick, 1, 5)}的日志 
						</c:if>
						<c:if test="${fn:length(sendUser.userNick) < 5}">
							${sendUser.userNick}的日志 
						</c:if>
					</c:if>
					<c:if test="${sendUser == null}">
						工作日志
					</c:if>
					</span>
				</c:if>
				</a>
				
				<c:if test="${fn:length(senders) != 1}">
					<a href="${pageContext.request.contextPath}/log/index">
					<div class="header-left" >
						<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;color:white"></span>
						
					</div>
					<span style="display: inline-block;margin-top: 4px;color:white">工作日志</span>
					</a>
					
				</c:if>
			</div>
			<div class="header-right text-right" >
				<c:if test="${type != 1}">
					<P><span id="reads">全部已读</span><span id="sifiings">筛选</span></P>
				</c:if>
			</div>
		</header>
		<div class="container mt40" >
			<form id="dataform" action="${pageContext.request.contextPath}/log/list" method="post">
				<input id="type" type="hidden" name="type" value="${type}">
				<input id="state" type="hidden" name="state" value="${state}">
				
				<c:forEach var="sender" items="${senders}" varStatus="status">
					<input type="hidden" name="sendUser" value="${sender}">
				</c:forEach>
				
				<input id="numPerPage" type="hidden" name="numPerPage" value="${pager.numPerPage}">
				<input id="totalCount" type="hidden" name="totalCount" value="${pager.totalCount}">
				<input id="pageCount" type="hidden" name="pageCount" value="${pager.pageCount}">
			</form>
			<div class="row tab-read" >
				<div id="logRcv" class="col-xs-6 text-center tab-read-borr tab-from-active" onclick="javascript:logActive('logRcv');">
					<span class="font-16">我收到的</span>
				</div>
				<div id="logFrom" class="col-xs-6 text-center " onclick="javascript:logActive('logFrom');">
					<span class="font-16">我发出的</span>
				</div>
			</div>
			
			
			<div id="logRcvContent" class="row">
			<c:if test="${fn:length(pager.list) > 0}">
				<ul id="list">
					<c:forEach var="log" items="${pager.list}">
						<li class="log-content" >
							<div class="row log-from-user" >
								<div class="col-xs-6" >
									<c:if test="${type == 0}">
										<a href="${pageContext.request.contextPath}/log/list?type=0&sendUser=${log.user.userId}" >
									</c:if>
									<c:if test="${type == 1}">
										<a href="${pageContext.request.contextPath}/log/content?lid=${log.logId}&state=${state}&type=${type}">
									</c:if>
										<c:if test="${log.user.userAvatar != null && log.user.userAvatar != ''}">
											<div class="log-from-user-icon"><img class="img-circle" src="${log.user.userAvatar}" /></div>
										</c:if>
										<c:if test="${log.user.userAvatar == null || log.user.userAvatar == ''}">
											<div class="log-from-user-icon"  style="background: ${log.user.color}" >
											<span>
												<c:if test="${fn:length(log.user.userNick) > 2}">
													${fn:substring(log.user.userNick, 1, 3)}
												</c:if>
												<c:if test="${fn:length(log.user.userNick) <= 2}">
													${log.user.userNick}
												</c:if>
											</span>
											</div>
										</c:if>
									</a>
									
									<a href="${pageContext.request.contextPath}/log/content?lid=${log.logId}&state=${state}&type=${type}" class="log-from-user-name" >
										<c:if test="${fn:length(log.user.userNick) >= 5}">
											${fn:substring(log.user.userNick, 1, 5)}
										</c:if>
										<c:if test="${fn:length(log.user.userNick) < 5}">
											${log.user.userNick}
										</c:if>
									</a>
								</div>
								<a href="${pageContext.request.contextPath}/log/content?lid=${log.logId}&state=${state}&type=${type}">
									<div class="col-xs-6 text-right" >
										
											<c:if test="${type != 1}">
												<c:if test="${log.userReads != null && fn:length(log.userReads) > 0}">
													<c:set var="read" value="未读"/>
													<c:forEach var="user" items="${log.userReads}">
														<c:if test="${user.userId eq userId}">
															<c:set var="read" value="已读" />
														</c:if>
													</c:forEach>
													<c:if test="${read == '未读'}">
														<span>未读</span>
													</c:if>
													<c:if test="${read == '已读'}">
														<span class="font-gray">已读</span>
													</c:if>
												</c:if>
												<c:if test="${log.userReads == null || fn:length(log.userReads) <= 0}">
													<span>未读</span>
												</c:if>
											</c:if>
											
										<span class="font-gray">${log.model.modelName}</span>
									</div>
								</a>
							</div>
							<a href="${pageContext.request.contextPath}/log/content?lid=${log.logId}&state=${state}&type=${type}">
								<div class="row log-user-content" >
									<c:forEach var="item" items="${log.model.modelItems}">
										<div >
											<div class="log-user-content-left" >
												<p class="font-gray" >${item.itemLabel}</p>
											</div>
											<div class="log-user-content-right" >
												<div class="log-user-content-right font-default" >
													<p>
														<c:choose>
															<c:when test="${item.dataType == 1 || item.dataType == 2 || item.dataType == 3}">
																<c:forEach var="attr" items="${log.logAttrs}">
																	<c:if test="${item.field eq attr.attrName}">
																		<c:if test="${fn:length(attr.attrValue) > 50}">
																			${fn:substring(attr.attrValue, 0, 50)}...
																		</c:if>
																		<c:if test="${fn:length(attr.attrValue) < 50}">
																			${attr.attrValue}
																		</c:if>
																	</c:if>
																</c:forEach>
															</c:when>
															<c:when test="${item.dataType == 4}">
																item.dataType == 4
															</c:when>
														</c:choose>
													</p>
												</div>
											</div>
											<div class="clearfix"></div>
										</div>
									</c:forEach>
								</div>
								<div class="row log-user-content" >
									<div class="col-xs-12" >
										<p class="font-gray log-user-time" ><fmt:formatDate value="${log.submitTime}" pattern="MM月dd日 HH:mm"/></p>
									</div>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
				</c:if>
				<c:if test="${fn:length(pager.list) <= 0}">
					<div class="text-center no-notice" >
						<img class="center-block img-responsive" src="${pageContext.request.contextPath}/resource/img/no-rizhi.png" width="100px"/>
						<p class="font-gray">暂无日志</p>
					</div>
				</c:if>
			</div>
			
			<div id="logFromContent" class="row" >
				
			</div>
		</div>
		
		<div id="sifiingsConent" >
			<div id="log-top" >
				<a href="${pageContext.request.contextPath}/log/list">
					<div class="log-top-all" >
						<div class="log-top-all-left" >
							<img class="center-block" src="${pageContext.request.contextPath}/resource/img/iconfont-quanbu@2x.png" />
						</div>
						<div class="log-top-all-right" >
							全部
						</div>
						<div class="clearfix"></div>
					</div>
				</a>
				<a href="${pageContext.request.contextPath}/log/list?state=0">
					<div class="log-top-unread" >
						<div class="log-top-unread-left" >
							<img class="center-block"  src="${pageContext.request.contextPath}/resource/img/icon_gb.png" />
						</div>
						<div class="log-top-unread-right font-default" >
							未读
						</div>
						<div class="clearfix"></div>
					</div>
				</a>
				<a href="${pageContext.request.contextPath}/log/list?state=1">
					<div class="log-top-send" >
						<div class="log-top-unread-left" >
							<img class="center-block"  src="${pageContext.request.contextPath}/resource/img/icon_dakai.png" />
						</div>
						<div class="log-top-unread-right font-default" >
							已读
						</div>
						<div class="clearfix"></div>
					</div>
				</a>
				<a href="${pageContext.request.contextPath}/log/contacts">
					<div class="log-top-send" >
						<div class="log-top-send-left" >
							<img class="img-responsive center-block" src="${pageContext.request.contextPath}/resource/img/iconfont-woguanzhude@2x.png" />
						</div>
						<div class="log-top-send-right" >
							<p class="pull-left font-default" style="margin-right: 5px;">发送人</p>
							
							<p class="pull-right" >
								<span class="glyphicon glyphicon-menu-right" ></span>
							</p>
							
							<p id="sendUser" class="pull-right user-icon">
								<c:forEach var="_user" items="${userList}" varStatus="status">
								<span>
									<c:if test="${fn:length(_user.userNick) > 2}">
										<c:choose>
											<c:when test="${status.index==userList.size()-1 }">
												${fn:substring(_user.userNick, 1, 3)}
											</c:when>
											<c:otherwise>
												${fn:substring(_user.userNick, 1, 3)},
											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${fn:length(_user.userNick) <= 2}">
										<c:choose>
											<c:when test="${status.index==userList.size()-1 }">
												${_user.userNick}
											</c:when>
											<c:otherwise>
												${_user.userNick},
											</c:otherwise>
										</c:choose>
									</c:if>
								</span>
								</c:forEach>
							</p>
								
						</div>
						<div class="clearfix"></div>
					</div>
				</a>
			</div>
			<div id="log-bottom" >
				
			</div>
		</div>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js" ></script>
		
		<script>
			var i = 2;
			$(document).ready(function(){
			
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
				
				var topH=$("#log-top").height();
				var bottomH=$(document).height() - topH;
				$("#log-bottom").height(bottomH);
				$("#sifiings").click(function(){
					$("#sifiingsConent").toggle();
				});
				$("#log-bottom").click(function(){
					$("#sifiingsConent").hide();
				});
				
				
				$("#reads").click(function(){
					$.ajax({ 
						url:"${pageContext.request.contextPath}/log/reads",
						type:'post',
						dataType:'json', 
						success: function(result){
							window.location.reload();
						}
					});
				});
				
				var id = "logRcv";
				var type = "${type}";
				if(type != null && type != ""){
					if(type == "1"){
						id = "logFrom";
					}
				}
				
				$("#" + id).siblings("div").removeClass("tab-from-active");
				$("#" + id).addClass("tab-from-active");
				
				//日志内容单行长度限制
				/*var str = $(".log-user-content-right p");
				var textLeng = 20;
				for(var i=0;i<str.length;i++){
					var leng=str[i].innerHTML;
					if(leng.length > textLeng ){
		                $(str[i]).text(leng.substring(0,textLeng )+"...");
		            }
				}*/
				
				/*联系人的长度进行限制*/
				if($("#sendUser").text().replace(/\s+/g,"").length>12){
					$("#sendUser").text($("#sendUser").text().replace(/\s+/g,"").substring(0,12)+"...");
				}
				
			    var winH = $(window).height(); //页面可视区域高度   
			    
			    var scrollHandler = function () {  
			        var pageH = $(document.body).height();  
			        var scrollT = $(window).scrollTop(); //滚动条top   
			        var aa = (pageH - winH - scrollT) / winH;  
			        if (aa < 0.02) {//0.02是个参数 
			        	var pageCount = $("#pageCount").val();
			        	if(pageCount > 1){
			        		$("#more").show();
				        	more(i);
			                $(window).unbind('scroll');	
			        	}
			        }  
			    };
			    //定义鼠标滚动事件  
			    $(window).scroll(scrollHandler);  
			});
			
			function logActive(id){
				if(id == "logRcv"){
					/*$("#logFromContent").hide();
					$("#sifiings").show();
					$("#logRcvContent").show();*/
					window.location.href="${pageContext.request.contextPath}/log/list?type=0";
				}else if(id == "logFrom"){
					/*$("#logRcvContent").hide();
					$("#sifiings").hide();
					$("#logFromContent").show();*/
					window.location.href="${pageContext.request.contextPath}/log/list?type=1";
				}
			};
			
			
			function more(page){
				i++; //页码自动增加，保证下次调用时为新的一页。
				var type = $("#type").val();
				var formParam = $("#dataform").serialize();
				$.ajax({ 
					url:"${pageContext.request.contextPath}/log/jlist?pageNum=" + page,
					type:'post',
					data:formParam,
					dataType:'json', 
					success: function(data){
						$("#more").hide();
						
						var list = data.list;
						for(var j=0; j < list.length; j++){
							var html = "<li class='log-content'>";
								html +="<div class='row log-from-user'>";
								html +="<div class='col-xs-6'>";
								
							
							if(type == 0){
								html+="<a href='${pageContext.request.contextPath}/log/list?type=0&sendUser="+list[j].userId+"'>";
							}else{
								html+="<a href='${pageContext.request.contextPath}/log/content?lid="+list[j].logId+"&state=${state}&type=${type}'>";
							}
								
							if(list[j].userAvatar != null && list[j].userAvatar != ''){
								html +="<div class='log-from-user-icon'><img class='img-circle' src='"+list[j].userAvatar+"'/></div></a>";
							}else{
								html +="<div class='log-from-user-icon' style='background: "+list[j].color+"' ><span>";
								
								if(list[j].userNick.length > 2){
									html += list[j].userNick.substring(1,3);
								}else{
									html += list[j].userNick;
								}
								
								html +="</span></div></a>";
							}
								
								html +="<a href='${pageContext.request.contextPath}/log/content?lid="+list[j].logId+"&state=${state}&type=${type}' class='log-from-user-name'>"+list[j].userNick+"</a>";
								html +="</div><div class='col-xs-6 text-right'>";
								html +="<a href='${pageContext.request.contextPath}/log/content?lid="+list[j].logId+"&state=${state}&type=${type}'>";
							if(type == 0){
								
								
								if(list[j].isRead == 1){
									html +="<span>未读</span>";
								}else{
									html +='<span class="font-gray">已读</span>';
								}
							}		
								html +="<span class='font-gray'>"+list[j].modelName+"</span></div></a></div><a href='${pageContext.request.contextPath}/log/content?lid="+list[j].logId+"&state=${state}&type=${type}'><div class='row log-user-content'>";
								
							var items = list[j].modelItems;
							for(var k = 0; k < items.length; k++){
								html +="<div><div class='log-user-content-left'><p class='font-gray'>"+ items[k].label +"</p>";
								html +="</div><div class='log-user-content-right'><div class='log-user-content-right'><p>"+ items[k].value +"</p>";
								html +="</div></div><div class='clearfix'></div></div>";
							}
								html +="</div><div class='row log-user-content'><div class='col-xs-12'>";
								html +="<p class='font-gray log-user-time'>"+list[j].submitTime+"</p>";
								html +="</div></div></a></li>";
							
							$("#list").append(html);
						}
			      	}
				});
			}
		</script>
	</body>
</html>