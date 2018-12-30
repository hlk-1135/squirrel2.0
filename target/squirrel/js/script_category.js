$(function(){
	var name = $('#name');
	name.on('blur',function(){
		var id = $("#id").val();
		var name =$("#name").val();
		if(name==""){
			$("#span").text("分类名不能为空");
			$("#submit").attr("disabled",true);
			return;
		}else{
			$("#span").text("");
		}
			
		//ajax请求
		$.ajax({     
			url:'checkName.action',     
			type:'post',  
			data:{'id':id,'name':name,},
			async : false, //默认为true 异步
			success:function(data){ 
				if(data=="success"){
					$("#submit").attr("disabled",false);
				}else{
					$("#span").text("分类已经存在");
					$("#submit").attr("disabled",true);
				}
			},
		});  
	});
});
