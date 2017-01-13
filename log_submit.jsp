<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
<title>提交日志</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resource/css/index.css" />
<link href="${pageContext.request.contextPath}/resource/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/alert.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/autosize.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/bootstrap-datetimepicker.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/bootstrap-datetimepicker.zh-CN.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/log_submit/log_sumbit.js" ></script>

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
	                    	back();
	                    }
	                }
	            });
	            window.history.pushState('forward', null, '#forward');
	        }
	});
	
</script>

</head>
<body class="bg-gray">
	<input type="hidden" id="path" value="${pageContext.request.contextPath}">
	<input type="hidden" id="flag" value="0">
	 <header class="header bg-log">
	<a id="goBack" class="font-white" onclick="back();" style="cursor:pointer">
		<div class="header-left">
			 <span class="glyphicon glyphicon-menu-left" style="font-size:2rem;margin-top: 5px;"></span>
		
		</div>
		 <span style="display: inline-block;margin-top: 4px;">发起日志</span>
		</a>
		<div class="header-center font-white"></div>

	</header> 
	<!-- <header class="header bg-log text-center">
	<a id="goBack" class="font-white" onclick="back();" style="cursor:pointer">
		<div class="header-left">
			 <span class="glyphicon glyphicon-menu-left" style="font-size:2.6rem;margin-top: 3px;"></span>
		
		</div>
		 <span style="display: inline-block;margin-top: 4px;float:left">返回</span>
		</a>
		<div class="header-center font-white">工作日志</div>
			<div class="header-right text-right"> 
				<a href="">选择模板</a> 
 			</div>
	</header> -->

	<form id="draftFrom" action="${pageContext.request.contextPath}/log_items/draft" method="post" enctype="multipart/form-data">
		
		<div class="container mt40" style="/*position:absolute; overflow:scroll; */width: 100%;/* -webkit-overflow-scrolling: touch; */" >
			<div class="row">
			<!-- <p style="height:30px;margin-left:10px;line-height:30px;color:#9D9696 "> 日报 </p> -->
				<p class="log-type" >
					<span>最后保存时间：</span>
					<span>2016-04-26</span>
				</p>
			</div>
				<input id="logId_hidden" type="hidden" name="logId" value="${logs.logId }">
				<input id="sendUserIds_hidden" type="hidden" name="sendUserIds" 
				value="<c:forEach items="${logs.userAttns }" var="temp" varStatus="status"><c:choose><c:when test="${status.index==0 }">${temp.userId }</c:when><c:otherwise>,${temp.userId }</c:otherwise></c:choose></c:forEach>">
				<c:forEach items="${mode1.modelItems }" var="temp">
					<c:if test="${temp.dataType==1 }">
						<!-- 1:单行输入框 -->
						<div class="row bg-white" <c:if test="${temp.isDisplay==0 }">style="display: none;"</c:if>>
							<div class="log-work">
								<div class="pull-left log-label">
									<p>${temp.itemLabel }<c:if test="${temp.unit !=null }">(${temp.unit })</c:if>:</p>
								</div><c:choose><c:when test=""><c:otherwise></c:otherwise></c:when></c:choose>
								<div class="pull-left pl15">
									<textarea  onblur="inputOnblur(this,'${temp.modelitemId }','${temp.help }','${temp.defValue }','${temp.isRequired }');"
									onfocus="inputOnfocus(this,'${temp.help }');"
									class="log-input font-13
										<c:choose>
											<c:when test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
												<c:forEach items="${logs.logAttrs }" var="val">
													<c:choose>
														<c:when test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }"></c:when>
														<c:when test="${(val.attrValue==null||val.attrValue=='')&&val.attrName==temp.field&& temp.isRequired==1}">font-gray-light</c:when>
													</c:choose>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${temp.defValue != null }"></c:when>
													<c:otherwise>font-gray-light</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose> log-word"
										><c:choose>
											<c:when test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
												<c:forEach items="${logs.logAttrs }" var="val">
													<c:choose>
														<c:when test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }">${val.attrValue }</c:when>
														<c:when test="${(val.attrValue==null||val.attrValue=='')&&val.attrName==temp.field&& temp.isRequired==1}">(必填)</c:when>
													</c:choose>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${temp.defValue != null }">${temp.defValue }</c:when>
													<c:otherwise>${temp.help }<c:if test="${temp.isRequired==1 }">(必填)</c:if></c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</textarea>
										<input id="hidden_${temp.modelitemId }" type="hidden" name="${temp.field }" class="<c:if test="${temp.isRequired==1 }">required</c:if>" 
											<c:choose>
												<c:when test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
													<c:forEach items="${logs.logAttrs }" var="val">
														<c:if test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }">value="${val.attrValue }"</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:if test="${temp.defValue != null }">value="${temp.defValue }"</c:if>
												</c:otherwise>
											</c:choose>
										/>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</c:if>
					<c:if test="${temp.dataType==2 }">
						<!-- 2:数字输入框 -->
						<div class="row bg-white" <c:if test="${temp.isDisplay==0 }">style="display: none;"</c:if>>
							<div class="log-work">
								<div class="pull-left log-label">
									<p>${temp.itemLabel }<c:if test="${temp.unit !=null }">(${temp.unit })</c:if>:</p>
								</div>
								<div class="pull-left pl15">
									<textarea  onblur="inputOnblur(this,'${temp.modelitemId }','${temp.help }','${temp.defValue }','${temp.isRequired }');"
									onfocus="inputOnfocus(this,'${temp.help }');"
									class="log-input  font-13
										<c:choose>
											<c:when test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
												<c:forEach items="${logs.logAttrs }" var="val">
													<c:choose>
														<c:when test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }"></c:when>
														<c:when test="${(val.attrValue==null||val.attrValue=='')&&val.attrName==temp.field&& temp.isRequired==1}">font-gray-light</c:when>
													</c:choose>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${temp.defValue != null }"></c:when>
													<c:otherwise>font-gray-light</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose> log-word"
										><c:choose>
											<c:when test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
												<c:forEach items="${logs.logAttrs }" var="val">
													<c:choose>
														<c:when test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }">${val.attrValue }</c:when>
														<c:when test="${(val.attrValue==null||val.attrValue=='')&&val.attrName==temp.field&& temp.isRequired==1}">(必填)</c:when>
													</c:choose>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${temp.defValue != null }">${temp.defValue }</c:when>
													<c:otherwise>${temp.help }<c:if test="${temp.isRequired==1 }">(必填)</c:if></c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</textarea>
										<input id="hidden_${temp.modelitemId }" type="hidden" name="${temp.field }" class="<c:if test="${temp.isRequired==1 }">required</c:if>" 
											<c:choose>
												<c:when test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
													<c:forEach items="${logs.logAttrs }" var="val">
														<c:if test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }">value="${val.attrValue }"</c:if>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:if test="${temp.defValue != null }">value="${temp.defValue }"</c:if>
												</c:otherwise>
											</c:choose>
										/>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</c:if>
					
					<c:if test="${temp.dataType==3 }">
						<!-- 3:下拉框 -->
						<div class="row bg-white" <c:if test="${temp.isDisplay==0 }">style="display: none;"</c:if>>
							<div class="log-work">
								<div class="pull-left log-label">
									<p>${temp.itemLabel }:</p>
								</div>
								<div id="${temp.modelitemId }" class="pull-left pl15" >
								<input id="draftValue" type="hidden"
									<c:if test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
											<c:forEach items="${logs.logAttrs }" var="val">
												<c:choose>
													<c:when test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }">
														value="${val.attrValue }" 
													</c:when>
												</c:choose>
											</c:forEach>
										</c:if>
								  >
									<script type="text/javascript">
	 									getOpt('${temp.modelitemId }','${temp.field }','${temp.optValue }','${temp.defValue }',3);
									</script> 
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</c:if>
					
					
	<%-- 				<c:if test="${temp.dataType==4 }">	<!-- 4:单选框 --> --%>
	<%-- 					<div class="row bg-white pl20" <c:if test="${temp.isDisplay==0 }">style="display: none;"</c:if>> --%>
	<!-- 						<div class="log-work"> -->
	<!-- 							<div class="pull-left log-label"> -->
	<%-- 								<p>${temp.itemLabel }</p> --%>
	<!-- 							</div> -->
	<%-- 							<div id="${temp.modelitemId }" class="pull-left pl15" > --%>
	<!-- 								<script type="text/javascript"> -->
	<%-- // 									getOpt('${temp.modelitemId }','${temp.field }','${temp.optValue }','${temp.defValue }',1); --%>
	<!-- 								</script> -->
	<!-- 							</div> -->
	<!-- 							<div class="clearfix"></div> -->
	<!-- 						</div> -->
	<!-- 					</div> -->
	<%-- 				</c:if> --%>
	<%-- 				<c:if test="${temp.dataType==5 }">	<!-- 5:多选框 --> --%>
	<%-- 					<div class="row bg-white pl20" <c:if test="${temp.isDisplay==0 }">style="display: none;"</c:if>> --%>
	<!-- 						<div class="log-work"> -->
	<!-- 							<div class="pull-left log-label"> -->
	<%-- 								<p>${temp.itemLabel }</p> --%>
	<!-- 							</div> -->
	<%-- 							<div id="${temp.modelitemId }" class="pull-left pl15" > --%>
	<!-- 								<script type="text/javascript"> -->
	<%-- // 									getOpt('${temp.modelitemId }','${temp.field }','${temp.optValue }','${temp.defValue }',2); --%>
	<!-- 								</script> -->
	<!-- 							</div> -->
	<!-- 							<div class="clearfix"></div> -->
	<!-- 						</div> -->
	<!-- 					</div> -->
	<%-- 				</c:if> --%>
					<c:if test="${temp.dataType==4 }">	<!-- 4:日期 -->
						<div class="row bg-white" <c:if test="${temp.isDisplay==0 }">style="display: none;"</c:if>>
							<div class="log-work">
								<div class="pull-left log-label">
									<p>${temp.itemLabel }:</p>
								</div>
								<div class="pull-left pl15">
									<input format="${temp.dateFormat }" type="text" onmouseover="getFormat(this);" readonly="readonly" name="${temp.field }" 
										class="log-input font-gray log-word <c:if test="${temp.isRequired==1 }">required</c:if>" 
										<c:if test="${logs.logAttrs!=null&&logs.logAttrs.size()>0 }">
											<c:forEach items="${logs.logAttrs }" var="val">
												<c:choose>
													<c:when test="${val.attrValue!=null&&val.attrValue!=''&&val.attrName==temp.field }">
														value="${val.attrValue }" 
													</c:when>
												</c:choose>
											</c:forEach>
										</c:if>
										<c:if test="${temp.defValue != null }">value="${temp.defValue }"</c:if>
										<c:if test="${temp.help!=null || temp.isRequired==1}">placeholder="${temp.help }(必填)"</c:if>
									/>
								</div>
								<div class="clearfix"></div>
							</div>
						</div>
					</c:if>
				</c:forEach>
				
				
				<div class="row bg-white pl20" >
					<div class="log-work-mark" >
						<div class="pull-left" >
							<textarea onblur="remarksChange(this,'${logs.logId }');"
								<c:choose>
									<c:when test="${logs.remarks!=null&&logs.remarks!='' }">class="log-remark log-mark font-13"</c:when>
									<c:otherwise>class="log-remark log-mark font-gray-light font-13"</c:otherwise>
								</c:choose>
							  ><c:choose><c:when test="${logs.remarks!=null&&logs.remarks!='' }">${logs.remarks}</c:when><c:otherwise>备注</c:otherwise></c:choose>
							</textarea>
							<input id="hidden_${logs.logId }" type="hidden" name="remarks" value="${logs.remarks }" >
						</div>
						<div class="clearfix"></div>
					</div>	
				</div>	
				
				<div class="row bg-white log-choice-img" style="padding-left:0">
					<c:if test="${logs.logImgs!=null&&logs.logImgs.size()>0 }">
						<c:forEach items="${logs.logImgs }" var="temp">
							<div class="col-xs-4">
								<input type="hidden" name="imgUrl" value="${temp.imgUrl }">
								<a><img class="img-responsive center-block" src="${temp.imgUrl }"  width="80px" height="80px"/></a>
								<img class="del-choice-img" url="${temp.imgUrl }" src="${pageContext.request.contextPath}/resource/img/dd-delete.png" onclick="delChoiceImg(this)" />
							</div> 
						</c:forEach>
					</c:if>
					<div id="upLoadImg" class="col-xs-4">
						<a href="javascript:;" class="file">
						    <input type="file" name="logo" onchange="loadImage(this)" accept="image/*" capture="camera">
							<!-- <input type="file" accept="image/*" multiple> -->
						    <img class="img-responsive center-block" src="${pageContext.request.contextPath}/resource/img/rizhi_xiangji.png" />
						</a>
					</div>
				</div>
	
				<div class="row bg-white log-rcv-user">
					<p>
						<span class="font-16">日志接收人</span> <span class="font-gray-light font-13">(点击头像删除)</span>
					</p>
					<div class="add-rcv-user">
						<c:forEach items="${logs.userAttns }" var="temp">
							<c:choose>
								<c:when test="${temp.userAvatar !=null && temp.userAvatar !='' }">
									<div onclick="deleteUser('${temp.userId }')" id="img_${temp.userId }" class="img-circle">
										<img  src="${temp.userAvatar }" /> 
									</div>
								</c:when>
								<c:otherwise>
									<div onclick="deleteUser('${temp.userId }')" id="img_${temp.userId }" class="img-circle" style="background-color: ${temp.color}">
											<c:if test="${temp.userNick.length()==2 || temp.userNick.length()<2 }">
												<p class="font-14">${temp.userNick}</p>
											</c:if>
											<c:if test="${temp.userNick.length()>2}">
												<p class="font-14">${temp.userNick.substring(1,3)}</p>
											</c:if>
									</div>	 
								</c:otherwise>
							
							</c:choose>
						</c:forEach>
						<img onclick="getLinkman()" class="add-rcv-default" src="${pageContext.request.contextPath}/resource/img/rizhi_jia.png" />
					</div>
				</div>
				<div class="row log-location">
