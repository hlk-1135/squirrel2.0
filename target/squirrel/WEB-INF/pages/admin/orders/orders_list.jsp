<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.modal-header {
	text-align: center;
}

table td {
	text-align: center;
	border: 0px;
}
</style>
<title>订单列表</title>
<!-- 分页 -->
<link href="<%=basePath%>css/mypage.css" rel="stylesheet">

<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<link href="<%=basePath%>css/bootstrap-datetimepicker.min.css"
	rel="stylesheet">

</head>

<body>
	<jsp:include page="../main_top.jsp"></jsp:include>
	<jsp:include page="../main_left.jsp"></jsp:include>
	<!--=============================================================================================================================================================================-->
	<!--main-container-part-->
	<div id="content" style="margin-right: 100px; margin-top: 40px;">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="<%=basePath%>admin/indexs" title="主页" class="tip-bottom"><i
					class="icon-home"></i>主页</a> <a title="订单列表" class="tip-bottom">订单列表</a>
			</div>
		</div>
		<!--End-breadcrumbs-->

		<!-- Page table -->
		<div class="container" style="width: 1000px;">
			<!-- &lt;!&ndash; Marketing Icons Section &ndash;&gt;-->

			<div class="col-lg-12">
				<h2 class="page-header"
					style="margin-top: 10px; text-align: center; font-family: '微软雅黑', Verdana, sans-serif, '宋体', serif;">
					订单列表显示</h2>
			</div>

			<!--搜索栏-->
			<form class="form-horizontal" id="myserchform" name="myform"
				action="<%=basePath%>admin/searchOrders" method="post">
				<div class="form-group">
					<div class="col-sm-8" style="text-align: center;">
						<span>订单编号：</span> <input type="number" placeholder="请输入纯数字~"
							name="orderNum" value="${searchorders.orderNum}" /> <span>订单信息：</span> <input
							type="text" name="orderInformation" value="${searchorders.orderInformation}" /> <span>状态：</span>
						<select name="orderState" id="myselected">
							<option value="" selected="selected">请选择订单状态</option>
							<option value="1">代发货</option>
							<option value="2">待收货</option>
							<option value="3">已完成</option>
						</select>
					</div>
					<div class="col-sm-4">
						<button class="btn btn-success btn-sm" type="submit">查找</button>
						<button class="btn btn-danger btn-sm" type="button"
							id="deleteOrdersButton">删除</button>
					</div>
				</div>
			</form>

			<!--表格显示-->
			<table class="table table-bordered">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAllButton"></th>
						<th>订单编号</th>
						<th>订单信息</th>
						<th>订单价格</th>
						<th>创建时间</th>
						<th>订单状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${ordersGrid.rows}" var="item">
						<tr>
							<td><input type="checkbox" name="itemIds" value="${item.id}"></td>
							<td>${item.orderNum}</td>
							<td>${item.orderInformation}</td>
							<td>￥${item.orderPrice}</td>
							<td>${item.orderDate}</td>
							<td><c:if test="${item.orderState == 1}">
									<span style="color: blue">代发货</span>
								</c:if> <c:if test="${item.orderState == 2}">
									<span style="color: red">待收货</span>
								</c:if> <c:if test="${item.orderState == 3}">
									<span style="color: orange">已完成</span>
								</c:if></td>
							<td>
								<button type="button" class="btn btn-primary btn-sm"
									onclick="doView(${item.id})">查看</button>
								<button type="button" class="btn btn-info btn-sm"
									onclick="doEdit(${item.id})">修改</button>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!--分页条-->
			<div style="text-align: right">
				<div class="pagination">
					<ul>
						<li><a>总订单数:${ordersGrid.total }个</a></li>
						<li><a>第${ordersGrid.current }页</a></li>
						<c:if test="${ordersGrid.current ne 1 }">
							<li><a
								href="<%=basePath%>admin/ordersList?pageNum=${ordersGrid.current-1 }">上一页</a>
							</li>
						</c:if>

						<c:if test="${ordersGrid.current < (ordersGrid.total+9)/10-1 }">
							<li><a
								href="<%=basePath%>admin/ordersList?pageNum=${ordersGrid.current+1 }">下一页</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>


	<!--==================================================================================================================-->
	<jsp:include page="../main_bottom.jsp"></jsp:include>

	<!--修改  模态框（Modal） -->
	<div class="modal fade" id="editModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">修改订单信息</h4>
				</div>
				<div class="modal-body" style="height: 0 auto;">
					<form class="form-horizontal" id="myeditform" name="myform">
						<input type="hidden" id="id" name="id" value="" />
						<div class="form-group">
							<label class="col-sm-4 control-label">订单编号:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="orderNum" style="margin-top: 8px;" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">订单信息:</label>
							<div class="col-sm-8">
								<textarea rows="3" cols="20"  name="orderInformation" style="margin-top: 8px; width: 365px">
								</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">订单价格:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="orderPrice" style="margin-top: 8px;" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">创建时间:</label>
							<div class="col-sm-8">
								<input type="text" name="orderDate" class="form-control form_datetime" style="margin-top: 8px;">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">状态:</label>
							<div class="col-sm-8">
								<select name="orderState"
									style="margin-top: 8px; width: 372px; height: 27px;">
									<option value="1" selected="selected">代发货</option>
									<option value="2">待收货</option>
									<option value="3">已完成</option>
								</select>
							</div>
						</div>
					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="doSave()">提交更改</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<!-- 查看 模态框（Modal） -->
	<div class="modal fade" id="viewModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">查看订单信息</h4>
				</div>
				<div class="modal-body" style="height: 0 auto;">
					<form class="form-horizontal" id="myviewform" name="myform">
						<input type="hidden" id="id" name="id" value="" />
						<div class="form-group">
							<label class="col-sm-4 control-label">订单编号:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control"  name="orderNum"
									readonly style="margin-top: 8px;" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">订单信息:</label>
							<div class="col-sm-8">
								<textarea rows="3" cols="20"  name="orderInformation"
									readonly style="margin-top: 8px; width: 365px">
								</textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">订单价格:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="orderPrice" readonly style="margin-top: 8px;" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">创建时间:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="orderDate" readonly style="margin-top: 8px;" />
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-4 control-label">状态:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="orderState" readonly style="margin-top: 8px;" />
							</div>
						</div>
					</form>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>

