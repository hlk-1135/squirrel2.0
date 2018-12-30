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
<title>个人信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<link rel="stylesheet" href="<%=basePath%>css/info_main.css"/>
<body>

	<jsp:include page="main_top.jsp"></jsp:include>
	<jsp:include page="main_left.jsp"></jsp:include>
	<!--=============================================================================================================================================================================-->
	<!--main-container-part-->
	<div id="content" style="margin-right: 100px; margin-top: 40px;">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="<%=basePath%>admin/indexs" title="主页" class="tip-bottom">
				<i class="icon-home"></i>主页</a> <a title="管理员个人信息" class="tip-bottom">管理员个人信息</a>
			</div>
		</div>
		<!--End-breadcrumbs-->
		<!-- Tabs Container-->
		<section id="tabsContainer" class="clearfix">

			<!--Inner-->
			<div id="innerBg">

				<!--About Tab-->
				<article id="about" class="clearfix">
					<!-- Introduction -->
					<section id="introduction" class="clearfix">
						<h1>个人信息</h1>
						<ul class="info">
							<li><span>姓名</span> : ${admin.userName }</li>
							<li><span>账号</span> : ${admin.phone }</li>
							<li><span>角色</span> : ${admin.userRole }</li>
						</ul>
					</section>
					<!-- End introduction -->
				</article>

			</div>
			<!--End Inner-->
		</section>

	</div>
	<!--==================================================================================================================-->
	<jsp:include page="main_bottom.jsp"></jsp:include>
	<!--End Page Wrapper-->
</body>