<!-- 						<p> -->
<%-- 							<img src="${pageContext.request.contextPath}/resource/img/local_rizhi.png" /> <span class="ml10">所在位置</span> --%>
<!-- 						</p> -->
				</div>
			
		</div>
		
		
		
	</form>
	<div class="log-footer">
			<button onclick="btn_submit();" type="button" class="btn log-submit">提交</button>
		</div>
	<!-- 提示信息 -->
	<div id="tipMsg" class="log-tip" >
		<p style="color: #fff;">请填写必填选项</p>
	</div>
	
	<!-- 上传进度条 -->
	<div id="approval_more" class="approval-tip_load" style="display: none;" >
		<div class="shade_load"></div>
			<div class="more-content_load" >
				<div>
				<img src="${pageContext.request.contextPath}/resource/img/loding.gif" width="50px" height="50px">
				<span>正在加载..</span>
			</div>
		</div>
	</div>
	
	<script>
		$(document).ready(function() {
		
			var inputW = document.documentElement.clientWidth - 35;
			$(".log-mark").width(inputW);
			$(".log-mark").height(70);

			$(".log-remark").focus(function() {
				if($(this).val()=="备注"){
					$(this).val("");
					$(this).removeClass("font-gray-light");
				}
			});
			
			var count = $(".del-choice-img").length;
			if (count < 9) {
				$("#upLoadImg").show();
			}else{
				$("#upLoadImg").hide();	
			}
		});
		
	</script>
	<script type="text/javascript">
		var _format="";
		var _minView="";
		function getFormat(o){
			_format=o.getAttribute("format");
			_minView=_format.contains("hh:ii")?"hour":"month";
			$(o).datetimepicker({
				minView: _minView,
				language: 'zh-CN',
				format: _format,
				todayBtn: true,
				yearStart: 2000,
				pickTime: false,
				pickerPosition: "bottom-left",
				autoclose: 1
			});
		}
		
	</script>
</body>
</html>
