<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>更改密码</title>
<jsp:include page="main_top.jsp"></jsp:include>
<jsp:include page="main_left.jsp"></jsp:include>


<link rel="stylesheet" href="<%=basePath%>css/info_main.css"/>
<!-- JavaScript includes - jQuery, the complexify plugin and our own script.js -->
<script src="<%=basePath%>js/jquery.min.js"></script>
<script src="<%=basePath%>js/jquery.md5.js"></script>
</head>

<body>

	<!--=============================================================================================================================================================================-->
	<!--main-container-part-->
	<div id="content" style="margin-right: 100px;margin-top: 40px;">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="<%=basePath%>admin/indexs" title="主页" class="tip-bottom"><i class="icon-home"></i>主页</a>
				<a title="修改密码" class="tip-bottom">修改密码</a>
			</div>
		</div>
		<!--End-breadcrumbs-->

		<div id="main">
			<form class="" method="post" action="<%=basePath%>admin/changePassword">
			
				<input type="hidden" value='${admin.id }' id="id" name="id"/>
				<div class="row pass">
					<input type="password" id="password" name="password" placeholder="原密码" />
				</div>
				<div class="row pass">
					<input type="password" id="password1" name="password1" placeholder="新密码" />
				</div>
				<c:if test="${msg!=null}">
				<span style="color:red;">${msg}</span><br>
				</c:if>
				<input type="submit" class="btn btn-info" value="立即提交" style="width:100px;"/>
			</form>
		</div>
	</div>
	<!--==================================================================================================================-->
	<jsp:include page="main_bottom.jsp"></jsp:include>
</body>
</html>