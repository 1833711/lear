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
		<title>日志 - 内容</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/swiper.3.1.7.min.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
		
	</head>
	<body class="bg-gray">
		<header class="bg-log header " style="background:#32a2ee;">
			<a id="go_back" href="${pageContext.request.contextPath}/log/list?state=${state}&type=${type}">
				<div class="header-left" >
					<span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 3px;color:white;"></span>
				</div>
				<span style="display: inline-block;margin-top: 4px;color:white;">${log.model.modelName}</span>
			</a>
			<div class="header-center"></div>
			<div class="header-right text-right" >
			<c:if test="${sessionScope.user.userId == log.user.userId}">
				<p id="logMore" >更多</p>
		 	</c:if>
			</div>
		</header>
		<input id="logId" type="hidden" value="${log.logId}" />
		<input id="flag" type="hidden" value="${flag}" />
		<input id="appointed" type="hidden" value="" />
		<div class="container mt40 font-15">
			<div class="row log-send-user" >
				<!-- 头像是图片的样式 -->
				<c:if test="${log.user.userAvatar != null && log.user.userAvatar != ''}">
					<div class="send-user-icon" style="background: url(${log.user.userAvatar});background-size: 50px 50px;"></div>
				</c:if>
				<c:if test="${log.user.userAvatar == null || log.user.userAvatar == ''}">
					<div class="send-user-icon" style="background: ${log.user.color};">
						<p>
							<c:if test="${fn:length(log.user.userNick) > 2}">
								${fn:substring(log.user.userNick, 1, 3)}
							</c:if>
							<c:if test="${fn:length(log.user.userNick) <= 2}">
								${log.user.userNick}
							</c:if>
						</p>
					</div>
				</c:if>
				
				<div class="send-user-info" >
					<p>
						<c:if test="${fn:length(log.user.userNick) > 10}">
							${fn:substring(log.user.userNick, 0, 10)}...
						</c:if>
						<c:if test="${fn:length(log.user.userNick) <= 10}">
							${log.user.userNick}
						</c:if>
					</p>
					<p class="font-gray font-13"><fmt:formatDate value="${log.submitTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
				</div>
				<c:if test="${sessionScope.user.userId ne log.user.userId}">
					<img class="read-flag" src="${pageContext.request.contextPath}/resource/img/read.png" />
				</c:if>
			</div>
			
			<div class="row log-send-user last-border" >
				<c:forEach var="item" items="${log.model.modelItems}" varStatus="status">
					<div <c:if test="${status.index > 0 }"> class="mt10" </c:if>  style="border-bottom:1px solid #e7e7e7;padding-bottom:5px">
						<p class="font-gray">${item.itemLabel}</p>
						<p >
							<c:choose>
								<c:when test="${item.dataType == 1 || item.dataType == 2 || item.dataType == 3}">
									<c:forEach var="attr" items="${log.logAttrs}">
										<c:if test="${item.field eq attr.attrName}">
											${attr.attrValue}
										</c:if>
									</c:forEach>
								</c:when>
							</c:choose>
						</p>
					</div>
				</c:forEach>
				
				
				<c:if test="${not empty log.remarks}">
					<div class="mt10" style="border-bottom:1px solid #e7e7e7;padding-bottom:5px">
						<p class="font-gray">备注</p>
						<p>${log.remarks}</p>
					</div>
				</c:if>
				
				
				<!-- 日报中的图片内容 -->
				<div class="mt15 content-img" >
					<c:forEach var="img" items="${log.logImgs}" varStatus="status">
						<div class="col-xs-4 ph5 mt10" style="overflow:hidden;">
							<img class="" src="${img.imgUrl}" width="80px" height="80px"/>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="row log-send-user" >
				<p class="font-gray log-read-user" >
					<span>已读</span>
					<span class="pull-right glyphicon log-read-user" ></span>
					<span class="pull-right" >${fn:length(list)}人</span>
				</p>
				<div>
					
						<ul class="read-user">
							<c:forEach var="user" items="${list}" varStatus="status">
								<c:if test="${sessionScope.user.userId eq user.userId}">
									<a class="font-default" href="${pageContext.request.contextPath}/log/list?type=1&sendUser=${user.userId}">
								</c:if>
								<c:if test="${sessionScope.user.userId ne user.userId}">
									<a class="font-default" href="${pageContext.request.contextPath}/log/list?type=0&sendUser=${user.userId}">
								</c:if>
							
								<li>
									<c:if test="${user.userAvatar != null && user.userAvatar != ''}">
										<div class="send-user-icon" style="background: url(${user.userAvatar});background-size: 50px 50px;"></div>
									</c:if>
									<c:if test="${user.userAvatar == null || user.userAvatar == ''}">
										<div class="send-user-icon" style="background: ${user.color}">
											<p>
												<c:if test="${fn:length(user.userNick) > 2}">
													${fn:substring(user.userNick, 1, 3)}
												</c:if>
												<c:if test="${fn:length(user.userNick) <= 2}">
													${user.userNick}
												</c:if>
											</p>
										</div>
									</c:if>
									<%-- <div>
										<c:if test="${fn:length(user.userNick) >= 3}">
											${fn:substring(user.userNick, 1, 3)}...
										</c:if>
										<c:if test="${fn:length(sendUser.userNick) < 3}">
											${sendUser.userNick}
										</c:if>
									</div> --%>
								</li>
								</a>
							</c:forEach>
						</ul>
				</div>
				
			</div>
			<div class="row log-send-user appraise">
				<div class="pinglun">
		          <p id="appraise" style="display:none;">共有<span>6</span>条回复</p>
				</div>
			</div>
		</div>
		<div class="log-footer" >
			<input class="log-comment" type="text" placeholder="评论" maxlength="150" />
			<input class="" type="hidden" name="uidclick" id="uidclick" />
			<button class="btn send-comment pull-right" >提交</button>
		</div><!-- 更多 -->
		<div id="moreAction" style="">
			<div class="more-bg" ></div>
			<div class="log-action" >
				<ul>
					<li id="deleteAction">
						<a  class="font-default font-16" href="javascript: void(0);">
							删除日志
						</a>
					</li>
					<li id="colseAction">
						<a class="font-default font-16" href="javascript: void(0);">
							取消
						</a>
					</li>	
				</ul>
			</div>
		</div>
		<div class="swiper-container swiper-container-horizontal">
		    <div id="swiper-wrapper" class="swiper-wrapper swiper-div">
		
		    </div>
		</div>
		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/swiper.3.1.7.jquery.min.js" ></script>
		
		<script>
		if($(".pinglun .comBox").length>0){
			$("#appraise").show();
		}
		$('.log-footer button').click(function(){
			var logText=$(".log-footer .log-comment").val();//评论内容
			var logId=$("#logId").val();//日志id
			var userId="${log.user.userId}";//用户id
			var usernick="${log.user.userNick}";//用户昵称
		if(logText.indexOf("回复：@")!=-1){
			var senduid=$(".log-footer #uidclick").val();			
		}else{
			var senduid=null;
		}
			var jsonData = {};
			jsonData.log_id=logId;
			jsonData.comment_text=logText;
			jsonData.parent_uid=userId;
			jsonData.parent_uname=usernick;
			jsonData.from_uid=senduid;
			jsonData.from_uname=null;
			jsonData.from_uimage=null;
			jsonData.to_uid=null;
			jsonData.to_uname=null;
			jsonData.comment_date=null;
			var data=JSON.stringify(jsonData);
			$.ajax({ 
				url:"${pageContext.request.contextPath}/log/saveLogComment",
				type:'post',
				data:{"jsonData":data},
				dataType:'json', 
				success: function(data){
					console.log(data);
						if(!data.from_uimage){
							var photo='<div class="send-user-icon" style="background: url('+data.from_uimage+');background-size: 50px 50px;"></div>'
						}else{
							var photo="<div class='send-user-icon' style='background: #32a2ee;'>"+
									"<p>"+data.from_uname+"</p>"+
									"</div>";
						}
						var c_dataTime=data.comment_date?data.comment_date:"";
						var html = "<div class='comBox' onclick='sendcopy(this)'>"+photo;
							html +="<input type='hidden' name='uid' class='senduid' value='"+data.from_uid+"'/>";
							html +="<div class='commentInfo'>";
							html +="<p style='color:#757575;font-size: 1.3rem;'>";
							html +="<span style='float: left;' class='uname'>"+data.from_uname+"</span>";
							html +="<span style='float: right;'>"+getTime(c_dataTime/1000)+"</span>";
							html +="</p>";
							html +="<div class='clearfix'></div>";
							html +="<p style='margin-top:5px;font-size: 1.4rem;'>"+data.comment_text+"</p>";
							html +="</div>";
							html +="</div>";
						$(".appraise").append(html);
						$(".log-footer .log-comment").val("");
						$("#appraise span").text($(".pinglun .comBox").length);
						if($("#appraise span").text()>0){
							$("#appraise").show();
						
						}
		      	}
			});
		})
		
		function sendcopy(o){
			var senduid=$(o).find(".senduid").val();
			var senduname=$(o).find(".uname").text();
			console.log(senduid);
			$(".log-footer .log-comment").val("回复：@"+senduname);
			$(".log-footer #uidclick").val(senduid);
		}
			$(document).ready(function(){
				if (window.history && window.history.pushState) {
		            $(window).on('popstate', function () {
		                var hashLocation = location.hash;
		                var hashSplit = hashLocation.split("#!/");
		                var hashName = hashSplit[1];
		                if (hashName !== '') {
		                    var hash = window.location.hash;
		                    if (hash === '') {
		                    	if($("#flag").val()==1){
		        					$("#go_back").attr("href","");
		        					$(".header-left").click(function(){
		        						closeWindow();
		        					});
		        				}else{
		        					window.location.href='${pageContext.request.contextPath}/log/list?state=${state}&type=${type}';
		        				}
		                    }
		                }
		            });
		            window.history.pushState('forward', null, '#forward');
		        }
		for(var i=0;i<$(".last-border>div").length;i++){
			if(i==$(".last-border>div").length-2){
				$(".last-border>div").eq(i).css("border","none");
			}
		}
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
					window.onscroll = function(){ 
					    var t = document.documentElement.scrollTop || document.body.scrollTop;
					    $("header").css({"position":"relative","marginBottom":"-50px","top":t});
					} 
					
					$("#appointed").val("ios");
					
				}
				else if (browser.versions.android) {
					$("#appointed").val("android");
				}
				if($("#flag").val()==1){
					$("#go_back").attr("href","");
					$(".header-left").click(function(){
						closeWindow();
					});
					
				}
				
				$("#logMore").click(function(){
					$("#moreAction").show();
				});
				$("#colseAction").click(function(){
					$("#moreAction").hide();
				});
				
				$("#deleteAction").click(function(){
				
					if(confirm("确定要删除吗？")){
	 					var id = $("#logId").val();
					
						if(id != null && id != ''){
							$.ajax({ 
								type:'post',      
								url: '${pageContext.request.contextPath}/log/delete?id=' + id,
								cache:false,  
								dataType:'json',  
								success:function(data){
									if(data == 1){
										$("#moreAction").hide();
										window.location.href='${pageContext.request.contextPath}/log/list?state=${state}&type=${type}';
									}else{
										alert("不能删除该日志");
									}
								}  
							});
						}
	 				}
				});
				
				$("img").each(function(){
			 		$(this).bind("click",function(){
			 			fileView($(this).attr("src"), '', '');
			 		});
				});
				
				//图片点击放大
/* 				var mySwiper;
			    var currentImg;
			    $('body').on('click', '.content-img div img', function () {
			        var isSame = $(this).parents('.content-img div').attr('data-load');
			        currentImg = $(this).parent('div').index();
			        //移除同级标示
			        $('.content-img div').removeAttr('data-load');
			
			        //组图 顶级 dom 添加标示
			        $(this).parents('.content-img div').attr('data-load', 'true');
			
			        //清空,重置样式
			        if (mySwiper) {
			            mySwiper.destroy(false, !0);
			        }
			
			        var tmpl = '';
			        var arr = new Array;
			        var i = 0;
			        //在这里写一段js获取当前点击的img的同组的所有img的src，遍历生成放大的图片
			        $(this).parent('div').parent('.content-img').find("img").each(function () {
			
			            arr.push($(this).attr('src'));
			
			            tmpl += '<div class="swiper-slide">' +
			                    '<img class="swiper-lazy swiper-lazy-loaded" src="' + $(this).attr('src') + '">' +
			                    '</div>';
			        });
			
			        //数据添加
			        $('.swiper-div').html(tmpl);
			
			        //设置应该显示的位置
			        for (i = 0; i < arr.length; i++) {
			            if (currentImg == i) {
			                var screenWidth = window.screen.width;
			                var moveWidth = -i * screenWidth + 'px'
			                $('.swiper-div').css("transform", "translate3d(" + moveWidth + ", 0px, 0px)");
			            }
			        }
			
			        //显示
			        $('.swiper-container').show();
			
			        //初始化插件
			        initSwiper();
			
			    });
			
			    function initSwiper() {
			        mySwiper = new Swiper('.swiper-container', {
			            preloadImages: false,
			            lazyLoading: true
			        });
			    }
			
			    //隐藏 swiper
			    $('body').on('click', '.swiper-slide', function () {
			        $('.swiper-container').hide();
			    }); */
				//日志评论列表
			    
				var logID=$("#logId").val();//日志id
				var userID="${log.user.userId}";//用户id
				$.ajax({ 
					
					url:"${pageContext.request.contextPath}/log/logCommentList",
					type:'post',
					data:{"logId":logID,"uid":userID},
					dataType:'json', 
					success: function(data){
						console.log(data);
						for(var i=0; i < data.length; i++){
							if(!data[i].from_uimage){
								var photo='<div class="send-user-icon" style="background: url('+data[i].from_uimage+');background-size: 50px 50px;"></div>'
							}else{
								var photo="<div class='send-user-icon' style='background: #32a2ee;'>"+
										"<p>"+data[i].from_uname+"</p>"+
										"</div>";
							}
						var dataTime=data[i].comment_date?data[i].comment_date:"";
						
							var html = "<div class='comBox' onclick='sendcopy(this)'>"+photo;
								html +="<input type='hidden' name='uid' class='senduid' value='"+data[i].from_uid+"'/>";
								html +="<div class='commentInfo'>";
								html +="<p style='color:#757575;font-size: 1.3rem;'>";
								html +="<span style='float: left;' class='uname'>"+data[i].from_uname+"</span>";
								html +="<span style='float: right;'>"+getTime(dataTime/1000)+"</span>";
								html +="</p>";
								html +="<div class='clearfix'></div>";
								html +="<p style='margin-top:5px;font-size: 1.4rem;'>"+data[i].comment_text+"</p>";
								html +="</div>";
								html +="</div>";
								$(".appraise").append(html);
							$("#appraise span").text($(".pinglun .comBox").length);
							if($("#appraise span").text()>0){
								$("#appraise").show();
							
							}
						}
			      	}
				});
			    
			    
			    
			    
			    
			});
			function getTime(/** timestamp=0 * */) {
	var ts = arguments[0] || 0;
	var t, y, m, d, h, i, s;
	t = ts ? new Date(ts * 1000) : new Date();
	y = t.getFullYear();s
	m = t.getMonth() + 1;
	d = t.getDate();
	h = t.getHours();
	i = t.getMinutes();
	s = t.getSeconds();
	// 可根据需要在这里定义时间格式
	return /* y + '年' + */ (m < 10 ? '0' + m : m) + '月' + (d < 10 ? '0' + d : d)
			+ '日' + (h < 10 ? '0' + h : h) + ':' + (i < 10 ? '0' + i : i)
			/* + ':' + (s < 10 ? '0' + s : s) */
}
			function closeWindow(){
				if($("#appointed").val()=="android"){
					window.callAndroid.JsCallandroid();
				}else if($("#appointed").val()=="ios"){
					close();
				}
				window.location.href = "${pageContext.request.contextPath}/logout";
			}
			
			
			function fileView(url, name, size) {
				if(url != null && url != ''){
					var suffix = url.substr(url.lastIndexOf('.') + 1);
					var type = 1;
					if (suffix != 'jpg' && suffix != 'gif' && suffix != 'png' && suffix != 'bmp' && suffix != 'jpeg') {
						type = 0;
					}
				
					if($("#appointed").val()=="android"){
						window.showImage.showIamge(type, url, name, size, suffix);
					}else if($("#appointed").val()=="ios"){
						OCModel.loadFile({'type': type, 'url': url,'name': name, 'size': size, 'suffix': suffix})
					}
				}
			}
		</script>
	</body>
</html>
