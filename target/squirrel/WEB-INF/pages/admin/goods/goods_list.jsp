<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

.modal-header{
	 text-align:center;
	} 
	
table td{
 text-align:center;
 border:0px;
}


</style>
<title>商品列表</title>
	<!-- 分页 -->
<link href="<%=basePath%>css/mypage.css" rel="stylesheet">

<link href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">

<link href="<%=basePath%>css/bootstrap-datetimepicker.min.css" rel="stylesheet">

</head>

<body>
	<jsp:include page="../main_top.jsp"></jsp:include>
	<jsp:include page="../main_left.jsp"></jsp:include>
	<!--=============================================================================================================================================================================-->
	<!--main-container-part-->
	<div id="content" style="margin-right: 100px;margin-top: 40px;">
		<!--breadcrumbs-->
		<div id="content-header">
			<div id="breadcrumb">
				<a href="<%=basePath%>admin/indexs" title="主页"
					class="tip-bottom"><i class="icon-home"></i>主页</a> <a title="商品列表"
					class="tip-bottom">商品列表</a>
			</div>
		</div>
		<!--End-breadcrumbs-->

		<!-- Page table -->
		<div class="container" style="width: 1000px;">
			<!-- &lt;!&ndash; Marketing Icons Section &ndash;&gt;-->

			<div class="col-lg-12">
				<h2 class="page-header"
					style="margin-top:10px;text-align: center; font-family: '微软雅黑', Verdana, sans-serif, '宋体', serif;">
					商品列表显示</h2>
			</div>

			<!--搜索栏-->
			 <form class="form-horizontal" id="myserchform" name="myform" action="<%=basePath%>admin/searchGoods" method="post">
				<div class="form-group">
				<div  class="col-sm-8" style="text-align:center;">
					<span >商品ID：</span>
					<input type="number" placeholder="请输入纯数字~" name="id" value="${searchgoods.id}"/>
					<span >名称：</span>
					<input type="text"  name="name" value="${searchgoods.name}"/>
					<span >状态：</span>
					<select name="form" id="myselected" >
					<option value="" selected="selected">选择商品状态</option>
					<option value="1">在售</option>
					<option value="0">下架</option>
					</select>
				</div>
					<div class="col-sm-4">
						<button class="btn btn-success btn-sm" type="submit" >查找</button>
						<button class="btn btn-danger btn-sm" type="button" id="deleteGoodsButton">删除</button>
					</div>
				</div>
			</form>
			
			<!--表格显示-->
			<table class="table table-bordered" >
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAllButton"></th>
						<th>ID</th>
						<th>名称</th>
						<th>类别</th>
						<th>价格</th>
						<th>创建时间</th>
						<th>状态</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${goodsGrid.rows}" var="item">
						<tr>
							<td ><input type="checkbox" name="itemIds" value="${item.id}"></td>
							<td>${item.id}</td>
							<td>${item.name}</td>
							<td>
					        <c:if test="${item.catelogId == 1}">  
							<span> 闲置数码</span>
							</c:if>
							<c:if test="${item.catelogId == 2}">  
							<span>校园代步 </span>
							</c:if>
							<c:if test="${item.catelogId == 3}">  
							<span> 电器日用  </span>
							</c:if>
							<c:if test="${item.catelogId == 4}">  
							<span> 图书教材  </span>
							</c:if>
							<c:if test="${item.catelogId == 5}">  
							<span>美妆衣物 </span>
							</c:if>
							<c:if test="${item.catelogId == 6}">  
							<span> 运动棋牌</span>
							</c:if>
							<c:if test="${item.catelogId == 7}">  
							<span> 票券小物</span>
							</c:if>
							</td>
							<td>￥${item.realPrice}</td>
							<td>${item.startTime}</td>
							<td>
							<c:if test="${item.status == 1}">
							<span style="color:blue">在售</span>
							</c:if>
							<c:if test="${item.status == 0}">
							<span style="color:red">下架</span>
							</c:if>
							</td>
							<td>
							<button type="button" class="btn btn-primary btn-sm" onclick="doView(${item.id})">查看</button>
							<button type="button" class="btn btn-info btn-sm"  onclick="doEdit(${item.id})" >修改</button>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!--分页条-->
			<div style="text-align: right">
				<div class="pagination">
					<ul>
						<li><a>总商品数:${goodsGrid.total }个</a></li>
						<li><a>第${goodsGrid.current }页</a></li>
						<c:if test="${goodsGrid.current ne 1 }">
							<li><a 
								href="<%=basePath%>admin/goodsList?pageNum=${goodsGrid.current-1 }">上一页</a>
								</li>
						</c:if>

						<c:if test="${goodsGrid.current < (goodsGrid.total+9)/10-1 }">
							<li><a
								href="<%=basePath%>admin/goodsList?pageNum=${goodsGrid.current+1 }">下一页</a>
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
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" >修改商品信息</h4>
            </div>
            <div class="modal-body" style="height:0 auto; ">
            <form class="form-horizontal" id="myeditform" name="myform">
             <input type="hidden" id="id" name="id" value=""/>
            	<div class="form-group">
					 <label class="col-sm-4 control-label" >名称:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_name" name="name" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >类别:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_catelogId" name="catelogId" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >原价:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_price" name="price" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >售价:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_realPrice" name="realPrice" style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >创建时间:</label>
					<div class="col-sm-8">
						 <input  type="text" id="my_startTime" name="startTime" class="form-control form_datetime" style="margin-top: 8px;">
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >描述:</label>
					<div class="col-sm-8">
					<textarea rows="3" cols="20" id="my_describle" name="describle" style="margin-top: 8px;width:365px">
					</textarea>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >状态:</label>
					<div class="col-sm-8">
						<select name="form" style="margin-top: 8px;width: 372px;height: 27px;">
						<option value="0" selected="selected">下架</option>
						<option value="1">上架</option>
						</select>
					</div>
				</div>
			  </form>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="doSave()">提交更改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<!-- 查看 模态框（Modal） -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel" >查看商品信息</h4>
            </div>
            <div class="modal-body" style="height:0 auto; ">
            <form class="form-horizontal" id="myviewform" name="myform">
             <input type="hidden" id="id" name="id" value=""/>
            	<div class="form-group">
					 <label class="col-sm-4 control-label" >名称:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_name" name="name" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >类别:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_catelogId" name="catelogId" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >原价:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_price" name="price" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >售价:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_realPrice" name="realPrice" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >创建时间:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_startTime" name="startTime" readonly style="margin-top: 8px;"/>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >描述:</label>
					<div class="col-sm-8">
					<textarea rows="3" cols="20" id="my_describle" name="describle" readonly style="margin-top: 8px;width:365px">
					</textarea>
					</div>
				</div>
				<div class="form-group">
					 <label class="col-sm-4 control-label" >状态:</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="my_form" name="form" readonly style="margin-top: 8px;"/>
					</div>
				</div>
			  </form>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>

