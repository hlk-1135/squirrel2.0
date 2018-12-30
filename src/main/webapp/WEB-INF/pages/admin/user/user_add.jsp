<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8" />
<title>用户信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="<c:url value="/js/jquery.min.js"/>"></script>
<script type="text/javascript" charset="utf-8"
	src="<c:url value="/js/script_user.js"/>"></script>
<link rel="stylesheet" href="<c:url value="/css/info_main.css"/>" />
</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>
	<jsp:include page="../main_left.jsp"></jsp:include>
	<!--=============================================================================================================================================================================-->
	<!--main-container-part-->
	<div id="content">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="<c:url value="/back"/>" title="主页"
					class="tip-bottom"> <i class="icon-home"></i>主页
				</a> <a title="用户信息" class="tip-bottom">用户信息</a>
			</div>
		</div>
		<!--End-breadcrumbs-->
		<!-- Tabs Container-->
		<section id="tabsContainer" class="clearfix">
			<!--Inner-->
			<div id="innerBg">

				<!--About Tab-->
				<article id="about" class="clearfix">
					<form action="<c:url value="${formAction}"/>"
						method="post">
						<input type="hidden" value="${user.id }" name="id" id="id">
						<c:if test="${errors!=null }">
							<c:forEach items="${errors }" var="error">
							<span id="span" style="color: red;">${error.defaultMessage }</span><br/>
						</c:forEach>
						</c:if>
						<!-- Introduction -->
						<section  class="clearfix">
							<h1>个人信息</h1>
							<ul class="info">
								
								<li><span>手机</span> :
									<input type="text" value="${user.phone }" name="phone" 
									id="phone"> <span id="span" style="color: red;">*</span>
								</li>
								<c:if test="${formAction ne '/back/user/update'}">
									<li><span>密码</span> :
										<input type="text" value="${user.password }" name="password" 
										id="phone"> <span id="span" style="color: red;">*</span>
									</li>
								</c:if>
								
								<li><span>昵称</span> :
									<input type="tel" value="${user.nickname}" name="nickname">
									<span id="span" style="color: red;">*</span>
								</li>
								<li >
									<span>性别</span> :
									<c:choose>
										<c:when test="${user.gender eq 'fmale' }">
											<input type="radio" id="gender"
												name="gender"  value="male" /> 男
											<input type="radio" id="gender"
												name="gender" checked="checked" value="fmale" /> 女
										</c:when>
										<c:otherwise >
											<input type="radio" id="gender"
												name="gender" checked="checked" value="male" /> 男
								
											<input type="radio" id="gender"
												name="gender" value="fmale" /> 女
										</c:otherwise>
									</c:choose>
								</li>
								
								<li style="margin-top: 10px;"><span>地址</span> :
									<input type="tel" value="${user.address}" name="address">
									<span id="span" style="color: red;">*</span>
								</li>
								
							</ul>
							
						</section>
						<section id="clearfix">
							<input type="submit" value="保存" id="submit" /> 
							<input type="reset" onclick="window.history.go(-1)" value="取消">
						</section>
					</form>
				</article>
			</div>
			<!--End Inner-->
		</section>


	</div>
	<!--==================================================================================================================-->
	<jsp:include page="../main_bottom.jsp"></jsp:include>
	<!--End Page Wrapper-->
</body>