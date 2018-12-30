$(function(){
	var name = $('#name');
	name.on('blur',function(){
		var id = $("#id").val();
		var name =$("#name").val();
		var storeId=$("#storeId").val();
		if(name==""){
			$("#span").text("菜品名不能为空");
			$("#submit").attr("disabled",true);
			return;
		}else{
			$("#span").text("");
		}
		//ajax请求
		$.ajax({     
			url:'checkName.action',     
			type:'post',  
			data:{'id':id,'name':name,'storeId':storeId},
			async : false, //默认为true 异步
			success:function(data){ 
				if(data=="success"){
					$("#submit").attr("disabled",false);
				}else{
					$("#span").text("菜品名已经存在");
					$("#submit").attr("disabled",true);
				}
			},
		});  
	});
});