<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- datetimepicker -->
<script type="text/javascript"
	src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript"
	src='<%=basePath%>js/bootstrap-datetimepicker.zh-CN.js'></script>
<!-- 全选 base.js -->
<script type="text/javascript" src="<%=basePath%>js/custom/base.js"></script>

<script type="text/javascript">
		//初始化时间
		$(".form_datetime").datetimepicker({  
			format:'yyyy-mm-dd hh:ii:ss',
	    	todayHighlight: true,
	    	language:'zh-CN',
	      	autoclose: true
		});  
		

		/* 查看 */
		function doView(id){
			$.ajax({
				url:'<%=basePath%>admin/getOrders',
				type:'GET',
				data:{id:id},
				dataType:'json',
				success:function(json){
					if(json){
						$('#myviewform').find("input[name='orderNum']").val(json.orderNum);
						$('#myviewform').find("textarea[name='orderInformation']").val(json.orderInformation);
						$('#myviewform').find("input[name='orderPrice']").val(json.orderPrice);
						$('#myviewform').find("input[name='orderDate']").val(json.orderDate);
						if(json.orderState==1){$('#myviewform').find("input[name='orderState']").val('代发货');}
						if(json.orderState==2){$('#myviewform').find("input[name='orderState']").val('待收货');}
						if(json.orderState==3){$('#myviewform').find("input[name='orderState']").val('已完成');}
						$('#viewModal').modal('toggle');
					}
				},
				error:function(){
					alert('请求超时或系统出错!');
					$('#viewModal').modal('hide');
				}
			});
		}
		
		/* 修改 */
		function doEdit(id){
			$.ajax({
				url:'<%=basePath%>admin/getOrders',
				type:'GET',
				data:{id:id},
				dataType:'json',
				success:function(json){
					if(json){
						$('#myeditform').find("input[name='id']").val(json.id);
						$('#myeditform').find("input[name='orderNum']").val(json.orderNum);
						$('#myeditform').find("textarea[name='orderInformation']").val(json.orderInformation);
						$('#myeditform').find("input[name='orderPrice']").val(json.orderPrice);
						$('#myeditform').find("input[name='orderDate']").val(json.orderDate);
						$('#myeditform').find("select[name='orderState']").val(json.orderState);
						$('#editModal').modal('toggle');
					}
				},
				error:function(){
					alert('请求超时或系统出错!');
					$('#viewModal').modal('hide');
				}
			});
				
		}
		
		/* 保存 */
		function doSave(){
			$.ajax({
				url:'<%=basePath%>admin/updateOrders',
				type:'POST',
				data:$('#myeditform').serialize(),// 序列化表单值  
				dataType:'json',
				success:function(json){
					alert(json.msg);
					$('#editModal').modal('toggle');
					location.reload();
				},
				error:function(){
					alert('请求超时或系统出错!');
					$('#editModal').modal('toggle');
				}
			});
				
		}
		
		//根据值 动态选中
		$("#myselected option[value='${searchorders.orderState}']").attr("selected","selected"); 
		
		
</script>

</html>