<script type="text/javascript" src="<%=basePath%>js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
<!-- datetimepicker -->
<script type="text/javascript" src="<%=basePath%>js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src='<%=basePath%>js/bootstrap-datetimepicker.zh-CN.js'></script>
<!-- 全选 base.js -->
<script type="text/javascript"src="<%=basePath%>js/custom/base.js"></script>

<script type="text/javascript">
		//初始化时间
		$(".form_datetime").datetimepicker({  
			format:'yyyy-mm-dd',
	    	todayHighlight: true,
	    	language:'zh-CN',
	    	minView: "month", 
	      	autoclose: true
		});  
		

		/* 查看 */
		function doView(id){
			$.ajax({
				url:'<%=basePath%>admin/getGoods',
				type:'GET',
				data:{id:id},
				dataType:'json',
				success:function(json){
					if(json){
						$('#myviewform').find("input[name='id']").val(json.id);
						$('#myviewform').find("input[name='name']").val(json.name);
						$('#myviewform').find("input[name='catelogId']").val(json.catelogId);
						$('#myviewform').find("input[name='price']").val(json.price);
						$('#myviewform').find("input[name='realPrice']").val(json.realPrice);
						$('#myviewform').find("input[name='startTime']").val(json.startTime);
						$('#myviewform').find("textarea[name='describle']").val(json.describle);
						if(json.form==1){
							$('#myviewform').find("input[name='form']").val('在售');
						}else{
							$('#myviewform').find("input[name='form']").val('下架');
						}
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
				url:'<%=basePath%>admin/getGoods',
				type:'GET',
				data:{id:id},
				dataType:'json',
				success:function(json){
					if(json){
						$('#myeditform').find("input[name='id']").val(json.id);
						$('#myeditform').find("input[name='name']").val(json.name);
						$('#myeditform').find("input[name='catelogId']").val(json.catelogId);
						$('#myeditform').find("input[name='price']").val(json.price);
						$('#myeditform').find("input[name='realPrice']").val(json.realPrice);
						$('#myeditform').find("input[name='startTime']").val(json.startTime);
						$('#myeditform').find("textarea[name='describle']").val(json.describle);
						$('#myeditform').find("select[name='form']").val(json.form);
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
				url:'<%=basePath%>admin/updateGoods',
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
	$("#myselected option[value='${searchgoods.form}']").attr("selected","selected"); 
	
</script>

</html>
